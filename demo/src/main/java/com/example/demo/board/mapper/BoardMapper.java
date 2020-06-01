package com.example.demo.board.mapper;
 
import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.board.domain.BoardVO;
import com.example.demo.board.domain.FileVO;
import com.example.demo.board.domain.SearchCriteria;
 
@Repository("com.example.demo.board.mapper.BoardMapper")
public interface BoardMapper {
	/*
	 * //게시글 개수 public int boardCount() throws Exception;
	 * 
	 * //게시글 목록 public List<BoardVO> boardList() throws Exception;
	 */
    
	//게시글 개수  
    public int boardCount(SearchCriteria scri) throws Exception;
    
    //게시글 목록  
    public List<BoardVO> boardList(SearchCriteria scri) throws Exception;
    
    //게시글 상세
    public BoardVO boardDetail(int bno) throws Exception;
    
    //게시글 작성  
    public int boardInsert(BoardVO board) throws Exception;
    
    //게시글 수정  
    public int boardUpdate(BoardVO board) throws Exception;
    
    //게시글 삭제  
    public int boardDelete(int bno) throws Exception;
    
    //파일 업로드
    public int fileInsert(FileVO file) throws Exception;
    
    //파일 리스트
    public List<FileVO> fileList(int bno) throws Exception;
    
    //파일 다운로드
    public FileVO fileDetail(int fno) throws Exception;
    
    //파일 삭제
    public int fileDelete(int fno) throws Exception;
    
    //파일 업데이트
    public int fileUpdate(FileVO file) throws Exception;
    
    // 게시물 목록 조회
 	public void boardHit(int bno) throws Exception;
}