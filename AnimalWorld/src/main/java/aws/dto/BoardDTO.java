package aws.dto;

import java.util.ArrayList;

import aws.dao.DBManager;
import aws.vo.BoardVO;

public class BoardDTO extends DBManager
{
	
	//게시물 등록 //임시저장
	public boolean Insert(BoardVO vo)
	{
		this.DBOpen();
		String sql = "";
		sql  = "insert into board ";
		sql += "(userno, btitle, bkind, saveflag, bnote, bfname, bpname, thead) ";
		sql += "values ( ";
		sql += " '"+ this._R(vo.getUserno())+"', ";
		sql += " '"+ this._R(vo.getBtitle())+"', ";
		sql += " '"+ this._R(vo.getBkind())+"', ";
		sql += " '"+ this._R(vo.getSaveflag())+"', ";
		sql += " '"+ this._R(vo.getBnote())+"', ";
		if(vo.getBfname() != null)
		{
			sql += " '"+ this._R(vo.getBfname())+"', ";
			sql += " '"+ this._R(vo.getBpname())+"', ";
		}else
		{
			sql += " null, ";
			sql += " null,  ";			
		}
		if(vo.getThead() != null)
		{
			sql += " '"+ this._R(vo.getThead())+"' ";
		}else
		{
			sql += " null  ";			
		}
		sql += ") ";
		this.RunSQL(sql);			// sql문을 실행한다
		
		sql = "select last_insert_id() as no "; // 등록된 게시물 번호를 얻는다
		this.Select(sql);
		this.GetNext();
		vo.setBno(this.GetValue("no"));	// vo에 게시물 번호를 반영한다
		this.DBClose();
		return true;
	}
	//게시물 정보 읽기
	//bkind = F>자유게시판, R>식품추천, S>나눔게시판, I>이미지갤러리 Q>qna게시판
	public BoardVO Read(String bno,boolean Ishit)
	{
		BoardVO vo = null;
		String sql = "";
		sql = "select bno,btitle,bkind,bnote,bfname,bpname,bwdate,bhit,thead,saveflag,userno, ";
		sql+= "(select name from user where userno = board.userno ) as name ";
		sql+= "from board";
		sql+= " where bno = " + bno;
		DBOpen();
		Select(sql);
		if(GetNext() == true)
		{
			vo = new BoardVO();
			vo.setBno(this.GetValue("bno"));
			vo.setUserno(this.GetValue("userno"));
			vo.setBtitle(this.GetValue("btitle"));
			vo.setBkind(this.GetValue("bkind"));
			vo.setBnote(this.GetValue("bnote"));
			vo.setBfname(this.GetValue("bfname"));
			vo.setBpname(this.GetValue("bpname"));
			vo.setBwdate(this.GetValue("bwdate"));
			vo.setThead(this.GetValue("thead"));
			vo.setSaveflag(this.GetValue("saveflag"));
			vo.setName(this.GetValue("name"));
			vo.setBhit(this.GetInt("bhit")+1+"");
			
			if(Ishit == true)
			{
				// 게시글 조회가 완료되어, DB의 조회수를 갱신합니다
				sql  = "update board set ";
				sql += "bhit = bhit + 1 where bno = " + bno;
				this.RunSQL(sql);
			}
			
		}
		DBClose();
		return vo;	
	}
	//전체게시물 갯수 불러오기
	public int GetTotal()
	{	/*	select count(*) as total
 		 	 from board where bkind = '선택된 게시판코드'  */
		int total = 0;
		this.DBOpen();
		
		String sql = "select count(*) as total from board ";
		
		this.Select(sql);
		this.GetNext();
		total = this.GetInt("total");
		
		this.DBClose();
		return total;
	}
	//게시물 갯수 불러오기
	//bkind = F>자유게시판, R>식품추천, S>나눔게시판, I>이미지갤러리 Q>qna게시판
	//target = 빈값:제목+내용, title:제목에서 검색, note: 내용에서 검색
	public int GetTotal(String bkind,String keyword,String tag)
	{	/*	select count(*) as total
 		 	 from board where bkind = '선택된 게시판코드'  */
		int total = 0;
		this.DBOpen();
		
		String sql = "select count(*) as total from board ";
		if(!bkind.equals(""))
		{
			sql += "where bkind = '" + bkind.toUpperCase() + "'";
		}else
		{
			sql += "where 1 = 1 ";
		}
		if( !keyword.equals("") )
		{
			switch(tag)
			{			
			case "title" :
				sql += "and btitle like '%" + keyword + "%'";
				break;
			case "con" :
				sql += "and bnote like '%" + keyword + "%'";
				break;
			default:
				sql += "and ( btitle like '%" + keyword + "%'";
				sql += "or bnote like '%" + keyword + "%' ) ";
				break;				
			}
		}
		this.Select(sql);
		this.GetNext();
		total = this.GetInt("total");
		
		this.DBClose();
		return total;
	}
	
