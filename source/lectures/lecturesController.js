import baseResponse from "../../config/baseResponeStatus";
import { response } from "../../config/response";
import lecturesProvider from "./lecturesProvider";
import lecturesService from "./lecturesService";

const lecturesController = {
    getRandomLectures: async (req, res) => {
        try {
            const lectures = await lecturesProvider.getRandomLectures();
            if (lectures.error) {return res.status(400).json(response(baseResponse.SERVER_ERROR, lectures))}
            return res.status(200).json(response(baseResponse.SUCCESS, lectures));
        } catch (e) {
            return res.status(500).json(response(baseResponse.SERVER_ERROR))
        }
    }
};

export default lecturesController;
