import React, { useEffect, useState } from "react";
import { getAllLeaves, updateLeaveStatus } from "../../api/api";
import { useNavigate } from "react-router-dom";
import ConfirmModal from "../../components/ConfirmModal";
import SuccessModal from "../../components/SuccessModal";

export default function ReviewLeave() {
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 10;

  const [isMobile, setIsMobile] = useState(window.innerWidth < 768);

  useEffect(() => {
    const handleResize = () => setIsMobile(window.innerWidth < 768);
    window.addEventListener("resize", handleResize);
    return () => window.removeEventListener("resize", handleResize);
  }, []);

  const [leaves, setLeaves] = useState([]);
  const navigate = useNavigate();
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [selectedAction, setSelectedAction] = useState(null);
  const [filterType, setFilterType] = useState("");
  const [fromDate, setFromDate] = useState("");
  const [comment, setComment] = useState("");
  const [toDate, setToDate] = useState("");
  const [successOpen, setSuccessOpen] = useState(false);
  const [successMsg, setSuccessMsg] = useState("");

  useEffect(() => {
    fetchLeaves();
  }, []);

  const fetchLeaves = async () => {
    const data = await getAllLeaves();

    setLeaves(data);
  };
  const handleAction = async (id, status) => {
    const updated = await updateLeaveStatus(id, status);

    setLeaves((prev) =>
      prev.map((l) => (l.id === id ? { ...l, status: updated.status } : l)),
    );
  };

  const getStatusBadge = (status) => {
    switch (status) {
      case "approved":
        return { background: "#2e7d32", color: "#fff" };
      case "rejected":
        return { background: "#d32f2f", color: "#fff" };
      case "pending":
        return { background: "#ed6c02", color: "#fff" };
      case "withdrawn":
        return { background: "#6d4c41", color: "#fff" };
      default:
        return { background: "#616161", color: "#fff" };
    }
  };

  const filteredLeaves = leaves.filter((leave) => {
    const matchType =
      !filterType || filterType === "All" || leave.leave_type === filterType;

    const leaveFrom = new Date(leave.from_date);
    const matchFrom = !fromDate || leaveFrom >= new Date(fromDate);
    const matchTo = !toDate || leaveFrom <= new Date(toDate);

    return matchType && matchFrom && matchTo;
  });

  const paginatedLeaves = filteredLeaves.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage,
  );

  return (
    <div style={styles.container}>
      <div style={styles.topHeader}>
        <h2 style={styles.heading}>Review Leave</h2>

        <div style={styles.filterRow}>
          <div style={styles.inputGroup}>
            <label style={styles.label}>From</label>
            <input
              type="date"
              value={fromDate}
              onChange={(e) => setFromDate(e.target.value)}
              style={styles.dateInput}
            />
          </div>

          <div style={styles.inputGroup}>
            <label style={styles.label}>To</label>
            <input
              type="date"
              value={toDate}
              onChange={(e) => setToDate(e.target.value)}
              style={styles.dateInput}
            />
          </div>

          <div style={styles.inputGroup}>
            <label style={styles.label}>Leave Type</label>
            <select
              value={filterType}
              onChange={(e) => setFilterType(e.target.value)}
              style={styles.dropdown}
            >
              <option value="">Select Leave Type</option>
              <option value="All">All</option>
              <option value="Loss Of Pay">Loss Of Pay</option>
              <option value="Comp Off">Comp Off</option>
              <option value="Planned Leave">Planned Leave</option>
              <option value="Unplanned Leave">Unplanned Leave</option>
              <option value="Sick Leave">Sick Leave</option>
            </select>
          </div>
        </div>
      </div>

      <div style={styles.table}>
        <div style={styles.tableInner}>
          <div style={styles.headerRow}>
            <div>Name</div>
            <div>Type</div>
            <div>From</div>
            <div>To</div>
            <div>Reason</div>
            <div>Status</div>
            <div>Action</div>
          </div>

          {paginatedLeaves.map((leave) => (
            <div
              key={leave.id}
              style={{ ...styles.row, cursor: "pointer" }}
              onMouseEnter={(e) =>
                (e.currentTarget.style.background = "#f9fbff")
              }
              onMouseLeave={(e) => (e.currentTarget.style.background = "white")}
              onClick={() => navigate(`/manager/review/${leave.id}`)}
            >
              <div style={styles.cell}>{leave.user?.name}</div>
              <div style={styles.cell}>{leave.leave_type}</div>
              <div style={styles.cell}>{leave.from_date}</div>
              <div style={styles.cell}>{leave.to_date}</div>
              <div style={styles.cell}>{leave.reason}</div>

              <div style={styles.cell}>
                <span
                  style={{
                    ...styles.statusBadge,
                    ...getStatusBadge(leave.status),
                  }}
                >
                  {leave.status}
                </span>
              </div>

              <div style={styles.actions}>
                {leave.status === "pending" ? (
                  <>
                    <button
                      style={styles.approve}
                      onClick={(e) => {
                        e.stopPropagation();
                        setSelectedAction({ id: leave.id, status: "approved" });
                        setConfirmOpen(true);
                      }}
                    >
                      Approve
                    </button>

                    <button
                      style={styles.reject}
                      onClick={(e) => {
                        e.stopPropagation();
                        setSelectedAction({ id: leave.id, status: "rejected" });
                        setConfirmOpen(true);
                      }}
                    >
                      Reject
                    </button>
                  </>
                ) : (
                  <>
                    <button
                      style={{ ...styles.approve, opacity: 0.5 }}
                      disabled
                    >
                      Approve
                    </button>
                    <button style={{ ...styles.reject, opacity: 0.5 }} disabled>
                      Reject
                    </button>
                  </>
                )}
              </div>
            </div>
          ))}
        </div>
      </div>

      <div style={styles.pagination}>
        <button
          disabled={currentPage === 1}
          onClick={() => setCurrentPage((p) => p - 1)}
        >
          ◀
        </button>

        <span>Page {currentPage}</span>

        <button
          disabled={currentPage * itemsPerPage >= filteredLeaves.length}
          onClick={() => setCurrentPage((p) => p + 1)}
        >
          ▶
        </button>
      </div>

      {confirmOpen && (
        <div style={modalStyles.overlay}>
          <div style={modalStyles.modal}>
            <h3 style={{ marginBottom: "10px" }}>Add Comment</h3>

            <div style={modalStyles.commentWrapper}>
              <textarea
                placeholder="Enter your comment..."
                value={comment}
                onChange={(e) => setComment(e.target.value)}
                style={modalStyles.textarea}
                onFocus={(e) => (e.target.style.border = "1px solid #1976d2")}
                onBlur={(e) => (e.target.style.border = "1px solid #dcdfe4")}
              />
            </div>
            <div style={modalStyles.actions}>
              <button
                style={modalStyles.cancelBtn}
                onClick={() => setConfirmOpen(false)}
              >
                Cancel
              </button>

              <button
                style={modalStyles.confirmBtn}
                onClick={async () => {
                  if (!comment.trim()) {
                    alert("Comment is required");
                    return;
                  }

                  await updateLeaveStatus(
                    selectedAction.id,
                    selectedAction.status,
                    comment,
                  );

                  setSuccessMsg(
                    selectedAction.status === "approved"
                      ? "Leave approved successfully"
                      : "Leave rejected successfully",
                  );

                  setConfirmOpen(false);
                  setSuccessOpen(true);
                  setComment("");
                  fetchLeaves();
                }}
              >
                {selectedAction.status === "approved" ? "Approve" : "Reject"}
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

const modalStyles = {
  overlay: {
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

  modal: {
    background: "#fff",
    padding: "20px",
    borderRadius: "10px",
    width: "420px",
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

  textarea: {
    width: "93%",
    minHeight: "110px",
    padding: "12px 14px",
    borderRadius: "8px",
    border: "1px solid #dcdfe4",
    fontSize: "14px",
    background: "#fafafa",
    resize: "none",
  },

  commentWrapper: {
    marginTop: "10px",
  },

  commentLabel: {
    fontSize: "13px",
    fontWeight: "500",
    marginBottom: "6px",
    display: "block",
    color: "#444",
  },

  actions: {
    display: "flex",
    justifyContent: "flex-end",
    gap: "10px",
    marginTop: "15px",
    flexWrap: "wrap",
  },
};

const styles = {
  container: {
    padding: "25px",
    background: "#f5f6f8",
    minHeight: "100vh",
  },

  tableInner: {
    minWidth: "1300px",
  },

  heading: {
    fontSize: "22px",
    marginBottom: "20px",
  },

  firstRow: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    width: "100%",
  },

  filterRow: {
    display: "flex",
    gap: "12px",
    alignItems: "center",
    marginBottom: "15px",
    flexWrap: "nowrap",
  },

  fullWidthFilter: {
    display: "flex",
    flexDirection: "column",
    marginBottom: "20px",
  },

  fullWidthDropdown: {
    padding: "10px",
    borderRadius: "6px",
    border: "1px solid #ccc",
    width: "100%",
  },

  pagination: {
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    gap: "70px",
    padding: "10px",
    fontSize: "14px",
  },

  table: {
    background: "#fff",
    borderRadius: "8px",
    border: "1px solid #ddd",
    overflowX: "auto",
  },

  headerRow: {
    display: "grid",
    gridTemplateColumns: "150px 130px 140px 120px 170px 140px 200px",
    padding: "14px 12px",
    fontWeight: "600",
    borderBottom: "2px solid #e0e0e0",
    background: "#fafafa",
    fontSize: "16px",
    color: "#555",
    alignItems: "center",
  },

  cell: {
    paddingRight: "10px",
    whiteSpace: "nowrap",
  },

  topHeader: {
    display: "flex",
    flexDirection: "column",
    gap: "15px",
    marginBottom: "15px",
  },

  rightFilters: {
    display: "flex",
    gap: "10px",
  },

  secondFilterRow: {
    width: "100%",
    display: "flex",
    justifyContent: "flex-end",
  },

  filterContainer: {
    display: "flex",
    gap: "20px",
    alignItems: "center",
  },

  inputGroup: {
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
  },

  label: {
    fontSize: "12px",
    color: "#555",
    marginBottom: "4px",
    fontWeight: "500",
  },

  dateInput: {
    padding: "6px 8px",
    borderRadius: "6px",
    border: "1px solid #ccc",
    width: "90px",
  },

  dropdown: {
    padding: "6px 8px",
    borderRadius: "6px",
    border: "1px solid #ccc",
    width: "150px", // 🔥 reduced
  },

  row: {
    display: "grid",
    gridTemplateColumns: "140px 110px 110px 150px 140px 120px 120px",
    padding: "14px 12px",
    borderBottom: "1px solid #eee",
    alignItems: "center",
    fontSize: "14.8px",
    transition: "0.2s",
    gap: "10px",
    whiteSpace: "nowrap",
  },

  statusBadge: {
    padding: "3px 10px",
    borderRadius: "999px",
    fontSize: "12px",
    fontWeight: "500",
    display: "inline-block",
    textTransform: "capitalize",
  },

  actions: {
    display: "flex",
    gap: "8px",
    justifyContent: "flex-start",
  },

  approve: {
    background: "#2e7d32",
    color: "#fff",
    border: "none",
    padding: "6px 12px",
    borderRadius: "4px",
  },

  reject: {
    background: "#d32f2f",
    color: "#fff",
    border: "none",
    padding: "6px 12px",
    borderRadius: "4px",
  },
};
