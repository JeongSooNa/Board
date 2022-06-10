<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="/resources/static/css/board.css">
</head>
<body>
    <div class="container">
        <!-- íì ì ë³´ ìì  -->
        <div class="update-popup">
            <div class="editor">
                <div class="close">
                    <a href="#" class="btn-close">ë«ê¸°</a>
                </div>
                <div class="input-box">
                    <label for="studentsId">íì ìì´ë : </label>
                    <input id="studentsId" type="text" placeholder="ìì´ë ìë ¥íì¸ì...">
                </div>
                <div class="input-box">
                    <label for="studentsName">íì ì´ë¦ : </label>
                    <input id="studentsName" type="text" placeholder="ì´ë¦ì ìë ¥íì¸ì...">
                </div>
                <div class="input-box">
                    <label for="studentsPassword">íì ë¹ë°ë²í¸ : </label>
                    <input id="studentsPassword" type="text" placeholder="ì´ë¦ì ìë ¥íì¸ì...">
                </div>
                <div class="btn-area">
                    <input id="boardIdHidden" type="hidden">
                    <a id="contentUpdate" href="#" class="btn-update">ìì </a>
                    <a id="contentDelete" href="#" class="btn-delete">ì­ì </a>
                </div>
            </div>
        </div>
        <div class="navigation">
            <ul>
                <li>
                    <a href="#">
                        <span class="icon"><ion-icon name="logo-apple"></ion-icon></span>
                        <span class="title">DW Board</span>                
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="icon"><ion-icon name="home-outline"></ion-icon></span>
                        <span class="title">Dashboard</span>                
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="icon"><ion-icon name="person-outline"></ion-icon></span>
                        <span class="title">Students</span>                
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="icon"><ion-icon name="lock-closed-outline"></ion-icon></span>
                        <span class="title">logs</span>                
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="icon"><ion-icon name="log-out-outline"></ion-icon></span>
                        <span class="title">Sign Out</span>                
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <!-- main -->
    <div class="main">
        <div class="topbar">
            <div class="toggle">
                <!-- toggleì ëì¤ì ë§ë¤ê¸° -->
                <ion-icon name="menu-outline"></ion-icon>
            </div>
            <!-- search -->
            <div class="search">
                <label>
                    <input id="searchBar" type="text" placeholder="íìì´ë¦ì ê²ìíì¸ì..." >
                    <input id="keyword" type="hidden" value="null">
                </label>
            </div>
            <div>
                <a href="#" class="logout">Logout</a>
            </div>
        </div>
         <!-- table -->
         <div class="details">
             <div class="recentOrders">
                 <div class="cardHeader">
                     <h2>íì ëªë¨</h2>
                 </div>
                 <table>
                     <thead>
                         <tr>
                            <th>íì ìì´ë</th>
                            <th>íì ì´ë¦</th>
                            <th>ê°ì ë ì§</th>
                        </tr>
                     </thead>
                     <tbody id="boardData">
                         <!-- <tr>
                             <td>hyunsangwon</td>
                             <td>íìì</td>
                             <td>2022-05-19</td>
                         </tr>
                         <tr>
                            <td>hyunsangwon</td>
                            <td>íìì</td>
                            <td>2022-05-19</td>
                        </tr>
                        <tr>
                            <td>hyunsangwon</td>
                            <td>íìì</td>
                            <td>2022-05-19</td>
                        </tr> -->
                     </tbody>
                 </table>
                 <div class="pagination">
                    <a href="#">Previous</a>
                    <a href="#">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">4</a>
                    <a href="#">5</a>
                    <a href="#">Next</a>
                 </div>
             </div>
         </div>
    </div>
</body>
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
<script
      src="https://code.jquery.com/jquery-3.6.0.min.js"
      integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
      crossorigin="anonymous"
    ></script>
