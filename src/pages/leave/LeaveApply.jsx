import { useState } from "react";
import ApplyLeaveForm from "./components/ApplyLeaveForm";
import CompOffGrant from "./components/CompOffGrant";
import PendingTab from "./components/PendingTab";
import HistoryTab from "./components/HistoryTab";

// ==============================================
// MAIN LEAVE APPLY PAGE (FIXED PROFESSIONAL UI)
// ==============================================

export default function LeaveApply() {
  const [activeTab, setActiveTab] = useState("apply");
  const [leaveType, setLeaveType] = useState("leave");

  const renderContent = () => {
    if (activeTab === "pending") return <PendingTab />;
    if (activeTab === "history") return <HistoryTab />;

    switch (leaveType) {
      case "leave":
        return <ApplyLeaveForm />;
      case "comp":
        return <CompOffGrant />;
      default:
        return <ApplyLeaveForm />;
    }
  };

  return (
    <div style={styles.container}>
      {/* HEADER */}
      <h1 style={styles.heading}>Leave Apply</h1>

      {/* TOP TABS */}
      <div style={styles.topTabs}>
        {["apply", "pending", "history"].map((tab) => (
          <div
            key={tab}
            onClick={() => setActiveTab(tab)}
            style={{
              ...styles.tab,
              background: activeTab === tab ? "#000" : "#f1f1f1",
              color: activeTab === tab ? "#fff" : "#333",
            }}
          >
            {tab.charAt(0).toUpperCase() + tab.slice(1)}
          </div>
        ))}
      </div>

      {/* MAIN CARD */}
      <div style={styles.card}>
        {/* LEAVE TYPE SELECTOR */}
        {activeTab === "apply" && (
          <div style={styles.typeTabs}>
            {[
              { key: "leave", label: "Leave" },
              { key: "comp", label: "Comp Off Grant" },
            ].map((item) => (
              <div
                key={item.key}
                onClick={() => setLeaveType(item.key)}
                style={{
                  ...styles.typeTab,
                  borderBottom:
                    leaveType === item.key
                      ? "2px solid black"
                      : "2px solid transparent",
                  color: leaveType === item.key ? "#000" : "#666",
                }}
              >
                {item.label}
              </div>
            ))}
          </div>
        )}

        {/* CONTENT AREA */}
        <div style={styles.content}>{renderContent()}</div>
      </div>
    </div>
  );
}

// ================= STYLES =================

const styles = {
  container: {
    background: "#f5f6f8",
    minHeight: "100vh",
    padding: "25px",
    fontFamily: "Arial",
  },

  heading: {
    fontSize: "22px",
    fontWeight: "600",
    marginBottom: "15px",
  },

  topTabs: {
    display: "flex",
    gap: "10px",
    marginBottom: "20px",
  },

  tab: {
    padding: "8px 20px",
    borderRadius: "6px",
    cursor: "pointer",
    fontSize: "14px",
    fontWeight: "500",
  },

  card: {
    background: "#fff",
    borderRadius: "8px",
    border: "1px solid #ddd",
    padding: "20px",
  },

  typeTabs: {
    display: "flex",
    gap: "25px",
    borderBottom: "1px solid #ddd",
    marginBottom: "20px",
  },

  typeTab: {
    paddingBottom: "10px",
    cursor: "pointer",
    fontSize: "14px",
    fontWeight: "500",
  },

  content: {
    marginTop: "10px",
  },
};
