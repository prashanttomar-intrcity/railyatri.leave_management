import React, { useState } from "react";
import { useEffect } from "react";
import { getLeaves } from "../../api/api";

// =========================================================
// LEAVE CALENDAR (FULL ENTERPRISE UI - 400+ LINES)
// =========================================================

export default function LeaveCalendar() {
  const [isMobile, setIsMobile] = useState(window.innerWidth < 768);

  useEffect(() => {
    const handleResize = () => setIsMobile(window.innerWidth < 768);
    window.addEventListener("resize", handleResize);
    return () => window.removeEventListener("resize", handleResize);
  }, []);
  const [currentMonth, setCurrentMonth] = useState(new Date());
  const [filter, setFilter] = useState("Me");
  const [search, setSearch] = useState("");
  const [leaveDates, setLeaveDates] = useState([]);

  useEffect(() => {
    fetchLeaves();
  }, []);

  const fetchLeaves = async () => {
    try {
      const data = await getLeaves();

      let dates = [];

      data.forEach((leave) => {
        const start = new Date(leave.from_date);
        const end = new Date(leave.to_date);

        let current = new Date(start);

        while (current <= end) {
          dates.push(current.toISOString().split("T")[0]);
          current.setDate(current.getDate() + 1);
        }
      });

      setLeaveDates(dates);
    } catch (err) {
      console.error(err);
    }
  };

  // ================= MONTH NAVIGATION =================

  const prevMonth = () => {
    const newDate = new Date(currentMonth);
    newDate.setMonth(newDate.getMonth() - 1);
    setCurrentMonth(newDate);
  };

  const nextMonth = () => {
    const newDate = new Date(currentMonth);
    newDate.setMonth(newDate.getMonth() + 1);
    setCurrentMonth(newDate);
  };

  const getMonthName = () => {
    return currentMonth.toLocaleString("default", {
      month: "long",
      year: "numeric",
    });
  };

  // ================= CALENDAR LOGIC =================

  const getDaysInMonth = () => {
    const year = currentMonth.getFullYear();
    const month = currentMonth.getMonth();

    const firstDay = new Date(year, month, 1).getDay();
    const totalDays = new Date(year, month + 1, 0).getDate();

    let days = [];

    for (let i = 0; i < firstDay; i++) {
      days.push(null);
    }

    for (let d = 1; d <= totalDays; d++) {
      days.push(d);
    }

    return days;
  };

  const days = getDaysInMonth();

  // ================= MOCK DATA =================

  const holidays = {
    20: "general",
    21: "restricted",
  };

  // ================= UI =================

  return (
    <div style={styles.container}>
      {/* HEADER */}
      <div style={styles.header}>
        <h2 style={styles.title}>Leave Calendar</h2>

        <select
          value={filter}
          onChange={(e) => setFilter(e.target.value)}
          style={styles.input}
        >
          <option>Me</option>
          <option>Team</option>
          <option>All</option>
        </select>
      </div>

      {/* MAIN GRID */}
      <div style={{ display: "flex", flexDirection: "column", gap: "20px" }}>
        {/* LEAVE TRANSACTIONS FULL WIDTH */}
        <div style={styles.transactionsCard}>
          <div style={styles.transactionsHeader}>Leave Transactions (0)</div>

          <div style={styles.tableHeader}>
            <span>Employee</span>
            <span>Days</span>
            <span>From-To</span>
          </div>

          <div style={styles.emptyState}>No Employees are on leave</div>
        </div>

        {/* CALENDAR */}
        <div style={styles.calendarCard}>
          <div style={styles.calendarHeader}>
            <span style={styles.navBtn} onClick={prevMonth}>
              ◀ Prev
            </span>

            <span style={styles.monthTitle}>{getMonthName()}</span>

            <span style={styles.navBtn} onClick={nextMonth}>
              Next ▶
            </span>
          </div>

          {/* DAYS HEADER */}
          <div style={styles.weekHeader}>
            {["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"].map((day) => (
              <div key={day} style={styles.weekCell}>
                {day}
              </div>
            ))}
          </div>

          {/* DAYS GRID */}
          <div style={styles.daysGrid}>
            {days.map((day, index) => (
              <DayCell
                key={index}
                day={day}
                holiday={holidays[day]}
                currentMonth={currentMonth}
                leaveDates={leaveDates}
              />
            ))}
          </div>

          {/* LEGEND */}
          <div style={styles.legend}>
            <span>Team on Leave 0</span>
            <span style={styles.legendDotYellow}></span>
            <span>Restricted Holiday</span>
            <span style={styles.legendDotPurple}></span>
            <span>General Holiday</span>
          </div>
        </div>
      </div>
    </div>
  );
}

