
def supported_resources():
    from ai21 import Completion, Dataset, CustomModel, Paraphrase, Tokenization, Summarize, \
        SummarizeBySegment ,Segmentation, Improvements, GEC, SageMaker

    return {
        'completion': Completion,
        'tokenization': Tokenization,
        'dataset': Dataset,
        'customModel': CustomModel,
        'paraphrase': Paraphrase,
        'summarization': Summarize,
        'summarizeBySegment': SummarizeBySegment,
        "segmentation": Segmentation,
        "improvements": Improvements,
        "gec": GEC,
        "sagemaker": SageMaker,
    }
