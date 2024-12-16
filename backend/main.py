```python
from fastapi import FastAPI, UploadFile, File
from app.scoring_engine import calculate_esg_score
from app.database import init_db

app = FastAPI()

@app.on_event("startup")
def startup_event():
    init_db()

@app.get("/")
def read_root():
    return {"message": "Welcome to the ESG Scoring API!"}

@app.post("/apply")
def apply_for_loan(file: UploadFile = File(...)):
    file_content = file.file.read()
    # Save the file securely or process further
    return {"message": "File uploaded successfully."}

@app.post("/calculate_score")
def score(data: dict):
    return {"score": calculate_esg_score(data)}
```