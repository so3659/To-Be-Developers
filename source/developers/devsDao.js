const devsDao = {
	selectSalary: async (devType, role, connection) => {
		const sql = `SELECT salary FROM salary WHERE role = ? and develop_id = ?`;
		try {
			const [result] = await connection.query(sql, [role, Number(devType)]);
			return result;
		} catch (e) {
			console.log(e);
			return { error: true, message: e.message };
		}
	},

	selectEditorRank: async (devType, role, connection) => {
		const sql =
			"select `rank`, editor, `count` from editorRank where role = ? and develop_id = ? order by `rank` asc limit 5";
		try {
			const [result] = await connection.query(sql, [role, Number(devType)]);
			return result;
		} catch (e) {
			console.log(e);
			return { error: true, message: e.message };
		}
	},

	selectLangRank: async (devType, role, connection) => {
		const sql =
			"select `rank`, language, `count` from languageRank where role = ? and develop_id = ? order by `rank` asc limit 5";
		try {
			const [result] = await connection.query(sql, [role, Number(devType)]);
			return result;
		} catch (e) {
			console.log(e);
			return { error: true, message: e.message };
		}
	},

	selectFrameworkRank: async (devType, role, connection) => {
		const sql =
			"select `rank`, framework, `count` from frameworkRank where role = ? and develop_id = ? order by `rank` asc limit 5";
		try {
			const [result] = await connection.query(sql, [role, Number(devType)]);
			return result;
		} catch (e) {
			console.log(e);
			return { error: true, message: e.message };
		}
	},

	selectJobCode: async (devType, role, connection) => {
		const sql = "select percent from jobCode where role = ? and develop_id = ? order by `rank` asc limit 1";
		try {
			const [[result]] = await connection.query(sql, [role, Number(devType)]);
			return result;
		} catch (e) {
			console.log(e);
			return { error: true, message: e.message };
		}
	},

	selectLearnTime: async (devType, role, connection) => {
		const sql = "select hours from learnTime where role = ? and develop_id = ? order by `rank` asc limit 1";
		try {
			const [[result]] = await connection.query(sql, [role, Number(devType)]);
			return result;
		} catch (e) {
			console.log(e);
			return { error: true, message: e.message };
		}
	},

	selectProductiveToJob: async (devType, role, connection) => {
		const sql = "select product from productiveToJob where role = ? and develop_id = ? order by `rank` asc limit 3";
		try {
			const [result] = await connection.query(sql, [role, Number(devType)]);
			return result ? result : null;
		} catch (e) {
			console.log(e);
			return { error: true, message: e.message };
		}
	},

	selectSleep: async (devType, role, connection) => {
		const sql = "select hours from sleep where role = ? and develop_id = ? order by `rank` asc limit 1";
		try {
			const [[result]] = await connection.query(sql, [role, Number(devType)]);
			return result ? result : null;
		} catch (e) {
			console.log(e);
			return { error: true, message: e.message };
		}
	},

	selectLectures: async (category, connection) => {
		const sql = "select * from lectures where category regexp ? order by rand() limit 10";
		try {
			const [result] = await connection.query(sql, category);
			return result ? result : null;
		} catch (e) {
			console.log(e);
			return { error: true, message: e.message };
		}
	},
};

export default devsDao;
