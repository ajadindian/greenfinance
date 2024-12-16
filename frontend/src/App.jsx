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
    <div className="app">
      <h1>ESG Scoring Application</h1>
      <textarea
        placeholder="Enter ESG data here..."
        onChange={(e) => setInputData(e.target.value)}
      />
      <button onClick={calculateScore}>Calculate ESG Score</button>
      {score && <p>ESG Score: {score}</p>}
      <input
        type="file"
        onChange={(e) => setFile(e.target.files[0])}
        style={{ marginTop: "1rem" }}
      />
      <button onClick={uploadFile}>Upload Document</button>
    </div>
  );
}

export default App;
