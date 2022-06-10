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
        <!-- ì ì ê¸°ë¡ íì -->
        <div class="logs-popup">
            <div class="editor">
                <div class="input-box">
                    <label for="ip">ì ì IP : </label>
                    <input id="ip" type="text" value="192.168.52.43" readonly>
                </div>
                <div class="input-box">
                    <label for="createAt">ì ì ìê° : </label>
                    <input id="createAt" type="text" value="2022-06-02 09:10:58" readonly>
                </div>
                <div class="input-box">
                    <div id="map" style="width:100%;height:350px;"></div>
                </div>
                <div class="btn-area">
                    <a href="#" class="btn-cancel">ë«ê¸°</a>
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
                    <!-- <input id="searchBar" type="text" placeholder="ìì±ìë¥¼ ê²ìíì¸ì..." > -->
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
                     <h2>ì ìì íì¤í ë¦¬</h2>
                 </div>
                 <table>
                     <thead>
                         <tr>
                            <th>ë¡ê·¸ ë²í¸</th>
                            <th>IP</th>
                            <th>ìì²­ URL</th>
                            <th>HTTP Method</th>
                            <th>ì ì ë ì§</th>
                         </tr>
                     </thead>
                     <tbody id="boardData">
                         <!-- <tr onclick="getPopup()">
                            <td>1</td>
                            <td>192.158.0.252</td>
                            <td>/board</td>
                            <td>GET</td>
                            <td>2022-05-19 13:33:02</td>
                         </tr>
                         <tr onclick="getPopup()">
                            <td>2</td>
                            <td>192.158.0.252</td>
                            <td>/board</td>
                            <td>GET</td>
                            <td>2022-05-19 13:33:02</td>
                        </tr>
                        <tr onclick="getPopup()">
                            <td>3</td>
                            <td>192.158.0.252</td>
                            <td>/board</td>
                            <td>GET</td>
                            <td>2022-05-19 13:33:02</td>
                        </tr> -->
                     </tbody>
                 </table>
                 <div class="pagination">
                    <!-- <a href="#">Previous</a>
                    <a href="#">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">4</a>
                    <a href="#">5</a>
                    <a href="#">Next</a> -->
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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=caaa41bc705bab7a2ab9ee324cd13e78"></script>
<script>
    let list = document.querySelectorAll('.navigation li');
    function activeLink(){
        list.forEach((item) => {item.classList.remove('hovered')});
        this.classList.add('hovered');
    }
    list.forEach((item) => {item.addEventListener('mouseover',activeLink)});
</script>
<script>
    function getPopup(logId){
        $('.logs-popup').css('display','block')
        $.ajax({
            url : "http://localhost:8080/api/v1/logs/logId/"+logId,
            type : "GET",
            dataType : "json",
            success : function (response){
                var latitude = response.latitude
                var longitude = response.longitude

                $('#ip').val(response.ip);
                $('#createAt').val(response.create_at);

                // ì¹´ì¹´ì¤ë§µ
                var mapContainer = document.getElementById('map'), // ì§ëë¥¼ íìí  div 
                mapOption = { 
                    center: new kakao.maps.LatLng(latitude, longitude), // ì§ëì ì¤ì¬ì¢í
                    level: 3 // ì§ëì íë ë ë²¨
                };
                var map = new kakao.maps.Map(mapContainer, mapOption); // ì§ëë¥¼ ìì±í©ëë¤
                // ë§ì»¤ê° íìë  ìì¹ìëë¤ 
                var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 
                // ë§ì»¤ë¥¼ ìì±í©ëë¤
                var marker = new kakao.maps.Marker({
                    position: markerPosition
                });
                // ë§ì»¤ê° ì§ë ìì íìëëë¡ ì¤ì í©ëë¤
                marker.setMap(map);
                // ìë ì½ëë ì§ë ìì ë§ì»¤ë¥¼ ì ê±°íë ì½ëìëë¤
                // marker.setMap(null);
            }
        });
    }
    $('.btn-cancel').click(function(){
        $('.logs-popup').css('display', 'none');
    });


    function getBoard(logId){
        // boardId htmlì hidden íê¸° : ìì ,ì­ì ì ì´ì©íë ¤ê³ 
        // íë©´ ëì°ê¸°
        $('.update-popup').css('display', 'block');
        // ajax ìì±
        
    }




    // 
    getLogsList(1,10);
    function getLogsList(pageNum, pageSize){
        $.ajax({
            url : "http://localhost:8080/api/v1/logs?pageNum="+pageNum+"&pageSize="+pageSize,
            type : "GET",
            dataType : "json",
            success : function (response){
                console.log(response)
                var len = response.list.length;
                var html = "";
                if(len > 0){
                    for(var i=0;i<len;i++){
                        html += 
                            "<tr onclick=getPopup("+response.list[i].log_id+")>"+
                            "<td>"+response.list[i].log_id+"</td>"+
                            "<td>"+response.list[i].ip+"</td>"+
                            "<td>"+response.list[i].url+"</td>"+
                            "<td>"+response.list[i].http_method+"</td>"+
                            "<td>"+response.list[i].create_at+"</td>"+
                            // "<td><span class="+"row"+">"+"0"+"</span></td>"+
                            "</tr>"
                    } // end for

                    // íì´ì§ íë©´ êµ¬í
                    var paginationHtml = '';
                    // ì´ì  íì´ì§ê° ìì ë
                    if(response.hasPreviousPage){ 
                        paginationHtml += '<a onclick="getLogsList('+(response.pageNum-1)+','+pageSize+')" href="#">Previous</a>';
                    }
                    // íì´ì§ ë²í¸
                    for(var i=0; i<response.navigatepageNums.length; i++){ // íì´ì§ ë²í¸ ê¸¸ì´ ë§í¼ forë¬¸ ì¤í
                        paginationHtml += '<a id="pageNum'+response.navigatepageNums[i]+'" onclick="getLogsList('+response.navigatepageNums[i]+',10)" href="#">'+response.navigatepageNums[i]+'</a>';
                    }
                    // ë¤ì íì´ì§ê° ìì ë
                    if(response.hasNextPage){ 
                        paginationHtml += '<a onclick="getLogsList('+(response.pageNum+1)+','+pageSize+')" href="#">Next</a>';
                    }
                    $('.pagination').children().remove();
                    $('.pagination').append(paginationHtml);
                    //íì´ì§ ë²í¸ì ë§ê² css ìì 
                    $('#pageNum'+pageNum).css('background-color','#287bff');
                    $('#pageNum'+pageNum).css('color','#fff');

                }else{
                    // ê²ìê¸ ìì ë
                    html += '<tr><td colspan=6 style="text-align: center;">ê²ìê¸ì´ ììµëë¤.</td></tr>';
                }
                $('#boardData').children().remove();
                $('#boardData').append(html);
            },
            error : function (request, status, error){
                console.log("ìë¬ ë´ì© : "+error);
            }
        })
    }
</script>
</html>