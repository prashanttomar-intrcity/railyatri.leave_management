import { useState, useRef, useEffect } from "react";
import { useNavigate } from "react-router-dom";

// ==========================================================
// ADVANCED NAVBAR (DARK + CLEAN + ENTERPRISE READY)
// ==========================================================

const SIDEBAR_WIDTH = 250;
const NAVBAR_HEIGHT = 60;

export default function Navbar() {
  const [open, setOpen] = useState(false);
  const dropdownRef = useRef();
  const navigate = useNavigate();

  const user = {
    name: "Prashant",
    email: "prashant@example.com",
  };

  // ================= CLICK OUTSIDE =================
  useEffect(() => {
    const handleClickOutside = (e) => {
      if (dropdownRef.current && !dropdownRef.current.contains(e.target)) {
        setOpen(false);
      }
    };

    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const handleLogout = () => {
    localStorage.removeItem("user"); // remove session
    navigate("/login"); // go to login page
  };

  return (
    <div style={styles.navbar}>
      {/* LEFT */}
      <div style={styles.leftSection}>
        {/* <div style={styles.pageTitle}>Leave Management</div> */}
      </div>

      {/* RIGHT */}
      <div style={styles.rightSection} ref={dropdownRef}>
        {/* NOTIFICATION */}
        <div style={styles.iconBtn}>🔔</div>

        {/* AVATAR */}
        <div style={styles.avatar} onClick={() => setOpen(!open)}>
          {user.name.charAt(0)}
        </div>

        {/* ✅ NEW LOGOUT BUTTON */}
        <button style={styles.logoutBtn} onClick={handleLogout}>
          Logout
        </button>

        {/* DROPDOWN */}
        {open && (
          <div style={styles.dropdown}>
            {/* USER */}
            <div style={styles.userBox}>
              <div style={styles.avatarLarge}>{user.name.charAt(0)}</div>
              <div>
                <div style={styles.name}>{user.name}</div>
                <div style={styles.email}>{user.email}</div>
              </div>
            </div>

            <div style={styles.divider}></div>

            {/* ONLY PROFILE */}
            <DropdownItem
              label="My Profile"
              onClick={() => {
                navigate("/profile");
                setOpen(false);
              }}
            />
          </div>
        )}
      </div>
    </div>
  );
}

// ==========================================================
// DROPDOWN ITEM
// ==========================================================

function DropdownItem({ label, onClick, danger }) {
  return (
    <div
      onClick={onClick}
      style={{
        ...styles.dropdownItem,
        color: danger ? "#ff4d4f" : "#333",
      }}
    >
      {label}
    </div>
  );
}

// ==========================================================
// STYLES
// ==========================================================

const styles = {
  navbar: {
    position: "fixed",
    top: 0,
    left: SIDEBAR_WIDTH,
    width: `calc(100% - ${SIDEBAR_WIDTH}px)`,
    height: NAVBAR_HEIGHT,
    background: "#1f2933",
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    padding: "0 25px",
    boxSizing: "border-box",
    borderBottom: "1px solid #3a3f45",
    zIndex: 1000,
  },

  logoutBtn: {
    background: "#fdfbfb",
    color: "#bb0707",
    border: "none",
    padding: "6px 12px",
    borderRadius: "6px",
    cursor: "pointer",
    fontSize: "13px",
  },

  leftSection: {
    display: "flex",
    alignItems: "center",
  },

  pageTitle: {
    color: "#fff",
    fontSize: "16px",
    fontWeight: "500",
  },

  rightSection: {
    display: "flex",
    alignItems: "center",
    gap: "18px",
    position: "relative",
  },

  quickLinks: {
    color: "#cbd2d9",
    fontSize: "13px",
    cursor: "pointer",
  },

  iconBtn: {
    color: "#cbd2d9",
    cursor: "pointer",
    fontSize: "16px",
  },

  avatar: {
    width: "36px",
    height: "36px",
    borderRadius: "50%",
    background: "#f0f0e6",
    color: "#070707",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    fontWeight: "bold",
    cursor: "pointer",
  },

  dropdown: {
    position: "absolute",
    right: 0,
    top: "55px",
    width: "260px",
    background: "#fff",
    borderRadius: "10px",
    boxShadow: "0 10px 30px rgba(0,0,0,0.2)",
    overflow: "hidden",
  },

  userBox: {
    display: "flex",
    gap: "10px",
    padding: "15px",
    alignItems: "center",
  },

  avatarLarge: {
    width: "45px",
    height: "45px",
    borderRadius: "50%",
    background: "#f0f0e6",
    color: "#070707",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    fontWeight: "bold",
  },

  name: {
    fontWeight: "600",
  },

  email: {
    fontSize: "12px",
    color: "#777",
  },

  divider: {
    height: "1px",
    background: "#eee",
  },

  dropdownItem: {
    padding: "12px 15px",
    cursor: "pointer",
    fontSize: "14px",
  },
};

// ==========================================================
// EXTRA BLOCKS FOR FUTURE SCALABILITY
// ==========================================================

export function NavbarSearch() {
  return <div style={{ padding: 20 }}>Search Component</div>;
}

export function NavbarNotifications() {
  return <div style={{ padding: 20 }}>Notifications Component</div>;
}

export function NavbarActions() {
  return <div style={{ padding: 20 }}>Actions Component</div>;
}

// ==========================================================
// NOTE:
// This navbar is scalable for enterprise usage
// ==========================================================
