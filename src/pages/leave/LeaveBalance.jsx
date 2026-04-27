import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { getLeaves } from "../../api/api";
// =====================================================
// LEAVE BALANCE PAGE (FULL PROFESSIONAL HR DASHBOARD UI)
// =====================================================

export default function LeaveBalance() {
  const navigate = useNavigate();
  const [isMobile, setIsMobile] = useState(window.innerWidth < 768);

  useEffect(() => {
    const handleResize = () => setIsMobile(window.innerWidth < 768);
    window.addEventListener("resize", handleResize);
    return () => window.removeEventListener("resize", handleResize);
  }, []);

  const [year, setYear] = useState("2026");

  const [leaveData, setLeaveData] = useState([]);

  useEffect(() => {
    if (localStorage.getItem("user")) {
      fetchLeaveBalance();
    }
  }, [year]);

  const fetchLeaveBalance = async () => {
    try {
      const data = await getLeaves();

      const user = JSON.parse(localStorage.getItem("user")) || {};

      // 🔥 STEP 2 DEBUG (ADD THESE EXACTLY HERE)
      console.log("USER ID:", user?.id);
      console.log(
        "ALL LEAVE USER IDS:",
        data.map((l) => l.user_id),
      );

      // 🔥 SAFETY CHECK (STEP 5 FIX)
      if (!Array.isArray(data)) {
        console.error("Invalid API response:", data);
        setLeaveData([]);
        return;
      }

      // join date (fallback = today)
      const joinDate = user?.created_at
        ? new Date(user.created_at)
        : new Date();

      // months worked
      const today = new Date();
      const monthsWorked =
        (today.getFullYear() - joinDate.getFullYear()) * 12 +
        (today.getMonth() - joinDate.getMonth()) +
        1;

      // Only current user (IMPORTANT)

      const myLeaves = data.filter((leave) => {
        const leaveYear = new Date(leave.from_date).getFullYear();

        return (
          Number(leave.user_id) === Number(user?.id) && // 🔥 FIX
          leaveYear === Number(year)
        );
      });
      if (!myLeaves || myLeaves.length === 0) {
        setLeaveData([
          { name: "Loss Of Pay", granted: 0, pending: 0, balance: 5 },
          { name: "Comp Off", granted: 0, pending: 0, balance: 5 },
          { name: "Planned Leave", granted: 0, pending: 0, balance: 5 },
          { name: "Unplanned Leave", granted: 0, pending: 0, balance: 5 },
          { name: "Sick Leave", granted: 0, pending: 0, balance: 5 },
        ]);
        return;
      }

      const leaveTypes = [
        "Loss Of Pay",
        "Comp Off",
        "Planned Leave",
        "Unplanned Leave",
        "Sick Leave",
      ];

      const result = leaveTypes.map((type) => {
        const normalize = (str) => {
          if (!str) return "";

          return str
            .toLowerCase()
            .replace(/\s+/g, "") // remove ALL spaces
            .replace(/-/g, "") // remove hyphen
            .trim();
        };

        const filtered = myLeaves.filter(
          (leave) => normalize(leave.leave_type) === normalize(type),
        );

        let approvedCount = 0;
        let pendingCount = 0;

        filtered.forEach((leave) => {
          const diff = Number(leave.days) || 0;

          const status = leave.status?.toLowerCase().trim();

          // 🔥 DEBUG LOG (ADD THIS)
          console.log("DEBUG LEAVE:", {
            originalType: leave.leave_type,
            normalizedType: normalize(leave.leave_type),
            currentCardType: type,
            status: status,
            days: diff,
          });

          if (status === "approved") {
            approvedCount += 1;
          } else if (status === "pending") {
            pendingCount += 1;
          }

          // ❌ IGNORE:
          // rejected
          // withdrawn
          // anything else
        });

        // ===== BASE =====
        let base = 5;

        // ===== MONTHLY ACCRUAL =====
        if (type === "Planned Leave") {
          base += monthsWorked * 1; // +1 per month
        }

        if (type === "Unplanned Leave") {
          base += monthsWorked * 0.5; // +0.5 per month
        }

        return {
          name: type,
          granted: approvedCount,
          pending: pendingCount,
          balance: base - (approvedCount + pendingCount),
        };
      });

      setLeaveData(result);
    } catch (err) {
      console.error(err);
    }
  };

  return (
    <div style={styles.container}>
      {/* HEADER */}
      <div style={styles.headerRow}>
        <h2 style={styles.title}>Leave Details</h2>

        <div style={styles.actions}>
          <button
            style={styles.applyBtn}
            onClick={() => navigate("/leave/apply")}
          >
            Apply
          </button>

          <select
            value={year}
            onChange={(e) => setYear(e.target.value)}
            style={styles.yearSelect}
          >
            <option>2026</option>
            <option>2025</option>
            <option>2024</option>
          </select>
        </div>
      </div>

      {/* GRID */}
      <div style={styles.grid}>
        {leaveData.map((leave, index) => (
          <LeaveCard key={index} data={leave} />
        ))}
      </div>
    </div>
  );
}