// =========================================================
// DAY CELL COMPONENT
// =========================================================

function DayCell({ day, holiday, currentMonth, leaveDates }) {
  if (!day) return <div style={styles.dayCell}></div>;
  const year = currentMonth.getFullYear();
  const month = currentMonth.getMonth() + 1;

  const formattedDate = `${year}-${String(month).padStart(2, "0")}-${String(
    day,
  ).padStart(2, "0")}`;

  const isLeave = leaveDates.includes(formattedDate);

  return (
    <div
      style={{
        ...styles.dayCell,
        background: isLeave ? "#fde2e2" : "#fff",
      }}
    >
      <div style={styles.dayNumber}>{day}</div>

      {holiday === "general" && <div style={styles.generalDot}></div>}

      {holiday === "restricted" && <div style={styles.restrictedDot}></div>}
    </div>
  );
}

// =========================================================
// STYLES
// =========================================================

const styles = {
  container: {
    background: "#f5f6f8",
    minHeight: "100vh",
    padding: "25px",
    fontFamily: "Arial",
  },

  header: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: "20px",
  },

  title: {
    fontSize: "22px",
    fontWeight: "600",
  },

  actions: {
    display: "flex",
    gap: "10px",
  },

  downloadBtn: {
    background: "#1976d2",
    color: "#fff",
    border: "none",
    padding: "8px 12px",
    borderRadius: "6px",
    cursor: "pointer",
  },

  filterRow: {
    marginBottom: "15px",
  },

  label: {
    fontSize: "13px",
  },

  input: {
    padding: "8px",
    border: "1px solid #ccc",
    borderRadius: "6px",
    marginTop: "5px",
  },

  mainGrid: {
    display: "grid",
    gridTemplateColumns: "2fr 1fr",
    gap: "20px",
  },

  calendarCard: {
    background: "#fff",
    border: "1px solid #ddd",
    borderRadius: "8px",
    padding: "15px",
  },

  calendarHeader: {
    display: "flex",
    justifyContent: "space-between",
    marginBottom: "10px",
  },

  navBtn: {
    cursor: "pointer",
    color: "#555",
  },

  monthTitle: {
    fontWeight: "500",
  },

  weekHeader: {
    display: "grid",
    gridTemplateColumns: "repeat(7, 1fr)",
  },

  weekCell: {
    padding: "10px",
    fontSize: "13px",
    color: "#666",
  },

  daysGrid: {
    display: "grid",
    gridTemplateColumns: "repeat(7, 1fr)",
  },

  dayCell: {
    border: "1px solid #eee",
    height: "80px",
    position: "relative",
    padding: "5px",
  },

  dayNumber: {
    fontSize: "12px",
  },

  generalDot: {
    width: "8px",
    height: "8px",
    background: "purple",
    borderRadius: "50%",
    position: "absolute",
    bottom: "5px",
    right: "5px",
  },

  restrictedDot: {
    width: "8px",
    height: "8px",
    background: "gold",
    borderRadius: "50%",
    position: "absolute",
    bottom: "5px",
    right: "15px",
  },

  legend: {
    marginTop: "10px",
    fontSize: "12px",
    display: "flex",
    gap: "10px",
    alignItems: "center",
  },

  legendDotYellow: {
    width: "8px",
    height: "8px",
    background: "gold",
    borderRadius: "50%",
  },

  legendDotPurple: {
    width: "8px",
    height: "8px",
    background: "purple",
    borderRadius: "50%",
  },

  sidePanel: {
    display: "flex",
    flexDirection: "column",
    gap: "10px",
  },

  searchRow: {
    display: "flex",
    flexWrap: "wrap",
    gap: "5px",
  },

  filterBtn: {
    padding: "8px",
    border: "1px solid #ccc",
    borderRadius: "6px",
  },

  transactionsCard: {
    background: "#fff",
    border: "1px solid #ddd",
    borderRadius: "8px",
    padding: "10px",
  },

  transactionsHeader: {
    fontWeight: "500",
    marginBottom: "10px",
  },

  tableHeader: {
    display: "flex",
    justifyContent: "space-between",
    fontSize: "13px",
    color: "#666",
    marginBottom: "10px",
  },

  emptyState: {
    textAlign: "center",
    color: "#888",
    padding: "30px",
  },
};
