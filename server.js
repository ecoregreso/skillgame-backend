import express from "express";
import cors from "cors";

const app = express();
app.use(cors());
app.use(express.json());

// Example ticket check endpoint
app.post("/login", (req, res) => {
  const { userCode, pin } = req.body;
  
  // TODO: Replace with real database lookup
  if (userCode === "ABC123" && pin === "1111") {
    res.json({ success: true, credits: 500 });
  } else {
    res.status(401).json({ success: false, message: "Invalid ticket" });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Backend running on port ${PORT}`));
