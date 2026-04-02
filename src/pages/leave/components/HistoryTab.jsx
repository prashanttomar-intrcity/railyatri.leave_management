import React, { useEffect, useMemo, useState } from "react";
import { getLeaves } from "../../../api/api";

// =========================================================
// HISTORY TAB (REAL DATA + SAME UI)
// =========================================================

export default function HistoryTab() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);

  const [filters, setFilters] = useState({
    search: "",
    type: "All",
    status: "All",
  });

  useEffect(() => {
    fetchLeaves();
  }, []);

  const fetchLeaves = async () => {
    setLoading(true);

    const res = await getLeaves();

    const formatted = res
      .filter((l) => l.status !== "pending")
      .map((l) => ({
        id: l.id,
        type: l.leave_type,
        from: l.from_date,
        to: l.to_date,
        days: l.days,
        status: capitalize(l.status),
        reason: l.reason,
      }));

    setData(formatted);
    setLoading(false);
  };

  const filtered = useMemo(() => {
    return data.filter((item) => {
      const matchSearch =
        !filters.search ||
        item.reason.toLowerCase().includes(filters.search.toLowerCase());

      const matchType = filters.type === "All" || item.type === filters.type;

      const matchStatus =
        filters.status === "All" || item.status === filters.status;

      return matchSearch && matchType && matchStatus;
    });
  }, [data, filters]);

  return (
    <div style={styles.container}>
      <div style={styles.title}>Leave History</div>

      <div style={styles.filterRow}>
        <input
          placeholder="Search"
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
        </select>

        <select
          value={filters.status}
          onChange={(e) => setFilters({ ...filters, status: e.target.value })}
          style={styles.input}
        >
          <option>All</option>
          <option>Approved</option>
          <option>Rejected</option>
          <option>Cancelled</option>
        </select>
      </div>

      <div style={styles.card}>
        {loading ? (
          <div style={styles.center}>Loading...</div>
        ) : filtered.length === 0 ? (
          <div style={styles.center}>No history available</div>
        ) : (
          <table style={styles.table}>
            <thead>
              <tr>
                <th style={styles.thLeft}>Type</th>
                <th style={styles.th}>From</th>
                <th style={styles.th}>To</th>
                <th style={styles.th}>Days</th>
                <th style={styles.th}>Status</th>
                <th style={styles.thLeft}>Reason</th>
              </tr>
            </thead>

            <tbody>
              {filtered.map((item) => (
                <tr key={item.id} style={styles.tr}>
                  <td style={styles.tdLeft}>{item.type}</td>
                  <td style={styles.td}>{item.from}</td>
                  <td style={styles.td}>{item.to}</td>
                  <td style={styles.td}>{item.days}</td>
                  <td style={styles.td}>
                    <StatusBadge status={item.status} />
                  </td>
                  <td style={styles.tdLeft}>{item.reason}</td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  );
}

// ================= HELPER =================
function capitalize(str) {
  return str.charAt(0).toUpperCase() + str.slice(1);
}

// ================= STATUS BADGE =================
function StatusBadge({ status }) {
  let bg = "#eee";
  let color = "#333";

  if (status === "Approved") {
    bg = "#e6f4ea";
    color = "#1e7e34";
  }
  if (status === "Rejected") {
    bg = "#fdecea";
    color = "#c62828";
  }
  if (status === "Cancelled") {
    bg = "#ececec";
    color = "#555";
  }

  return (
    <span style={{ ...styles.badge, background: bg, color }}>{status}</span>
  );
}

// ================= STYLES =================
const styles = {
  container: { padding: "10px" },
  title: { fontSize: "16px", fontWeight: "600", marginBottom: "10px" },
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
  table: { width: "100%", borderCollapse: "collapse", fontSize: "14px" },
  th: {
    padding: "12px",
    textAlign: "center",
    background: "#f5f6f8",
    borderBottom: "1px solid #ddd",
  },
  thLeft: {
    padding: "12px",
    textAlign: "left",
    background: "#f5f6f8",
    borderBottom: "1px solid #ddd",
  },
  tr: { borderBottom: "1px solid #eee" },
  td: { padding: "12px", textAlign: "center" },
  tdLeft: { padding: "12px", textAlign: "left" },
  badge: {
    padding: "4px 10px",
    borderRadius: "12px",
    fontSize: "12px",
  },
  center: { textAlign: "center", padding: "20px", fontSize: "14px" },
};
