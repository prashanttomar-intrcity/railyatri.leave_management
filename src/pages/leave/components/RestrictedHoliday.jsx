// based on your original file :contentReference[oaicite:0]{index=0}

import React, { useState } from "react";
import { applyRestrictedHoliday } from "../../../api/api";
import ConfirmModal from "../../../components/ConfirmModal";
import SuccessModal from "../../../components/SuccessModal";

export default function RestrictedHoliday() {
  const [form, setForm] = useState({
    holiday: "",
    remarks: "",
    cc: [],
    manager: "",
  });

  const [confirmOpen, setConfirmOpen] = useState(false);
  const [successOpen, setSuccessOpen] = useState(false);

  const [errors, setErrors] = useState({});
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);

  const [showNotice, setShowNotice] = useState(true);
  const [showManagerDropdown, setShowManagerDropdown] = useState(false);
  const [showCCDropdown, setShowCCDropdown] = useState(false);

  const holidays = [
    "Diwali",
    "Holi",
    "Eid",
    "Christmas",
    "Independence Day",
    "Republic Day",
  ];

  const users = [
    "Kalpesh Kumar",
    "A M Tharun",
    "A Muhammed",
    "A Rehmaan",
    "John Doe",
  ];

  // ==============================
  // HANDLERS
  // ==============================

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const selectManager = (user) => {
    setForm({ ...form, manager: user });
    setShowManagerDropdown(false);
  };

  const addCCUser = (user) => {
    if (!form.cc.includes(user)) {
      setForm({ ...form, cc: [...form.cc, user] });
    }
    setShowCCDropdown(false);
  };

  const removeCC = (index) => {
    setForm({
      ...form,
      cc: form.cc.filter((_, i) => i !== index),
    });
  };

  const validate = () => {
    let err = {};
    if (!form.holiday) err.holiday = "Required";
    if (!form.remarks) err.remarks = "Required";
    if (!form.manager) err.manager = "Required";

    setErrors(err);
    return Object.keys(err).length === 0;
  };

  const handleSubmit = async () => {
    if (!validate()) return;

    setLoading(true);

    const user = JSON.parse(localStorage.getItem("user"));
    const data = {
      user_id: user.id,
      leave_type: "Restricted Holiday",
      from_date: new Date(),
      to_date: new Date(),
      days: 1,
      reason: form.remarks,
      applying_to: form.manager,
      contact: "",
      status: "pending",
    };

    const res = await applyRestrictedHoliday(data);

    setLoading(false);

    if (res.id) {
      setSuccess(true);
    }
  };

  const resetForm = () => {
    setForm({ holiday: "", remarks: "", cc: [], manager: "" });
    setErrors({});
    setSuccess(false);
  };

  return (
    <div style={styles.container}>
      {/* 🔔 NOTIFICATION */}
      {showNotice && (
        <div style={styles.notice}>
          Restricted Holidays (RH) are a set of holidays allocated by the
          company that are optional for the employee to utilize. The company
          sets a limit on the amount of holidays that can be used.
          <span style={styles.hide} onClick={() => setShowNotice(false)}>
            Hide
          </span>
        </div>
      )}

      <h2 style={styles.title}>Applying for Restricted Holiday</h2>

      <div style={styles.card}>
        <Field
          label={
            <>
              Holiday <span style={{ color: "red" }}>*</span>
            </>
          }
          error={errors.holiday}
        >
          <select
            name="holiday"
            value={form.holiday}
            onChange={handleChange}
            style={styles.input}
          >
            <option value="">Select holiday</option>
            {holidays.map((h) => (
              <option key={h}>{h}</option>
            ))}
          </select>
        </Field>

        {/* MANAGER DROPDOWN */}
        <div style={styles.field}>
          <label style={styles.label}>
            Manager <span style={{ color: "red" }}>*</span>
          </label>

          <div style={styles.row}>
            <div style={styles.userBox}>
              <div style={styles.avatar}></div>
              <div>
                <div style={styles.userName}>
                  {form.manager || "Select Manager"}
                </div>
                <div style={styles.userId}>#11</div>
              </div>
            </div>

            <button
              style={styles.plusBtn}
              onClick={() => setShowManagerDropdown(!showManagerDropdown)}
            >
              +
            </button>

            {showManagerDropdown && (
              <div style={styles.dropdown}>
                {users.map((u) => (
                  <div
                    key={u}
                    style={styles.dropdownItem}
                    onClick={() => selectManager(u)}
                  >
                    {u}
                  </div>
                ))}
              </div>
            )}
          </div>

          {errors.manager && <span style={styles.error}>{errors.manager}</span>}
        </div>

        {/* CC SECTION */}
        <div style={styles.ccSection}>
          <label style={styles.label}>CC to</label>

          <div style={styles.row}>
            <button
              style={styles.plusBtn}
              onClick={() => setShowCCDropdown(!showCCDropdown)}
            >
              +
            </button>

            {showCCDropdown && (
              <div style={styles.dropdown}>
                {users.map((u) => (
                  <div
                    key={u}
                    style={styles.dropdownItem}
                    onClick={() => addCCUser(u)}
                  >
                    {u}
                  </div>
                ))}
              </div>
            )}
          </div>

          {/* CHIPS */}
          <div style={styles.ccContainer}>
            {form.cc.map((c, i) => (
              <div key={i} style={styles.chip}>
                {c}
                <span onClick={() => removeCC(i)}>×</span>
              </div>
            ))}
          </div>
        </div>

        {/* REMARKS */}
        <Field label="Remarks" error={errors.remarks}>
          <textarea
            name="remarks"
            value={form.remarks}
            onChange={handleChange}
            placeholder="Enter remarks"
            style={styles.textarea}
          />
        </Field>

        {/* ACTIONS */}
        <div style={styles.actions}>
          <button style={styles.submit} onClick={() => setConfirmOpen(true)}>
            {loading ? "Submitting..." : "Submit"}
          </button>

          <button style={styles.cancel} onClick={resetForm}>
            Cancel
          </button>
        </div>

        {success && (
          <div style={styles.success}>Holiday Applied Successfully</div>
        )}
      </div>
      <ConfirmModal
        open={confirmOpen}
        title="Apply Leave"
        message="Are you sure you want to apply for this leave?"
        confirmText="Submit"
        onCancel={() => setConfirmOpen(false)}
        onConfirm={async () => {
          await handleSubmit();
          setConfirmOpen(false);
          setSuccessOpen(true);
        }}
      />
      <SuccessModal
        open={successOpen}
        message="Restricted Holiday Leave applied successfully"
        onClose={() => setSuccessOpen(false)}
      />
    </div>
  );
}

