import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { login } from "../../api/api";

export default function Login() {
  const navigate = useNavigate();

  const [form, setForm] = useState({
    email: "",
    password: "",
  });

  const [error, setError] = useState("");

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleLogin = async () => {
    try {
      const res = await login(form);

      if (res.error) {
        alert(res.error);
        return;
      }

      localStorage.setItem("user", JSON.stringify(res.user));
      navigate("/home");
    } catch (err) {
      alert("Login failed");
    }
  };

  return (
    <div style={styles.container}>
      <div style={styles.card}>
        <h2 style={styles.title}>Welcome Back</h2>

        <div style={styles.field}>
          <label style={styles.label}>Email</label>
          <input
            name="email"
            value={form.email}
            onChange={handleChange}
            style={styles.input}
            placeholder="Enter your email"
          />
        </div>

        <div style={styles.field}>
          <label style={styles.label}>Password</label>
          <input
            type="password"
            name="password"
            value={form.password}
            onChange={handleChange}
            style={styles.input}
            placeholder="Enter your password"
          />
        </div>

        {error && <div style={styles.error}>{error}</div>}

        <button style={styles.button} onClick={handleLogin}>
          Login
        </button>

        <p style={styles.link}>
          Don’t have an account?{" "}
          <span onClick={() => navigate("/signup")}>Sign Up</span>
        </p>
      </div>
    </div>
  );
}

const styles = {
  container: {
    height: "100vh",
    background: "linear-gradient(135deg, #edf0f4, #2c3e50)",
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
  },

  card: {
    background: "#fff",
    padding: "35px",
    borderRadius: "10px",
    width: "360px",
    boxShadow: "0 10px 30px rgba(0,0,0,0.2)",
  },

  title: {
    textAlign: "center",
    marginBottom: "25px",
  },

  field: {
    marginBottom: "15px",
    display: "flex",
    flexDirection: "column",
  },

  label: {
    fontSize: "13px",
    marginBottom: "5px",
    color: "#333",
  },

  input: {
    padding: "12px",
    borderRadius: "6px",
    border: "1px solid #ccc",
    outline: "none",
  },

  button: {
    width: "100%",
    padding: "12px",
    background: "#1f2a37",
    color: "#fff",
    border: "none",
    borderRadius: "6px",
    cursor: "pointer",
    marginTop: "10px",
  },

  error: {
    color: "red",
    fontSize: "13px",
    marginBottom: "10px",
  },

  link: {
    textAlign: "center",
    marginTop: "15px",
    fontSize: "14px",
    cursor: "pointer",
  },
};
