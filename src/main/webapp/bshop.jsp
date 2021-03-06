<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>书籍分类</title>
    <%@include file="/compoments/ResourcesTemplate.jsp" %>
    <link rel="stylesheet" href="<c:url value="/css/book-shop.css"/>">
</head>

<body>
<%@include file="/compoments/HeadTemplate.jsp" %>

<div class="container">
    <div class="productlist-left">
        <h4>分类</h4>
        <ul>
            <c:forEach items="${ requestScope.bookTypes }" var="type">
                <c:choose>
                    <c:when test="${ type.id ==  requestScope.bookType.id }">
                        <a href="<c:url value="/book?actionType=getBookType&typeId=${ type.id }"/> " class="active"><i
                                class="fa fa-check-square"></i>${ type.typeName } ${ type.numbers }</a>
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value="/book?actionType=getBookType&typeId=${ type.id }"/> "><i
                                class="fa fa-check-square"></i>${ type.typeName } ${ type.numbers }</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </ul>
    </div>
    <div class="productlist-right">
        <h4 class="book-list"><i class="fa fa-list"></i>商品目录</h4>
        <h4 class="book-type">${ requestScope.bookType.typeName } 类 <span>共${ requestScope.bookType.numbers }种商品</span>
        </h4>
        <div class="list-warp">PRODUCT LIST</div>
        <div class="book-img-warp">
            <c:forEach items="${ requestScope.bookTypeLists }" var="bookTypeList">
                <c:choose>
                    <c:when test="${ bookTypeList.bookQuantity == 0 }">
                        <div class="box loading">
                            <div class="image">
                                <img src="<c:url value="${ bookTypeList.bookImg }"/> "/>
                            </div>
                            <div class="content">
                                <h4 class="book-name">${ bookTypeList.bookName }</h4>
                                <div class="author">${ bookTypeList.bookAuthor }</div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="box">
                            <div class="image">
                                <a target="_blank"
                                   href="<c:url value="/book?actionType=getBook&bookCode=${ bookTypeList.bookCode }"/> ">
                                    <img src="<c:url value="${ bookTypeList.bookImg }"/> "/>
                                </a>
                            </div>
                            <div class="content">
                                <h4 class="book-name">${ bookTypeList.bookName }</h4>
                                <div class="author">${ bookTypeList.bookAuthor }</div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </div>
</div>
<%@include file="/compoments/FooterTemplate.jsp" %>
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
</body>

</html>