package membership;

import java.util.HashMap;
import java.util.Map;


public class Tset {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memAge", "27");
		MemberDAO dao = new MemberDAO();
		
		System.out.println(dao.selectListPage(map).toString());
	}

}
