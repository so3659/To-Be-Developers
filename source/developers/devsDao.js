const devsDao = {
    selectEditorRank: async (devType, role, connection) => {
        const sql = 'select `rank`, editor, `count` from editorRank where role = ? and develop_id = ? order by `rank` asc limit 5';
        try {
            const [result] = await connection.query(sql, [role, Number(devType)]);
            return result;
        } catch (e) {
            console.log(e);
            return {error: true, message: e.message};
        }
    },
};

export default devsDao;
