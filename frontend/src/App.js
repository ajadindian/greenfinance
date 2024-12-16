import React, { useState } from "react";

function App() {
  const [inputData, setInputData] = useState("");
  const [score, setScore] = useState(null);
  const [file, setFile] = useState(null);

  const calculateScore = async () => {
    const response = await fetch("http://localhost:8000/calculate_score", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ data: inputData }),
    });
    const result = await response.json();
    setScore(result.score);
  };

  const uploadFile = async () => {
    const formData = new FormData();
    formData.append("file", file);

    await fetch("http://localhost:8000/apply", {
      method: "POST",
      body: formData,
    });
  };

  return (
    <div>
      <h1>ESG Scoring App</h1>
      <textarea onChange={(e) => setInputData(e.target.value)}></textarea>
      <button onClick={calculateScore}>Calculate Score</button>
      {score && <p>Score: {score}</p>}
      <input type="file" onChange={(e) => setFile(e.target.files[0])} />
      <button onClick={uploadFile}>Upload File</button>
    </div>
  );
}

export default App;