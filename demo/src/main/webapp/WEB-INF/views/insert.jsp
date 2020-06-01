<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>      <!-- 추가 -->
<layoutTag:layout>                                          <!-- 여는 태그 -->
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert Form</title>
</head>
<body>
 
<div class="container">
	<div class="col-xs-12" style="margin:15px auto;">
        <label style="font-size:20px;"><span class="glyphicon glyphicon-edit"></span>게시글 작성</label>
    </div>

    <form name="writeForm" action="/insertProc" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label for="subject">구분</label>
        <select id="gubun" name="gubun">
        	<option value="1">공지사항</option>
        	<option value="2">고시</option>
        </select>
      </div>
<!--       <div class="form-group">
        <label for="subject">제목</label>
        <input type="text" class="form-control" id="subject" name="subject" placeholder="제목을 입력하세요." maxlength="50">
      </div>
      <div class="form-group">
        <label for="writer">작성자</label>
        <input type="text" class="form-control" id="writer" name="writer" placeholder="작성자를 입력하세요." maxlength="50">
      </div>
      <div class="form-group">
        <label for=content">내용</label>
        <textarea class="form-control" id="content" name="content" rows="3" placeholder="내용을 입력하세요." maxlength="1024"></textarea>
      </div>
      <div class="form-group">
         <label for="file">파일 업로드</label>
         <input type="file" id="file" name="files">
       </div>
       <div class="form-group">
         <label for="file">신규 파일 업로드</label>
         <button class="btn btn-info fileAdd_btn" type="button">파일추가</button>
         <div id="fileIndex"></div>
       </div> -->
       
       
       
       <table class="table" id="fileIndex">
           <tbody>
            <tr style="line-height:32px;">
                <td>제목</td>
                <td colspan="3">
                    <input type="text" id="subject" name="subject" class="form-control chk" title="제목을 입력하세요." maxlength="50"/>
                </td>                      
            </tr>
            <tr>
                <td>작성자</td>
                <td colspan="3">
                    <input type="text" id="writer" name="writer" class="form-control chk" title="작성자를 입력하세요." maxlength="50" />
                </td>
            </tr>
            <tr>
                <td>내용</td>
                <td colspan="3">
                    <textarea id="content" name="content" class="form-control chk" title="내용을 입력하세요." maxlength="1024"></textarea>                                   
                </td>
            </tr>  
           </tbody>
       </table>
		<div class="text-center mt-3" style="margin-bottom:10px;">
	        <button type="button" class="btn btn-primary write_btn">작성</button>
	        <button type="button" class="btn btn-default cancel_btn">취소</button>
	        <button class="btn btn-info fileAdd_btn" type="button" onclick="fn_addFile();">파일추가</button>	
	    </div>
    </form>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		fn_addFile();
		
		var formObj = $("form[name='writeForm']");
		$(".write_btn").on("click", function(){
			if(fn_valiChk()){
				return false;
			}
			formObj.attr("action", "/insertProc");
			formObj.attr("method", "post");
			formObj.submit();
		});

		$(".cancel_btn").on("click", function(){
			event.preventDefault();
			location.href = "/list";
		})
	})
	
	$(document).on("click","#fileDelBtn", function(){
		$(this).parent().parent().remove();
		
	});
	
	function fn_valiChk(){
		var regForm = $("form[name='writeForm'] .chk").length;
		for(var i = 0; i<regForm; i++){
			if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
				alert($(".chk").eq(i).attr("title"));
				return true;
			}
		}
	}
	function fn_addFile(){
		$("#fileIndex").append("<tr><td colspan='4'><input type='file' style='float:left;' name='file'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></td></tr>");
	}
</script>	
</body>
</html>

</layoutTag:layout>                                            <!-- 닫는 태그 -->