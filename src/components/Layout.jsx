import { useState, useEffect } from "react";
import Navbar from "./Navbar";
import Sidebar from "./Sidebar";

export default function Layout({ children }) {
  const [isOpen, setIsOpen] = useState(false);
  const [isMobile, setIsMobile] = useState(window.innerWidth < 768);

  useEffect(() => {
    const handleResize = () => {
      setIsMobile(window.innerWidth < 768);
    };
    window.addEventListener("resize", handleResize);
    return () => window.removeEventListener("resize", handleResize);
  }, []);

  return (
    <>
      <Navbar setIsOpen={setIsOpen} isMobile={isMobile} />
      <Sidebar isOpen={isOpen} setIsOpen={setIsOpen} isMobile={isMobile} />

      {isOpen && isMobile && (
        <div onClick={() => setIsOpen(false)} style={styles.overlay} />
      )}

      <div
        style={{
          ...styles.content,
          marginLeft: isMobile ? "0" : "250px",
          width: isMobile ? "100%" : "calc(100% - 250px)",
          boxSizing: "border-box",
        }}
      >
        {children}
      </div>
    </>
  );
}

const styles = {
  content: {
    marginTop: "60px",
    padding: "15px",
    background: "#f1f2f6",
    minHeight: "100vh",
    transition: "0.3s",
    width: "100%",
    overflowX: "hidden",
  },

  overlay: {
    position: "fixed",
    top: 0,
    left: 0,
    width: "100%",
    height: "100%",
    background: "rgba(0,0,0,0.3)",
    zIndex: 999,
  },
};
