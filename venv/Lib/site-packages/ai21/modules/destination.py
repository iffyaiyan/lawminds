from dataclasses import dataclass
from typing import Optional


class Destination:
    pass


class AI21Destination(Destination):
    pass


@dataclass
class AWSDestination(Destination):
    pass


@dataclass
class BedrockDestination(AWSDestination):
    model_id: str
    boto_session: Optional["boto3.Session"] = None


@dataclass
class SageMakerDestination(AWSDestination):
    endpoint_name: str
    sm_session: Optional["sagemaker.session.Session"] = None
