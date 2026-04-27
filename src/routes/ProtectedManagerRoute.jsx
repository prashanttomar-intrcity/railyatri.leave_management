import { Navigate, useLocation } from "react-router-dom";

export default function ProtectedManagerRoute({ children }) {
  const user = JSON.parse(localStorage.getItem("user"));
  const location = useLocation();

  // ❌ Not logged in
  if (!user) {
    return <Navigate to="/login" state={{ from: location.pathname }} replace />;
  }

  // ❌ Logged in but NOT manager
  // Allow if user is manager of someone OR self manager
  if (!user || user.id !== user.manager_id) {
    return <Navigate to="/login" state={{ from: location.pathname }} replace />;
  }

  // ✅ Manager → allow
  return children;
}
