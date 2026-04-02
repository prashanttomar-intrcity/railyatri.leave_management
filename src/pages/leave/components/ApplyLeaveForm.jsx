import React, { useState, useEffect } from "react";
import { applyLeave } from "../../../api/api";

export default function ApplyLeaveForm() {
  const [form, setForm] = useState({
    type: "",
    fromDate: "",
    toDate: "",
    contact: "",
    reason: "",
    applyingTo: "",
    cc: [],
    files: [],
  });

  const [errors, setErrors] = useState({});
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);
  const [leaveDays, setLeaveDays] = useState(0);

  const [showNotice, setShowNotice] = useState(true);
  const [showApplyDropdown, setShowApplyDropdown] = useState(false);
  const [showCCDropdown, setShowCCDropdown] = useState(false);

  const leaveTypes = [
    "Loss Of Pay",
    "Comp - Off",
    "Planned Leave",
    "Unplanned Leave",
    "Sick Leave",
    "OD",
  ];

  const users = [
    "A M Tharun",
    "A Muhammed",
    "A Rehmaan",
    "John Doe",
    "Jane Smith",
  ];

  const isSickLeave = form.type === "Sick Leave";

  useEffect(() => {
    if (form.fromDate && form.toDate) {
      const start = new Date(form.fromDate);
      const end = new Date(form.toDate);
      const diff = (end - start) / (1000 * 60 * 60 * 24) + 1;
      setLeaveDays(diff > 0 ? diff : 0);
    }
  }, [form.fromDate, form.toDate]);

  const handleChange = (e) => {
    const { name, value } = e.target;

    // 🔥 CONTACT VALIDATION (10 DIGITS ONLY)
    if (name === "contact") {
      if (/^\d{0,10}$/.test(value)) {
        setForm({ ...form, contact: value });
      }
      return;
    }

    setForm({ ...form, [name]: value });
  };

  const handleFileUpload = (e) => {
    setForm({ ...form, files: Array.from(e.target.files) });
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

  const selectApplyingTo = (user) => {
    setForm({ ...form, applyingTo: user });
    setShowApplyDropdown(false);
  };

  // 🔥 VALIDATION
  const validate = () => {
    let err = {};

    if (!form.type) err.type = "Required";
    if (!form.fromDate) err.fromDate = "Required";
    if (!form.toDate) err.toDate = "Required";
    if (!form.contact || form.contact.length !== 10)
      err.contact = "Enter valid 10 digit number";
    if (!form.reason) err.reason = "Required";
    if (!form.applyingTo) err.applyingTo = "Required";

    if (isSickLeave && form.files.length === 0) {
      err.files = "Medical document required";
    }

    setErrors(err);
    return Object.keys(err).length === 0;
  };

  const handleSubmit = async () => {
    if (!validate()) return;

    const user = JSON.parse(localStorage.getItem("user"));

    console.log("USER:", user); // MUST PRINT ID

    if (!user || !user.id) {
      alert("User not found. Please login again.");
      return;
    }

    const data = {
      user_id: user.id,
      leave_type: form.type,
      from_date: form.fromDate,
      to_date: form.toDate,
      days: leaveDays,
      reason: form.reason,
      applying_to: form.applyingTo,
      contact: form.contact,
      status: "pending",
    };

    console.log("FINAL DATA SENT:", data);

    const res = await applyLeave(data);

    console.log("RESPONSE:", res);

    if (res.id) {
      alert("Leave Applied Successfully");
    } else {
      alert(JSON.stringify(res));
    }
  };

  const resetForm = () => {
    setForm({
      type: "",
      fromDate: "",
      toDate: "",
      contact: "",
      reason: "",
      applyingTo: "",
      cc: [],
      files: [],
    });
    setErrors({});
    setSuccess(false);
  };

  return (
    <div style={styles.container}>
      {/* 🔔 NOTIFICATION BAR */}
      {showNotice && (
        <div style={styles.notice}>
          Leave is earned by employee as per policy.
          <span style={styles.hide} onClick={() => setShowNotice(false)}>
            Hide
          </span>
        </div>
      )}

      <h2 style={styles.title}>Applying for Leave</h2>

      {/* SECTION 1 */}
      <div style={styles.card}>
        <div style={styles.grid}>
          <Field label="Leave Type" required error={errors.type}>
            <select
              name="type"
              value={form.type}
              onChange={handleChange}
              style={styles.input}
            >
              <option value="">Select type</option>
              {leaveTypes.map((t) => (
                <option key={t}>{t}</option>
              ))}
            </select>
          </Field>

          <Field label="From Date" required error={errors.fromDate}>
            <input
              type="date"
              name="fromDate"
              value={form.fromDate}
              onChange={handleChange}
              style={styles.input}
            />
          </Field>

          <Field label="To Date" required error={errors.toDate}>
            <input
              type="date"
              name="toDate"
              value={form.toDate}
              onChange={handleChange}
              style={styles.input}
            />
          </Field>
        </div>

        <div style={styles.info}>Leave Days: {leaveDays}</div>
      </div>

      {/* SECTION 2 */}
      <div style={styles.card}>
        {/* APPLYING TO */}
        <Field label="Applying To" required error={errors.applyingTo}>
          <div style={styles.row}>
            <div style={styles.applyBox}>{form.applyingTo || "Select"}</div>

            <button
              style={styles.plusBtn}
              onClick={() => setShowApplyDropdown(!showApplyDropdown)}
            >
              +
            </button>

            {showApplyDropdown && (
              <div style={styles.dropdown}>
                {users.map((u) => (
                  <div
                    key={u}
                    style={styles.dropdownItem}
                    onClick={() => selectApplyingTo(u)}
                  >
                    {u}
                  </div>
                ))}
              </div>
            )}
          </div>
        </Field>

        {/* CC */}
        <div style={{ marginTop: "15px" }}>
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

          {/* CC CHIPS */}
          <div style={styles.ccContainer}>
            {form.cc.map((c, i) => (
              <div key={i} style={styles.chip}>
                {c}
                <span onClick={() => removeCC(i)}>×</span>
              </div>
            ))}
          </div>
        </div>

        {/* CONTACT */}
        <Field label="Contact Details" required error={errors.contact}>
          <div style={styles.contactBox}>
            <span style={styles.prefix}>+91</span>
            <input
              name="contact"
              value={form.contact}
              onChange={handleChange}
              style={styles.contactInput}
            />
          </div>
        </Field>

        {/* REASON */}
        <Field label="Reason" required error={errors.reason}>
          <textarea
            name="reason"
            value={form.reason}
            onChange={handleChange}
            placeholder="Enter a Reason"
            style={styles.textareaFull}
          />
        </Field>

        {/* FILE */}
        {isSickLeave && (
          <Field label="Attach Medical Files" required error={errors.files}>
            <input type="file" multiple onChange={handleFileUpload} />
          </Field>
        )}
      </div>

      {/* ACTIONS */}
      <div style={styles.card}>
        <div style={styles.actions}>
          <button style={styles.submit} onClick={handleSubmit}>
            {loading ? "Submitting..." : "Submit"}
          </button>
          <button style={styles.cancel} onClick={resetForm}>
            Cancel
          </button>
        </div>

        {success && (
          <div style={styles.success}>Leave applied successfully</div>
        )}
      </div>
    </div>
  );
}

