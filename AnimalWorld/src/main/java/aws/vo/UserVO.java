/* *********************************
 클래스 기능 : 회원정보 클래스
 작성자 : 추고천
 작성일 : 2024.05.09
*************************************/
package aws.vo;

public class UserVO 
{
	private String userno;    //회원번호
	private String id;        //아이디
	private String pw;        //비밀번호
	private String name;      //이름
	private String gender;    //성별
	private String joindate;  //가입일자
	private String isretire;  //탈퇴여부
	private String email;     //이메일
	private String isadmin;   //관리자여부
	
	
	
	
	public String getUserno()   { return userno;   }
	public String getId()       { return id;       }
	public String getPw()       { return pw;       }
	public String getName()     { return name;     }
	public String getGender()   { return gender;   }
	public String getJoindate() { return joindate; }
	public String getIsretire() { return isretire; }
	public String getEmail()    { return email;    }
	public String getIsadmin()  { return isadmin;  }
	
	public void setUserno(String userno)     { this.userno = userno;     }
	public void setId(String id)             { this.id = id;             }
	public void setPw(String pw)             { this.pw = pw;             }
	public void setName(String name)         { this.name = name;         }
	public void setGender(String gender)     { this.gender = gender;     }
	public void setJoindate(String joindate) { this.joindate = joindate; }
	public void setIsretire(String isretire) { this.isretire = isretire; }
	public void setEmail(String email)       { this.email = email;       }
	public void setIsadmin(String isadmin)   { this.isadmin = isadmin;   }
}

