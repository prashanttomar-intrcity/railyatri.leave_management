import React, { useEffect, useMemo, useState } from "react";
import { getLeaves, updateLeaveStatus } from "../../../api/api";

// =========================================================
// PENDING TAB (EMPLOYEE VIEW - WITHDRAW ONLY - REAL API)
// =========================================================

export default function PendingTab() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);

  const [filters, setFilters] = useState({
    search: "",
    type: "All",
  });

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

  // ================= WITHDRAW =================
  const handleWithdraw = async (id) => {
    const confirm = window.confirm(
      "Are you sure you want to withdraw this leave request?",
    );

    if (!confirm) return;

    await updateLeaveStatus(id, "withdrawn");

    fetchLeaves(); // refresh
  };

  return (
    <div style={styles.container}>
      {/* HEADER */}
      <div style={styles.headerRow}>
        <div style={styles.title}>Pending Leave Requests</div>
      </div>

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
          <option>Sick Leave</option>
          <option>Planned Leave</option>
          <option>Unplanned Leave</option>
          <option>Comp Off</option>
          <option>Restricted Holiday</option>
        </select>
      </div>

      {/* TABLE */}
      <div style={styles.card}>
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
              {filtered.map((item) => (
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
                      >
                        Withdraw
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  );
}

// ================= STYLES (UNCHANGED) =================
const styles = {
  container: { padding: "10px" },
  headerRow: { marginBottom: "10px" },
  title: { fontSize: "16px", fontWeight: "600" },
  filterRow: { display: "flex", gap: "10px", marginBottom: "10px" },
  input: {
    padding: "8px",
    border: "1px solid #ccc",
    borderRadius: "6px",
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
