import json
from typing import Optional, List

from ai21.modules.destination import SageMakerDestination
from ai21.ai21_studio_client import AI21StudioClient
from ai21.utils import validate_mandatory_field, validate_unsupported_field


def execute_studio_request(task_url: str, params, method: str = 'POST'):
    client = AI21StudioClient(**params)
    return client.execute_http_request(method=method, url=task_url, params=params)


def execute_sm_request(destination: SageMakerDestination, params, mandatory_fields=None, unsupported_fields=None):
    call_name = f'Sagemaker {destination.endpoint_name}'

    if mandatory_fields is not None:
        for mandatory_field in mandatory_fields:
            validate_mandatory_field(mandatory_field, call_name, params)

    if unsupported_fields is not None:
        for unsupported_field in unsupported_fields:
            validate_unsupported_field(key=unsupported_field, call_name=call_name, params=params)

    input_json = json.dumps(params)

    from ai21.AWS_utils import invoke_sm_endpoint  # import here because boto3 exists only in AWS mode

    return invoke_sm_endpoint(
        endpoint_name=destination.endpoint_name,
        input_json=input_json,
        sm_session=destination.sm_session,
    )


def execute_bedrock_request(model_id: str, params, boto_session: Optional["boto3.Session"] = None,
                            unsupported_fields: Optional[List[str]] = None):
    call_name = 'Bedrock'

    if unsupported_fields is not None:
        for unsupported_field in unsupported_fields:
            validate_unsupported_field(key=unsupported_field, call_name=call_name, params=params)

    from ai21.bedrock_client import BedrockClient  # import here because boto3 exists only in AWS mode
    client = BedrockClient(**params)

    return client.execute_http_request(params=params, model_id=model_id, boto_session=boto_session)
