import baseResponse from "../../config/baseResponeStatus";
import { response } from "../../config/response";
import devsProvider from "./devsProvider";

const devsController = {
    devReport: async (req, res) => {
        try {
            const {devType, role} = req.query;
            const report = await devsProvider.makeDevsReport(devType, role);
            if (report.error) {return res.status(400).json(response(baseResponse.SERVER_ERROR, report))}
            return res.status(200).json(response(baseResponse.SUCCESS, report));
        } catch (e) {
            return res.status(500).json(response(baseResponse.SERVER_ERROR))
        }
    }
};

export default devsController;
