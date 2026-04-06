const BASE_URL = "http://localhost:3000/api";

export const signup = (data) =>
  fetch(`${BASE_URL}/signup`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  }).then((res) => res.json());

export const login = (data) =>
  fetch(`${BASE_URL}/login`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  }).then((res) => res.json());

export const applyLeave = async (data) => {
  const user = JSON.parse(localStorage.getItem("user"));

  return fetch(`${BASE_URL}/leave_requests`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      ...data,
      user_id: user.id, // ✅ FORCE
    }),
  }).then((res) => res.json());
};

export const getLeaves = async () => {
  const user = JSON.parse(localStorage.getItem("user"));

  if (!user || !user.id) {
    console.error("User not found");
    return [];
  }

  const res = await fetch(`${BASE_URL}/leave_requests?user_id=${user.id}`);

  return res.json();
};

export const applyRestrictedHoliday = (data) =>
  fetch(`${BASE_URL}/leave_requests`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  }).then((res) => res.json());

export const applyCompOff = (data) =>
  fetch(`${BASE_URL}/leave_requests`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  }).then((res) => res.json());

export const updateLeaveStatus = (id, status) =>
  fetch(`${BASE_URL}/leave_requests/${id}`, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ status }),
  }).then((res) => res.json());
