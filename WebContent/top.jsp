<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>簡易Twitter</title>
        <link href="./css/style.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div class="main-contents">
			<div class="header">
				<%-- ログアウト時の表示 --%>
			    <c:if test="${ empty loginUser }">
			        <a href="login">ログイン</a>
			        <a href="signup">登録する</a>
			    </c:if>

			    <%-- ログイン時の表示 --%>
			    <c:if test="${ not empty loginUser }">
			        <a href="./">ホーム</a>
			        <a href="setting">設定</a>
			        <a href="logout">ログアウト</a>
			    </c:if>
			</div>

			<%-- ログイン時の表示 --%>
			<c:if test="${ not empty loginUser }">
			    <div class="profile">
			        <div class="name"><h2><c:out value="${loginUser.name}" /></h2></div>
			        <div class="account">@<c:out value="${loginUser.account}" /></div>
			        <div class="description"><c:out value="${loginUser.description}" /></div>
			    </div>
			</c:if>

			<%-- エラーメッセージの表示 --%>
			<c:if test="${ not empty errorMessages }">
			    <div class="errorMessages">
			        <ul>
			            <c:forEach items="${errorMessages}" var="errorMessage">
			                <li><c:out value="${errorMessage}" />
			            </c:forEach>
			        </ul>
			    </div>
			    <c:remove var="errorMessages" scope="session" />
			</c:if>

			<%-- コメントフォームの表示 --%>
			<div class="form-area">
			    <c:if test="${ isShowMessageForm }">
			        <form action="message" method="post">
			            いま、どうしてる？<br />
			            <textarea name="text" cols="100" rows="5" class="tweet-box"></textarea>
			            <br />
			            <input type="submit" value="つぶやく">（140文字まで）
			        </form>
			    </c:if>
			</div>

			<%-- つぶやきの表示 --%>
			<div class="messages">
			    <c:forEach items="${messages}" var="message">
			        <div class="message">
			            <div class="account-name">
							<span class="account">
							    <a href="./?user_id=<c:out value="${message.userId}"/> ">
							        <c:out value="${message.account}" />
							    </a>
							</span>
			                <span class="name"><c:out value="${message.name}" /></span>
			            </div>
			            <div class="text"><pre><c:out value="${message.text}" /></pre></div>
			            <div class="date"><fmt:formatDate value="${message.createdDate}" pattern="yyyy/MM/dd HH:mm:ss" /></div>
			        </div>

			        <%-- 投稿の削除ボタン --%>
			        <c:if test="${ loginUser.id == message.userId }">
				        <div class="delete">
				        	<form action="deleteMessage" method="post">
				        		<input type="hidden" name="messageId" value="${message.id}">
				        		<input type="submit" value="削除">
				        	</form>
				        </div>

				        <%-- 投稿の編集ボタン --%>
				        <div class="update">
				        	<form action="edit" method="get">
				        		<input type="hidden" name="messageId" value="${message.id}">
				        		<input type="submit" value="編集">
				        	</form>
				        </div>
			        </c:if>

			        <%-- 返信フォームの表示 --%>
					<div class="commentform-area">
					    <c:if test="${ not empty loginUser }">
					        <form action="comment" method="post">
					            <br />
					            <textarea name="text" cols="100" rows="5" class="tweet-box"></textarea>
					            <br />
					            <input type="hidden" name="messageId" value="${ message.id }">
					            <input type="submit" value="返信">（140文字まで）
					        </form>
					    </c:if>

					    <%-- 返信コメントの表示 --%>
					    <c:forEach items="${messages}" var="message">
					        <div class="message">
					            <div class="account-name">
									<span class="account">
									    <a href="./?user_id=<c:out value="${message.userId}"/> ">
									        <c:out value="${message.account}" />
									    </a>
									</span>
					                <span class="name"><c:out value="${message.name}" /></span>
					            </div>
					            <div class="text"><pre><c:out value="${message.text}" /></pre></div>
					            <div class="date"><fmt:formatDate value="${message.createdDate}" pattern="yyyy/MM/dd HH:mm:ss" /></div>
					        </div>
					    </c:forEach>
					</div>
			    </c:forEach>
			</div>
            <div class="copyright"> Copyright(c)上島　卓也</div>
        </div>
    </body>
</html>