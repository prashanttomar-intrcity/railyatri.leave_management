import React, { useState } from "react";

// =====================================================
// PROFILE PAGE (ENTERPRISE CLEAN UI)
// =====================================================

export default function Profile() {
  const [editMode, setEditMode] = useState(false);

  const [user, setUser] = useState({
    name: "Prashant",
    email: "prashant@example.com",
    empId: "EMP001",
    department: "IT",
    phone: "9876543210",
    location: "Delhi, India",
  });

  const [form, setForm] = useState(user);

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSave = () => {
    setUser(form);
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
            <div style={styles.avatar}>{user.name.charAt(0)}</div>
            <div>
              <div style={styles.name}>{user.name}</div>
              <div style={styles.meta}>{user.email}</div>
            </div>
          </div>

          <div style={styles.divider}></div>

          <ProfileField label="Employee ID" value={user.empId} />
          <ProfileField label="Department" value={user.department} />
          <ProfileField label="Location" value={user.location} />
        </div>

        {/* DETAILS FORM */}
        <div style={styles.card}>
          <div style={styles.sectionTitle}>Personal Information</div>

          <FormField
            label="Full Name"
            name="name"
            value={form.name}
            onChange={handleChange}
            disabled={!editMode}
          />

          <FormField
            label="Email"
            name="email"
            value={form.email}
            onChange={handleChange}
            disabled={!editMode}
          />

          <FormField
            label="Phone"
            name="phone"
            value={form.phone}
            onChange={handleChange}
            disabled={!editMode}
          />

          <FormField
            label="Department"
            name="department"
            value={form.department}
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

      {/* EXTRA SECTION */}
      <div style={styles.card}>
        <div style={styles.sectionTitle}>Account Details</div>

        <div style={styles.row}>
          <div>
            <div style={styles.label}>Role</div>
            <div style={styles.value}>Software Engineer</div>
          </div>

          <div>
            <div style={styles.label}>Status</div>
            <div style={styles.value}>Active</div>
          </div>

          <div>
            <div style={styles.label}>Joining Date</div>
            <div style={styles.value}>01 Jan 2024</div>
          </div>
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
// STYLES
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
    marginBottom: "20px",
  },

  title: { fontSize: "22px", fontWeight: 600 },
  subtitle: { fontSize: "12px", color: "#777" },

  editBtn: {
    background: "#000",
    color: "#fff",
    padding: "8px 15px",
    border: "none",
    cursor: "pointer",
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
    display: "grid",
    gridTemplateColumns: "1fr 2fr",
    gap: "20px",
    marginBottom: "20px",
  },

  card: {
    background: "#fff",
    padding: "20px",
    borderRadius: "8px",
  },

  profileTop: {
    display: "flex",
    gap: "15px",
    alignItems: "center",
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

  row: {
    display: "flex",
    justifyContent: "space-between",
  },
};
