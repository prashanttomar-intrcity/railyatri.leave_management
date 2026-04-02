import { Routes, Route } from "react-router-dom";
import Layout from "../components/Layout";

import Home from "../pages/Home";
import LeaveApply from "../pages/leave/LeaveApply";
import LeaveBalance from "../pages/leave/LeaveBalance";
import LeaveCalendar from "../pages/leave/LeaveCalendar";
import HolidayCalendar from "../pages/leave/HolidayCalendar";
import Profile from "../pages/Profile";
import ProtectedRoute from "./ProtectedRoute";

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
          <LayoutWrapper>
            <LeaveApply />
          </LayoutWrapper>
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
        path="/leave/holiday"
        element={
          <LayoutWrapper>
            <HolidayCalendar />
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
    </Routes>
  );
}

/* ✅ SMALL HELPER (NO CHANGE IN YOUR Layout.jsx) */
function LayoutWrapper({ children }) {
  return <Layout>{children}</Layout>;
}
