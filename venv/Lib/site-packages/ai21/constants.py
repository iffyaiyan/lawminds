DEFAULT_API_VERSION = 'v1'
STUDIO_HOST = 'https://api.ai21.com'

SAGEMAKER_ENDPOINT_KEY = 'sm_endpoint'
DESTINATION_KEY = 'destination'
BEDROCK_HOST_FORMAT = 'bedrock.{region_name}.amazonaws.com'
BEDROCK_URL_FORMAT = f'https://{BEDROCK_HOST_FORMAT}'

SAGEMAKER_MODEL_PACKAGE_NAMES = [
    'j2-light',
    'j2-mid',
    'j2-ultra',
    'gec',
    'contextual-answers',
    'paraphrase',
    'summarize',
]


class BedrockModelID:
    J2_GRANDE_INSTRUCT = 'ai21.j2-grande-instruct'
    J2_JUMBO_INSTRUCT = 'ai21.j2-jumbo-instruct'
    J2_ULTRA = 'ai21.j2-ultra'
    J2_MID = 'ai21.j2-mid'


MODEL_ID_REMAPPING = {
    BedrockModelID.J2_JUMBO_INSTRUCT: BedrockModelID.J2_ULTRA,
    BedrockModelID.J2_GRANDE_INSTRUCT: BedrockModelID.J2_MID,
}
