const lecturesDao = {
    selectLectures: async (connection) => {
        const sql = 'select * from lectures order by rand() limit 10';
        try {
            const [result] = await connection.query(sql);
            return result;
        } catch (e) {
            console.log(e);
            return {error: true, message: e.message};
        }
    }
};

export default lecturesDao;
