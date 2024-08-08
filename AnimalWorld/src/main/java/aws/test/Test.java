package aws.test;

import aws.dao.*;
import aws.vo.*;
import aws.dto.*;

public class Test 
{
public static void main(String[] args) 
{
	// BoardDTO 객체 생성
	BoardDTO dto = new BoardDTO();
	// BoardVO 객체 생성
	BoardVO vo = new BoardVO();
	// BoardVO 객체에, 데이터를 넣기
	vo.setUserno("5");
	vo.setBkind("free");
	vo.setBtitle("DTO를 이용한 게시글");
	vo.setBnote("test.java에서 실행했습니다");
	vo.setSaveflag("F");
	vo.setBfname("");
	vo.setBpname("");
	// insert 결과가 true이면 생성된 bno를 출력해봅니다
	if(dto.Insert(vo)==true)
	{
		System.out.println(vo.getBno());
	}	
}
}