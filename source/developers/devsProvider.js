import pool from "../../config/database";
import devsDao from "./devsDao";
import categoryMap from "./categoryMap";

const devsProvider = {
    makeDevsReport : async (devType, role) => {
        try {
        const connection = await pool.getConnection();
        const editorRank = await devsDao.selectEditorRank(devType, role, connection);
        if (editorRank && editorRank.error) {return editorRank}

        const langRank = await devsDao.selectLangRank(devType, role, connection);
        if (langRank && langRank.error) {return langRank}

        const frameworkRank = await devsDao.selectFrameworkRank(devType, role, connection);
        if (frameworkRank && frameworkRank.error) {return frameworkRank}

        const jobCodeHours = await devsDao.selectJobCode(devType, role, connection);
        if (jobCodeHours && jobCodeHours.error) {return jobCodeHours}

        const learnTime = await devsDao.selectLearnTime(devType, role, connection);
        if (learnTime && learnTime.error) {return learnTime}

        const productiveToJob = await devsDao.selectProductiveToJob(devType, role, connection);
        if (productiveToJob && productiveToJob.error) {return productiveToJob}

        const sleepHours = await devsDao.selectSleep(devType, role, connection);
        if (sleepHours && sleepHours.error) {return sleepHours}

        const recommendLectures = await devsDao.selectLectures(categoryMap[devType], connection);
        if (recommendLectures && recommendLectures.error) {return recommendLectures}
        for (const lecture of recommendLectures) {
            if ("inflearn" === recommendLectures.image_url){
                recommendLectures.link_url = "https://inflearn.com" + recommendLectures.link_url;
            }
            else {
                recommendLectures.link_url = "https://udemy.com" + recommendLectures.link_url;
            }

        }

        const devReport= {editorRank, langRank, frameworkRank, jobCodeHours, learnTime, productiveToJob, sleepHours, recommendLectures};
        return devReport;
        } catch (e) {
            console.log(e)
            return {error: true, message: e.message};
        }
    },
};

export default devsProvider;
