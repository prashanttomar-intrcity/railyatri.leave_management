import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { getAllLeaves, updateLeaveStatus } from "../../api/api";
import SuccessModal from "../../components/SuccessModal";

export default function LeaveDetails() {
  const { id } = useParams();

  const [leave, setLeave] = useState(null);
  const [comment, setComment] = useState("");
  const [actionType, setActionType] = useState("");
  const [showModal, setShowModal] = useState(false);
  const [successOpen, setSuccessOpen] = useState(false);
  const [successMsg, setSuccessMsg] = useState("");

  useEffect(() => {
    fetchLeave();
  }, []);

  const fetchLeave = async () => {
    const data = await getAllLeaves();
    const found = data.find((l) => l.id === parseInt(id));
    setLeave(found);
  };

  const handleSubmit = async () => {
    if (!comment.trim()) {
      alert("Comment is required");
      return;
    }

    const updated = await updateLeaveStatus(leave.id, actionType, comment);

    setLeave({
      ...leave,
      status: updated.status,
      manager_comment: comment,
    });

    setSuccessMsg(
      actionType === "approved"
        ? "Leave approved successfully"
        : "Leave rejected successfully",
    );

    setShowModal(false);
    setSuccessOpen(true);
    setComment("");
  };

  const getStatusBadge = (status) => {
    switch (status) {
      case "approved":
        return styles.approved;
      case "rejected":
        return styles.rejected;
      case "pending":
        return styles.pending;
      case "withdrawn":
        return styles.withdrawn;
      default:
        return styles.defaultStatus;
    }
  };

  if (!leave) return <div style={{ padding: 30 }}>Loading...</div>;

  return (
    <div style={styles.container}>
      {/* HEADER */}
      <div style={styles.header}>
        <h2 style={styles.heading}>Leave Details</h2>
        <span
          style={{ ...styles.statusBadge, ...getStatusBadge(leave.status) }}
        >
          {leave.status}
        </span>
      </div>

      {/* MAIN CARD */}
      <div style={styles.card}>
        {/* USER */}
        <div style={styles.userSection}>
          <div style={styles.avatar}>{leave.user?.name?.charAt(0)}</div>
          <div>
            <div style={styles.name}>{leave.user?.name}</div>
            <div style={styles.subText}>Employee</div>
          </div>
        </div>

        {/* INFO GRID */}
        <div style={styles.grid}>
          <div style={styles.infoBox}>
            <div style={styles.label}>From Date</div>
            <div style={styles.value}>{leave.from_date}</div>
          </div>

          <div style={styles.infoBox}>
            <div style={styles.label}>To Date</div>
            <div style={styles.value}>{leave.to_date}</div>
          </div>

          <div style={styles.infoBox}>
            <div style={styles.label}>Total Days</div>
            <div style={styles.value}>{leave.days}</div>
          </div>

          <div style={styles.infoBox}>
            <div style={styles.label}>Leave Type</div>
            <div style={styles.value}>{leave.leave_type}</div>
          </div>
        </div>

        {/* DETAILS */}
        <div style={styles.section}>
          <div style={styles.sectionTitle}>Reason</div>
          <div style={styles.reasonBox}>{leave.reason}</div>
        </div>

        {/* MANAGER COMMENT DISPLAY */}
        {leave.manager_comment && (
          <div style={styles.section}>
            <div style={styles.sectionTitle}>Manager Comment</div>
            <div style={styles.commentBox}>{leave.manager_comment}</div>
          </div>
        )}

        {/* ACTION BUTTONS */}
        {leave.status === "pending" && (
          <div style={styles.actionBar}>
            <button
              style={styles.approveBtn}
              onClick={() => {
                setActionType("approved");
                setShowModal(true);
              }}
            >
              Approve
            </button>

            <button
              style={styles.rejectBtn}
              onClick={() => {
                setActionType("rejected");
                setShowModal(true);
              }}
            >
              Reject
            </button>
          </div>
        )}
      </div>

      {/* MODAL */}
      {showModal && (
        <div style={styles.modalOverlay}>
          <div style={styles.modalBox}>
            <h3 style={styles.modalTitle}>Add Comment</h3>

            <textarea
              placeholder="Write your comment here..."
              value={comment}
              onChange={(e) => setComment(e.target.value)}
              style={styles.textarea}
            />

            <div style={styles.modalActions}>
              <button
                style={styles.cancelBtn}
                onClick={() => setShowModal(false)}
              >
                Cancel
              </button>

              <button style={styles.confirmBtn} onClick={handleSubmit}>
                {actionType === "approved" ? "Approve" : "Reject"}
              </button>
            </div>
          </div>
        </div>
      )}

      <SuccessModal
        open={successOpen}
        message={successMsg}
        onClose={() => setSuccessOpen(false)}
      />
    </div>
  );
}

