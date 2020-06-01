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
<title>List</title>
</head>
<body>
 
<div class="container">
	<div class="col-xs-12" style="margin:15px auto;">
        <label style="font-size:20px;"><span class="glyphicon glyphicon-list-alt"></span>게시글 목록</label>
        <!-- <button class="btn btn-primary btn-sm" style="float:right;" onclick="location.href='/insert'">글쓰기</button> -->
    </div>
    
    <div class="col-xs-12">
    	<select id="gubunSelect" name="gubunSelect" onchange="fn_gubunSelect();" class="form-control" style="margin-left:18px;width:200px;">
			<option value=""<c:out value="${scri.gubunSelect eq '' ? 'selected' : ''}"/>>전체</option>
			<option value="1"<c:out value="${scri.gubunSelect eq '1' ? 'selected' : ''}"/>>공지사항</option>
			<option value="2"<c:out value="${scri.gubunSelect eq '2' ? 'selected' : ''}"/>>고시</option>
		</select>
		<hr>
	    <table class="table table-hover">
	        <tr>
	            <th>번호</th>
	            <th>구분</th>
	            <th>제목</th>
	            <th>작성자</th>
	            <th>등록일</th>
	            <th>수정일</th>
	            <th>조회수</th>
	        </tr>
	          <c:forEach var="l" items="${list}">
	              <tr onclick="location.href='/detail?bno=${l.bno}&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&gubunSelect=${scri.gubunSelect}'" style="cursor:pointer;">
	                  <td>${l.bno}</td>
	                  <td>
	                  <c:if test="${l.gubun == '1'}">
						<p>공지사항</p>
					  </c:if>
					  <c:if test="${l.gubun == '2'}">
						<p>고시</p>
					  </c:if>
	                  </td>
	                  <td>${l.subject}</td>
	                  <td>${l.writer}</td>
	                  <td>
	                  	<fmt:formatDate value="${l.reg_date}" pattern="yyyy.MM.dd HH:mm:ss"/>
	                  </td>
	                  <td>
	                  	<fmt:formatDate value="${l.mod_date}" pattern="yyyy.MM.dd HH:mm:ss"/>
	                  </td>
	                  <td>${l.hit}</td>
	              </tr>
	          </c:forEach>
	    </table>
	    <div class="search row">
			<div class="col-xs-2 col-sm-2">
				<select id="searchType" name="searchType" class="form-control">
					<option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
					<option value="s"<c:out value="${scri.searchType eq 's' ? 'selected' : ''}"/>>제목</option>
					<option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
					<option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
					<option value="sc"<c:out value="${scri.searchType eq 'sc' ? 'selected' : ''}"/>>제목+내용</option>
					<option value="all"<c:out value="${scri.searchType eq 'all' ? 'selected' : ''}"/>>전체</option>
				</select>
			</div>
			
			<div class="col-xs-10 col-sm-10">
				<div class="input-group">
					<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" class="form-control"/>
					<span class="input-group-btn">
						<button id="searchBtn" type="button" class="btn btn-default" onclick="fn_search();">검색</button> 	
					</span>
				</div>
			</div>
		</div>
		<div class="sui-pager sui-pager-core">
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li><a href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
				</c:if> 
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					<li <c:out value="${pageMaker.cri.page == idx ? 'class=active' : ''}" />>
					<a href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
				</c:forEach>
				
				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li><a href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
				</c:if> 
			</ul>
			<div class="sui-pager-info-box" style="float:right;margin-top:15px;">
				<button type="button" class="btn btn-primary" onclick="location.href='/insert'">글쓰기</button>
			</div>
		</div>
	</div>	    
</div>
 
 <script type="text/javascript">
 	function fn_search(){
 		 if($("#searchType option:selected").val() == "n"){
			 alert("검색 항목을 선택해 주세요.");
		 }else{
			 if($('#keywordInput').val() == ""){
				 alert("검색어를 입력해 주세요.");
			 }else{
				 self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("#searchType option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val()) + "&gubunSelect=" + $("#gubunSelect option:selected").val();
			 }
		 }
 	}
 
	function fn_gubunSelect(){ 
		self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("#searchType option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val()) + "&gubunSelect=" + $("#gubunSelect option:selected").val();
	}
</script>
</body>
</html>

</layoutTag:layout>                                            <!-- 닫는 태그 -->