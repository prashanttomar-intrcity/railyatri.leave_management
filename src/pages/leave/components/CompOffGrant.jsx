import React, { useState, useEffect } from "react";
import { applyCompOff } from "../../../api/api";

export default function CompOffGrant() {
  const [form, setForm] = useState({
    type: "Comp Off",
    fromDate: "",
    toDate: "",
    days: "",
    reason: "",
    cc: [],
    manager: "",
  });

  const [leaveDays, setLeaveDays] = useState(0);
  const [errors, setErrors] = useState({});
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);

  const [showNotice, setShowNotice] = useState(true);
  const [showManagerDropdown, setShowManagerDropdown] = useState(false);
  const [showCCDropdown, setShowCCDropdown] = useState(false);

  const users = [
    "Kalpesh Kumar",
    "A M Tharun",
    "A Muhammed",
    "A Rehmaan",
    "John Doe",
  ];

  // ================= CALCULATE DAYS =================
  useEffect(() => {
    if (form.fromDate && form.toDate) {
      const start = new Date(form.fromDate);
      const end = new Date(form.toDate);
      const diff = (end - start) / (1000 * 60 * 60 * 24) + 1;
      const finalDays = diff > 0 ? diff : 0;
      setLeaveDays(finalDays);
      setForm((prev) => ({ ...prev, days: finalDays }));
    }
  }, [form.fromDate, form.toDate]);

  // ================= HANDLERS =================
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

  const removeCC = (i) => {
    setForm({ ...form, cc: form.cc.filter((_, index) => index !== i) });
  };

  // ================= VALIDATION =================
  const validate = () => {
    let err = {};

    if (!form.type) err.type = "Required";
    if (!form.fromDate) err.fromDate = "Required";
    if (!form.toDate) err.toDate = "Required";
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
      leave_type: "Comp Off",
      from_date: form.fromDate,
      to_date: form.toDate,
      days: leaveDays,
      reason: form.reason,
      applying_to: form.manager,
      contact: "",
      status: "pending",
    };

    const res = await applyCompOff(data);

    setLoading(false);

    if (res.id) {
      setSuccess(true);
    }
  };

  const resetForm = () => {
    setForm({
      type: "Comp Off",
      fromDate: "",
      toDate: "",
      days: "",
      reason: "",
      cc: [],
      manager: "",
    });
    setSuccess(false);
    setErrors({});
  };

  return (
    <div style={styles.container}>
      {/* 🔔 NOTIFICATION */}
      {showNotice && (
        <div style={styles.notice}>
          Compensatory Off is additional leave granted as a compensation for
          working overtime or on an off day.
          <span style={styles.hide} onClick={() => setShowNotice(false)}>
            Hide
          </span>
        </div>
      )}

      <h2 style={styles.title}>Comp Off Grant</h2>

      <div style={styles.card}>
        <h3 style={styles.subtitle}>Applying for Comp Off Grant</h3>

        {/* GRID */}
        <div style={styles.grid}>
          <Field label="Leave Type" error={errors.type}>
            <input
              value="Comp Off"
              readOnly
              style={{ ...styles.input, background: "#eee" }}
            />
          </Field>

          <Field
            label={
              <>
                From Date <span style={{ color: "red" }}>*</span>
              </>
            }
            error={errors.fromDate}
          >
            <input
              type="date"
              name="fromDate"
              value={form.fromDate}
              onChange={handleChange}
              style={styles.input}
            />
          </Field>

          <Field
            label={
              <>
                To Date <span style={{ color: "red" }}>*</span>
              </>
            }
            error={errors.toDate}
          >
            <input
              type="date"
              name="toDate"
              value={form.toDate}
              onChange={handleChange}
              style={styles.input}
            />
          </Field>

          <Field label="Days">
            <input
              value={form.days}
              readOnly
              style={{ ...styles.input, background: "#eee" }}
            />
          </Field>
        </div>

        {/* APPLYING TO */}
        <div style={styles.field}>
          <label style={styles.label}>
            Applying to <span style={{ color: "red" }}>*</span>
          </label>

          <div style={styles.row}>
            <div style={styles.userBox}>
              <div style={styles.avatar}></div>
              <div>
                <div>{form.manager || "Select Manager"}</div>
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

        {/* CC */}
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

          <div style={styles.ccContainer}>
            {form.cc.map((c, i) => (
              <div key={i} style={styles.chip}>
                {c}
                <span onClick={() => removeCC(i)}>×</span>
              </div>
            ))}
          </div>
        </div>

        {/* REASON */}
        <Field label="Reason">
          <textarea
            name="reason"
            value={form.reason}
            onChange={handleChange}
            placeholder="Enter a reason"
            style={styles.textarea}
          />
        </Field>

        {/* ACTIONS */}
        <div style={styles.actions}>
          <button style={styles.submit} onClick={handleSubmit}>
            {loading ? "Submitting..." : "Submit"}
          </button>
          <button style={styles.cancel} onClick={resetForm}>
            Cancel
          </button>
        </div>

        {success && (
          <div style={styles.success}>Comp Off Applied Successfully</div>
        )}
      </div>
    </div>
  );
}

// FIELD
function Field({ label, children, error }) {
  return (
    <div style={styles.field}>
      <label style={styles.label}>{label}</label>
      {children}
      {error && <span style={styles.error}>{error}</span>}
    </div>
  );
}

// STYLES (UNCHANGED + SMALL ADDITIONS)
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
    marginBottom: "15px",
  },

  infoBox: {
    background: "#f0f0e6",
    padding: "12px",
    borderRadius: "6px",
    marginBottom: "20px",
  },

  card: {
    background: "#fff",
    padding: "25px",
    borderRadius: "8px",
    border: "1px solid #ddd",
  },

  subtitle: {
    marginBottom: "20px",
    fontSize: "16px",
  },

  grid: {
    display: "grid",
    gridTemplateColumns: "1fr 1fr 1fr",
    gap: "15px",
  },

  field: {
    display: "flex",
    flexDirection: "column",
    marginTop: "10px",
  },

  label: {
    fontSize: "13px",
    marginBottom: "5px",
  },

  input: {
    padding: "10px",
    border: "1px solid #ccc",
    borderRadius: "6px",
  },

  textarea: {
    padding: "10px",
    border: "1px solid #ccc",
    borderRadius: "6px",
    minHeight: "90px",
  },

  error: {
    fontSize: "12px",
    color: "#d32f2f",
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
    marginTop: "15px",
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

  userId: {
    fontSize: "12px",
    color: "#666",
  },

  ccSection: {
    marginTop: "15px",
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

  actions: {
    display: "flex",
    gap: "10px",
    marginTop: "20px",
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
