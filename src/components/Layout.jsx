import Navbar from "./Navbar";
import Sidebar from "./Sidebar";

export default function Layout({ children }) {
  return (
    <>
      <Navbar />
      <Sidebar />

      <div style={styles.content}>{children}</div>
    </>
  );
}

const styles = {
  content: {
    marginTop: "60px", // same as navbar height
    marginLeft: "240px", // same as sidebar width
    padding: "20px",
    background: "#f1f2f6",
    minHeight: "100vh",
  },
};
