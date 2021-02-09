<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	if (title == null || title.isEmpty()) {
		title = "환영합니다";
	}
	pageContext.setAttribute("title", title);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- CSS --%>
<link type="text/css" rel="stylesheet" href="resources/style/style.css" >
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<%-- CDN --%>
<script defer src="https://use.fontawesome.com/releases/v5.15.1/js/all.js" integrity="sha384-9/D4ECZvKMVEJ9Bhr3ZnUAF+Ahlagp1cyPC7h5yDlZdXs4DQ/vRftzfd+2uFUuqS" crossorigin="anonymous"></script>
<%-- jQuery --%>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<%-- summbernote --%>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<%-- sweetalert --%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>


<title>${title}</title>

</head>

<body>
	<div class="header">
		<div class="top-wrap" >
			<a href="javascript:void(0)" ><img id="logo" alt="로고" src="resources/images/silhouette.png"></a>
			<ul class="top">
				<%-- 로그인 하지 않은 상태 --%>
				<c:if test="${loginUser eq null}">
					<li><a href="usersLoginPage.hey" >LOGIN</a></li>
					<li><a href="usersLoginPage.hey" >마이페이지</a></li>
					<li>
						<a href="javascript:void(0)" >
							<img alt="noticebell" src="resources/images/bell2.png" style="width:30px;"/>
						</a>
					</li>
				</c:if>
				<%-- 로그인 상태 --%>
				<c:if test="${loginUser ne null}">
					<li style="font-size:12px; font-weight:900;" ><a href="javascript:void(0)"></a>반갑습니다!</li>
					<li><a href="usersLogout.hey" >LOGOUT</a></li>
					<li><a href="myPage_commonPart.hey" >마이페이지</a></li>
					<li>
						<a href="javascript:void(0)" >
							<img alt="noticebell" src="../images/bell2.png"/>
						</a>
					</li>
				</c:if>
			</ul>
		</div>
		<nav>
			<ul class="menu-bar">
				<li><a href="javascript:void(0)" >ABOUT US</a></li>
				<li>
					<a href="goboard_knowhowList.limyeng">노하우 게시판</a>
				</li>
				<li>
					<a href="TrainerClassListPage.leo" >커뮤니티</a>
				</li>
				<li><a href="goTrainerList.plitche" >트레이너</a></li>
				<li><a href="goQnAPage.plitche" >질의응답</a></li>
			</ul>
		</nav>
	</div>
	<div class="body-wrap">