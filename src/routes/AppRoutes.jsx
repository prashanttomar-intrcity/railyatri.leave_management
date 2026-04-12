import { Routes, Route } from "react-router-dom";
import Layout from "../components/Layout";

import Home from "../pages/Home";
import LeaveApply from "../pages/leave/LeaveApply";
import LeaveBalance from "../pages/leave/LeaveBalance";
import LeaveCalendar from "../pages/leave/LeaveCalendar";
import Profile from "../pages/Profile";
import ProtectedRoute from "./ProtectedRoute";
import PendingTab from "../pages/leave/components/PendingTab";
import HistoryTab from "../pages/leave/components/HistoryTab";
import ReviewLeave from "../pages/manager/ReviewLeave";
import LeaveDetails from "../pages/manager/LeaveDetails";
import ProtectedManagerRoute from "./ProtectedManagerRoute";

import Login from "../pages/auth/Login";
import Signup from "../pages/auth/Signup";

export default function AppRoutes() {
  return (
    <Routes>
      {/* 🔓 AUTH PAGES (NO LAYOUT) */}
      <Route path="/" element={<Signup />} />
      <Route path="/login" element={<Login />} />
      <Route path="/signup" element={<Signup />} />

      {/* PROTECTED ROUTES */}
      <Route
        path="/home"
        element={
          <ProtectedRoute>
            <LayoutWrapper>
              <Home />
            </LayoutWrapper>
          </ProtectedRoute>
        }
      />
      <Route
        path="/leave/apply"
        element={
          <ProtectedRoute>
            <LayoutWrapper>
              <LeaveApply />
            </LayoutWrapper>
          </ProtectedRoute>
        }
      />
      <Route
        path="/leave/balance"
        element={
          <LayoutWrapper>
            <LeaveBalance />
          </LayoutWrapper>
        }
      />
      <Route
        path="/leave/calendar"
        element={
          <LayoutWrapper>
            <LeaveCalendar />
          </LayoutWrapper>
        }
      />
      <Route
        path="/leave/pending-tab"
        element={
          <LayoutWrapper>
            <PendingTab />
          </LayoutWrapper>
        }
      />

      <Route
        path="/leave/history-tab"
        element={
          <LayoutWrapper>
            <HistoryTab />
          </LayoutWrapper>
        }
      />
      <Route
        path="/profile"
        element={
          <LayoutWrapper>
            <Profile />
          </LayoutWrapper>
        }
      />

      <Route
        path="/manager/review"
        element={
          <ProtectedRoute>
            <LayoutWrapper>
              <ReviewLeave />
            </LayoutWrapper>
          </ProtectedRoute>
        }
      />

      <Route
        path="/manager/review/:id"
        element={
          <ProtectedManagerRoute>
            <LayoutWrapper>
              <LeaveDetails />
            </LayoutWrapper>
          </ProtectedManagerRoute>
        }
      />
    </Routes>
  );
}

/* ✅ SMALL HELPER (NO CHANGE IN YOUR Layout.jsx) */
function LayoutWrapper({ children }) {
  return <Layout>{children}</Layout>;
}
