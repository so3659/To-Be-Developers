import pool from "../../config/database";
import devsDao from "./devsDao";

const devsProvider = {
    makeDevsReport : async (devType, role) => {
        const connection = await pool.getConnection();
        const devReport = await devsDao.selectReportInfo(devType, role, connection);
        return devReport;
    },
};

export default devsProvider;
