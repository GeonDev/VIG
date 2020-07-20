<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 		 
 <nav aria-label="Page navigation">

  <ul class="pagination pg-blue" >    
    <!--  <<== 좌측 nav -->
  	<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
 		<li class="page-item disabled"> 		
	</c:if>	
	
	<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
		<li class="page-item">
	</c:if>
	
      <a class="page-link" aria-label="Previous" href="javascript:funcGetList('${ resultPage.currentPage-1}')">
        <span aria-hidden="true">&laquo;</span>
        <span class="sr-only">Previous</span>
      </a>
    </li>
    
    <!--  중앙  -->
	<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">		
		<c:if test="${ resultPage.currentPage == i }">
			<!--  현재 page 가르킬경우 : active -->
		    <li class="page-item active">
		    	<a class="page-link" href="javascript:funcGetList('${ i }');">${ i }</a>
		    </li>
		</c:if>	
		
		<c:if test="${ resultPage.currentPage != i}">	
			<li class="page-item">
				<a class="page-link" href="javascript:funcGetList('${ i }');">${ i }</a>
			</li>
		</c:if>
	</c:forEach>
    
     <!--  우측 nav==>> -->
     <c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
  		<li class="page-item disabled">
	</c:if>
	<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
		<li class="page-item">
	</c:if>
	
      <a class="page-link" aria-label="Next" href="javascript:funcGetList('${resultPage.endUnitPage+1}')" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
        <span class="sr-only">Next</span>
      </a>
    </li>
  </ul>
</nav>
		