<script>
    let list = document.querySelectorAll('.navigation li');
    function activeLink(){
        list.forEach((item) => {item.classList.remove('hovered')});
        this.classList.add('hovered');
    }
    list.forEach((item) => {item.addEventListener('mouseover',activeLink)});
</script>
<script>
    // get Students
    getStudentsList(1,10);
    function getStudentsList(pageNum, pageSize){
        var controllerUrl = "http://localhost:8080/api/v1/students/map?pageNum="+pageNum+"&pageSize="+pageSize;
        var keyword = $('#keyword').val();
        if(keyword != 'null'){
            controllerUrl = "http://localhost:8080/api/v1/students/search?writer="+keyword+"&pageNum="+pageNum+"&pageSize="+pageSize;
        }
        $.ajax({
            url : controllerUrl,
            type : "GET",
            dataType : "json",
            success : function(response){
                var len = response.list.length;
                console.log(response.list)
                var html = "";
                if(len>0){
                    for(var i=0;i<len;i++){
                        html += 
                            "<tr onclick=getStudents("+response.list[i].studentsId+")>"+
                            "<td>"+response.list[i].studentsId+"</td>"+
                            "<td>"+response.list[i].studentsName+"</td>"+
                            "<td>"+response.list[i].createAt+"</td>"+
                            "</tr>"
                    }
                    // íì´ì§ íë©´ êµ¬í
                    var paginationHtml = '';
                    // ì´ì  íì´ì§ê° ìì ë
                    if(response.hasPreviousPage){ 
                        paginationHtml += '<a onclick="getStudentsList('+(response.pageNum-1)+','+pageSize+')" href="#">Previous</a>';
                    }
                    // íì´ì§ ë²í¸
                    for(var i=0; i<response.navigatepageNums.length; i++){ // íì´ì§ ë²í¸ ê¸¸ì´ ë§í¼ forë¬¸ ì¤í
                        paginationHtml += '<a id="pageNum'+response.navigatepageNums[i]+'" onclick="getStudentsList('+response.navigatepageNums[i]+',10)" href="#">'+response.navigatepageNums[i]+'</a>';
                    }
                    // ë¤ì íì´ì§ê° ìì ë
                    if(response.hasNextPage){ 
                        paginationHtml += '<a onclick="getStudentsList('+(response.pageNum+1)+','+pageSize+')" href="#">Next</a>';
                    }
                    $('.pagination').children().remove();
                    $('.pagination').append(paginationHtml);
                    //íì´ì§ ë²í¸ì ë§ê² css ìì 
                    $('#pageNum'+pageNum).css('background-color','#287bff');
                    $('#pageNum'+pageNum).css('color','#fff');
                }else{
                    // ê²ìê¸ ìì ë
                    html += '<tr><td colspan=6 style="text-align: center;">íìì´ ììµëë¤.</td></tr>';
                }
                $('#boardData').children().remove();
                $('#boardData').append(html);
            }
        })
    }

    // í´ë¦­í íì íì¸
    function getStudents(studentsId){
        $('.update-popup').css('display', 'block');

        $.ajax({
            url : "http://localhost:8080/api/v1/students/id/"+studentsId,
            type : "GET",
            dataType : "json",
            success : function (response){
                // inputì data set í´ì£¼ê¸°
                $('#studentsId').val(response.studentsId);
                $('#studentsName').val(response.studentsName);
                $('#studentsPassword').val(studentsPassword);
            },
            error : function (request, status, error){
                console.log("Error : "+error);
            }
        })
    }
    $('.btn-close').click(function(){
        $('.update-popup').css('display', 'none');
    })
    
    // ìì 
    $('#contentUpdate').click(function(){
        var studentsId = $('#studentsId').val();
        var studentsName = $('#studentsName').val();
        var studentsPassword = $('#studentsPassword').val();
        var jsonData = {
            studentsId : studentsId,
            studentsName : studentsName,
            studentsPassword : studentsPassword
        };
        $.ajax({
            url : 'http://localhost:8080/api/v1/students/id/'+studentsId,
            type : 'PATCH',
            contentType : 'application/json',
            dataType : 'json',
            data : JSON.stringify(jsonData),
            success : function (response){
                // ê²ìë¬¼ ìì¸íë©´ ê°ì¶ê¸°
                if(response > 0){
                    alert('ìì  ìë£');
                    getStudentsList(1,10);
                    $('.update-popup').css('display','none');
                    location.reload();
                }

            }
        });
    })
    // ì­ì 
    $('#contentDelete').click(function(){
        var studentsId = $('#studentsId').val();
        $.ajax({
            url : 'http://localhost:8080/api/v1/students/id/'+studentsId,
            type : 'DELETE',
            contentType : 'application/json',
            dataType : 'json',
            success : function (response){
                // ê²ìë¬¼ ìì¸íë©´ ê°ì¶ê¸°
                if(response > 0){
                    alert('ì­ì  ìë£');
                    $('.update-popup').css('display','none');
                    location.reload();
                }
            }
        });
    })

    // ê²ì
    // getStudentsListìì input hidden ì ì´ì©í´ urlì ë³ê²½í´ ê²ì
    $('#searchBar').keyup(function(key){
        var pageNum = 1;
        var pageSize = 10;
        if(key.keyCode==13){
            // input ê° ê°ì ¸ì¤ê¸°
            // ajax í¸ì¶
            var search = $('#searchBar').val().trim();
            if(search != ''){
                $('#keyword').val(search);
            }
            $.ajax({
                url : "http://localhost:8080/api/v1/students/search?writer="+search+"&pageNum="+pageNum+"&pageSize="+pageSize,
                type : "GET",
                dataType : "json",
                success : function (response){
                    var len = response.list.length;
                console.log(response.list)
                var html = "";
                if(len>0){
                    for(var i=0;i<len;i++){
                        html += 
                            "<tr onclick=getStudents("+response.list[i].studentsId+")>"+
                            "<td>"+response.list[i].studentsId+"</td>"+
                            "<td>"+response.list[i].studentsName+"</td>"+
                            "<td>"+response.list[i].createAt+"</td>"+
                            "</tr>"
                    }
                    // íì´ì§ íë©´ êµ¬í
                    var paginationHtml = '';
                    // ì´ì  íì´ì§ê° ìì ë
                    if(response.hasPreviousPage){ 
                        paginationHtml += '<a onclick="getStudentsList('+(response.pageNum-1)+','+pageSize+')" href="#">Previous</a>';
                    }
                    // íì´ì§ ë²í¸
                    for(var i=0; i<response.navigatepageNums.length; i++){ // íì´ì§ ë²í¸ ê¸¸ì´ ë§í¼ forë¬¸ ì¤í
                        paginationHtml += '<a id="pageNum'+response.navigatepageNums[i]+'" onclick="getStudentsList('+response.navigatepageNums[i]+',10)" href="#">'+response.navigatepageNums[i]+'</a>';
                    }
                    // ë¤ì íì´ì§ê° ìì ë
                    if(response.hasNextPage){ 
                        paginationHtml += '<a onclick="getStudentsList('+(response.pageNum+1)+','+pageSize+')" href="#">Next</a>';
                    }
                    $('.pagination').children().remove();
                    $('.pagination').append(paginationHtml);
                    //íì´ì§ ë²í¸ì ë§ê² css ìì 
                    $('#pageNum'+pageNum).css('background-color','#287bff');
                    $('#pageNum'+pageNum).css('color','#fff');
                }else{
                    // ê²ìê¸ ìì ë
                    html += '<tr><td colspan=6 style="text-align: center;">íìì´ ììµëë¤.</td></tr>';
                }
                $('#boardData').children().remove();
                $('#boardData').append(html); 
                }
            })
        }
    })
    
    
</script>
</html>