/* ================= STYLES ================= */

const styles = {
  container: {
    padding: "25px",
    background: "#f4f6f9",
    minHeight: "100vh",
  },

  header: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: "20px",
  },

  heading: {
    fontSize: "24px",
    fontWeight: "600",
  },

  card: {
    background: "#fff",
    borderRadius: "12px",
    padding: "25px",
    boxShadow: "0 4px 12px rgba(0,0,0,0.05)",
  },

  userSection: {
    display: "flex",
    alignItems: "center",
    gap: "12px",
    marginBottom: "20px",
  },

  avatar: {
    width: "45px",
    height: "45px",
    borderRadius: "50%",
    background: "#1976d2",
    color: "#fff",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    fontWeight: "600",
  },

  name: {
    fontSize: "16px",
    fontWeight: "600",
  },

  subText: {
    fontSize: "13px",
    color: "#777",
  },

  grid: {
    display: "grid",
    gridTemplateColumns: "repeat(4, 1fr)",
    gap: "15px",
    marginBottom: "20px",
  },

  infoBox: {
    background: "#f9fbff",
    padding: "15px",
    borderRadius: "8px",
    border: "1px solid #e3eaf5",
  },

  label: {
    fontSize: "12px",
    color: "#777",
  },

  value: {
    fontSize: "15px",
    fontWeight: "600",
    marginTop: "4px",
  },

  section: {
    marginTop: "20px",
  },

  sectionTitle: {
    fontWeight: "600",
    marginBottom: "8px",
  },

  reasonBox: {
    background: "#fafafa",
    padding: "12px",
    borderRadius: "6px",
    border: "1px solid #eee",
  },

  commentBox: {
    background: "#eef6ff",
    padding: "12px",
    borderRadius: "6px",
    border: "1px solid #cfe3ff",
  },

  actionBar: {
    marginTop: "25px",
    display: "flex",
    gap: "10px",
  },

  approveBtn: {
    background: "#2e7d32",
    color: "#fff",
    padding: "10px 18px",
    border: "none",
    borderRadius: "6px",
  },

  rejectBtn: {
    background: "#d32f2f",
    color: "#fff",
    padding: "10px 18px",
    border: "none",
    borderRadius: "6px",
  },

  statusBadge: {
    padding: "6px 14px",
    borderRadius: "20px",
    fontSize: "13px",
    fontWeight: "500",
    textTransform: "capitalize",
  },

  approved: { background: "#2e7d32", color: "#fff" },
  rejected: { background: "#d32f2f", color: "#fff" },
  pending: { background: "#ed6c02", color: "#fff" },
  withdrawn: { background: "#6d4c41", color: "#fff" },
  defaultStatus: { background: "#616161", color: "#fff" },

  modalOverlay: {
    position: "fixed",
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    background: "rgba(0,0,0,0.4)",
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
  },

  modalBox: {
    background: "#fff",
    padding: "20px",
    borderRadius: "10px",
    width: "420px",
  },

  modalTitle: {
    fontSize: "18px",
    marginBottom: "10px",
  },

  textarea: {
    width: "93%",
    minHeight: "110px",
    padding: "12px 14px",
    borderRadius: "8px",
    border: "1px solid #dcdfe4",
    fontSize: "14px",
    outline: "none",
    transition: "0.2s",
    background: "#fafafa",
    resize: "none",
  },

  textareaFocus: {
    border: "1px solid #1976d2",
    background: "#fff",
  },

  modalActions: {
    display: "flex",
    justifyContent: "flex-end",
    gap: "10px",
    marginTop: "15px",
  },

  cancelBtn: {
    background: "#eee",
    border: "none",
    padding: "8px 14px",
  },

  confirmBtn: {
    background: "#1976d2",
    color: "#fff",
    border: "none",
    padding: "8px 14px",
  },
};