// =====================================================
// CARD COMPONENT
// =====================================================

function LeaveCard({ data }) {
  return (
    <div style={styles.card}>
      {/* TOP */}
      <div style={styles.cardHeader}>
        <span style={styles.leaveName}>{data.name}</span>
        <div>
          <div style={styles.granted}>Granted: {data.granted}</div>
          <div style={styles.pending}>Pending: {data.pending}</div>
        </div>
      </div>

      {/* CENTER */}
      <div style={styles.cardCenter}>
        <div style={styles.balanceNumber}>{data.balance}</div>
        <div style={styles.balanceText}>Balance</div>
      </div>

      {/* FOOTER */}
      <div style={styles.cardFooter}>
        <button style={styles.smallBtn}></button>
      </div>
    </div>
  );
}

// =====================================================
// STYLES
// =====================================================

const styles = {
  container: {
    background: "#f5f6f8",
    minHeight: "100vh",
    padding: "25px",
    fontFamily: "Arial",
    color: "#111",
  },

  headerRow: {
    display: "flex",
    justifyContent: "space-between",
    flexWrap: "wrap",
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
    alignItems: "center",
  },

  applyBtn: {
    background: "#fff",
    border: "1px solid #1976d2",
    color: "#1976d2",
    padding: "8px 18px",
    borderRadius: "6px",
    cursor: "pointer",
    fontWeight: "500",
  },

  downloadBtn: {
    background: "#1976d2",
    color: "#fff",
    border: "none",
    padding: "8px 12px",
    borderRadius: "6px",
    cursor: "pointer",
  },

  yearSelect: {
    padding: "8px 10px",
    borderRadius: "6px",
    border: "1px solid #ccc",
  },

  grid: {
    display: "grid",
    gridTemplateColumns: window.innerWidth < 768 ? "1fr" : "repeat(3, 1fr)",
    gap: "20px",
  },

  card: {
    background: "#fff",
    borderRadius: "10px",
    border: "1px solid #ddd",
    padding: "20px",
    minHeight: "150px",
    display: "flex",
    flexDirection: "column",
    justifyContent: "space-between",
    transition: "0.2s",
  },

  cardHeader: {
    display: "flex",
    justifyContent: "space-between",
    fontSize: "14px",
    color: "#444",
  },

  leaveName: {
    fontWeight: "500",
  },

  granted: {
    fontSize: "13px",
    color: "#777",
  },

  pending: {
    fontSize: "13px",
    color: "#777",
  },

  cardCenter: {
    textAlign: "center",
    marginTop: "10px",
  },

  balanceNumber: {
    fontSize: "28px",
    fontWeight: "600",
  },

  balanceText: {
    fontSize: "13px",
    color: "#777",
  },

  cardFooter: {
    textAlign: "center",
  },

  smallBtn: {
    border: "none",
    background: "#f1f1f1",
    padding: "6px 10px",
    borderRadius: "4px",
    cursor: "pointer",
    fontSize: "12px",
  },
};

// =====================================================
// EXTRA: MOCK EXTENDED UI BLOCKS (FOR FUTURE SCALING)
// =====================================================

export function LeaveBalanceSummary() {
  return (
    <div style={{ padding: "20px" }}>
      <h3>Summary Section (Future API Data)</h3>
    </div>
  );
}

export function LeaveBalanceFilters() {
  return (
    <div style={{ padding: "20px" }}>
      <h3>Filters Section (Year / Department)</h3>
    </div>
  );
}

export function LeaveBalanceCharts() {
  return (
    <div style={{ padding: "20px" }}>
      <h3>Charts Section (Graph Coming)</h3>
    </div>
  );
}

// =====================================================
// NOTE:
// This file is structured large intentionally
// for enterprise-level scalability
// =====================================================
