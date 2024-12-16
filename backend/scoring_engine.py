from transformers import AutoTokenizer, AutoModelForCausalLM

# Load Qwen Model
model_path = "../models/qwen/"
tokenizer = AutoTokenizer.from_pretrained(model_path)
model = AutoModelForCausalLM.from_pretrained(model_path)

def calculate_esg_score(data):
    prompt = f"""
    ESG data:
    {data}
    Calculate the ESG score and explain the rationale.
    """
    inputs = tokenizer(prompt, return_tensors="pt")
    outputs = model.generate(**inputs, max_new_tokens=200)
    return tokenizer.decode(outputs[0], skip_special_tokens=True)
