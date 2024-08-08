package aws.dto;

import java.util.ArrayList;

import aws.dao.DBManager;
import aws.vo.ReplyVO;

public class ReplyDTO extends DBManager
{
	//댓글 등록
	public boolean Insert(ReplyVO vo)
	{
		this.DBOpen();
		String sql = "";
		sql  = "insert into reply ";
		sql += "(bno, ruserno, rnote) ";
		sql += "values ( ";
		sql += " '" + _R(vo.getBno()) +"', ";
		sql += " '" + _R(vo.getRuserno()) +"', ";
		sql += " '" + _R(vo.getRnote()) +"' ";
		sql += ") ";
		
		RunSQL(sql);
		
		sql = "select last_insert_id() as no "; // 등록된 댓글 번호를 얻는다
		this.Select(sql);
		this.GetNext();
		vo.setRno(this.GetValue("no"));	// vo에 댓글 번호를 반영한다
		this.DBClose();
		return true;
		
	}
	//댓글 정보조회
	public ReplyVO Read(String rno)
	{
		
		ReplyVO vo = null;
		DBOpen();
		
		String sql = "";
		sql  = "select rno,ruserno,rnote,rwdate,bno,";
		sql += "(select name from user where userno = reply.ruserno) as name ";
		sql += 		 "from reply ";
		sql += 		 "where rno = '" + rno + "'";
		Select(sql);
		if(this.GetNext())
		{
			vo = new ReplyVO();
			vo.setBno(this.GetValue("bno"));
			vo.setRno(this.GetValue("rno"));
			vo.setRuserno(this.GetValue("ruserno"));
			vo.setRnote(this.GetValue("rnote"));
			vo.setRwdate(this.GetValue("rwdate"));
			vo.setName(this.GetValue("name"));
		}
		
		this.DBClose();
		return vo;
		
	}
	//댓글 목록조회
	public ArrayList<ReplyVO> GetList(String bno)
	{
		ArrayList<ReplyVO> list = new ArrayList<ReplyVO>();
		
		DBOpen();
		String sql = "";
		sql  = "select rno,ruserno,rnote,date(rwdate) as rwdate,";
		sql += "(select name from user where userno = reply.ruserno) as name ";
		sql += 		 "from reply ";
		sql += 		 "where bno = '" + bno + "' ";
		sql += 		 "order by rwdate desc ";
		Select(sql);
		while(GetNext())
		{
			ReplyVO vo = new ReplyVO();
			vo.setRno(this.GetValue("rno"));
			vo.setRuserno(this.GetValue("ruserno"));
			vo.setRnote(this.GetValue("rnote"));
			vo.setRwdate(this.GetValue("rwdate"));
			vo.setName(this.GetValue("name"));
			list.add(vo);
		}
		DBClose();
		return list;
		
	}
	
	// 내가 작성한 댓글개수 얻어오기
	public int MyTotal(String ruserno)
	{	
		int total = 0;
		this.DBOpen();
		
		String sql = "select count(*) as total from reply ";
		sql += "where ruserno = '" + ruserno + "'";
		
		this.Select(sql);
		this.GetNext();
		total = this.GetInt("total");
		
		this.DBClose();
		return total;
	}
	// 내가작성한 댓글목록 얻어오기
	public ArrayList<ReplyVO> MyList(int pageno,String ruserno)
	{	int startno = (pageno - 1) * 10;
		ArrayList<ReplyVO> Rlist = new ArrayList<ReplyVO>();
		
		DBOpen();
		String sql = "";
		sql  = "select bno,rno,ruserno,rnote,date(rwdate) as rwdate,";
		sql += "(select btitle from board where bno = reply.bno) as title, ";
		sql += "(select bkind from board where bno = reply.bno) as bkind, ";
		sql += "(select name from user where userno = reply.ruserno) as name ";
		sql += 		 "from reply ";
		sql += 		 "where ruserno = '" + ruserno + "' ";
		sql += 		 "order by rno desc ";
		sql += "limit " + startno + ", 10";
		Select(sql);
		while(GetNext())
		{
			ReplyVO vo = new ReplyVO();
			vo.setRno(this.GetValue("rno"));
			vo.setRuserno(this.GetValue("ruserno"));
			vo.setRnote(this.GetValue("rnote"));
			vo.setRwdate(this.GetValue("rwdate"));
			vo.setName(this.GetValue("name"));
			vo.setBno(this.GetValue("bno"));
			vo.setTitle(this.GetValue("title"));
			vo.setKind(this.GetValue("bkind"));
			
			Rlist.add(vo);
		}
		DBClose();
		return Rlist;
		
	}
	//댓글 삭제
	//return true : 삭제 성공, false : 삭제 실패
	public boolean Delete(String rno)
	{
		String sql = "";
	
		this.DBOpen();

		//게시물에 매달려 있는 댓글을 삭제한다.
		sql = "delete from reply where rno = " + rno;
		this.RunSQL(sql);
		
		this.DBClose();
		return true;
	}
}