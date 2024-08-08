/* *********************************
 클래스 기능 : 댓글정보 클래스
 작성자 : 추고천
 작성일 : 2024.05.09
*************************************/
package aws.vo;

public class ReplyVO 
{
	private String rno;     //댓글번호
	private String bno;     //게시물번호
	private String ruserno; //댓글작성회원번호
	private String rnote;   //댓글내용
	private String rwdate;  //작성일자
	//조회를 위한 추가 항목(필드)
	private String name;    //작성자
	private String title;   //글제목
	private String kind;    //게시판종류
	

	
	public String getRno()     { return rno;     }
	public String getBno()     { return bno;     }
	public String getRuserno() { return ruserno; }
	public String getRnote()   { return rnote;   }
	public String getRwdate()  { return rwdate;  }
	public String getName()    { return name;    }
	public String getTitle()   { return title;   }
	public String getKind()    { return kind;    }
	public String getHTML()
	{
		String note = this.rnote;
		//HTML을 TEXT로 변환한다.
		note = note.replace("<","&lt;");
		note = note.replace(">","&gt;");
		note = note.replace("\n","\n<br>");
		return note;
	}
	
	public void setRno(String rno)         { this.rno = rno;         }
	public void setBno(String bno)         { this.bno = bno;         }
	public void setRuserno(String ruserno) { this.ruserno = ruserno; }
	public void setRnote(String rnote)     { this.rnote = rnote;     }
	public void setRwdate(String rwdate)   { this.rwdate = rwdate;   }
	public void setName(String name)       { this.name = name;       }
	public void setTitle(String title)     { this.title = title;      }
	public void setKind(String kind)       { this.kind = kind;       }
	
}
