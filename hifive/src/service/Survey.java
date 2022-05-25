package service;

import question.QuestionDAO;

public class Survey {
	
	QuestionDAO qdao;
	
	private String[] questions = {"1. 당신은 모든 메뉴가 맛있다는 김밥천국에 왔습니다. 어떤 음식을 먹을까요?", 
			 			  		  "2. 당신은 혼자 영화관에 왔습니다. 어떤 영화를 볼까요?", 
			 			  		  "3. 당신은 버스를 타고 이어폰을 꽂았습니다. 어떤 노래를 들을까요?", 
			 			  		  "4. 당신은 동아리에 들고 싶습니다. 어떤 동아리에 가입할까요?", 
			 	 		  		  "5. 바쁜 당신에게 자유시간이 생겼습니다. 뭐할까요?"};
	private String[] options = {"\n① 김밥류(야채/참치/치즈김밥 등)\n② 식사류(비빔밥/덮밥/볶음밥 등)\n③ 찌개류(김치찌개/뚝불 등)\n④ 분식류(라면/떡복이/만두 등)\n⑤ 튀김류(돈까스/생선까스 등)",
								"\n① 스릴 넘치는 액션/범죄 영화\n② 꿈에 나올까 무서운 공포 영화\n③ 달달하고 설레는 로맨스 영화\n④ 웃겨서 뒤집어지는 코미디 영화\n⑤ 매니아틱한 판타지 영화 (해리포터, 어벤저스 등)",
								"\n① 아이유의 희망차고 밝은 노래\n② 백예린의 잔잔하고 편안한 노래\n③ 지코, 비오의 귀에 때력박는 빡센 힙합\n④ 크러쉬의 그루비한 알앤비\n⑤ 숀의 속이 뻥 뚫리는 EDM",
								"\n① 밴드부/합창단/오케스트라\n② 독서/시사토론 동아리/방송반\n③ 운동/댄스 동아리\n④ 봉사/교육동아리\n⑤ 친목/문화생활 동아리",
								"\n① 자기계발/공부해야지!\n② 운동이나 하자~\n③ 친구 만나서 놀기\n④ 한 숨 잘거야...\n⑤ 게임 한 판ㄱㄱ"};
	private String asking = "---> 당신의 답은? ";
	private String[][] surveyResult = {{"① 김밥류(야채/참치/치즈김밥 등)", "② 식사류(비빔밥/덮밥/볶음밥 등)", "③ 찌개류(김치찌개/뚝불 등)", 
										"④ 분식류(라면/떡복이/만두 등)", "⑤ 튀김류(돈까스/생선까스 등)"},
									   {"① 스릴 넘치는 액션/범죄 영화", "② 꿈에 나올까 무서운 공포 영화", "③ 달달하고 설레는 로맨스 영화", 
										"④ 웃겨서 뒤집어지는 코미디 영화", "⑤ 매니악한 판타지 영화 (해리포터, 어벤저스 등)"},
									   {"① 아이유의 희망차고 밝은 노래", "② 백예린의 잔잔하고 편안한 노래", "③ 지코, 비오의 귀에 때력박는 빡센 힙합", 
										"④ 크러쉬, 딘의 그루비한 알앤비", "⑤ 숀의 속이 뻥 뚫리는 EDM"},
									   {"① 밴드부/합창단/오케스트라", "② 독서/시사토론 동아리/방송반", "③ 운동/댄스 동아리", 
										"④ 봉사/교육동아리", "⑤ 친목/문화생활 동아리"},
									   {"① 자기계발(공부)해야지!", "② 운동이나 해야겠다~", "③ 오랜만에 친구 만나서 놀까?", 
										"④ 한 숨 잘거야...", "⑤ 게임 한 판ㄱㄱ?"}}; 

	public Survey() { }

	// 설문오프닝 getters & setter
	public String[] getQuestions() {
		return questions;
	}
	public String getQuestion(String questType) { // 설문유형에 해당하는 개별 설문오프닝 getter
		return questions[Integer.parseInt(questType)-1];
	}
	public void setQuestions(String[] questions) {
		this.questions = questions;
	}

	// 설문옵션 getters & setter
	public String[] getOptions() {
		return options;
	}
	public String getOption(String questType) { // 설문유형에 해당하는 개별 설문옵션 getter
		return options[Integer.parseInt(questType)-1];
	}
	public void setOptions(String[] options) {
		this.options = options;
	}

	// 설문엔딩 getter & setter
	public String getAsking() {
		return asking;
	}
	public void setAsking(String asking) {
		this.asking = asking;
	}

	// 설문결과워딩 getter & setter
	public String[][] getSurveyResult() {
		return surveyResult;
	}
	public String getSurveyResult(String questType, String questAns) { // 설문유형에 해당하는 개별 설문결과워딩 getter
		return surveyResult[Integer.parseInt(questType)-1][Integer.parseInt(questAns)-1];
	}
	public void setSurveyResult(String[][] surveyResult) {
		this.surveyResult = surveyResult;
	}		
	
	public void showSurveyResult(QuestionDAO qdao) {
		for (int i = 1; i <= questions.length; i++) {
			System.out.println(getQuestion(Integer.toString(i)));
			double rows = (double)qdao.countQuest(Integer.toString(i));
			for (int j = 1; j <= options.length; j++) {
				System.out.printf(getSurveyResult(Integer.toString(i), Integer.toString(j)), (qdao.countQuest(Integer.toString(i), Integer.toString(j))/rows)*100);	
			}
		}	
	}
	
}
