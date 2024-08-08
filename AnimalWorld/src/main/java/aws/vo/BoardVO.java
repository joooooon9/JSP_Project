/* *********************************
 클래스 기능 : 게시물정보 클래스
 작성자 : 추고천
 작성일 : 2024.05.09
*************************************/
package aws.vo;

public class BoardVO 
{
	private String bno;    //게시물번호
	private String userno; //회원번호
	private String btitle; //제목
	private String bkind;  //구분
	private String bnote;  //내용
	private String bfname; //첨부파일명
	private String bpname; //저장첨부파일명	
	private String bwdate; //작성일자
	private String bhit;   //조회수
	private String name;   //작성자
	private String rcount; //댓글갯수
	private String thead;  //말머리
	private String saveflag; //저장,임시저장 선택
	
	
	
	public String getBno()    { return bno;    }
	public String getUserno() { return userno; }
	public String getBtitle() { return btitle; }
	public String getBkind()  { return bkind;  }
	public String getBnote()  { return bnote;  }
	public String getBfname() { return bfname; }
	public String getBpname() { return bpname; }
	public String getBwdate() { return bwdate; }
	public String getBhit()   { return bhit;   }
	public String getThead()  { return thead;  }
	public String getName()   { return name;   }
	public String getRcount() { return rcount; }
	public String getSaveflag()    { return saveflag;    }
	public String getHTML()
	{
		String note = this.bnote;
		//HTML을 TEXT로 변환한다.
		note = note.replace("<","&lt;");
		note = note.replace(">","&gt;");
		note = note.replace("\n","\n<br>");
		return note;
	}
	public void setBno(String bno)       { this.bno = bno;       }
	public void setUserno(String userno) { this.userno = userno; }
	public void setBtitle(String btitle) { this.btitle = btitle; }
	public void setBkind(String bkind)   { this.bkind = bkind;   }
	public void setBnote(String bnote)   { this.bnote = bnote;   }
	public void setBfname(String bfname) { this.bfname = bfname; }
	public void setBpname(String bpname) { this.bpname = bpname; }
	public void setBwdate(String bwdate) { this.bwdate = bwdate; }
	public void setBhit(String bhit)     { this.bhit = bhit;     }
	public void setName(String name)     { this.name = name;     }
	public void setRcount(String rcount) { this.rcount = rcount; }
	public void setThead(String thead)   { this.thead = thead;   }
	public void setSaveflag(String saveflag)   { this.saveflag = saveflag;   }
	
}

