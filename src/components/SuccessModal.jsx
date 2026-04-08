import React from "react";

export default function SuccessModal({ open, message, onClose }) {
  if (!open) return null;

  return (
    <div style={styles.overlay}>
      <div style={styles.modal}>
        <h3>Success</h3>
        <p>{message}</p>

        <button style={styles.button} onClick={onClose}>
          OK
        </button>
      </div>
    </div>
  );
}

const styles = {
  overlay: {
    position: "fixed",
    top: 0,
    left: 0,
    width: "100%",
    height: "100%",
    background: "rgba(0,0,0,0.4)",
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    zIndex: 999,
  },

  modal: {
    background: "#fff",
    padding: "20px",
    borderRadius: "8px",
    width: "320px",
    textAlign: "center",
  },

  button: {
    marginTop: "15px",
    padding: "8px 20px",
    background: "#000",
    color: "#fff",
    border: "none",
    cursor: "pointer",
  },
};
