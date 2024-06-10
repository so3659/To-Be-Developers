import baseResponse from "../../config/baseResponeStatus";
import { response } from "../../config/response";
import devsProvider from "./devsProvider";

const devsController = {
    devReport: async (req, res) => {
        try {
            const {devType, role} = req.query;
            const report = await devsProvider.makeDevsReport(devType, role);
            return res.status(200).json(response(baseResponse.SUCCESS, report));
        } catch (e) {

        }
    }
};

export default devsController;
