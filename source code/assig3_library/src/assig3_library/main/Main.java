package assig3_library.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;

import assig3_library.dao.DataBaseExcutor;

//The entry of this program
public class Main {

	
	public static void main(String[] args) {
		printMenu();
	}
	
	public static void printMenu() {
		String menu = "f - to finish running the program.\n";
		menu += "1 - Check the user name of all users, real name, maximum number of loans, maximum lending time.\n";
		menu += "2 - Check all users' username, historical borrowing quantity.\n";
		menu += "3 - Check all book titles and average evaluation scores.\n";
		menu += "4 - Check all books by book name, author, first edition club name, publisher address.\n";
		menu += "5 - Check through the view for all loan information that is out of time for return, including borrowing time, return time, user name, book title and number of overdue days.\n";
		Scanner sc = new Scanner(System.in);
	    System.out.println(menu);
	    String command = sc.nextLine();
	    if("f".equals(command)) {
	    	//do nothing, stop running
	    } else if ("1".equals(command)) {
	    	query1();
	    	printMenu();
	    }else if ("2".equals(command)) {
	    	query2();
	    	printMenu();
	    }else if ("3".equals(command)) {
	    	query3();
	    	printMenu();
	    }else if ("4".equals(command)) {
	    	query4();
	    	printMenu();	    	
	    }else if ("5".equals(command)) {
	    	query5();
	    	printMenu();
	    }else {
	    	System.out.println("error!please check your input.");
	    	printMenu();
	    }
	}
	
	public static void query1() {
		Connection connection = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "SELECT u.U_USERNAME,U_REALNAME,p.P_MAX_NUMBER,p.P_MAX_TIME" +
					 " FROM user u, permission p" +
					 " WHERE u.P_ID=p.P_ID;";
		try {
			connection = DataBaseExcutor.getConnection();
			pstm = connection.prepareStatement(sql);
			rs = pstm.executeQuery();
			StringBuilder sBuilder = new StringBuilder();
			sBuilder.append("U_USERNAME\tU_REALNAME\tP_MAX_NUMBER\tP_MAX_TIME\r\n"); 
			while(rs.next()) {
				sBuilder.append(rs.getString("U_USERNAME") + "\t");
				sBuilder.append(rs.getString("U_REALNAME") + "\t");
				sBuilder.append(rs.getString("P_MAX_NUMBER") + "\t");
				sBuilder.append(rs.getString("P_MAX_TIME") + "\r\n");
			}
			System.out.println(sBuilder.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DataBaseExcutor.release(connection, pstm);
		}
	}
	
	public static void query2() {
		Connection connection = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "SELECT U_USERNAME, COUNT(BO_ID) AS COUNT" +
					 " FROM borrow bo" +
					 " GROUP BY U_USERNAME;";
		try {
			connection = DataBaseExcutor.getConnection();
			pstm = connection.prepareStatement(sql);
			rs = pstm.executeQuery();
			StringBuilder sBuilder = new StringBuilder();
			sBuilder.append("U_USERNAME\tCOUNT\r\n"); 
			while(rs.next()) {
				sBuilder.append(rs.getString("U_USERNAME") + "\t");
				sBuilder.append(rs.getString("COUNT") + "\r\n");
			}
			System.out.println(sBuilder.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DataBaseExcutor.release(connection, pstm);
		}
	}
	
	public static void query3() {
		Connection connection = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "SELECT b.B_TITLE,sum(C_SCORE)/count(C_ID) AS AVERAGE" +
					 " FROM comment c" +
					 " JOIN book b" +
					 " WHERE c.B_ID=b.B_ID" +
					 " GROUP BY b.B_TITLE;";
		try {
			connection = DataBaseExcutor.getConnection();
			pstm = connection.prepareStatement(sql);
			rs = pstm.executeQuery();
			StringBuilder sBuilder = new StringBuilder();
			sBuilder.append("B_TITLE\tAVERAGE\r\n"); 
			while(rs.next()) {
				sBuilder.append(rs.getString("B_TITLE") + "\t");
				sBuilder.append(rs.getString("AVERAGE") + "\r\n");
			}
			System.out.println(sBuilder.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DataBaseExcutor.release(connection, pstm);
		}
	}
	
	public static void query4() {
		Connection connection = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "SELECT b.B_TITLE,b.B_AUTHOR,b.PU_NAME,pu.PU_ADDRESS" +
					 " FROM book b" +
					 " JOIN publisher pu" +
					 " WHERE b.PU_NAME=pu.PU_NAME;";
		try {
			connection = DataBaseExcutor.getConnection();
			pstm = connection.prepareStatement(sql);
			rs = pstm.executeQuery();
			StringBuilder sBuilder = new StringBuilder();
			sBuilder.append("B_TITLE\tB_AUTHOR\tPU_NAME\tPU_ADDRESS\r\n"); 
			while(rs.next()) {
				sBuilder.append(rs.getString("B_TITLE") + "\t");
				sBuilder.append(rs.getString("B_AUTHOR") + "\t");
				sBuilder.append(rs.getString("PU_NAME") + "\t");
				sBuilder.append(rs.getString("PU_ADDRESS") + "\r\n");
			}
			System.out.println(sBuilder.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DataBaseExcutor.release(connection, pstm);
		}
	}
	
	public static void query5() {
		Connection connection = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "SELECT * " +
					 " FROM v_not_return;";
		try {
			connection = DataBaseExcutor.getConnection();
			pstm = connection.prepareStatement(sql);
			rs = pstm.executeQuery();
			StringBuilder sBuilder = new StringBuilder();
			sBuilder.append("BO_BORROWTIME\tBO_RETURNTIME\tU_USERNAME\tB_TITLE\tdelay\r\n"); 
			while(rs.next()) {
				sBuilder.append(rs.getString("BO_BORROWTIME") + "\t");
				sBuilder.append(rs.getString("BO_RETURNTIME") + "\t");
				sBuilder.append(rs.getString("U_USERNAME") + "\t");
				sBuilder.append(rs.getString("B_TITLE") + "\t");
				sBuilder.append(rs.getString("delay") + "\r\n");
			}
			System.out.println(sBuilder.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DataBaseExcutor.release(connection, pstm);
		}
	}
	
	
	
}