// FIELD COMPONENT
function Field({ label, children, error, required }) {
  return (
    <div style={styles.field}>
      <label style={styles.label}>
        {label} {required && <span style={styles.star}>*</span>}
      </label>
      {children}
      {error && <span style={styles.error}>{error}</span>}
    </div>
  );
}

// STYLES
const styles = {
  container: {
    background: "#f4f6f8",
    minHeight: "100vh",
    padding: "20px",
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
    marginBottom: "20px",
    fontWeight: "600",
  },

  card: {
    background: "#fff",
    padding: "20px",
    borderRadius: "8px",
    marginBottom: "20px",
    border: "1px solid #e0e0e0",
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
    marginBottom: "5px",
    fontSize: "13px",
  },

  star: { color: "red" },

  input: {
    padding: "10px",
    borderRadius: "6px",
    border: "1px solid #ccc",
  },

  textareaFull: {
    width: "100%",
    minHeight: "100px",
    padding: "10px",
    borderRadius: "6px",
    border: "1px solid #ccc",
  },

  info: {
    marginTop: "15px",
    background: "#eee",
    padding: "10px",
    borderRadius: "6px",
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
    top: "40px",
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

  applyBox: {
    padding: "10px",
    border: "1px solid #ccc",
    borderRadius: "6px",
    minWidth: "200px",
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
    cursor: "pointer",
  },

  contactBox: {
    display: "flex",
    alignItems: "center",
    border: "1px solid #ccc",
    borderRadius: "6px",
    overflow: "hidden",
  },

  prefix: {
    padding: "10px",
    background: "#eee",
    fontSize: "13px",
  },

  contactInput: {
    border: "none",
    padding: "10px",
    flex: 1,
    outline: "none",
  },

  error: {
    fontSize: "12px",
    color: "red",
  },

  actions: {
    display: "flex",
    gap: "10px",
  },

  submit: {
    background: "#000",
    color: "#fff",
    padding: "10px 20px",
    border: "none",
    borderRadius: "6px",
  },

  cancel: {
    background: "#ddd",
    padding: "10px 20px",
    border: "none",
    borderRadius: "6px",
  },

  success: {
    marginTop: "10px",
    color: "green",
  },
};
