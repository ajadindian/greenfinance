#!/bin/bash

# Define project paths
BACKEND_PATH="./backend"
FRONTEND_PATH="./frontend"
TESTS_PATH="./tests"
MODEL_PATH="./models"
LOG_FILE="./deploy_logs.txt"

echo "Starting deployment pipeline..." | tee $LOG_FILE

# Step 1: Install Python dependencies for backend
echo "Installing backend dependencies..." | tee -a $LOG_FILE
pip install -r "$BACKEND_PATH/requirements.txt" 2>&1 | tee -a $LOG_FILE
if [ $? -ne 0 ]; then
    echo "Backend dependency installation failed. Exiting..." | tee -a $LOG_FILE
    exit 1
fi

# Step 2: Run backend tests
echo "Running backend tests..." | tee -a $LOG_FILE
pytest "$TESTS_PATH" 2>&1 | tee -a $LOG_FILE
if [ $? -ne 0 ]; then
    echo "Tests failed. Exiting..." | tee -a $LOG_FILE
    exit 1
fi

# Step 3: Install Node.js dependencies for frontend
echo "Installing frontend dependencies..." | tee -a $LOG_FILE
npm install --prefix "$FRONTEND_PATH" 2>&1 | tee -a $LOG_FILE
if [ $? -ne 0 ]; then
    echo "Frontend dependency installation failed. Exiting..." | tee -a $LOG_FILE
    exit 1
fi

# Step 4: Build frontend assets
echo "Building frontend..." | tee -a $LOG_FILE
npm run build --prefix "$FRONTEND_PATH" 2>&1 | tee -a $LOG_FILE
if [ $? -ne 0 ]; then
    echo "Frontend build failed. Exiting..." | tee -a $LOG_FILE
    exit 1
fi

# Step 5: Ensure model files are in place
if [ ! -d "$MODEL_PATH/qwen" ]; then
    echo "Qwen model files not found in $MODEL_PATH/qwen. Please add them before deploying." | tee -a $LOG_FILE
    exit 1
fi

# Step 6: Start backend server
echo "Starting backend server..." | tee -a $LOG_FILE
python "$BACKEND_PATH/app/main.py" > "$BACKEND_PATH/server.log" 2>&1 &
BACKEND_PID=$!
sleep 5

if ps -p $BACKEND_PID > /dev/null; then
    echo "Backend server is running with PID $BACKEND_PID" | tee -a $LOG_FILE
else
    echo "Backend server failed to start. Check $BACKEND_PATH/server.log for details." | tee -a $LOG_FILE
    exit 1
fi

echo "Deployment pipeline completed successfully." | tee -a $LOG_FILE
