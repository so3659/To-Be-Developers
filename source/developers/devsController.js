import baseResponse from "../../config/baseResponeStatus";
import { response } from "../../config/response";
import devsProvider from "./devsProvider";

const devsController = {
	devReport: async (req, res) => {
		try {
			const { devType, role } = req.query;
			if (Number(devType) > 14) return res.status(404).json(response(baseResponse.WRONG_DEVTYPE));
			const roles = ["junior", "midlevel", "senior"];
			if (roles.indexOf(role) === -1) return res.status(404).json(response(baseResponse.WRONG_ROLE));
			const report = await devsProvider.makeDevsReport(devType, role);
			if (report.error) {
				return res.status(400).json(response(baseResponse.SERVER_ERROR, report));
			}
			return res.status(200).json(response(baseResponse.SUCCESS, report));
		} catch (e) {
			console.log(e);
			return res.status(500).json(response(baseResponse.SERVER_ERROR, { message: e.message }));
		}
	},
};

export default devsController;
