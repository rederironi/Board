<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>      <!-- 추가 -->
<layoutTag:layout>                                          <!-- 여는 태그 -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
 
<div class="container">
    <div class="col-xs-12" style="margin:15px auto;">
        <label style="font-size:20px;"><span class="glyphicon glyphicon-edit"></span>게시글 수정</label>
    </div>
 
    <div class="col-xs-12">
        <form action="/updateProc" method="post" name="updateForm" enctype="multipart/form-data">
	       	<%-- <input type="hidden" name="bno" value="${detail.bno}" readonly="readonly"/>
			<input type="hidden" id="page" name="page" value="${scri.page}"> 
			<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
			<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
			<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
			<input type="hidden" id="gubunSelect" name="gubunSelect" value="${scri.gubunSelect}"> 
        
          <div class="form-group">
            <label for="subject">구분</label>
	        <select id="gubun" name="gubun">
	        	<option value="1"<c:if test="${detail.gubun == '1'}"> selected</c:if>>공지사항</option>
	        	<option value="2"<c:if test="${detail.gubun == '2'}"> selected</c:if>>고시</option>
	        </select>
          </div>
          <div class="form-group">
            <label for="subject">제목</label>
            <input type="text" class="form-control" id="subject" name="subject" value="${detail.subject}">
          </div>
          <div class="form-group">
            <label for="content">내용</label>
            <textarea class="form-control" id="content" name="content" rows="3">${detail.content}</textarea>
          </div>
          <div class="form-group">
	         <label for="file">등록된 첨부파일</label>
	         <c:forEach var="file" items="${files}" varStatus="var">
	         <div>
	         	<a href="/fileDown/${file.fno}">${file.fileOriName}</a>
	         	<button id="fileDel" onclick="fn_del('${file.fno}');" type="button" style='float:right;'>삭제</button><br>
	         </div>
	         </c:forEach>
	       </div>
	       <c:forEach var="file" items="${file}" varStatus="var">
           <tr>
				<td colspan="4">
					<input type="hidden" id="FILE_NO" name="FILE_NO_${var.index}" value="${file.FILE_NO }">
					<input type="hidden" id="FILE_NAME" name="FILE_NAME" value="FILE_NO_${var.index}">
					<a href="#" id="fileName" onclick="return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)
					<button id="fileDel" onclick="fn_del('${file.FILE_NO}','FILE_NO_${var.index}');" type="button" style='float:right;'>삭제</button><br>
				</td>
			</tr>
			</c:forEach>
	       
          <div class="form-group">
	         <label for="file">파일 업로드</label>
	         <input type="file" id="file" name="files">
	       </div>
          <input type="hidden" name="bno" value="${detail.bno}"/>
          <button type="submit" class="btn btn-primary btn-sm" style="float:right;">수정</button> --%>
            <input type="hidden" name="bno" value="${detail.bno}" readonly="readonly"/>
		    <input type="hidden" id="page" name="page" value="${scri.page}"> 
			<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
			<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
			<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
			<input type="hidden" id="gubunSelect" name="gubunSelect" value="${scri.gubunSelect}">
			<input type="hidden" id="fileNoDel" name="fileNoDel" value=""> 
          
			<table class="table" id="fileIndex">
			    <tbody>
			    <tr>
			      <td>구분</td>
			      <td>
			      	<label for="subject">구분</label>
			        <select id="gubun" name="gubun">
			        	<option value="1"<c:if test="${detail.gubun == '1'}"> selected</c:if>>공지사항</option>
			        	<option value="2"<c:if test="${detail.gubun == '2'}"> selected</c:if>>고시</option>
			        </select>
			      </td>
			    </tr>
			     <tr style="line-height:32px;">
			       <td>제목</td>
			       <td colspan="3">
			           <input type="text" id=subject name="subject" class="form-control chk" title="제목을 입력하세요." value="${detail.subject}" />
			       </td>                      
			   </tr>
			   <tr>
			       <td>내용</td>
			       <td colspan="3">
			           <textarea id="content" name="content" class="form-control chk" title="내용을 입력하세요."><c:out value="${detail.content}" /></textarea>                                   
			       </td>
			   </tr>  
			   <tr>
			       <td>작성자</td>
			       <td colspan="3">
			           <input type="text" id="writer" name="writer" class="form-control chk" title="작성자를 입력하세요." value="${detail.writer}" />
			       </td>
			   </tr>
			   <c:forEach var="file" items="${files}" varStatus="var">
			   <tr>
					<td colspan="4">
					<input type="hidden" name="fno" value="${file.fno}">
					<a href="#" id="fileOriName" onclick="return false;">${file.fileOriName}</a><%-- (${file.FILE_SIZE}kb) --%>
					<button id="fileDel" onclick="fn_orgDel('${file.fno}');" type="button" style='float:right;'>삭제</button><br>
					</td>
				</tr>
				</c:forEach>
			    </tbody>
			</table>        
			<div class="text-center mt-3" style="margin-bottom:10px;">
		        <button type="button" class="btn btn-primary update_btn">수정</button>
				<button type="button" class="btn btn-default cancel_btn">취소</button>
				<button type="button" class="btn btn-info fileAdd_btn" onclick="fn_addFile();">파일추가</button>	
		    </div>  
        </form>
    </div>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		var formObj = $("form[name='updateForm']");
		
		$(document).on("click","#fileDel", function(){
			$(this).parent().remove();
		})
		
		$(".cancel_btn").on("click", function(){
			event.preventDefault();
			location.href = "/detail?bno=${detail.bno}"
				   + "&page=${scri.page}"
				   + "&perPageNum=${scri.perPageNum}"
				   + "&searchType=${scri.searchType}"
				   + "&keyword=${scri.keyword}"
				   + "&gubunSelect=${scri.gubunSelect}";
		})
		
		$(".update_btn").on("click", function(){
			if(fn_valiChk()){
				return false;
			}
			formObj.attr("action", "/updateProc");
			formObj.attr("method", "post");
			formObj.submit();
		})
	})
		
	function fn_valiChk(){
		var updateForm = $("form[name='updateForm'] .chk").length;
		for(var i = 0; i<updateForm; i++){
			if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
				alert($(".chk").eq(i).attr("title"));
				return true;
			}
		}
	}
	
	function fn_addFile(){
		$("#fileIndex").append("<tr><td colspan='4'><input type='file' style='float:left;' name='file'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></td></tr>");
	}
	
	function fn_orgDel(value){
		var fileNoDel = $("#fileNoDel").val();
		
		if(fileNoDel != ""){
			fileNoDel = fileNoDel + "|";
		}
		$("#fileNoDel").val(fileNoDel + value);
	}
</script>	
</body>
</html>

</layoutTag:layout>                                            <!-- 닫는 태그 -->