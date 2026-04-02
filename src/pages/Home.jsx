import { useEffect, useMemo, useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";

const API_BASE = "http://localhost:3000";

export default function Home() {
  const navigate = useNavigate();

  const [leaves, setLeaves] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const [filters, setFilters] = useState({
    search: "",
    type: "All",
  });

  const user = useMemo(
    () => ({
      name: "Prashant",
      role: "Software Engineer",
      empId: "EMP001",
      email: "prashant@example.com",
      avatar: "P",
    }),
    [],
  );

  const holidays = useMemo(
    () => [
      { date: "2026-01-01", name: "New Year" },
      { date: "2026-01-26", name: "Republic Day" },
      { date: "2026-03-20", name: "Eid-ul-Fitr" },
      { date: "2026-08-15", name: "Independence Day" },
      { date: "2026-10-02", name: "Gandhi Jayanti" },
    ],
    [],
  );

  useEffect(() => {
    fetchLeaves();
  }, []);

  const fetchLeaves = async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await axios.get(`${API_BASE}/api/leave_requests`);
      setLeaves(Array.isArray(res.data) ? res.data : []);
    } catch (err) {
      console.error(err);
      setError("Failed to load leaves");
    } finally {
      setLoading(false);
    }
  };

  // 🔥 FILTERED DATA
  const filteredLeaves = useMemo(() => {
    return leaves.filter((l) => {
      const matchesType =
        filters.type === "All" || l.leave_type === filters.type;

      const matchesSearch =
        !filters.search ||
        `${l.leave_type} ${l.reason}`
          .toLowerCase()
          .includes(filters.search.toLowerCase());

      return matchesType && matchesSearch;
    });
  }, [leaves, filters]);

  // 🔥 REAL KPI CALCULATION
  const summary = useMemo(() => {
    const count = (type) => leaves.filter((l) => l.leave_type === type).length;

    return {
      lop: count("Loss Of Pay"),
      sick: count("Sick Leave"),
      casual: count("Planned Leave"),
      comp: count("Comp Off"),
    };
  }, [leaves]);

  const handleNavigate = (path) => navigate(path);

  const getStatusStyle = (status) => {
    switch (status) {
      case "approved":
        return {
          background: "#dcfce7",
          color: "#166534",
        };
      case "rejected":
        return {
          background: "#fee2e2",
          color: "#991b1b",
        };
      case "pending":
        return {
          background: "#fef9c3",
          color: "#854d0e",
        };
      case "withdrawn":
        return {
          background: "#ffedd5",
          color: "#9a3412",
        };
      default:
        return {
          background: "#e5e7eb",
          color: "#374151",
        };
    }
  };

  const getStatusBadge = (status) => {
    switch (status) {
      case "approved":
        return { background: "#2e7d32", color: "#fff" }; // green
      case "rejected":
        return { background: "#d32f2f", color: "#fff" }; // red
      case "pending":
        return { background: "#ed6c02", color: "#fff" }; // orange-yellow
      case "withdrawn":
        return { background: "#6d4c41", color: "#fff" }; // brown/orange
      default:
        return { background: "#616161", color: "#fff" };
    }
  };

  return (
    <div style={styles.page}>
      <div style={styles.headerRow}>
        <div>
          <div style={styles.pageTitle}>Dashboard</div>
          <div style={styles.subTitle}>Overview & quick actions</div>
        </div>

        <div style={styles.headerActions}>
          <button
            style={styles.primaryBtn}
            onClick={() => handleNavigate("/leave/apply")}
          >
            Apply Leave
          </button>

          <button style={styles.ghostBtn} onClick={fetchLeaves}>
            Refresh
          </button>
        </div>
      </div>

      <div style={styles.grid2}>
        <div style={styles.card}>
          <div style={styles.profileRow}>
            <div style={styles.avatar}>{user.avatar}</div>
            <div>
              <div style={styles.name}>Welcome, {user.name}</div>
              <div style={styles.meta}>{user.role}</div>
              <div style={styles.meta}>ID: {user.empId}</div>
              <div style={styles.meta}>{user.email}</div>
            </div>
          </div>
        </div>

        <div style={styles.kpiRow}>
          <KpiCard label="Loss Of Pay" value={summary.lop} />
          <KpiCard label="Sick Leaves" value={summary.sick} />
          <KpiCard label="Casual Leaves" value={summary.casual} />
          <KpiCard label="Comp Off" value={summary.comp} />
        </div>
      </div>

      <div style={styles.card}>
        <div style={styles.cardTitle}>Quick Actions</div>
        <div style={styles.actionsRow}>
          <ActionCard
            title="Apply Leave"
            onClick={() => handleNavigate("/leave/apply")}
          />
          <ActionCard
            title="Leave Details"
            onClick={() => handleNavigate("/leave/balance")}
          />
          <ActionCard
            title="Leave Calendar"
            onClick={() => handleNavigate("/leave/calendar")}
          />
          <ActionCard
            title="Holiday Calendar"
            onClick={() => handleNavigate("/leave/holiday")}
          />
        </div>
      </div>

      <div style={styles.gridMain}>
        <div style={{ ...styles.card, ...styles.leftSection }}>
          <div style={styles.cardHeaderRow}>
            <div style={styles.cardTitle}>Recent Leave Applications</div>

            <div style={styles.filters}>
              <input
                style={styles.input}
                placeholder="Search"
                value={filters.search}
                onChange={(e) =>
                  setFilters({ ...filters, search: e.target.value })
                }
              />

              <select
                style={styles.input}
                value={filters.type}
                onChange={(e) =>
                  setFilters({ ...filters, type: e.target.value })
                }
              >
                <option>All</option>
                <option>Planned Leave</option>
                <option>Unplanned Leave</option>
                <option>Sick Leave</option>
                <option>Comp Off</option>
              </select>
            </div>
          </div>

          {loading ? (
            <div style={styles.center}>Loading...</div>
          ) : error ? (
            <div style={styles.error}>{error}</div>
          ) : filteredLeaves.length === 0 ? (
            <div style={styles.center}>No leaves found</div>
          ) : (
            <table style={{ ...styles.table, marginTop: "30px" }}>
              <thead style={styles.tableHead}>
                <tr>
                  <th style={styles.th}>Type</th>
                  <th style={styles.th}>From</th>
                  <th style={styles.th}>To</th>
                  <th style={styles.th}>Reason</th>
                  <th style={styles.th}>Status</th>
                </tr>
              </thead>

              <tbody>
                {filteredLeaves.map((l) => (
                  <tr key={l.id} style={styles.tableRow}>
                    <td style={styles.td}>{l.leave_type}</td>
                    <td style={styles.td}>{l.from_date}</td>
                    <td style={styles.td}>{l.to_date}</td>
                    <td style={styles.td}>{l.reason}</td>
                    <td>
                      <span
                        style={{
                          ...styles.statusBadge,
                          ...getStatusBadge(l.status),
                        }}
                      >
                        {l.status.charAt(0).toUpperCase() + l.status.slice(1)}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>

        <div style={{ ...styles.card, ...styles.rightSection }}>
          <div style={styles.cardTitle}>Upcoming Holidays</div>
          {holidays.map((h, i) => (
            <div key={i} style={styles.holidayItem}>
              <div style={styles.holidayName}>{h.name}</div>
              <div style={styles.holidayDate}>{h.date}</div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

function KpiCard({ label, value }) {
  return (
    <div style={styles.kpiCard}>
      <div style={styles.kpiLabel}>{label}</div>
      <div style={styles.kpiValue}>{value}</div>
    </div>
  );
}

function ActionCard({ title, onClick }) {
  return (
    <div style={styles.actionCard} onClick={onClick}>
      {title}
    </div>
  );
}

// =============================================================
// STYLES
// =============================================================

const styles = {
  page: {
    padding: "20px",
    marginLeft: "13px",
    marginTop: "0px",
    background: "#f5f6f8",
    minHeight: "100vh",
  },

  headerRow: {
    display: "flex",
    justifyContent: "space-between",
    marginBottom: "20px",
  },

  statusBadge: {
    padding: "3px 10px",
    borderRadius: "999px",
    fontSize: "12px",
    fontWeight: "500",
    display: "inline-block",
    textTransform: "capitalize",
  },

  pageTitle: { fontSize: "22px", fontWeight: 600 },
  subTitle: { fontSize: "12px", color: "#777" },

  headerActions: { display: "flex", gap: "10px" },

  primaryBtn: {
    background: "#000",
    color: "#fff",
    padding: "8px 15px",
    border: "none",
    cursor: "pointer",
  },

  ghostBtn: {
    background: "#ddd",
    padding: "8px 15px",
    border: "none",
  },

  grid2: { display: "flex", gap: "20px", marginBottom: "20px" },

  profileRow: { display: "flex", gap: "15px" },

  avatar: {
    width: "60px",
    height: "60px",
    borderRadius: "50%",
    background: "#000",
    color: "#fff",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    fontSize: "20px",
  },

  tableHead: {
    background: "#f1f3f5",
  },

  tableRow: {
    borderBottom: "1px solid #e5e7eb",
  },

  td: {
    padding: "6px 8px",
  },

  th: {
    padding: "6px 8px",
    fontWeight: "600",
  },

  name: { fontSize: "16px", fontWeight: 600 },
  meta: { fontSize: "12px", color: "#666" },

  kpiRow: { display: "flex", gap: "10px", flex: 1 },

  kpiCard: {
    flex: 1,
    background: "#fff",
    padding: "15px",
    borderRadius: "8px",
  },

  kpiLabel: { fontSize: "12px", color: "#777" },
  kpiValue: { fontSize: "20px", fontWeight: 600 },

  card: {
    background: "#fff",
    padding: "15px",
    borderRadius: "8px",
    marginBottom: "20px",
  },

  cardTitle: { fontWeight: 600, marginBottom: "10px" },

  actionsRow: { display: "flex", gap: "10px" },

  actionCard: {
    padding: "10px 15px",
    background: "#eee",
    cursor: "pointer",
    borderRadius: "6px",
  },

  gridMain: {
    display: "flex",
    gap: "20px",
  },

  leftSection: {
    flex: 3, // 🔥 bigger width
  },

  rightSection: {
    flex: 1, // 🔥 smaller sidebar
  },

  cardHeaderRow: {
    display: "flex",
    justifyContent: "space-between",
    marginBottom: "10px",
  },

  filters: { display: "flex", gap: "10px" },

  input: {
    padding: "6px",
    border: "1px solid #ccc",
  },

  table: {
    width: "100%",
    borderCollapse: "collapse",
    textAlign: "center",
    fontSize: "14px",
  },

  holidayItem: { marginBottom: "10px" },
  holidayName: { fontWeight: 500 },
  holidayDate: { fontSize: "12px", color: "#666" },

  calendarGrid: {
    display: "grid",
    gridTemplateColumns: "repeat(7, 1fr)",
    gap: "10px",
  },

  dayCell: {
    padding: "10px",
    background: "#f1f2f6",
    textAlign: "center",
    borderRadius: "6px",
  },

  activityList: { paddingLeft: "20px" },

  center: { textAlign: "center", padding: "20px" },

  error: { color: "red" },
};

// END OF FILE
