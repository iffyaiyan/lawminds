from ai21.ai21_studio_client import AI21StudioClient
from ai21.modules.resources.ai21_module import AI21Module


class DeletableResource(AI21Module):

    @classmethod
    def delete(cls, resource_id: str, **params):
        url = f'{cls.get_module_url(**params)}/{resource_id}'
        client = AI21StudioClient(**params)
        return client.execute_http_request(method='DELETE', url=url)



