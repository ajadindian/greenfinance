my_esg_project/
├── backend/
│   ├── app/
│   │   ├── main.py            # FastAPI app entry point
│   │   ├── scoring_engine.py  # LLM-based scoring engine
│   │   ├── document_parser.py # OCR and data extraction
│   │   ├── database.py        # Database models and queries
│   │   └── utils.py           # Utility functions
├── frontend/
│   ├── public/                # Frontend static files
│   ├── src/                   # React components
│   ├── package.json           # Node.js dependencies
├── models/
│   ├── qwen/                  # Pretrained Qwen model
│   └── fine_tuned/            # Fine-tuned model files
├── scripts/
│   ├── data_preprocessing.py  # Preprocessing scripts
│   ├── model_training.py      # Model fine-tuning scripts
│   └── deploy_pipeline.sh     # Deployment automation
├── tests/                     # Unit and integration tests
├── jenkins/                   # Jenkins-specific files
│   ├── Jenkinsfile            # Jenkins pipeline configuration
└── README.md                  # Project documentation