package com.example.demo.board.service;
 
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.example.demo.board.domain.BoardVO;
import com.example.demo.board.domain.FileVO;
import com.example.demo.board.domain.SearchCriteria;
import com.example.demo.board.mapper.BoardMapper;
 
@Service("com.example.demo.board.service.BoardService")
public class BoardService {
 
    @Resource(name="com.example.demo.board.mapper.BoardMapper")
    BoardMapper mBoardMapper;
    
	/*
	 * public List<BoardVO> boardListService() throws Exception{
	 * 
	 * return mBoardMapper.boardList(); }
	 */
    
    // 게시물 목록 조회
 	public List<BoardVO> boardListServicePage(SearchCriteria scri) throws Exception {
		return mBoardMapper.boardList(scri);
	}
 	
 	// 게시물 총 갯수
 	public int boardListCount(SearchCriteria scri) throws Exception {
		return mBoardMapper.boardCount(scri);
	}
    
    public BoardVO boardDetailService(int bno) throws Exception{
        
        return mBoardMapper.boardDetail(bno);
    }
    
    public int boardInsertService(BoardVO board) throws Exception{
        
        return mBoardMapper.boardInsert(board);
    }
    
    public int boardUpdateService(BoardVO board) throws Exception{
        
        return mBoardMapper.boardUpdate(board);
    }
    
    public int boardDeleteService(int bno) throws Exception{
        
        return mBoardMapper.boardDelete(bno);
    }
    
    public int fileInsertService(FileVO file) throws Exception{
        return mBoardMapper.fileInsert(file);
    }
    
    public List<FileVO> fileListService(int bno) throws Exception{
        
        return mBoardMapper.fileList(bno);
    }
    
    public FileVO fileDetailService(int fno) throws Exception{

        return mBoardMapper.fileDetail(fno);
    }
    
    public int fileDeleteService(int fno) throws Exception{
        
        return mBoardMapper.fileDelete(fno);
    }
    
    public int fileUpdateService(FileVO file) throws Exception{
        
        return mBoardMapper.fileUpdate(file);
    }
    
    public void boardHit(int bno) throws Exception {
		mBoardMapper.boardHit(bno);
	}
    
    
}