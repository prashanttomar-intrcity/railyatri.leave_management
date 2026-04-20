import React, { useEffect, useMemo, useState } from "react";
import { getLeaves, updateLeaveStatus } from "../../../api/api";
import ConfirmModal from "../../../components/ConfirmModal";
import SuccessModal from "../../../components/SuccessModal";

// =========================================================
// PENDING TAB (EMPLOYEE VIEW - WITHDRAW ONLY - REAL API)
// =========================================================

export default function PendingTab() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 10;

  const [btnLoadingId, setBtnLoadingId] = useState(null);
  const [confirmLoading, setConfirmLoading] = useState(false);

  const [filters, setFilters] = useState({
    search: "",
    type: "All",
  });

  useEffect(() => {
    setCurrentPage(1);
  }, [filters]);

  const [confirmOpen, setConfirmOpen] = useState(false);
  const [selectedId, setSelectedId] = useState(null);

  const [successOpen, setSuccessOpen] = useState(false);
  const [errorMsg, setErrorMsg] = useState("");

  // ================= FETCH FROM BACKEND =================
  useEffect(() => {
    fetchLeaves();
  }, []);

  const fetchLeaves = async () => {
    setLoading(true);

    const res = await getLeaves();

    // convert backend format to UI format
    const formatted = res
      .filter((l) => l.status === "pending")
      .reverse()
      .map((l) => ({
        id: l.id,
        type: l.leave_type,
        from: l.from_date,
        to: l.to_date,
        days: l.days,
        reason: l.reason,
      }));

    setData(formatted);
    setLoading(false);
  };

  // ================= FILTER =================
  const filtered = useMemo(() => {
    return data.filter((item) => {
      const matchSearch =
        !filters.search ||
        item.reason.toLowerCase().includes(filters.search.toLowerCase());

      const matchType = filters.type === "All" || item.type === filters.type;

      return matchSearch && matchType;
    });
  }, [data, filters]);

  const totalPages = Math.ceil(filtered.length / itemsPerPage);

  const paginatedData = useMemo(() => {
    const start = (currentPage - 1) * itemsPerPage;
    return filtered.slice(start, start + itemsPerPage);
  }, [filtered, currentPage]);

  // ================= WITHDRAW =================
  const canWithdraw = () => {
    const today = new Date();
    return today.getDate() <= 26;
  };

  const handleWithdraw = (id) => {
    if (!canWithdraw()) {
      setErrorMsg("Cannot be withdrawn after 26th of this month");
      return;
    }

    setErrorMsg(""); // clear old error
    setSelectedId(id);
    setConfirmOpen(true);
  };

  return (
    <div style={styles.container}>
      {/* HEADER */}
      <div style={styles.headerRow}>
        <div style={styles.title}>Pending Leave Requests</div>
      </div>
      {errorMsg && <div style={styles.errorText}>{errorMsg}</div>}

      {/* FILTERS */}
      <div style={styles.filterRow}>
        <input
          placeholder="Search reason"
          value={filters.search}
          onChange={(e) => setFilters({ ...filters, search: e.target.value })}
          style={styles.input}
        />

        <select
          value={filters.type}
          onChange={(e) => setFilters({ ...filters, type: e.target.value })}
          style={styles.input}
        >
          <option>All</option>
          <option>Loss of Pay</option>
          <option>Sick Leave</option>
          <option>Planned Leave</option>
          <option>Unplanned Leave</option>
          <option>Comp Off</option>
        </select>
      </div>

      {/* TABLE */}
      <div style={{ ...styles.card, overflowX: "auto" }}>
        {loading ? (
          <div style={styles.center}>Loading...</div>
        ) : filtered.length === 0 ? (
          <div style={styles.center}>No pending requests</div>
        ) : (
          <table style={styles.table}>
            <thead>
              <tr>
                <th style={styles.thLeft}>Type</th>
                <th style={styles.th}>From</th>
                <th style={styles.th}>To</th>
                <th style={styles.th}>Days</th>
                <th style={styles.thLeft}>Reason</th>
                <th style={styles.th}>Action</th>
              </tr>
            </thead>

            <tbody>
              {paginatedData.map((item) => (
                <tr key={item.id} style={styles.tr}>
                  <td style={styles.tdLeft}>{item.type}</td>
                  <td style={styles.td}>{item.from}</td>
                  <td style={styles.td}>{item.to}</td>
                  <td style={styles.td}>{item.days}</td>
                  <td style={styles.tdLeft}>{item.reason}</td>

                  <td style={styles.td}>
                    <div style={styles.actionRow}>
                      <button
                        style={styles.withdrawBtn}
                        onClick={() => handleWithdraw(item.id)}
                        disabled={btnLoadingId === item.id}
                      >
                        {btnLoadingId === item.id ? (
                          <div style={styles.spinner}></div>
                        ) : (
                          "Withdraw"
                        )}
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
        <div
          style={{
            marginTop: "10px",
            display: "flex",
            justifyContent: "center",
            alignItems: "center",
            gap: "10px",
          }}
        >
          <button
            onClick={() => setCurrentPage((prev) => Math.max(prev - 1, 1))}
            disabled={currentPage === 1}
            style={{
              width: "32px",
              height: "32px",
              minWidth: "32px",
              marginBottom: "12px",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              fontSize: "14px",
              borderRadius: "6px",
              border: "1px solid #ccc",
              background: "#fff",
              cursor: "pointer",
              opacity: currentPage === 1 ? 0.5 : 1,
            }}
          >
            ◀
          </button>

          <span
            style={{
              fontSize: "13px",
              minWidth: "40px",
              textAlign: "center",
              marginBottom: "12px",
            }}
          >
            {currentPage}/{totalPages}
          </span>

          <button
            onClick={() =>
              setCurrentPage((prev) => Math.min(prev + 1, totalPages))
            }
            disabled={currentPage === totalPages}
            style={{
              width: "32px",
              height: "32px",
              minWidth: "32px",
              marginBottom: "12px",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              fontSize: "14px",
              borderRadius: "6px",
              border: "1px solid #ccc",
              background: "#fff",
              cursor: "pointer",
              opacity: currentPage === totalPages ? 0.5 : 1,
            }}
          >
            ▶
          </button>
        </div>
      </div>
      <ConfirmModal
        open={confirmOpen}
        title="Withdraw Leave"
        message="Are you sure you want to withdraw this leave application?"
        confirmText="Withdraw"
        confirmLoading={confirmLoading}
        onCancel={() => setConfirmOpen(false)}
        onConfirm={async () => {
          setConfirmLoading(true);
          setBtnLoadingId(selectedId);

          await updateLeaveStatus(selectedId, "withdrawn");

          setConfirmLoading(false);
          setBtnLoadingId(null);

          setConfirmOpen(false);
          setSuccessOpen(true);
          fetchLeaves();
        }}
      />
      <SuccessModal
        open={successOpen}
        message="Leave withdrawn successfully"
        onClose={() => setSuccessOpen(false)}
      />
    </div>
  );
}

// ================= STYLES (UNCHANGED) =================
const styles = {
  container: { padding: "10px" },
  headerRow: { marginBottom: "10px" },
  title: { fontSize: "16px", fontWeight: "600" },
  filterRow: {
    display: "flex",
    gap: "10px",
    flexWrap: "wrap",
    marginBottom: "10px",
  },
  input: {
    padding: "8px",
    border: "1px solid #ccc",
    borderRadius: "6px",
  },

  errorText: {
    color: "red",
    marginBottom: "10px",
    fontSize: "13px",
  },

  spinner: {
    width: "16px",
    height: "16px",
    border: "2px solid #fff",
    borderTop: "2px solid transparent",
    borderRadius: "50%",
    animation: "spin 0.6s linear infinite",
  },

  card: {
    background: "#fff",
    border: "1px solid #ddd",
    borderRadius: "8px",
    overflow: "hidden",
  },
  table: { width: "100%", borderCollapse: "collapse" },
  th: {
    padding: "12px",
    textAlign: "center",
    background: "#f5f6f8",
    borderBottom: "1px solid #ddd",
    fontSize: "14px",
  },
  thLeft: {
    padding: "12px",
    textAlign: "left",
    background: "#f5f6f8",
    borderBottom: "1px solid #ddd",
    fontSize: "14px",
  },
  tr: { borderBottom: "1px solid #eee", fontSize: "14px" },
  td: { padding: "12px", textAlign: "center", fontSize: "14px" },
  tdLeft: { padding: "12px", textAlign: "left", fontSize: "14px" },
  actionRow: { display: "flex", justifyContent: "center", fontSize: "14px" },
  withdrawBtn: {
    padding: "6px 12px",
    border: "none",
    background: "#1f2a37",
    color: "#fff",
    cursor: "pointer",
    borderRadius: "4px",
    fontSize: "14px",
  },
  center: { textAlign: "center", fontSize: "14px", padding: "20px" },
};

const style = document.createElement("style");
style.innerHTML = `
@keyframes spin {
  to { transform: rotate(360deg); }
}
`;
document.head.appendChild(style);
