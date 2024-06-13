import pool from "../../config/database";
import lecturesDao from "./lecturesDao";

const lecturesProvider = {
    getRandomLectures: async () => {
        try {
            const connection = await pool.getConnection();
            const lectures = await lecturesDao.selectLectures(connection);
            for (const lecture of lectures) {
                if ("inflearn" === lecture.image_url){
                    lecture.link_url = "https://inflearn.com" + lecture.link_url;
                }
                else {
                    lecture.link_url = "https://udemy.com" + lecture.link_url;
                }

            }
            return lectures;
        } catch (e) {
            return {error: true, message: e.message};
        }
    }

};

export default lecturesProvider;
