// esc
$(document).keydown(function(e) {
	if (e.keyCode == 27) {
		$('.write-popup').css('display', 'none');
		$('.update-popup').css('display', 'none');
	}
})

function goPage(pageName) {
	if (pageName == 'logs') {
		location.href = "/logs";
	}
	if (pageName == 'students') {
		location.href = "/students";
	}
	if (pageName == 'dashboard') {
		location.href = "/board?pageNum=1&pageSize=10";
	}
}

function getBoardList(pageNum, pageSize) {
	location.href = "/board?pageNum=" + pageNum + "&pageSize=" + pageSize
}
// 통계함수 호출
getBoardStatistics();
function getBoardStatistics() {
	$.ajax({
		url: "/api/v1/board/statistics",
		type: 'GET',
		dataType: 'json',
		success: function(response) {
			$('#boardCnt').text(response.boardCnt);
			$('#studentsCnt').text(response.studentsCnt);
			$('#viewsCnt').text(response.viewsCnt);
			$('#writerCnt').text(response.writerCnt);
		}
	});
}

// page 번호 알아내서 css 바꾸기
getPageNum()
function getPageNum() {
	var pageNum = $('#nowPageNum').val();
	$('#pageNum' + pageNum).css('backgroundColor', '#287bff')
	$('#pageNum' + pageNum).css('color', '#fff')
}
// Board 보여주기 함수
function getBoard(boardId) {
	// boardId html에 hidden 하기 : 수정,삭제에 이용하려고
	// 화면 띄우기
	$('.update-popup').css('display', 'block');
	// ajax 작성
	$.ajax({
		url: "/api/v1/board/boardId/" + boardId,
		type: "GET",
		dataType: "json",
		success: function(response) {
			// input에 data set 해주기
			$('#upt-title').val(response.title);
			$('#upt-content').val(response.content);
			$('#boardIdHidden').val(boardId);
			setBoardViews(boardId); // 조회 수 함수
		},
		error: function(request, status, error) {
			console.log("Error : " + error);
		}
	});
}
// 조회수 증가 함수
function setBoardViews(boardId) {
	$.ajax({
		url: '/api/v1/board/views/boardId/' + boardId,
		type: 'PATCH',
		contentType: 'application/json',
		dataType: 'json',
		success: function(response) {
			// 게시물 상세화면 감추기
			if (response > 0) {
				// 추후 로직 예정
				// error page로 이동하는 로직
			}

		}
	});
}

// 게시판 작성
$('#contentSubmit').click(function() {
	if (confirm('게시글을 작성하시겠습니까?')) {
		var studentsId = $('#studentsId').val();
		var title = $('#title').val();
		var content = $('#content').val();
		// 빈칸 확인
		if (title == '') {
			alert('제목을 입력해주세요.')
			return false;
		}
		if (content == '') {
			alert('내용을 입력해주세요.')
			return false;
		}
		// API 서버에 전송할 JSON 생성
		var jsonData = {
			studentsId: studentsId,
			title: title,
			content: content
		}
		// AJAX 세팅
		$.ajax({
			url: '/api/v1/board',
			type: 'POST',
			contentType: 'application/json', // 서버에 json type으로 보낼 예정(요청)
			dataType: 'json', // 서버 결과를 json으로 응답 받겠다.
			data: JSON.stringify(jsonData),
			success: function(response) {
				// 전송 한 data가 DB에 저장되었으면 alert
				if (response > 0) {
					var pageNum = $('#nowPageNum').val();
					getBoardList(pageNum, 10);
				}
			}
		})
	}
});

// 게시물 수정
$('#contentUpdate').click(function() {
	var boardId = $('#boardIdHidden').val(); // hidden에 숨겨놓은 boardId
	// json data 만들기
	var title = $('#upt-title').val();
	var content = $('#upt-content').val();
	var jsonData = {
		title: title,
		content: content
	};
	// ajax 작성
	$.ajax({
		url: '/api/v1/board/boardId/' + boardId,
		type: 'PATCH',
		contentType: 'application/json',
		dataType: 'json',
		data: JSON.stringify(jsonData),
		success: function(response) {
			// 게시물 상세화면 감추기
			if (response > 0) {
				alert("수정 완료")
				var pageNum = $('#nowPageNum').val();
				getBoardList(pageNum, 10);
			}

		}
	});
})
// 게시물 삭제
$('#contentDelete').click(function() {
	var boardId = $('#boardIdHidden').val(); // hidden에 숨겨놓은 boardId

	if (confirm('해당 게시물을 정말 삭제하시겠습니까?')) {
		// ajax 작성
		$.ajax({
			url: '/api/v1/board/boardId/' + boardId,
			type: 'DELETE',
			contentType: 'application/json',
			dataType: 'json',
			success: function(response) {
				// 게시물 상세화면 감추기
				if (response > 0) {
					alert("삭제 완료")
					var pageNum = $('#nowPageNum').val();
					getBoardList(pageNum, 10);
				}
			}
		});
	}
})
$('#searchBar').keyup(function(key) {
	var pageNum = 1;
	var pageSize = 10;
	if (key.keyCode == 13) {
		// input 값 가져오기
		var search = $('#searchBar').val().trim();
		// hidden tag에 내가 검색한 keyword를 vlaue에 set
		if (search != '') {
			location.href = "/board/search?search=" + search + "&pageNum=" + pageNum + "&pageSize=" + pageSize;
		}
	}
})