import React, { useEffect, useState } from "react";

// =====================================================
// PROFILE PAGE (DYNAMIC REAL DATA)
// =====================================================

export default function Profile() {
  const [isMobile, setIsMobile] = useState(window.innerWidth < 768);

  useEffect(() => {
    const handleResize = () => setIsMobile(window.innerWidth < 768);
    window.addEventListener("resize", handleResize);
    return () => window.removeEventListener("resize", handleResize);
  }, []);
  const [editMode, setEditMode] = useState(false);

  const [user, setUser] = useState({
    name: "",
    email: "",
    phone: "",
    location: "",
  });

  const [form, setForm] = useState(user);

  // ================= LOAD USER =================
  useEffect(() => {
    const storedUser = JSON.parse(localStorage.getItem("user")) || {};
    const extra = JSON.parse(localStorage.getItem("profile_extra")) || {};

    const merged = {
      name: storedUser.name || "",
      email: storedUser.email || "",
      phone: extra.phone || "",
      location: extra.location || "",
    };

    setUser(merged);
    setForm(merged);
  }, []);

  // ================= HANDLE CHANGE =================
  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  // ================= SAVE =================
  const handleSave = () => {
    setUser(form);

    // only save extra fields (not name/email)
    localStorage.setItem(
      "profile_extra",
      JSON.stringify({
        phone: form.phone,
        location: form.location,
      }),
    );

    setEditMode(false);
  };

  const handleCancel = () => {
    setForm(user);
    setEditMode(false);
  };

  return (
    <div style={styles.page}>
      {/* HEADER */}
      <div style={styles.headerRow}>
        <div>
          <div style={styles.title}>My Profile</div>
          <div style={styles.subtitle}>Manage your personal details</div>
        </div>

        {!editMode ? (
          <button style={styles.editBtn} onClick={() => setEditMode(true)}>
            Edit Profile
          </button>
        ) : (
          <div style={styles.actionRow}>
            <button style={styles.saveBtn} onClick={handleSave}>
              Save
            </button>
            <button style={styles.cancelBtn} onClick={handleCancel}>
              Cancel
            </button>
          </div>
        )}
      </div>

      {/* MAIN GRID */}
      <div style={styles.grid}>
        {/* PROFILE CARD */}
        <div style={styles.card}>
          <div style={styles.profileTop}>
            <div style={styles.avatar}>
              {user.name ? user.name.charAt(0) : "U"}
            </div>
            <div>
              <div style={styles.name}>{user.name}</div>
              <div style={styles.meta}>{user.email}</div>
            </div>
          </div>

          <div style={styles.divider}></div>

          <ProfileField label="Phone" value={user.phone || "—"} />
          <ProfileField label="Location" value={user.location || "—"} />
        </div>

        {/* DETAILS FORM */}
        <div style={styles.card}>
          <div style={styles.sectionTitle}>Personal Information</div>

          <FormField
            label="Full Name"
            name="name"
            value={form.name}
            onChange={handleChange}
            disabled={true} // ❌ NOT editable
          />

          <FormField
            label="Email"
            name="email"
            value={form.email}
            onChange={handleChange}
            disabled={true} // ❌ NOT editable
          />

          <FormField
            label="Phone"
            name="phone"
            value={form.phone}
            onChange={handleChange}
            disabled={!editMode}
          />

          <FormField
            label="Location"
            name="location"
            value={form.location}
            onChange={handleChange}
            disabled={!editMode}
          />
        </div>
      </div>
    </div>
  );
}

// =====================================================
// COMPONENTS
// =====================================================

function ProfileField({ label, value }) {
  return (
    <div style={styles.fieldRow}>
      <div style={styles.label}>{label}</div>
      <div style={styles.value}>{value}</div>
    </div>
  );
}

function FormField({ label, name, value, onChange, disabled }) {
  return (
    <div style={styles.formGroup}>
      <label style={styles.label}>{label}</label>
      <input
        name={name}
        value={value}
        onChange={onChange}
        disabled={disabled}
        style={{
          ...styles.input,
          background: disabled ? "#f1f1f1" : "#fff",
        }}
      />
    </div>
  );
}

// =====================================================
// STYLES (UNCHANGED)
// =====================================================

const styles = {
  page: {
    marginLeft: "10px",
    marginTop: "5px",
    padding: "20px",
    background: "#f5f6f8",
    minHeight: "100vh",
  },

  headerRow: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center", // 🔥 vertical alignment fix
    marginBottom: "20px",
  },

  title: { fontSize: "22px", fontWeight: 600 },
  subtitle: { fontSize: "12px", color: "#777", whiteSpace: "nowrap" },

  editBtn: {
    background: "#000",
    color: "#fff",
    padding: "6px 12px",
    fontSize: "13px",
    borderRadius: "6px",
    border: "none",
    cursor: "pointer",
    width: "auto",
    whiteSpace: "nowrap",
    alignSelf: "flex-start",
  },

  actionRow: { display: "flex", gap: "10px" },

  saveBtn: {
    background: "#000",
    color: "#fff",
    padding: "8px 15px",
    border: "none",
  },

  cancelBtn: {
    background: "#ddd",
    padding: "8px 15px",
    border: "none",
  },

  grid: {
    display: "flex",
    flexDirection: "column",
    gap: "20px",
    marginBottom: "20px",
  },

  card: {
    background: "#fff",
    padding: "18px",
    borderRadius: "8px",
    maxWidth: "500px",
  },

  profileTop: {
    display: "flex",
    gap: "15px",
    alignItems: "center",
    minHeight: "auto",
  },

  avatar: {
    width: "60px",
    height: "60px",
    borderRadius: "50%",
    background: "#000",
    color: "#fff",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    fontSize: "22px",
  },

  name: { fontWeight: 600, fontSize: "16px" },
  meta: { fontSize: "12px", color: "#666" },

  divider: {
    height: "1px",
    background: "#eee",
    margin: "15px 0",
  },

  fieldRow: {
    display: "flex",
    justifyContent: "space-between",
    marginBottom: "10px",
  },

  label: { fontSize: "13px", color: "#666" },
  value: { fontSize: "14px", fontWeight: 500 },

  sectionTitle: {
    fontWeight: 600,
    marginBottom: "15px",
  },

  formGroup: {
    display: "flex",
    flexDirection: "column",
    marginBottom: "10px",
  },

  input: {
    padding: "8px",
    border: "1px solid #ccc",
    borderRadius: "6px",
  },
};
