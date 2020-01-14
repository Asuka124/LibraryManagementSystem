package assig3_library.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.Types;


public class DataBaseExcutor {


	public static Connection getConnection() throws Exception{
		DataBaseConnectionPool dbcp = DataBaseConnectionPool.getInstance();
		
		return dbcp.getConnection();
	}
	
	
	public static void reConnect(){
		DataBaseConnectionPool.reConnect();
	}
	
	
	public static void setParams(PreparedStatement pstm, 
			Object... params) throws Exception{
		if(params == null || params.length == 0) {
			return;
		}
		for(int i=1;i<=params.length;i++) {
			Object param = params[i-1];
			if(param==null) {
				pstm.setNull(i, Types.NULL);
			} else if(param instanceof Integer) {
				pstm.setInt(i, (Integer)param); 
			} else if(param instanceof String) {
				pstm.setString(i, (String)param);
			} else if(param instanceof Double) {
				pstm.setDouble(i, (Double)param); 
			} else if(param instanceof Long) {
				pstm.setLong(i, (Long)param); 
			} else if(param instanceof Timestamp) {
				pstm.setTimestamp(i, (Timestamp)param); 
			} else if(param instanceof Boolean) {
				pstm.setBoolean(i, (Boolean)param); 
			} else if(param instanceof Date) {
				pstm.setDate(i, (Date)param); 
			}
		}		
	}
	
	
	public static void release(Connection connection, PreparedStatement pstm) {
		if(connection != null) {
			try {
				connection.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(pstm != null) {
			try {
				pstm.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	
	public static void release(Connection connection, PreparedStatement pstm,
			ResultSet rs) {
		release(connection, pstm);
		if(rs != null) {
			try {
				rs.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
}
