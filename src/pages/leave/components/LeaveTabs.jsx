export default function LeaveTabs({ activeTab, setActiveTab }) {
  return (
    <div style={styles.tabs}>
      {["apply", "pending", "history"].map((tab) => (
        <button
          key={tab}
          style={{
            ...styles.tab,
            background: activeTab === tab ? "#1e90ff" : "#dfe4ea",
            color: activeTab === tab ? "#fff" : "#2f3542",
          }}
          onClick={() => setActiveTab(tab)}
        >
          {tab.toUpperCase()}
        </button>
      ))}
    </div>
  );
}

const styles = {
  tabs: {
    display: "flex",
    gap: "10px",
    marginBottom: "20px",
  },
  tab: {
    padding: "10px 20px",
    border: "none",
    cursor: "pointer",
    borderRadius: "5px",
  },
};
