from flask import Flask, request, jsonify
import requests as req
import os
import pdfplumber


# import os
from dotenv import load_dotenv
import ai21

# Load your API key from the .env file
load_dotenv()

app = Flask(__name__)

# Load your AI21 API key from the .env file
# API_KEY = os.environ.get('API_KEY')
API_KEY = os.getenv("AI21_API_KEY")

# Load context from a PDF or text file
def load_context(file_path):
    if file_path.endswith(".pdf"):
        with pdfplumber.open(file_path) as pdf:
            context = ""
            for page in pdf.pages:
                context += page.extract_text()
        return context
    elif file_path.endswith((".txt", ".md")):
        with open(file_path, "r") as file:
            context = file.read()
        return context
    else:
        return "Unsupported file format. Please use PDF, TXT, or MD."

# Initialize the context
CONTEXT_FILE = "SexualHarassmentinWorkplaceALiteratureReview.pdf"  # Replace with your context file
context = load_context(CONTEXT_FILE)

@app.route("/")
def get_answer():
    question = request.args.get('question')

    url = "https://api.ai21.com/studio/v1/experimental/answer"

    payload = {
        "context": context,
        "question": question
    }

    headers = {
        "accept": "application/json",
        "content-type": "application/json",
        "Authorization": f'Bearer {API_KEY}'
    }

    response = req.post(url, json=payload, headers=headers)
    return response.text

if __name__ == "__main__":
    app.run()


