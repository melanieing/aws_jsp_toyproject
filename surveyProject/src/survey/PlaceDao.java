package survey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class PlaceDao {
	private static DataSource ds = null;
	{
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/myOracle");
		} catch (Exception e) {
			System.err.println("Connection 실패");
		}
	}

	public Connection getConnection() throws SQLException {
		return ds.getConnection();
	}

	private static PlaceDao instance = null;

	private PlaceDao() {
	}

	public static PlaceDao getInstance() {
		if (instance == null) {
			synchronized (PlaceDao.class) {
				instance = new PlaceDao();
			}
		}
		return instance;
	}

	public boolean insertplace(PlaceVo vo) {
		boolean ret = false;
		Connection conn = null;
		PreparedStatement pstmt = null;

		String sql = "insert into \"PLACE\" values (?, ?)";
		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, vo.getpcode());
			pstmt.setString(2, vo.getplace());

			pstmt.executeUpdate();
			System.out.println("플레이스완료");
			ret = true;
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					if (conn != null) {
						try {
							conn.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
		return ret;
	}

	public List<RankVo> rankplace() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// String place = "";
		// int placecode =0;
		// int rank =1;
		// int vote = 0;

		ArrayList<RankVo> result = new ArrayList<>();

		String sql = "select * from \"PLACE\",(select \"PLACE_CODE\", count(\"PLACE_CODE\") as COUNT from \"PURPOSE\" group by \"PLACE_CODE\") where PLACE.P_CODE=\"PLACE_CODE\" order by COUNT desc";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) { // 그다음행 결과 뽑을라고 while문 사용
				String place = rs.getString(2); // 2행이 place
				int vote = rs.getInt(4);
				RankVo vo = new RankVo(place, vote);
				result.add(vo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				} finally {
					if (conn != null) {
						try {
							conn.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
		return result;
	}

	public int placeNum() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = -1;

		String sql = "select count(*) from \"PLACE\"";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) { // 그다음행 결과 뽑을라고 while문 사용
				result = rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				} finally {
					if (conn != null) {
						try {
							conn.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
		return result;
	}

}