	// 내가 작성한 게시물 얻어오기
	public int MyTotal(String userno)
	{	/*	select count(*) as total
 		 	 from board where bkind = '선택된 게시판코드'  */
		int total = 0;
		this.DBOpen();
		
		String sql = "select count(*) as total from board ";
		sql += "where userno = '" + userno + "'";
		
		this.Select(sql);
		this.GetNext();
		total = this.GetInt("total");
		
		this.DBClose();
		return total;
	}
	
	
	//게시물 목록 가져오기
	//bkind = F>자유게시판, R>식품추천, S>나눔게시판, I>이미지갤러리 Q>qna게시판
	//target = 빈값:제목+내용, title:제목에서 검색, note: 내용에서 검색
	public ArrayList<BoardVO> GetList(int pageno,String bkind,String keyword,String tag)
	{
		int startno = (pageno -1) * 10;
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		DBOpen();
		
		String sql = "";
		sql  = "select bno,bkind,btitle,bhit,date(bwdate) as bwdate, saveflag,thead,";
		sql += "(select count(*) from reply where bno = board.bno) as rcount,";
		sql += "(select name from user where userno = board.userno) as name ";
		sql += "from board ";
		if(!bkind.equals(""))
		{
			sql += "where bkind = '" + bkind.toUpperCase() + "'";
		}else
		{
			sql += "where 1 = 1 ";
		}
		if( !keyword.equals("") )
		{
			switch(tag)
			{			
			case "title" :
				sql += "and btitle like '%" + keyword + "%'";
				break;
			case "con" :
				sql += "and bnote like '%" + keyword + "%'";
				break;
			default:
				sql += "and ( btitle like '%" + keyword + "%'";
				sql += "or bnote like '%" + keyword + "%' ) ";
				break;				
			}
		}
		sql += " and saveflag= 'T' ";
		sql += " order by bno desc ";
		sql += "limit " + startno + ",10 ";
		
		Select(sql);
		while(GetNext())
		{
			BoardVO vo = new BoardVO();
			vo.setBno(this.GetValue("bno"));
			vo.setBkind(this.GetValue("bkind"));
			vo.setBtitle(this.GetValue("btitle"));
			vo.setBhit(this.GetValue("bhit"));
			vo.setBwdate(this.GetValue("bwdate"));
			vo.setRcount(this.GetValue("rcount"));
			vo.setName(this.GetValue("name"));
			vo.setThead(this.GetValue("thead"));
			list.add(vo);
		}
		DBClose();
		return list;
		
	}
	
