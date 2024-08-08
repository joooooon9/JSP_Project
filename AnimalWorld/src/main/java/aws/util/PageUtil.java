package aws.util;

//페이징 처리 클래스 (Helper Class)
public class PageUtil 
{
	private int pageno     = 1;  //현재 페이지 번호
	private int total      = 0;  //전체 게시물 갯수
	private int maxpage    = 0;  //전체 페이지수
	private int startBlock = 0; //페이지 시작 블럭 번호
	private int endBlock   = 0; //페이지 끝 블럭 번호

	//현재 페이지 번호를 세팅한다.
	public void setPageNo(String pageno)
	{
		try
		{
			this.pageno = Integer.parseInt(pageno);
		}catch(Exception e) {};
	}
	
	//현재 페이지 번호를 세팅한다.
	public void setPageNo(int pageno)
	{
		this.pageno = pageno;
	}
	
	//전체 게시물 갯수 설정
	public void setTotal(int total)
	{
		//전체 페이지 갯수 설정
		this.total   = total;
		this.maxpage = total / 10;
		if( total % 10 != 0 ) maxpage++;
		
		//시작 블럭 번호 , 끝 블럭 번호
		startBlock = ((pageno-1) - ((pageno-1) % 10)) + 1;
		
		endBlock   = startBlock + 10 - 1;
		if(endBlock > maxpage) endBlock = maxpage;	
	}
	
	public int getPageNo()     { return this.pageno;     }
	public int getMaxPage()    { return this.maxpage;    }
	public int getStartBlock() { return this.startBlock; }
	public int getEndBlock()   { return this.endBlock;   }
	
	public String PrintStart(String url)
	{
		String new_url = url; 
		if(this.startBlock > 10)
		{
			new_url = new_url.replace("{page}", Integer.toString(this.startBlock - 1)); 
		}else
		{
			new_url = "";
		}
		return new_url;
	}
	
	public String PrintEnd(String url)
	{
		String new_url = url; 
		if(this.endBlock != this.maxpage)
		{
			new_url = new_url.replace("{page}", Integer.toString(this.endBlock + 1)); 
		}else
		{
			new_url = "";
		}
		return new_url;
	}
	
	public String PrintPage(String url)
	{
		String new_url = url;
		String html = "";
		
		for(int p = this.startBlock; p <= this.endBlock; p++)
		{
			String css = "";
			if(p == this.pageno) css = "current";
			new_url = url;
			new_url = new_url.replace("{current}", css);
			new_url = new_url.replace("{page}", Integer.toString(p));			
			html += new_url;
		}	
		return html;
		
	}
	
}
