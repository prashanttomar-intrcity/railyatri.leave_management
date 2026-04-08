import React from "react";

export default function ConfirmModal({
  open,
  title,
  message,
  onConfirm,
  onCancel,
  confirmText = "Confirm",
}) {
  if (!open) return null;

  return (
    <div style={styles.overlay}>
      <div style={styles.modal}>
        <h3>{title}</h3>
        <p>{message}</p>

        <div style={styles.actions}>
          <button style={styles.cancel} onClick={onCancel}>
            Cancel
          </button>
          <button style={styles.confirm} onClick={onConfirm}>
            {confirmText}
          </button>
        </div>
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
    width: "350px",
  },

  actions: {
    marginTop: "15px",
    display: "flex",
    justifyContent: "flex-end",
    gap: "10px",
  },

  cancel: {
    padding: "8px 15px",
    background: "#ccc",
    border: "none",
  },

  confirm: {
    padding: "8px 15px",
    background: "#2e7d32",
    color: "#fff",
    border: "none",
  },
};
