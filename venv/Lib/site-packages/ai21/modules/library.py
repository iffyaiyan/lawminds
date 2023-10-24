from ai21.modules.resources.deletable_resource import DeletableResource
from ai21.modules.resources.execution_utils import execute_studio_request
from ai21.utils import validate_mandatory_field

from ai21.modules.resources.nlp_task import NLPTask

from ai21.modules.resources.listable_resource import ListableResource
from ai21.modules.resources.retrievable_resource import RetrievableResource
from ai21.modules.resources.updatable_resource import UpdatableResource
from ai21.modules.resources.uploadable_resource import UploadableResource


class Library:
    class Files(UploadableResource, RetrievableResource, ListableResource, UpdatableResource, DeletableResource):
        MODULE_NAME = 'library/files'

        @classmethod
        def upload(cls, file_path: str, **params):
            return super().upload(file_path=file_path, file_param_name='file', **params)

    class Answer(NLPTask):
        MODULE_NAME = 'library/answer'

        @classmethod
        def _get_call_name(cls) -> str:
            return cls.MODULE_NAME

        @classmethod
        def _validate_params(cls, params):
            validate_mandatory_field(
                key='question', call_name=cls.MODULE_NAME, params=params, validate_type=True, expected_type=str)

        @classmethod
        def _execute_studio_api(cls, params):
            url = cls.get_base_url(**params)
            url = f'{url}/{cls.MODULE_NAME}'
            return execute_studio_request(task_url=url, params=params)

    class Search(NLPTask):
        MODULE_NAME = 'library/search'

        @classmethod
        def _get_call_name(cls) -> str:
            return cls.MODULE_NAME

        @classmethod
        def _validate_params(cls, params):
            validate_mandatory_field(
                key='query', call_name=cls.MODULE_NAME, params=params, validate_type=True, expected_type=str)

        @classmethod
        def _execute_studio_api(cls, params):
            url = cls.get_base_url(**params)
            url = f'{url}/{cls.MODULE_NAME}'
            return execute_studio_request(task_url=url, params=params)
