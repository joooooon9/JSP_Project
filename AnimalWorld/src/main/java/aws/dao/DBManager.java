package aws.dao;

import java.sql.*;



public class DBManager
{
	private Connection conn;
	private ResultSet rs;
	//1. 드라이버를 로딩한다.
	private boolean LoadDriver() 
	{
		System.out.println("드라이버를 로딩합니다.");
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) 
		{
			e.printStackTrace();
			return false;
		}
		return true;
	}
	//2. 데이터베이스에 접속한다.
	public boolean DBOpen()
	{
		if(LoadDriver() == false) return false;
		System.out.println("데이터베이스에 연결합니다.");
		String url = "jdbc:mysql://localhost:3306/db?serverTimezone=Asia/Seoul&characterEncoding=UTF-8";
		try 
		{
			conn = DriverManager.getConnection(url, "","");
		} catch (SQLException e) 
		{
			e.printStackTrace();
			return false;
		}
		return true;
	}

	//3-1  C/U/D를 처리한다.
	public boolean RunSQL(String sql)
	{
		Statement stmt;
		try 
		{
			stmt = conn.createStatement();
			System.out.println(sql);
			stmt.executeUpdate(sql);
			stmt.close();
		} catch (SQLException e)
		{
			e.printStackTrace();
			return false;
		}
		return true;
	}
	//3-2  R를 처리한다.
	public boolean Select(String sql)
	{
		Statement stmt;
		try 
		{
			stmt = conn.createStatement();
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) 
		{
			e.printStackTrace();
			return false;
		}
		return true;
	}
	//커서를 다음 행으로 이동한다.
	public boolean GetNext() 
	{
		try
		{
			return rs.next();
		} catch (SQLException e) 
		{
			e.printStackTrace();
			return false;
		}
	}
	
	public String GetValue(String column)
	{
		try 
		{
			return rs.getString(column);
		} catch (SQLException e) 
		{
			e.printStackTrace();
			return null;
		}
	}
	public int GetInt(String column) 
	{
		try 
		{
			return rs.getInt(column);
		} catch (SQLException e) 
		{
			e.printStackTrace();
			return 0;
		}
	}
	
	//4. 데이터베이스 접속을 종료한다.
	public void DBClose() 
	{
		System.out.println("데이터베이스에 연결을 종료합니다.");
		try 
		{
			conn.close();
		}catch(SQLException e)
		{
			e.printStackTrace();
		}
	}
	//작은따옴표를 작은따음표 2개로 변환한다.
	public String _R(String value)
	{
		if(value == null) return null;
		return value.replace("'","''");
	}
}
