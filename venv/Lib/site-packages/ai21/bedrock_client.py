from typing import Optional, Dict, Any

import boto3
from aws_requests_auth.aws_auth import AWSRequestsAuth
from botocore.session import Session
from aws_requests_auth.boto_utils import BotoAWSRequestsAuth

from ai21.constants import BEDROCK_HOST_FORMAT, BEDROCK_URL_FORMAT
from ai21.errors import WrongInputTypeException
from ai21.http_client import HttpClient
from ai21.utils import get_global_configs, convert_to_ai21_object, get_value


class BedrockClient:
    def __init__(self, **params):
        self._http_client = self._build_http_client(params)

    def _build_http_client(self, params):
        global_configs = get_global_configs()
        headers = self._build_default_headers()
        passed_headers = params.get('headers', None)

        if passed_headers is not None:
            if not isinstance(passed_headers, Dict):
                raise WrongInputTypeException('headers', Dict, type(passed_headers))
            headers.update(passed_headers)

        timeout_sec = get_value('timeout_sec', params, global_configs, int)
        num_retries = get_value('num_retries', params, global_configs, int)

        return HttpClient(timeout_sec=timeout_sec, num_retries=num_retries, headers=headers)

    def _build_default_headers(self):
        headers = {'Content-Type': 'application/json'}

        return headers

    def execute_http_request(self, params: Optional[Dict[str, Any]], model_id: str,
                             boto_session: Optional[Session] = None):
        aws_region = self._get_aws_region(boto_session)

        auth_token = self._get_auth_token(boto_session)

        bedrock_url = f'{BEDROCK_URL_FORMAT.format(region_name=aws_region)}/model/{model_id}/invoke'

        response = self._http_client.execute_http_request(
            method='POST',
            url=bedrock_url,
            params=params,
            auth=auth_token,
        )

        return convert_to_ai21_object(response)

    def _get_aws_region(self, boto_session: Optional[boto3.Session]) -> str:
        if boto_session:
            return boto_session.region_name

        global_configs = get_global_configs()
        return global_configs.get('aws_region') or boto3.Session().region_name

    def _get_auth_token(self, boto_session: Optional[boto3.Session]) -> AWSRequestsAuth:
        aws_region = self._get_aws_region(boto_session)
        aws_host = BEDROCK_HOST_FORMAT.format(region_name=aws_region)
        aws_service = 'bedrock'

        if boto_session:
            credentials_obj = boto_session.get_credentials().get_frozen_credentials()

            return AWSRequestsAuth(
                aws_access_key=credentials_obj.access_key,
                aws_secret_access_key=credentials_obj.secret_key,
                aws_token=credentials_obj.token,
                aws_host=aws_host,
                aws_region=aws_region,
                aws_service=aws_service,
            )

        return BotoAWSRequestsAuth(
            aws_host=BEDROCK_HOST_FORMAT.format(region_name=aws_region),
            aws_region=aws_region,
            aws_service=aws_service,
        )
