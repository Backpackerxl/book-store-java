<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>书籍详情页</title>
    <%@include file="ResourcesTemplate.jsp" %>
    <link rel="stylesheet" href="<c:url value="/css/book-info.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/book-shop.css"/> ">
</head>

<body>
<%@include file="HeadTemplate.jsp" %>

<div class="container">
    <div class="productlist-left">
        <h4>分类</h4>
        <ul>
            <c:forEach items="${ requestScope.bookTypes }" var="bookType">
                <c:choose>
                    <c:when test="${ bookType.id ==  requestScope.book.typeId }">
                        <a href="<c:url value="/"/> " class="active"><i
                                class="fa fa-check-square"></i>${ bookType.typeName }</a>
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value="/"/> "><i class="fa fa-check-square"></i>${ bookType.typeName }</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </ul>
    </div>
    <div class="productlist-right">
        <h4 class="book-list"><i class="fa fa-info-circle"></i>商品详情</h4>
        <div class="porduct-book">
            <div class="product-img-warp">
                <img src="<c:url value="${ requestScope.book.bookImg }"/>"/>
            </div>
            <div class="product-information">
                <h4 class="book-name"><i class="fa fa-book"></i>${ requestScope.book.bookName }</h4>
                <div class="book-content">
                    <div class="book-author">
                        <span>作&nbsp;&nbsp;&nbsp;者<i class="fa fa-caret-right"></i></span>
                        <span>${ requestScope.book.bookAuthor }</span>
                    </div>
                    <div class="book-price">
                        <span>售&nbsp;&nbsp;&nbsp;价<i class="fa fa-caret-right"></i></span>
                        <span id="money">
                            <c:choose>
                                <c:when test="${ requestScope.book.bookSalePrice == 0.0 }">
                                    ￥ ${ requestScope.book.bookPrice }
                                </c:when>
                                <c:otherwise>
                                    ￥ ${ requestScope.book.bookSalePrice }
                                    <del>原价：￥${ requestScope.book.bookPrice }</del>
                                </c:otherwise>
                            </c:choose>
                            </span>
                    </div>
                    <div class="book-press">
                        <span>出版社<i class="fa fa-caret-right"></i></span>
                        <sapn>${ requestScope.book.bookPublish }</sapn>
                    </div>
                    <div class="book-description">
                        <h5>内容简介</h5>
                        <p>${ requestScope.book.bookInfo }</p>
                    </div>
                    <div class="add-car">
                        <button><i class="fa fa-shopping-cart"></i> 加入购物车</button>
                        <button><i class="fa fa-credit-card-alt"></i> 立即支付</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="compents" class="compents">
            <h4 id="return-master"><i class="fa fa-commenting-o"></i>用户评价</h4>
            <div class="add-compents">
                <c:choose>
                    <c:when test="${ sessionScope.username == null }">
                        <div id="img-user" class="user-img">
                            <img src="<c:url value="/img/buser/user.png"/>">
                        </div>
                        <textarea id="compents-input" placeholder="请先登录再发表评论，谢谢" maxlength="1000"></textarea>
                        <button disabled="disabled">提交</button>
                    </c:when>
                    <c:otherwise>
                        <div id="img-user" class="user-img">
                            <img src="<c:url value="${ sessionScope.userImg }"/>">
                        </div>
                        <textarea id="compents-input" placeholder="请使用文明用语，谢谢" maxlength="1000"></textarea>
                        <button data-submit="<%=request.getContextPath()%>"
                                data-bookCode="${ requestScope.book.bookCode }" data-code="${ sessionScope.code }"
                                id="submit-comment">提交
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>
            <c:forEach items="${ requestScope.commentList }" var="comment">
                <div class="compents-box">
                    <div class="compents-img">
                        <img src="<c:url value="${ comment.userCommpment.userImg }"/> ">
                    </div>
                    <div class="compents-content">
                        <p>${ comment.userCommpment.name }</p>
                        <p>${ comment.userCommpment.content }</p>
                        <p>
                            <span><i class="fa fa-calendar-minus-o"></i>${ comment.userCommpment.createTime }</span>
                            <c:if test="${ comment.userCommentList != null }">
                                <b id="more-compents">— 展开${ comment.userCommentList.size() }条回复 <i
                                        class="fa fa-caret-down"></i></b>
                            </c:if>
                            <a data-index=${ comment.userCommpment.id } id="reply-compents" href="javascript:;">回复</a>
                        </p>
                    </div>
                    <c:if test="${ comment.userCommentList != null }">
                        <div style="display: none;" id="child-compents">
                            <c:forEach items="${ comment.userCommentList }" var="childrenComment">
                                <div class="compents-box">
                                    <div class="compents-img">
                                        <img src="<c:url value="${ childrenComment.userImg }"/>">
                                    </div>
                                    <div class="compents-content">
                                        <p>${ childrenComment.name }
                                            <c:if test="${ childrenComment.parentCommentId != comment.userCommpment.id }">
                                                @ <c:forEach items="${ comment.userCommentList }" var="find_name">
                                                <c:if test="${ find_name.id == childrenComment.parentCommentId }">
                                                    <c:out value="${ find_name.name }"/>
                                                </c:if>
                                            </c:forEach>
                                            </c:if>
                                        </p>
                                        <p>${ childrenComment.content }</p>
                                        <p>
                                        <span><i
                                                class="fa fa-calendar-minus-o"></i>${ childrenComment.createTime }</span>
                                            <a data-index=${ childrenComment.id } id="reply-compents-child"
                                               href="javascript:;">回复</a>
                                        </p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<%@include file="FooterTemplate.jsp" %>
<div id="up-to-top">
    <i class="fa fa-arrow-up"></i>
</div>
<script>
    $(function () {
        let newtop;
        $(window).bind("scroll", function () {
            if ($(document).scrollTop() >= 100) {
                $("#up-to-top").show(50)
            } else {
                $("#up-to-top").hide(50)
            }
        })
        $('#up-to-top').click(function () {
            const timer = setInterval(function () {
                newtop = $(document).scrollTop();
                if ($(document).scrollTop() == 0) {
                    clearInterval(timer);
                } else {
                    var a = $(document).scrollTop(newtop - 20);
                }
            }, 10);

        });
    })
</script>
<script src="<c:url value="/js/compements.js"/> " type="module"></script>
</body>

</html>