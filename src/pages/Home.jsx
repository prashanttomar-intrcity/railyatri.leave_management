import { useEffect, useMemo, useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import { getLeaves, getAllLeaves } from "../api/api";

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

  const [user, setUser] = useState({
    name: "",
    email: "",
    role: "",
  });

  useEffect(() => {
    const storedUser = JSON.parse(localStorage.getItem("user")) || {};
    setUser({
      name: storedUser.name || "",
      email: storedUser.email || "",
      role: storedUser.role || "employee",
    });
  }, []);

  const [selectedCard, setSelectedCard] = useState(null);

  const today = new Date();
  const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
  const lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0);

  const [dateRange, setDateRange] = useState({
    from: firstDay.toISOString().split("T")[0],
    to: lastDay.toISOString().split("T")[0],
  });

  const isManager = user.role === "manager";

  useEffect(() => {
    if (user.role) {
      fetchLeaves();
    }
  }, [user.role]);

  // ================= HOLIDAY DATA =================
  const holidayData = {
    January: [
      { date: "2026-01-01", name: "New Year's Day" },
      { date: "2026-01-13", name: "Lohri" },
      { date: "2026-01-26", name: "Republic Day" },
    ],
    February: [{ date: "2026-02-15", name: "Maha Shivaratri" }],
    March: [{ date: "2026-03-20", name: "Eid-Ul-Fitar" }],
    May: [{ date: "2026-05-27", name: "Eid Ul-Adha" }],
    June: [{ date: "2026-06-26", name: "Muharram/Ashura" }],
    July: [{ date: "2026-07-16", name: "Rath Yatra" }],
    August: [
      { date: "2026-08-15", name: "Independence Day" },
      { date: "2026-08-28", name: "Raksha Bandhan" },
    ],
    September: [
      { date: "2026-09-04", name: "Janmashtami" },
      { date: "2026-09-25", name: "Ganesh Visarjan" },
    ],
    October: [{ date: "2026-10-02", name: "Gandhi Jayanti" }],
    November: [
      { date: "2026-11-01", name: "Govardhan Puja" },
      { date: "2026-11-13", name: "Bhai Dooj" },
      { date: "2026-11-26", name: "Chhath Puja" },
    ],
    December: [
      { date: "2026-12-24", name: "Christmas Eve" },
      { date: "2026-12-25", name: "Christmas" },
    ],
  };

  // ================= FILTER UPCOMING =================
  const holidays = useMemo(() => {
    const today = new Date();

    const all = Object.values(holidayData).flat();

    return all
      .filter((h) => new Date(h.date) >= today)
      .sort((a, b) => new Date(a.date) - new Date(b.date));
  }, []);

  const fetchLeaves = async () => {
    setLoading(true);
    setError(null);

    try {
      let res;

      if (isManager) {
        const allLeaves = await getAllLeaves();

        const currentUser = JSON.parse(localStorage.getItem("user"));

        // ❗ REMOVE manager's own leaves
        res = allLeaves.filter((l) => l.user_id !== currentUser.id);
      } else {
        res = await getLeaves();
      }

      setLeaves(Array.isArray(res) ? res : []);
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
    const from = new Date(dateRange.from);
    const to = new Date(dateRange.to);

    const filtered = leaves.filter((l) => {
      const leaveDate = new Date(l.from_date);
      return leaveDate >= from && leaveDate <= to;
    });

    const count = (type) =>
      filtered.filter((l) => l.leave_type === type).length;

    return {
      lop: count("Loss Of Pay"),
      comp: count("Comp Off") + count("Comp - Off"),
      planned: count("Planned Leave"),
      unplanned: count("Unplanned Leave"),
      sick: count("Sick Leave"),
    };
  }, [leaves, dateRange]);

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
          {!isManager && (
            <button
              style={styles.primaryBtn}
              onClick={() => handleNavigate("/leave/apply")}
            >
              Apply Leave
            </button>
          )}
        </div>
      </div>

      <div style={styles.grid2}>
        <div style={styles.card}>
          <div
            style={{ ...styles.profileRow, cursor: "pointer" }}
            onClick={() => handleNavigate("/profile")}
          >
            <div style={styles.avatar}>
              {user.name
                ? user.name.charAt(0).toUpperCase()
                : user.email?.charAt(0).toUpperCase()}
            </div>

            <div>
              <div style={styles.name}>Welcome, {user.name?.split(" ")[0]}</div>

              <div style={styles.meta}>{user.email}</div>
            </div>
          </div>
        </div>

        <div style={styles.kpiRow}>
          <KpiCard
            label="Loss Of Pay"
            value={summary.lop}
            onClick={() => setSelectedCard("Loss Of Pay")}
          />
          <KpiCard
            label="Comp Off"
            value={summary.comp}
            onClick={() => setSelectedCard("Comp Off")}
          />
          <KpiCard
            label="Planned Leave"
            value={summary.planned}
            onClick={() => setSelectedCard("Planned Leave")}
          />
          <KpiCard
            label="Unplanned Leave"
            value={summary.unplanned}
            onClick={() => setSelectedCard("Unplanned Leave")}
          />
          <KpiCard
            label="Sick Leave"
            value={summary.sick}
            onClick={() => setSelectedCard("Sick Leave")}
          />
        </div>
        {selectedCard && (
          <div style={styles.expandCard}>
            <div style={styles.expandHeader}>
              <div style={styles.cardTitle}>{selectedCard} Details</div>
            </div>

            <div style={styles.dateRow}>
              <div>
                <label>From</label>
                <input
                  type="date"
                  value={dateRange.from}
                  onChange={(e) =>
                    setDateRange({ ...dateRange, from: e.target.value })
                  }
                />
              </div>

              <div>
                <label>To</label>
                <input
                  type="date"
                  value={dateRange.to}
                  onChange={(e) =>
                    setDateRange({ ...dateRange, to: e.target.value })
                  }
                />
              </div>
            </div>

            <div style={styles.expandCount}>
              Count:{" "}
              {
                summary[
                  selectedCard === "Loss Of Pay"
                    ? "lop"
                    : selectedCard === "Comp Off"
                      ? "comp"
                      : selectedCard === "Planned Leave"
                        ? "planned"
                        : selectedCard === "Unplanned Leave"
                          ? "unplanned"
                          : "sick"
                ]
              }
            </div>
          </div>
        )}
      </div>

      {!isManager && (
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
              title="Pending Leaves"
              onClick={() => handleNavigate("/leave/pending-tab")}
            />

            <ActionCard
              title="Leave History"
              onClick={() => handleNavigate("/leave/history-tab")}
            />
          </div>
        </div>
      )}

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
                {[...filteredLeaves]
                  .sort(
                    (a, b) => new Date(b.created_at) - new Date(a.created_at),
                  )
                  .map((l) => (
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
      </div>
    </div>
  );
}

function KpiCard({ label, value, onClick }) {
  const today = new Date();
  const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
  const lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0);

  return (
    <div
      onClick={onClick}
      style={{
        ...styles.kpiCard,
        cursor: "pointer",
        width: window.innerWidth < 768 ? "48%" : "auto",
      }}
    >
      <div style={styles.kpiLabel}>{label}</div>
      <div style={styles.kpiValue}>{value}</div>

      {/* ✅ DATE RANGE BELOW COUNT */}
      <div style={styles.kpiDate}>
        {firstDay.toLocaleDateString()} - {lastDay.toLocaleDateString()}
      </div>
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
    padding: "15px",
    marginLeft: "0px",
    marginTop: "0px",
    background: "#f5f6f8",
    minHeight: "100vh",
  },

  headerRow: {
    display: "flex",
    justifyContent: "space-between",
    marginBottom: "20px",
    flexWrap: "wrap",
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
    borderRadius: "6px",
    width: window.innerWidth < 768 ? "100%" : "auto",
  },

  kpiDate: {
    fontSize: "10px",
    color: "#777",
    marginTop: "5px",
  },

  expandCard: {
    width: "100%",
    background: "#fff",
    padding: "15px",
    borderRadius: "8px",
    marginTop: "10px",
  },

  expandHeader: {
    marginBottom: "10px",
  },

  dateRow: {
    display: "flex",
    gap: "20px",
    marginBottom: "10px",
  },

  expandCount: {
    fontSize: "16px",
    fontWeight: "600",
  },

  ghostBtn: {
    background: "#ddd",
    padding: "8px 15px",
    border: "none",
  },

  grid2: {
    display: "flex",
    gap: "20px",
    flexDirection: "column",
    marginBottom: "20px",
  },

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

  kpiRow: {
    display: "flex",
    flexWrap: "wrap",
    gridTemplateColumns: "repeat(3, 1fr)",
    gap: "10px",
    flex: 1,
    justifyContent: "space-between",
  },

  kpiCard: {
    flex: 1,
    background: "#fff",
    padding: "15px",
    borderRadius: "8px",
    marginBottom: "18px",
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

  actionsRow: { display: "flex", flexWrap: "wrap", gap: "10px" },

  actionCard: {
    padding: "10px 15px",
    background: "#eee",
    cursor: "pointer",
    borderRadius: "6px",
    width: window.innerWidth < 768 ? "20%" : "auto",
    textAlign: "center",
  },

  gridMain: {
    display: "flex",
    flexDirection: window.innerWidth < 768 ? "column" : "row",
    gap: "20px",
  },

  leftSection: {
    flex: 3, // 🔥 bigger width
  },

  rightSection: {
    flex: 1,
    maxHeight: "400px",
    overflowY: "auto",

    scrollbarWidth: "none", // Firefox
    msOverflowStyle: "none", // IE
  },

  cardHeaderRow: {
    display: "flex",
    justifyContent: "space-between",
    marginBottom: "10px",
  },

  filters: { display: "flex", gap: "10px", flexWrap: "wrap" },

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

  holidayItem: {
    marginBottom: "12px",
    paddingBottom: "8px",
    borderBottom: "1px solid #eee",
  },
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
// HIDE SCROLLBAR FOR CHROME
const hideScrollbar = {
  scrollbarWidth: "none",
};

document.addEventListener("DOMContentLoaded", () => {
  const style = document.createElement("style");
  style.innerHTML = `
    ::-webkit-scrollbar {
      display: none;
    }
  `;
  document.head.appendChild(style);
});
