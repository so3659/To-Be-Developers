const baseResponse = {
	// Success
	SUCCESS: { status: "SUCCESS", code: 1000, message: "성공" },

	//FAIL
	SEARCH_KEYWORD_EMPTY: {
		status: "FAIL",
		code: 2000,
		message: "검색 키워드를 입력해야 합니다.",
	},

	//ERROR
	SERVER_ERROR: { status: "ERROR", code: 3000, message: "서버 에러" },
};

export default baseResponse;
