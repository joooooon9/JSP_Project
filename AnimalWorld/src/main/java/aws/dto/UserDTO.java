package aws.dto;

import aws.dao.DBManager;
import aws.vo.UserVO;

public class UserDTO extends DBManager
{
	//아이디 중복검사
	public boolean CheckID(String id)
	{
		this.DBOpen();
		String sql = "";
		sql = "select userno from user "; 
		sql += "where id = '" + _R(id) + "' ";  //user 테이블에서 id가 ㅇㅇㅇ인 userno 를 출력해줘
		Select(sql);
		if(this.GetNext() == true) //select를 하고나서 다음 행으로 이동이 되는지
		{	//중복된 아이디가 있을 때
			DBClose();
			return true;
		}
		DBClose();
		return false;
	}
	
	//회원가입
	public boolean Join(UserVO vo)
	{
		String sql = "";
		sql = "insert into user (id,pw,name,gender,email) ";
		sql += "values (";
		sql += "'" + _R(vo.getId()) + "',";
		sql += "md5('" + _R(vo.getPw()) + "'),";
		sql += "'" + _R(vo.getName()) +"',";
		sql += "'" + _R(vo.getGender())+"',";
		sql += "'" + _R(vo.getEmail())+ "') ";
		
		this.DBOpen();
		this.RunSQL(sql);
		
		//자동증가된 사용자 번호를 얻는다.
		sql = "select last_insert_id() as no ";
		this.Select(sql);
		this.GetNext();
		vo.setUserno(this.GetValue("no"));
		
		this.DBClose();			
		return true;
	}
	
	//로그인
	public UserVO Login(String id, String pw)
	{
		String sql = "";
		sql = "select userno,id,pw,name,gender,email,joindate,isretire ";
		sql += "from user ";
		sql += "where id = '"+ _R(id) + "' ";
		sql += "and pw = md5('" + _R(pw)+"') ";
		sql += "and isretire = 'N'";
		
		DBOpen();
		Select(sql);
		if(GetNext()== false)
		{
			DBClose();
			return null;
		}
		UserVO vo = new UserVO();
		vo.setUserno(this.GetValue("userno"));
		vo.setId(this.GetValue("id"));
		vo.setPw(this.GetValue("pw"));
		vo.setName(this.GetValue("name"));
		vo.setGender(this.GetValue("gender"));
		vo.setEmail(this.GetValue("email"));
		vo.setJoindate(this.GetValue("joindate"));
		vo.setIsretire(this.GetValue("isretire"));
		
		DBClose();
		return vo;
	}
	//아이디 찾기
	public UserVO FindID(String name, String email)
	{
		String sql = "";
		sql =  "select * from user ";
		sql += "where name = '" + _R(name) + "' ";
		sql += "and email = '" + _R(email) + "' ";
		sql += "and isretire = 'N'";
		
		DBOpen();
		Select(sql);
		if(GetNext()== false)
		{
			DBClose();
			return null;
		}
		UserVO vo = new UserVO();
		vo.setUserno(this.GetValue("userno"));
		vo.setId(this.GetValue("id"));
		vo.setPw(this.GetValue("pw"));
		vo.setName(this.GetValue("name"));
		vo.setGender(this.GetValue("gender"));
		vo.setEmail(this.GetValue("email"));
		vo.setJoindate(this.GetValue("joindate"));
		vo.setIsretire(this.GetValue("isretire"));
		
		DBClose();
		return vo;
	}
	//비밀번호 찾기
    // id만 입력받을 때
    public UserVO FindPW(String id) {
        return findUser(id, null, null);
    }

    // id,mail,이름 입력받을때
    public UserVO FindPW(String id, String email, String name) {
        return findUser(id, email, name);
    }
	//위에 로직을 공통으로 처리하는 메소드
    public UserVO findUser(String id, String email, String name) 
    {
    	String sql= "";
    	sql =  "select * from user ";
    	sql += "where id = '" + _R(id) + "' ";
    	if(email != null)
    	{
    		sql += "and email = '" + _R(email) + "' ";
    	}
    	if(name != null)
    	{
    		sql += "and name = '" + _R(name) + "' ";
    	}
    	
    	DBOpen();
		Select(sql);
		if(GetNext()== false)
		{
			DBClose();
			return null;
		}
		UserVO vo = new UserVO();
		vo.setUserno(this.GetValue("userno"));
		vo.setId(this.GetValue("id"));
		vo.setPw(this.GetValue("pw"));
		vo.setName(this.GetValue("name"));
		vo.setGender(this.GetValue("gender"));
		vo.setEmail(this.GetValue("email"));
		vo.setJoindate(this.GetValue("joindate"));
		vo.setIsretire(this.GetValue("isretire"));
		
		DBClose();
		return vo;
    }
    //새로운비밀번호
    public boolean ChangePW(UserVO vo)
    {
    	String sql = "";
    	sql = "update user set ";
    	sql += " pw = md5('" + _R(vo.getPw())+"') ";
    	sql += "where id = '"+_R(vo.getId())+"'";
    	if(vo.getName() != null)
    	{
    		sql += " and name = '" + _R(vo.getName()) + "' ";
    	}
    	DBOpen();
    	RunSQL(sql);
    	DBClose();
    	return true;
    }
    public boolean DeleteUser(String userno)
    {
    	String sql = "";
    	DBOpen();
    	sql = "delete from user where userno = "+ userno;
    	
    	RunSQL(sql);
    	DBClose();
    	return true;
    }
}