// FIELD COMPONENT
function Field({ label, children, error }) {
  return (
    <div style={styles.field}>
      <label style={styles.label}>{label}</label>
      {children}
      {error && <span style={styles.error}>{error}</span>}
    </div>
  );
}

// STYLES (UNCHANGED + small additions)
const styles = {
  container: {
    background: "#f5f6f8",
    minHeight: "100vh",
    padding: "20px",
    fontFamily: "Arial",
  },

  notice: {
    background: "#f0f0e6",
    color: "#070707",
    padding: "10px",
    borderRadius: "6px",
    marginBottom: "15px",
    display: "flex",
    justifyContent: "space-between",
    fontSize: "13px",
  },

  hide: {
    cursor: "pointer",
    fontWeight: "bold",
    color: "blue",
  },

  title: {
    fontSize: "22px",
    fontWeight: "600",
    marginBottom: "20px",
  },

  card: {
    background: "#fff",
    padding: "25px",
    borderRadius: "8px",
    border: "1px solid #ddd",
    maxWidth: "900px",
  },

  field: {
    marginBottom: "15px",
    display: "flex",
    flexDirection: "column",
  },

  label: {
    marginBottom: "5px",
    fontSize: "13px",
    color: "#444",
  },

  input: {
    padding: "10px",
    borderRadius: "6px",
    border: "1px solid #ccc",
  },

  textarea: {
    padding: "10px",
    borderRadius: "6px",
    border: "1px solid #ccc",
    minHeight: "90px",
  },

  error: {
    color: "#d32f2f",
    fontSize: "12px",
  },

  row: {
    display: "flex",
    alignItems: "center",
    gap: "10px",
    position: "relative",
  },

  plusBtn: {
    width: "32px",
    height: "32px",
    borderRadius: "50%",
    border: "1px solid #ccc",
    cursor: "pointer",
  },

  dropdown: {
    position: "absolute",
    top: "45px",
    left: "0",
    background: "#fff",
    border: "1px solid #ccc",
    borderRadius: "6px",
    width: "200px",
    zIndex: 10,
  },

  dropdownItem: {
    padding: "8px",
    cursor: "pointer",
  },

  userBox: {
    display: "flex",
    alignItems: "center",
    gap: "10px",
    background: "#f1f1f1",
    padding: "10px",
    borderRadius: "6px",
    minWidth: "250px",
  },

  avatar: {
    width: "35px",
    height: "35px",
    borderRadius: "50%",
    background: "#ccc",
  },

  userName: {
    fontSize: "14px",
    fontWeight: "500",
  },

  userId: {
    fontSize: "12px",
    color: "#666",
  },

  ccContainer: {
    marginTop: "10px",
    display: "flex",
    gap: "8px",
    flexWrap: "wrap",
  },

  chip: {
    background: "#e0e0e0",
    padding: "6px 10px",
    borderRadius: "20px",
    display: "flex",
    gap: "6px",
    alignItems: "center",
  },

  ccSection: {
    marginBottom: "15px",
  },

  actions: {
    display: "flex",
    gap: "10px",
    marginTop: "15px",
  },

  submit: {
    background: "#000",
    color: "#fff",
    padding: "10px 20px",
    border: "none",
    borderRadius: "6px",
  },

  cancel: {
    background: "#e0e0e0",
    padding: "10px 20px",
    border: "none",
    borderRadius: "6px",
  },

  success: {
    marginTop: "10px",
    color: "green",
  },
};
