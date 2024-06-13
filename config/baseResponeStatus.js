const baseResponse = {
	// Success
	SUCCESS: { status: "SUCCESS", code: 1000, message: "성공" },

	//FAIL
	WRONG_DEVTYPE: {
		status: "FAIL",
		code: 2000,
		message: "잘못된 devType 입니다.",
	},

	WRONG_ROLE: {
		status: "FAIL",
		code: 2001,
		message: "잘못된 role 입니다.",
	},

	//ERROR
	SERVER_ERROR: { status: "ERROR", code: 3000, message: "서버 에러" },
};

export default baseResponse;
