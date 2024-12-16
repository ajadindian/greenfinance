from transformers import AutoModelForCausalLM, AutoTokenizer

model_path = "../models/qwen/"
tokenizer = AutoTokenizer.from_pretrained(model_path)
model = AutoModelForCausalLM.from_pretrained(model_path)

def fine_tune_model(data):