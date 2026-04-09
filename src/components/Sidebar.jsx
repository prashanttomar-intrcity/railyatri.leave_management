import { useState } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import { Box, Typography } from "@mui/material";
import HomeOutlinedIcon from "@mui/icons-material/HomeOutlined";
import EventNoteOutlinedIcon from "@mui/icons-material/EventNoteOutlined";

// ======================================================
// SIDEBAR (DARK GREY + LOGO BOX + WHITE ICONS)
// ======================================================

export default function Sidebar({ isOpen, setIsOpen, isMobile }) {
  const navigate = useNavigate();
  const location = useLocation();

  const user = JSON.parse(localStorage.getItem("user"));

  const [openMenu, setOpenMenu] = useState({
    leave: true,
  });

  const toggleMenu = (menu) => {
    setOpenMenu((prev) => ({
      ...prev,
      [menu]: !prev[menu],
    }));
  };

  const isActive = (path) => location.pathname === path;

  const isParentActive = (paths) => paths.includes(location.pathname);

  return (
    <div
      style={{
        ...styles.sidebar,
        left: isMobile ? (isOpen ? "0" : "-250px") : "0",
        transition: "0.3s",
        zIndex: 1000,
      }}
    >
      {/* NEW LOGO SECTION */}
      <Box sx={styles.logoBox}>
        <img
          src="https://images.railyatri.in/ry_images_prod/logo-1601537442.png"
          alt="Logo"
          style={{ width: 140, marginBottom: 6 }}
        />

        <Typography sx={styles.logoSubText}>Leave Management App</Typography>
      </Box>

      {/* MENU */}
      <div style={styles.menuContainer}>
        <MenuItem
          icon={<HomeOutlinedIcon style={styles.icon} />}
          label="Home"
          active={isActive("/")}
          onClick={() => navigate("/home")}
        />

        {/* LEAVE */}
        <div>
          <MenuItem
            icon={<EventNoteOutlinedIcon style={styles.icon} />}
            label="Leave"
            active={isParentActive([
              "/leave/apply",
              "/leave/balance",
              "/leave/calendar",
              "/leave/holiday",
            ])}
            onClick={() => toggleMenu("leave")}
            arrow={openMenu.leave}
          />

          <div
            style={{
              ...styles.subMenu,
              maxHeight: openMenu.leave ? "500px" : "0px",
            }}
          >
            <SubItem
              label="Apply Leave"
              active={isActive("/leave/apply")}
              onClick={() => {
                navigate("/leave/apply");
                if (isMobile) setIsOpen(false);
              }}
            />

            <SubItem
              label="Leave Details"
              active={isActive("/leave/balance")}
              onClick={() => navigate("/leave/balance")}
            />

            <SubItem
              label="Leave Calendar"
              active={isActive("/leave/calendar")}
              onClick={() => navigate("/leave/calendar")}
            />

            {user?.role === "manager" && (
              <SubItem
                label="Review Leave"
                active={isActive("/manager/review")}
                onClick={() => navigate("/manager/review")}
              />
            )}
          </div>
        </div>
      </div>

      {/* FOOTER */}
      <div style={styles.footer}>
        <div style={styles.footerItem}></div>
      </div>
    </div>
  );
}

// ======================================================
// COMPONENTS
// ======================================================

function MenuItem({ icon, label, active, onClick, arrow }) {
  return (
    <div
      onClick={onClick}
      style={{
        ...styles.menuItem,
        ...(active ? styles.activeItem : {}),
      }}
    >
      {icon}
      <span style={styles.text}>{label}</span>
      {arrow !== undefined && (
        <span style={styles.arrow}>{arrow ? "▲" : "▼"}</span>
      )}
    </div>
  );
}

function SubItem({ label, active, onClick }) {
  return (
    <div
      onClick={onClick}
      style={{
        ...styles.subItem,
        ...(active ? styles.activeSubItem : {}),
      }}
    >
      {label}
    </div>
  );
}

// ======================================================
// STYLES
// ======================================================

const styles = {
  sidebar: {
    width: "250px",
    height: "100vh",
    background: "#1f4494",
    position: "fixed",
    top: 0,
    display: "flex",
    flexDirection: "column",
    justifyContent: "space-between",
    color: "#e4e7eb",
  },

  logoBox: {
    px: 3,
    py: 3,
    display: "flex",
    flexDirection: "column",
    alignItems: "flex-start",
    borderBottom: "1px solid #3a3f45",
  },

  logoSubText: {
    color: "#94a3b8",
    fontSize: "13px",
  },

  menuContainer: {
    flex: 1,
    paddingTop: "10px",
  },

  menuItem: {
    display: "flex",
    alignItems: "center",
    padding: "12px 20px",
    cursor: "pointer",
    borderLeft: "3px solid transparent",
  },

  activeItem: {
    background: "#32383f",
    borderLeft: "3px solid #3b82f6",
  },

  icon: {
    marginRight: "12px",
    fontSize: "20px",
    color: "#ffffff",
  },

  text: {
    flex: 1,
    fontSize: "15px",
  },

  arrow: {
    fontSize: "12px",
    color: "#9aa5b1",
  },

  subMenu: {
    overflow: "hidden",
    transition: "0.3s",
  },

  subItem: {
    padding: "10px 50px",
    fontSize: "14px",
    cursor: "pointer",
    color: "#cbd2d9",
  },

  activeSubItem: {
    background: "#3a3f45",
    color: "#fff",
  },

  footer: {
    borderTop: "1px solid #3a3f45",
    padding: "10px 0",
  },

  footerItem: {
    padding: "10px 20px",
    fontSize: "13px",
    cursor: "pointer",
    color: "#cbd2d9",
  },
};
