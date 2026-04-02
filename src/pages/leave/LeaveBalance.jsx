import React, { useState } from "react";

// =====================================================
// LEAVE BALANCE PAGE (FULL PROFESSIONAL HR DASHBOARD UI)
// =====================================================

export default function LeaveBalance() {
  const [year, setYear] = useState("2026");

  const leaveData = [
    { name: "Loss Of Pay", balance: 0, granted: 0 },
    { name: "Comp - Off", balance: 0, granted: 0 },
    { name: "Planned Leaves", balance: 0, granted: 0 },
    { name: "Unplanned Leaves", balance: 0, granted: 0 },
    { name: "Sick Leaves", balance: 0, granted: 0 },
    { name: "OD", balance: 0, granted: 0 },
  ];

  return (
    <div style={styles.container}>
      {/* HEADER */}
      <div style={styles.headerRow}>
        <h2 style={styles.title}>Leave Details</h2>

        <div style={styles.actions}>
          <button style={styles.applyBtn}>Apply</button>

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
        <span style={styles.granted}>Granted: {data.granted}</span>
      </div>

      {/* CENTER */}
      <div style={styles.cardCenter}>
        <div style={styles.balanceNumber}>{data.balance}</div>
        <div style={styles.balanceText}>Balance</div>
      </div>

      {/* FOOTER */}
      <div style={styles.cardFooter}>
        <button style={styles.smallBtn}>View Details</button>
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
    gridTemplateColumns: "repeat(3, 1fr)",
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
