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
<title>Detail</title>
</head>
<body>

<div class="container">
    <div class="col-xs-12" style="margin:15px auto;">
        <label style="font-size:20px;"><span class="glyphicon glyphicon-list-alt"></span>게시글 상세</label>
    </div>
 	<form name="readForm" role="form" method="post">
		<input type="hidden" id="bno" name="bno" value="${detail.bno}" />
		<input type="hidden" id="page" name="page" value="${scri.page}"> 
		<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
		<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
		<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
		<input type="hidden" id="gubunSelect" name="gubunSelect" value="${scri.gubunSelect}"> 
	</form>
 
    <div class="col-xs-12">
        <form action="/insertProc" method="post">
            <dl class="dl-horizontal">
              <dt>구분</dt>
              <dd>
              <c:if test="${detail.gubun == '1'}">
				공지사항
			  </c:if>
              <c:if test="${detail.gubun == '2'}">
				고시
			  </c:if>
              </dd>
              <dt>제목</dt>
              <dd>${detail.subject}</dd>
              
              <dt>내용</dt>
              <dd>
              	<%-- <div style="min-height:100px;display:block;"><c:out value="${detail.content}" /></div> --%>
              	<pre><c:out value="${detail.content}" /></pre>
              </dd>
              
              <dt>작성자</dt>
              <dd>${detail.writer}</dd>
              
              <dt>작성날짜</dt>
              <dd>
                  <fmt:formatDate value="${detail.reg_date}" pattern="yyyy.MM.dd HH:mm:ss"/>
              </dd>
              <dt>수정날짜</dt>
              <dd>
                  <fmt:formatDate value="${detail.mod_date}" pattern="yyyy.MM.dd HH:mm:ss"/>
              </dd>
              <dt>파일 목록</dt>
              <dd>
              	<c:forEach var="file" items="${files}">
              		<a href="/fileDown/${file.fno}">${file.fileOriName}</a>
              	</c:forEach>
              </dd>
            </dl>
        </form>
        <div class="btn-group btn-group-sm" role="group" style="float:right;">
          <%-- <button type="button" class="btn btn-default delete_btn" onclick="location.href='/delete/${detail.bno}'">삭제</button>
          <button type="button" class="btn btn-default update_btn" onclick="location.href='/update/${detail.bno}'">수정</button>
          <button type="button" class="btn btn-default list_btn" onclick="location.href='/list'"> 목록 </button> --%>
          <button type="button" class="btn btn-default delete_btn">삭제</button>
          <button type="button" class="btn btn-default update_btn">수정</button>
          <button type="button" class="btn btn-default list_btn"> 목록 </button>
        </div>
    </div>
</div>
<script type="text/javascript">
	
	$(document).ready(function(){
		// 수정 
		$(".update_btn").on("click", function(){
			location.href="/update?bno=${detail.bno}"
				  +"&page=${scri.page}"
			      +"&perPageNum=${scri.perPageNum}"
			      +"&searchType=${scri.searchType}&keyword=${scri.keyword}"
			      +"&gubunSelect=${scri.gubunSelect}";
		})
		
		// 삭제
		$(".delete_btn").on("click", function(){
			location.href="/delete?bno=${detail.bno}"
				  +"&page=${scri.page}"
			      +"&perPageNum=${scri.perPageNum}"
			      +"&searchType=${scri.searchType}&keyword=${scri.keyword}"
			      +"&gubunSelect=${scri.gubunSelect}";
		})
		
		// 목록
		$(".list_btn").on("click", function(){
			location.href = "/list?page=${scri.page}"
					      +"&perPageNum=${scri.perPageNum}"
					      +"&searchType=${scri.searchType}&keyword=${scri.keyword}"
					      +"&gubunSelect=${scri.gubunSelect}";
		})
	})
</script>	 
</body>
</html>

</layoutTag:layout>                                            <!-- 닫는 태그 -->