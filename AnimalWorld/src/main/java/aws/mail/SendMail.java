package aws.mail;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class SendMail 
{
	private String from;  //보내는 사람 메일주소
	private String to;    //받는 사람 메일주소
	private String title; //메일 제목
	private String body;  //메일 내용
	private String id;    //계정 아이디
	private String pw;    //계정 비밀번호
	
	public void setTo(String to)     { this.to = to;     };
	public void setFrom(String from) { this.from = from; };
	public void setMail(String title,String body)
	{
		this.title = title;
		this.body  = body;
	}
	public void setAccount(String id,String pw)
	{
		this.id = id;
		this.pw = pw;
	}
	
	
	//max자리의 인증코드를 생성한다.
	public String AuthCode(int max)
	{
		String datas = "01234567890abcdefghijklmnopqrstuvwxyz";
		String code = "";
		for(int i = 0 ; i < max; i++)
		{
			int rand = (int)(Math.random() * 100);
			rand = rand % datas.length();
			code += datas.charAt(rand);
		}
		return code;
	}
	
	//메일을 발송한다.
	public boolean sendMail()
	{
		try
		{
			System.out.println("메일 발송을 시작합니다.");
			
			Properties clsProp = System.getProperties();
			
			// 메일 서버 주소
			clsProp.put( "mail.smtp.host", "smtp.naver.com" );
			
			// 메일 서버 포트 번호
			clsProp.put( "mail.smtp.port", 465 );
			
			// 네이버 로그인인증
			clsProp.put("mail.smtp.auth", "true"); 
			clsProp.put("mail.smtp.ssl.enable", "true"); 
			clsProp.put("mail.smtp.ssl.trust", "smtp.naver.com");
			clsProp.put("mail.smtp.ssl.protocols", "TLSv1.2");
			
			Session clsSession = Session.getInstance( clsProp, new Authenticator()
			{
				public PasswordAuthentication getPasswordAuthentication()
				{
					// 인증 아이디/비밀번호를 저장한다.
					return new PasswordAuthentication( id, pw );
				}
			} );
			
			Message clsMessage = new MimeMessage( clsSession );
			
			// 발신자 이메일 주소를 설정한다.
			clsMessage.setFrom( new InternetAddress( from ) );
			
			// 수신자 이메일 주소를 설정한다.
			clsMessage.addRecipient( Message.RecipientType.TO, new InternetAddress( to ) );
			
			// 제목을 저장한다.
			clsMessage.setSubject( title );
			
			// 메일 내용을 저장한다. 소스 코드를 euc-kr 로 작성하여서 charset 을 euckr 로 설정함.
			clsMessage.setContent( body , "text/html;charset=euckr" );
			
			// 메일 전송
			Transport.send( clsMessage );
			
			System.out.println("메일 발송을 종료합니다.");
			
			return true;
		}catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("메일 발송을 종료합니다.");
			return false;
		}
	}
	
	public static void main(String[] args)
	{
		SendMail mail = new SendMail();
		//System.out.println(mail.AuthCode(7));
		mail.setFrom("cnrhcjs10@naver.com");
		mail.setTo("cnrhcjs10@naver.com");
		mail.setAccount("cnrhcjs10", "1124rhcjs@");
		mail.setMail("이것은 제목입니다.", "인증코드 : " + mail.AuthCode(4));
		mail.sendMail();
		
	}

}
