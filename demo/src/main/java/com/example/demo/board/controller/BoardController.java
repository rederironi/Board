package com.example.demo.board.controller;
 
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.board.domain.BoardVO;
import com.example.demo.board.domain.FileVO;
import com.example.demo.board.domain.PageMaker;
import com.example.demo.board.domain.SearchCriteria;
import com.example.demo.board.service.BoardService;
 
@Controller
public class BoardController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	@Value("${file.upload.directory}")
	String uploadFileDir;
	
    @Resource(name="com.example.demo.board.service.BoardService")
    BoardService mBoardService;
    
	/*
	 * @RequestMapping("/list") //게시판 리스트 화면 호출 private String boardList(Model
	 * model) throws Exception{
	 * 
	 * model.addAttribute("list", mBoardService.boardListService());
	 * 
	 * return "list"; //생성할 jsp }
	 */
    
    @RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
    	return "redirect:/list";
	}
    
    @RequestMapping(value = "/list", method = RequestMethod.GET) //게시판 리스트 화면 호출  
    public String boardList(Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
        
		/* model.addAttribute("list", mBoardService.boardListService()); */
    	
    	model.addAttribute("list", mBoardService.boardListServicePage(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(mBoardService.boardListCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
    	
        
        return "list"; //생성할 jsp
    }
    
    //@RequestMapping("/detail/{bno}")
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    private String boardDetail(Model model, BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
    	
    	mBoardService.boardHit(boardVO.getBno());
    	
    	//model.addAttribute("read", service.read(boardVO.getBno()));
		model.addAttribute("scri", scri);
        
        model.addAttribute("detail", mBoardService.boardDetailService(boardVO.getBno()));
        model.addAttribute("files", mBoardService.fileListService(boardVO.getBno()));
       
        
        return "detail";
    }
    
    @RequestMapping("/insert") //게시글 작성폼 호출  
    private String boardInsertForm(){
        
        return "insert";
    }
    
    /*
    @RequestMapping("/insertProc")
    private String boardInsertProc(HttpServletRequest request, @RequestPart MultipartFile files) throws Exception{
        BoardVO board = new BoardVO();
        FileVO  file  = new FileVO();
        
        board.setGubun(request.getParameter("gubun"));
        board.setSubject(request.getParameter("subject"));
        board.setContent(request.getParameter("content"));
        board.setWriter(request.getParameter("writer"));
        
        
        if(files.isEmpty()){ //업로드할 파일이 없을 시
            mBoardService.boardInsertService(board); //게시글 insert
        }else{
            String fileName = files.getOriginalFilename(); 
            String fileNameExtension = FilenameUtils.getExtension(fileName).toLowerCase(); 
            File destinationFile; 
            String destinationFileName; 
            //String fileUrl = "D:\\projects\\jsp\\demo\\src\\main\\webapp\\WEB-INF\\uploadFiles\\";
            
            do { 
                destinationFileName = RandomStringUtils.randomAlphanumeric(32) + "." + fileNameExtension; 
                destinationFile = new File(uploadFileDir+ destinationFileName); 
            } while (destinationFile.exists()); 
            
            destinationFile.getParentFile().mkdirs(); 
            files.transferTo(destinationFile); 
            
            mBoardService.boardInsertService(board); //게시글 insert
            
            file.setBno(board.getBno());
            file.setFileName(destinationFileName);
            file.setFileOriName(fileName);
            file.setFileUrl(uploadFileDir);
            
            mBoardService.fileInsertService(file); //file insert
        }
        
        
        return "redirect:/list";
    }
	*/
	
    
    @RequestMapping("/insertProc")
    private String boardInsertProc(HttpServletRequest request, MultipartHttpServletRequest mRequest) throws Exception{
    	/*
    	logger.trace("Trace Level 테스트"); 
    	logger.debug("DEBUG Level 테스트"); 
    	logger.info("INFO Level 테스트"); 
    	logger.warn("Warn Level 테스트"); 
    	logger.error("ERROR Level 테스트");
		*/
    	
    	BoardVO board = new BoardVO();
        FileVO  file  = new FileVO();
        
        board.setGubun(request.getParameter("gubun"));
        board.setSubject(request.getParameter("subject"));
        board.setContent(request.getParameter("content"));
        board.setWriter(request.getParameter("writer"));
        
        mBoardService.boardInsertService(board); //게시글 insert
        
        int r_Bno = board.getBno();
      
        List<MultipartFile> multipartFiles = mRequest.getMultiFileMap().get("file");
        
		String originalFileName = null; 
		String originalFileExtension = null; 
		String storedFileName = null; 
		
		File dir = new File(uploadFileDir);
        if(!dir.isDirectory()) {
        	dir.mkdir();
        }
        
        if(multipartFiles != null) {
			int count = 1;
			for (MultipartFile multipartFile: multipartFiles) {
				if(multipartFile.isEmpty() == false){ 
					originalFileName = multipartFile.getOriginalFilename(); 
					originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf(".")); 
					storedFileName = getRandomString() + originalFileExtension; 
					multipartFile.transferTo(new File(uploadFileDir + storedFileName)); 
					
					file.setBno(r_Bno);
		            file.setFileName(storedFileName);
		            file.setFileOriName(originalFileName);
		            file.setFileUrl(uploadFileDir);
		            
		            mBoardService.fileInsertService(file); //file insert
		            count++;
				}
			}
        }
        return "redirect:/list";
    }

    
    //@RequestMapping("/update/{bno}") //게시글 수정폼 호출  
    @RequestMapping(value = "/update", method = RequestMethod.GET)
    private String boardUpdateForm(Model model, BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
        
    	model.addAttribute("scri", scri);
    	
        model.addAttribute("detail", mBoardService.boardDetailService(boardVO.getBno()));
        model.addAttribute("files", mBoardService.fileListService(boardVO.getBno()));
        
        return "update";
    }
    
    @RequestMapping("/updateProc")
    private String boardUpdateProc(HttpServletRequest request,
    							   MultipartHttpServletRequest mRequest,
    							   @ModelAttribute("scri") SearchCriteria scri, 
    							   RedirectAttributes rttr) throws Exception{
        
    	BoardVO board = new BoardVO();
    	FileVO  file  = new FileVO();
    	
    	int r_Bno = Integer.parseInt(request.getParameter("bno"));
    	
    	board.setGubun(request.getParameter("gubun"));
        board.setSubject(request.getParameter("subject"));
        board.setContent(request.getParameter("content"));
        board.setWriter(request.getParameter("writer"));
        board.setBno(r_Bno);
        
        mBoardService.boardUpdateService(board);
        
        String fileNoDel = (request.getParameter("fileNoDel") == null) ? "" : request.getParameter("fileNoDel").trim();
        
        if(fileNoDel != "") {
        	File delFile = null;
        	FileVO DelfileVO = null;
        	String delFilePath = "";
            String delFileName = "";
        	
	        if(fileNoDel.indexOf("|") > -1) {
	        	String[] fileNoDelArr = fileNoDel.split("\\|");
		        for(int i=0; i<fileNoDelArr.length; i++) {
		        	if(isNumber(fileNoDelArr[i])){
		        		DelfileVO = mBoardService.fileDetailService(Integer.parseInt(fileNoDelArr[i]));
		        		delFilePath = DelfileVO.getFileUrl();
		        		delFileName = DelfileVO.getFileName();
		        		delFile = new File(delFilePath, delFileName);
		        		if(delFile.exists()) {
		        			delFile.delete();
		        		}
		        		mBoardService.fileDeleteService(Integer.parseInt(fileNoDelArr[i]));
		        	}
		        }
	        } else {
	        	if(isNumber(fileNoDel)){
	        		DelfileVO = mBoardService.fileDetailService(Integer.parseInt(fileNoDel));
	        		delFilePath = DelfileVO.getFileUrl();
	        		delFileName = DelfileVO.getFileName();
	        		delFile = new File(delFilePath, delFileName);
	        		if(delFile.exists()) {
	        			delFile.delete();
	        		}
	        		mBoardService.fileDeleteService(Integer.parseInt(fileNoDel));
	        	}
	        }
	        
	        delFile = null;
	        DelfileVO = null;
        }

        
        List<MultipartFile> multipartFiles = mRequest.getMultiFileMap().get("file");

		String originalFileName = null; 
		String originalFileExtension = null; 
		String storedFileName = null; 

		File dir = new File(uploadFileDir);
        if(!dir.isDirectory()) {
        	dir.mkdir();
        }
        
        
        if(multipartFiles != null) {
			int count = 1;
			for (MultipartFile multipartFile: multipartFiles) {
				if(multipartFile.isEmpty() == false){ 
					originalFileName = multipartFile.getOriginalFilename(); 
					originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf(".")); 
					storedFileName = getRandomString() + originalFileExtension; 
					multipartFile.transferTo(new File(uploadFileDir + storedFileName)); 
					
					file.setBno(r_Bno);
		            file.setFileName(storedFileName);
		            file.setFileOriName(originalFileName);
		            file.setFileUrl(uploadFileDir);
	
		            mBoardService.fileInsertService(file); //file insert
		            count++;
				}
			}
        }
        
        rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		rttr.addAttribute("gubunSelect", scri.getGubunSelect());
        
        return "redirect:/detail?bno="+r_Bno;
    }
 
	//@RequestMapping("/delete/{bno}")
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    private String boardDelete(BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception{
    	
    	List<FileVO> delFileVOList = mBoardService.fileListService(boardVO.getBno());
    	
    	if(delFileVOList.isEmpty() == false) {
            delFileVOList.forEach(file-> { 
            	String delFilePath = file.getFileUrl();
            	String delFileName = file.getFileName();
            	File delFile = new File(delFilePath, delFileName);
            	if(delFile.exists()) {
    				delFile.delete();
    			}
    		});
    	}
    	
        mBoardService.boardDeleteService(boardVO.getBno());
        
        rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		rttr.addAttribute("gubunSelect", scri.getGubunSelect());
        
        return "redirect:/list";
    }
    
    @RequestMapping("/fileDown/{fno}")
    private void fileDown(@PathVariable int fno, HttpServletRequest request, HttpServletResponse response) throws Exception{
        
        request.setCharacterEncoding("UTF-8");
        FileVO fileVO = mBoardService.fileDetailService(fno);
        
        //파일 업로드된 경로 
        try{
            String fileUrl = fileVO.getFileUrl();
            //fileUrl += "/";
            String savePath = fileUrl;
            String fileName = fileVO.getFileName();
            
            //실제 내보낼 파일명 
            String oriFileName = fileVO.getFileOriName();
            InputStream in = null;
            OutputStream os = null;
            File file = null;
            boolean skip = false;
            String client = "";
            
            //파일을 읽어 스트림에 담기  
            try{
                file = new File(savePath, fileName);
                in = new FileInputStream(file);
            } catch (FileNotFoundException fe) {
                skip = true;
            }
            
            client = request.getHeader("User-Agent");
            
            //파일 다운로드 헤더 지정 
            response.reset();
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Description", "JSP Generated Data");
            
            if (!skip) {
                // IE
                if (client.indexOf("MSIE") != -1) {
                    response.setHeader("Content-Disposition", "attachment; filename=\""
                            + java.net.URLEncoder.encode(oriFileName, "UTF-8").replaceAll("\\+", "\\ ") + "\"");
                    // IE 11 이상.
                } else if (client.indexOf("Trident") != -1) {
                    response.setHeader("Content-Disposition", "attachment; filename=\""
                            + java.net.URLEncoder.encode(oriFileName, "UTF-8").replaceAll("\\+", "\\ ") + "\"");
                } else {
                    // 한글 파일명 처리
                    response.setHeader("Content-Disposition",
                            "attachment; filename=\"" + new String(oriFileName.getBytes("UTF-8"), "ISO8859_1") + "\"");
                    response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
                }
                response.setHeader("Content-Length", "" + file.length());
                os = response.getOutputStream();
                byte b[] = new byte[(int) file.length()];
                int leng = 0;
                while ((leng = in.read(b)) > 0) {
                    os.write(b, 0, leng);
                }
            } else {
                response.setContentType("text/html;charset=UTF-8");
                System.out.println("<script language='javascript'>alert('파일을 찾을 수 없습니다');history.back();</script>");
            }
            in.close();
            os.close();
        } catch (Exception e) {
            System.out.println("ERROR : " + e.getMessage());
        }
        
    }
    
    public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
    
    public static boolean isNumber(String str){
        boolean result = false;
         
         
        try{
            Double.parseDouble(str) ;
            result = true ;
        }catch(Exception e){}
         
         
        return result ;
    }
}