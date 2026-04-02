import React, { useState, useEffect } from "react";
import { updateLeaveStatus, getLeaves } from "../../../api/api";
// ==============================================
// LEAVE CANCEL PAGE (PROFESSIONAL HR UI)
// ==============================================

export default function LeaveCancel() {
  const [leaves, setLeaves] = useState([]);
  const [selected, setSelected] = useState(null);
  const [reason, setReason] = useState("");
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);

  const [showNotice, setShowNotice] = useState(true);

  useEffect(() => {
    fetchLeaves();
  }, []);

  const fetchLeaves = async () => {
    const data = await getLeaves();
    setLeaves(data.filter((l) => l.status === "approved"));
  };

  const handleCancel = async () => {
    if (selected === null) return;

    const leave = leaves[selected];

    await updateLeaveStatus(leave.id, "withdrawn");

    setSuccess(true);
  };

  return (
    <div style={styles.container}>
      {/* 🔔 NOTIFICATION BAR */}
      {showNotice && (
        <div style={styles.notice}>
          Cancel Leave enables you to apply for cancellation of approved leave
          applications.
          <span style={styles.hide} onClick={() => setShowNotice(false)}>
            Hide
          </span>
        </div>
      )}

      <h2 style={styles.title}>Apply for Cancelling Leave</h2>

      <div style={styles.card}>
        {/* EMPTY STATE */}
        {leaves.length === 0 && (
          <div style={styles.emptyState}>
            <div style={styles.emptyIcon}>📄</div>
            <div style={styles.emptyText}>
              You have not applied for any leave yet, as per our record.
            </div>
          </div>
        )}

        {/* LIST */}
        {leaves.length > 0 && (
          <div>
            {leaves.map((leave, index) => (
              <div
                key={leave.id}
                style={{
                  ...styles.leaveItem,
                  border:
                    selected === index ? "1px solid black" : "1px solid #ddd",
                }}
                onClick={() => setSelected(index)}
              >
                <div>
                  <div style={styles.leaveType}>{leave.leave_type}</div>
                  <div style={styles.leaveDate}>
                    {leave.from_date} → {leave.to_date}
                  </div>
                </div>
                <div style={styles.status}>{leave.status}</div>
              </div>
            ))}

            {/* REASON */}
            <div style={styles.field}>
              <label style={styles.label}>Cancellation Reason</label>
              <textarea
                value={reason}
                onChange={(e) => setReason(e.target.value)}
                style={styles.textarea}
              />
            </div>

            {/* ACTIONS */}
            <div style={styles.actions}>
              <button style={styles.submit} onClick={handleCancel}>
                {loading ? "Processing..." : "Cancel Leave"}
              </button>

              <button style={styles.cancel} onClick={() => setReason("")}>
                Reset
              </button>
            </div>

            {success && (
              <div style={styles.success}>Leave Cancelled Successfully</div>
            )}
          </div>
        )}
      </div>
    </div>
  );
}

// ================= STYLES =================

const styles = {
  container: {
    background: "#f5f6f8",
    minHeight: "100vh",
    padding: "20px",
    fontFamily: "Arial",
    color: "#111",
  },

  notice: {
    background: "#f0f0e6",
    color: "#070707",
    padding: "10px",
    borderRadius: "6px",
    marginBottom: "15px",
    display: "flex",
    justifyContent: "space-between",
    fontSize: "13px",
  },

  hide: {
    cursor: "pointer",
    fontWeight: "bold",
    color: "blue",
  },

  title: {
    fontSize: "22px",
    fontWeight: "600",
    marginBottom: "15px",
  },

  infoBox: {
    background: "#f0f0e6",
    padding: "12px",
    borderRadius: "6px",
    marginBottom: "20px",
    fontSize: "14px",
  },

  card: {
    background: "#fff",
    padding: "25px",
    borderRadius: "8px",
    border: "1px solid #ddd",
  },

  subtitle: {
    fontSize: "16px",
    marginBottom: "20px",
  },

  emptyState: {
    textAlign: "center",
    padding: "60px",
    color: "#888",
  },

  emptyIcon: {
    fontSize: "50px",
    marginBottom: "10px",
  },

  emptyText: {
    fontSize: "14px",
  },

  leaveItem: {
    display: "flex",
    justifyContent: "space-between",
    padding: "12px",
    borderRadius: "6px",
    marginBottom: "10px",
    cursor: "pointer",
  },

  leaveType: {
    fontWeight: "500",
  },

  leaveDate: {
    fontSize: "12px",
    color: "#666",
  },

  status: {
    fontSize: "12px",
    color: "green",
  },

  field: {
    marginTop: "15px",
  },

  label: {
    fontSize: "13px",
    marginBottom: "5px",
    display: "block",
  },

  textarea: {
    width: "100%",
    padding: "10px",
    borderRadius: "6px",
    border: "1px solid #ccc",
    minHeight: "80px",
  },

  actions: {
    display: "flex",
    gap: "10px",
    marginTop: "15px",
  },

  submit: {
    background: "#000",
    color: "#fff",
    padding: "10px 20px",
    border: "none",
    borderRadius: "6px",
    cursor: "pointer",
  },

  cancel: {
    background: "#e0e0e0",
    padding: "10px 20px",
    border: "none",
    borderRadius: "6px",
    cursor: "pointer",
  },

  success: {
    marginTop: "10px",
    color: "green",
  },
};
