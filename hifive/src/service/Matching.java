package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map.Entry;
import java.util.Set;

import membership.MemberDAO;
import question.QuestionDAO;

public class Matching {
	
	private MemberDAO mdao;
	private QuestionDAO qdao;
	final static int questSize = 5;
	
	public Matching() {	}
	
	public Matching(MemberDAO mdao, QuestionDAO qdao) {
		super();
		this.mdao = mdao;
		this.qdao = qdao;
	}

	public int[] getMatchingChecklist(String targetMemNum) {
		QuestionDAO qdao = new QuestionDAO();
		
		// targetMemNum과 일치하는 설문유형 별 설문응답을 배열에 담기 (ex. targetAns[0] : memNum의 1번 설문응답, targetAns[1] : memId의 2번 설문응답)
		// SELECT questAns FROM question WHERE memNum=? (ex. 3, 4, 5, 3, 5)
		int[] targetAns = new int[questSize];
		for (int i = 0; i < questSize; i++) {
			targetAns[i] = Integer.parseInt(qdao.getQuestAns(targetMemNum, Integer.toString(i+1))); // (회원고유번호, 설문유형)으로 찾은 설문응답 배열
		}
		
		// targetMemNum의 설문정보와 일치하는 회원고유번호 리스트 합치기 
		// SELECT memNum FROM question WHERE questType=? AND questAns=?
		ArrayList<Integer> memNums = new ArrayList<>();
		for (int i = 0; i < questSize; i++) { 
			if (qdao.getMemNumListToInteger(Integer.toString(i+1), Integer.toString(targetAns[i])) != null) { // (설문유형, 타겟설문응답)에 일치하는 회원고유번호 리스트 
				memNums.addAll(qdao.getMemNumListToInteger(Integer.toString(i+1), Integer.toString(targetAns[i])));
			}
		}
		// memNums 안에 있는 회원고유번호 중 가장 큰 수 뽑기 (2, 4, 5, ...)
		int memNumMax = 0;
		Iterator<Integer> it2 = memNums.iterator();
		while (it2.hasNext()) {
			int temp = it2.next().intValue();
			if (temp >= memNumMax) {
				memNumMax = temp;
			}
		}
		// memNums 안에 있는 회원고유번호 중 가장 큰 수만큼 배열 만들고 targetMemNum의 설문응답과 일치할 때마다 count올리기 
		int[] memberScores = new int[memNumMax]; // memberScores[0] = 1번 회원카운트, memberScores[1] = 2번 회원카운트, ...
		
		if (!memNums.isEmpty()) {
			try {
				Iterator<Integer> it = memNums.iterator();
				while (it.hasNext()) {
					int temp = it.next().intValue();
					memberScores[temp - 1]++;
				}
			} catch (ArrayIndexOutOfBoundsException e) {
				e.printStackTrace();
			}
			try {
				memberScores[Integer.parseInt(targetMemNum)-1] = 0; // 본인(타겟회원고유번호)이 본인에게 매칭되면 안되므로 0으로 초기화
			} catch (ArrayIndexOutOfBoundsException e) { e.printStackTrace(); }
		} else {
			//System.out.println("아직 매칭되는 회원이 없습니다!ㅠ_ㅠ");
			//System.out.println("더 많은 사람들이 Hi-Five!에 참여할 수 있도록 공유해주세요!>_<");
			return null;
		}
		return memberScores;
	}
	// 회원 고유번호와 1:1 매칭되는 회원 1명의 (회원 고유번호, 유사도) map 반환
	public HashMap<String, Integer> getOneMatchingMemNum(String targetMemNum) {
		int[] memberScores = getMatchingChecklist(targetMemNum);
		
		int max = 0;
		int matchingMemNum = 0;
		int similarity = 0;
		
		// 예상친밀도 60% 이상만 매칭가능
		for (int i = 0; i < memberScores.length; i++) {
			if ((memberScores[i] >= max) && (memberScores[i] >= 3)) {
				max = memberScores[i];
				matchingMemNum = i+1;
				similarity = max*20;
			}
		}
		HashMap<String, Integer> matchingInfo = new HashMap<>();
		matchingInfo.put(Integer.toString(matchingMemNum), similarity);
		
		return matchingInfo;
	}
	// 회원 고유번호와 그룹 매칭되는 회원  3명의 (회원 고유번호, 유사도) 순서 있는 map 반환
	public LinkedHashMap<String, Integer> getGroupMatchingMemNum(String targetMemNum) {
		int[] memberScores = getMatchingChecklist(targetMemNum);
		// 순서가 있는 맵에 (회원고유번호, 예상친밀도)를 넣기
		LinkedHashMap<String, Integer> matchingInfo = new LinkedHashMap<>();
		
		// 예상친밀도 60% 이상만 매칭가능
		for (int i = 0; i < memberScores.length; i++) {
			if (memberScores[i] == 5) {
				matchingInfo.put(Integer.toString(i+1), memberScores[i]*20);
			} else if (memberScores[i] == 4){
				matchingInfo.put(Integer.toString(i+1), memberScores[i]*20);
			} else if (memberScores[i] == 3) {
				matchingInfo.put(Integer.toString(i+1), memberScores[i]*20);
			} else {
				continue;
			}
		}
		
//		if (matchingInfo.size() < 3) {
//			System.out.println("아직 매칭되는 회원이 없습니다!ㅠ_ㅠ");
//		}
		return (matchingInfo.size() >= 3) ? matchingInfo : null;
	}
	
	// MAIN에서 1:1 매칭 시 사용
	public void matchOne(String memNum, Matching manager) {
		try {
			String matchingMemNum = "";
			int matchingSimilarity = 0;
			Set<Entry<String, Integer>> entrySet = manager.getOneMatchingMemNum(memNum).entrySet();
			for (Entry<String, Integer> entry : entrySet) {
				matchingMemNum = entry.getKey();
				matchingSimilarity = entry.getValue();	
			}
			System.out.printf("%s 님입니다!>_< (예상친밀도 %d%%) (짝짝짝)\n", mdao.getMdtoByMemNum(matchingMemNum).getMemId(), matchingSimilarity);
		} catch (NullPointerException e) {
			System.out.println("아직 매칭되는 회원이 없습니다!ㅠ_ㅠ");
			System.out.println("더 많은 사람들이 Hi-Five!에 참여할 수 있도록 공유해주세요!>_<");
			e.printStackTrace();
			System.exit(0); 
		}
	}
	
	// MAIN에서 그룹 매칭 시 사용
	public void matchGroup(String memNum, Matching manager) {
		try {
			String matchingMemNum = "";
			int matchingSimilarity = 0;
			int countLimit = 1;
			Set<Entry<String, Integer>> entrySet = manager.getGroupMatchingMemNum(memNum).entrySet();
			for (Entry<String, Integer> entry : entrySet) {
				if (countLimit == 4) { break; }
				matchingMemNum = entry.getKey();
				matchingSimilarity = entry.getValue();
				System.out.printf("%d 번째, %s 님입니다!>_< (예상친밀도 %d%%) (짝짝짝)\n", countLimit,
						mdao.getMdtoByMemNum(matchingMemNum).getMemId(), matchingSimilarity);
				++countLimit;
			}
		} catch (NullPointerException e) { System.exit(0); }
	}



}