	public ArrayList<BoardVO> MyList(int pageno, String userno, String saveflag,String tag,String keyword) {
	    int startno = (pageno - 1) * 10;
	    ArrayList<BoardVO> list = new ArrayList<BoardVO>();
	    DBOpen();
	    
	    String sql = "";
	    sql  = "select bno, bkind, btitle, bhit, date(bwdate) as bwdate, saveflag, thead, ";
	    sql += "(select count(*) from reply where bno = board.bno) as rcount, ";
	    sql += "(select name from user where userno = board.userno) as name ";
	    sql += "from board ";
	    sql += "where userno = '" + userno + "' ";
		if( !keyword.equals("") )
		{
			switch(tag)
			{			
			case "title" :
				sql += "and btitle like '%" + keyword + "%'";
				break;
			case "con" :
				sql += "and bnote like '%" + keyword + "%'";
				break;
			default:
				sql += "and ( btitle like '%" + keyword + "%'";
				sql += "or bnote like '%" + keyword + "%' ) ";
				break;				
			}
		}
	    sql += "and saveflag = '"+ saveflag +"' ";
	    sql += "order by bno desc ";
	    sql += "limit " + startno + ", 10";
	    
	    Select(sql);
	    while(GetNext()) {
	        BoardVO vo = new BoardVO();
	        vo.setBno(this.GetValue("bno"));
	        vo.setBkind(this.GetValue("bkind"));
	        vo.setBtitle(this.GetValue("btitle"));
	        vo.setBhit(this.GetValue("bhit"));
	        vo.setBwdate(this.GetValue("bwdate"));
	        vo.setRcount(this.GetValue("rcount"));
	        vo.setName(this.GetValue("name"));
	        vo.setThead(this.GetValue("thead"));
	        list.add(vo);
	    }
	    DBClose();
	    return list;
	}
	public ArrayList<BoardVO> GetList(int pageno)
	{
		int startno = (pageno -1) * 10;
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		DBOpen();
		
		String sql = "";
		sql  = "select bno,btitle,bhit,date(bwdate) as bwdate, saveflag,thead,bkind,";
		sql += "(select count(*) from reply where bno = board.bno) as rcount,";
		sql += "(select name from user where userno = board.userno) as name ";
		sql += "from board ";
		sql += "where saveflag= 'T' ";
		sql += " order by bno desc ";
		sql += "limit " + startno + ",10 ";
		
		Select(sql);
		while(GetNext())
		{
			BoardVO vo = new BoardVO();
			vo.setBno(this.GetValue("bno"));
			vo.setBtitle(this.GetValue("btitle"));
			vo.setBkind(this.GetValue("bkind"));
			vo.setBhit(this.GetValue("bhit"));
			vo.setBwdate(this.GetValue("bwdate"));
			vo.setRcount(this.GetValue("rcount"));
			vo.setName(this.GetValue("name"));
			vo.setThead(this.GetValue("thead"));
			list.add(vo);
		}
		DBClose();
		return list;
		
	}
	//게시물 수정
	public boolean Update(BoardVO vo)
	{
		String sql = "";
		sql = "update board set ";
		sql += "btitle = '"+ _R(vo.getBtitle()) +"', ";
		sql += "bnote = '"+ _R(vo.getBnote()) +"', ";
		sql += "saveflag = '" + _R(vo.getSaveflag()) + "' ";
		if(vo.getThead() !=null)
		{
			sql += ", thead = '"+ _R(vo.getThead()) +"' ";
		}
		if(vo.getBfname() != null)
		{
			sql += ", bfname = '" + _R(vo.getBfname()) + "', ";
			sql += "bpname = '" + _R(vo.getBpname()) + "' ";
		}
		sql += "where bno= "+vo.getBno();
		DBOpen();
		RunSQL(sql);
		DBClose();
		return true;
	}
	//게시물 삭제
	//return true : 삭제 성공, false : 삭제 실패
	public boolean Delete(String bno)
	{
		String sql = "";
	
		this.DBOpen();

		//게시물에 매달려 있는 댓글을 모두 삭제한다.
		sql = "delete from reply where bno = " + bno;
		this.RunSQL(sql);

		//게시물을 삭제한다.		
		sql = "delete from board where bno = " + bno;
		this.RunSQL(sql);
		
		this.DBClose();
		return true;
	}
}