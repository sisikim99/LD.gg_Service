<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<title>LD.GG</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
	<!--BOOTSTRAP JavaScript-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous">

	</script>
	<!--SWEET-ALERT2 CSS-->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	<!--SWEET-ALERT2 JS-->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	<!--JQUERY-->
	<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
		crossorigin="anonymous"></script>
	<!--AJAX-->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!--JQUERY VALIDATE-->
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js"></script>
	<!--sideBar CSS-->
	<link rel="stylesheet" type="text/css" href="/resources/css/main/sideBar.css">
	<!--header CSS-->
	<link rel="stylesheet" type="text/css" href="/resources/css/main/header.css">
	<!--footer CSS-->
	<link rel="stylesheet" type="text/css" href="/resources/css/main/footer.css">
	<!--loginModal CSS-->
	<link rel="stylesheet" type="text/css" href="/resources/css/main/loginModal.css">
	<!--로그인 및 세션관련 JS-->
	<script src="/resources/js/main/loginSession.js" defer></script>
	<!-- 채팅 관련 JS-->
	<script src="/resources/js/main/chat.js" defer></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	<!--SWEET-ALERT2 JS-->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	<!--JQUERY-->
	<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
		crossorigin="anonymous"></script>
	<!--AJAX-->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!--JQUERY VALIDATE-->
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js"></script>
	<!--sideBar CSS-->
	<link rel="stylesheet" type="text/css" href="/resources/css/main/sideBar.css">
	<!--header CSS-->
	<link rel="stylesheet" type="text/css" href="/resources/css/main/header.css">
	<!--footer CSS-->
	<link rel="stylesheet" type="text/css" href="/resources/css/main/footer.css">
	<!--loginModal CSS-->
	<link rel="stylesheet" type="text/css" href="/resources/css/main/loginModal.css">
	<!--로그인 및 세션관련 JS-->
	<script src="/resources/js/main/loginSession.js" defer></script>
	<!-- 채팅 관련 JS-->
	<script src="/resources/js/main/chat.js" defer></script>
	<!-- 차트 JS -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
	<!-- jqGrid CSS -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">
	<!-- jqGrid JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>

	<!-- 서머너 랭킹 CSS -->
	<link href="/resources/css/summoner/summonerRank.css" rel="stylesheet">
	<link href="/resources/css/summoner/summonerRank.css?after" rel="stylesheet">

	<style type="text/css">
		.main-container {
			padding: 50px 50px 0px 100px;
			box-sizing: border-box;
		}
	</style>

</head>

<body>
	<%@ include file="../header.jsp"%>
	<%@ include file="../sidebar.jsp"%>
	<%@ include file="../footer.jsp"%>
	<div id="rank-main-container">
		<div id="rank_tool">
			<div id="grid-wrapper">
				<table id="summoner_rank_table"></table>
				<div id="pager"></div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$('#summoner_rank_table').jqGrid({
		url : "/summoner/rank/solo/loading/data.json",
		datatype : "json",
		loadtext : '로딩중..',
		sortable : true,
		loadonce : true,
		multiselect : false,
		pager : '#pager',
		rowNum : 100,
		sortname : 'date',
		sortorder : 'desc',
		sorttype: "text",
		width : 1000,
		height : "fit-content",
		pgbuttons : true, // 이전/다음 버튼 표시 여부
		pgtext : null, // 페이징 정보(1 - 10 / 100) 표시 여부
		viewrecords : false, // 레코드 수 표시 여부
		recordpos : 'left', // 레코드 수 위치
		pagerpos : 'center', // 페이징 버튼 위치
		pginput : false, // 페이지 번호 입력칸 표시 여부
		colNames : [ '소환사', '레벨', '티어', '승리', '패배', '리그포인트', '승률' ],
		colModel : [{
			name : 'summoner_name',
			index : 'summoner_name',
			width : 90,
			key : true,
			formatter : function(cellvalue, options, rowObject){
				return "<div style = 'text-align : left;'><img style = 'display : inline' src='/resources/img/profileicon/" + rowObject.profile_icon_id + ".png'/>" + cellvalue;"</div>"
			},
			cellattr : function(rowId, val,	rawObject) {
				let decodeStr = (rawObject.summoner_name);
				let summonerName = encodeURIComponent(decodeStr);
				let decodedSummonerName = decodeURIComponent(summonerName);
				return 'style= "margin : 0,0,0,30px; font-size: 12px; cursor : pointer; border-left: 0.1px solid #F0F0F0; border-right: none;" onclick="handleClick(\'' + summonerName + '\')"';
			}
		}, {
				name : 's_level',
				index : 's_level',
				width : 20,
				align : "center",
				formatter: function(cellvalue, options, rowObject) {
				    return '<span style="font-size: 12px;">' + cellvalue + '</span>';
				}
		}, {
				name : 'tier',
				index : 'tier',
				width : 50,
				align : "center"
		}, {
				name : 'wins',
				index : 'wins',
				width : 30,
				align : "center"
		}, {
				name : 'losses',
				index : 'losses',
				width : 30,
				align : "center"
		}, {
				name : 'lp',
				index : 'lp',
				width : 50,
				align : "center"
		}, {
				name : 'winrate',
				index : 'winrate',
				width : 40,
				align : "center"
	} ]
});

/*		$('#solo_rank')
			.click(
				function () {
					$('#summoner_rank_table')
						.jqGrid({
							url: "/summoner/rank/solo/data.json",
							datatype: "json",
							loadtext: '로딩중..',
							sortable: true,
							loadonce: true,
							multiselect: false,
							pager: '#pager',
							rowNum: 100,
							sortname: 'date',
							sortorder: 'desc',
							width: 1000,
							height: 500,
							pgbuttons: true, // 이전/다음 버튼 표시 여부
							pgtext: null, // 페이징 정보(1 - 10 / 100) 표시 여부
							viewrecords: false, // 레코드 수 표시 여부
							recordpos: 'left', // 레코드 수 위치
							pagerpos: 'center', // 페이징 버튼 위치
							pginput: false, // 페이지 번호 입력칸 표시 여부,
							colNames: ['소환사', '소환사 레벨',
								'티어', '승리', '패배',
								'리그포인트', '승률'
							],
							colModel: [{
								name: 'summoner_name',
								index: 'summoner_name',
								width: 90,
								align: "center",
								key: true,
								formatter: function (
									cellvalue,
									options,
									rowObject) {
									return "<div style = 'text-align : left;'><img style = 'display : inline' src='/resources/img/profileicon/" +
										rowObject.profile_icon_id + ".png'/>" +
										cellvalue;
									"</div>"
								},
								cellattr: function (
									rowId, val,
									rawObject) {
									console
										.log(val)
									return "onclick=\"location.href='/summoner/info/?'+val\"";
								}
							}, {
								name: 's_level',
								index: 's_level',
								width: 90,
								align: "center"
							}, {
								name: 'tier',
								index: 'tier',
								width: 90,
								align: "center"
							}, {
								name: 'wins',
								index: 'wins',
								width: 90,
								align: "center"
							}, {
								name: 'losses',
								index: 'losses',
								width: 90,
								align: "center"
							}, {
								name: 'lp',
								index: 'lp',
								width: 90,
								align: "center"
							}, {
								name: 'winrate',
								index: 'winrate',
								width: 90,
								align: "center"
							}]
						});
				})

		$('#flex_rank')
			.click(
				function () {
					$('#summoner_rank_table')
						.jqGrid({
							url: "/summoner/rank/flex/data.json",
							datatype: "json",
							loadtext: '로딩중..',
							sortable: true,
							loadonce: true,
							multiselect: false,
							pager: '#pager',
							rowNum: 100,
							sortname: 'date',
							sortorder: 'desc',
							width: 1000,
							height: 500,
							pgbuttons: true, // 이전/다음 버튼 표시 여부
							pgtext: null, // 페이징 정보(1 - 10 / 100) 표시 여부
							viewrecords: false, // 레코드 수 표시 여부
							recordpos: 'left', // 레코드 수 위치
							pagerpos: 'center', // 페이징 버튼 위치
							pginput: false, // 페이지 번호 입력칸 표시 여부,
							colNames: ['소환사', '소환사 레벨',
								'티어', '승리', '패배',
								'리그포인트', '승률'
							],
							colModel: [{
								name: 'summoner_name',
								index: 'summoner_name',
								width: 90,
								align: "center",
								key: true,
								formatter: function (
									cellvalue,
									options,
									rowObject) {
									return "<div style = 'text-align : left;'><img style = 'display : inline' src='/resources/img/profileicon/" +
										rowObject.profile_icon_id + ".png'/>" +
										cellvalue;
									"</div>"
								},
								cellattr: function (
									rowId, val,
									rawObject) {
									return "onclick=\"location.href='/summoner/info/?'+val\"";
								}
							}, {
								name: 's_level',
								index: 's_level',
								width: 90,
								align: "center"
							}, {
								name: 'tier',
								index: 'tier',
								width: 90,
								align: "center"
							}, {
								name: 'wins',
								index: 'wins',
								width: 90,
								align: "center"
							}, {
								name: 'losses',
								index: 'losses',
								width: 90,
								align: "center"
							}, {
								name: 'lp',
								index: 'lp',
								width: 90,
								align: "center"
							}, {
								name: 'winrate',
								index: 'winrate',
								width: 90,
								align: "center"
							}]
						});
				});

		$('#level')
			.click(
				function () {
					$('#summoner_rank_table')
						.jqGrid({
							url: "/summoner/rank/level/data.json",
							datatype: "json",
							loadtext: '로딩중..',
							sortable: true,
							loadonce: true,
							multiselect: false,
							pager: '#pager',
							rowNum: 10,
							sortname: 'date',
							sortorder: 'desc',
							width: 1000,
							height: 500,
							pgbuttons: true, // 이전/다음 버튼 표시 여부
							pgtext: null, // 페이징 정보(1 - 10 / 100) 표시 여부
							viewrecords: false, // 레코드 수 표시 여부
							recordpos: 'left', // 레코드 수 위치
							pagerpos: 'center', // 페이징 버튼 위치
							pginput: false, // 페이지 번호 입력칸 표시 여부,
							colNames: [
								'소환사', '소환사 레벨',
								'티어', '승리', '패배',
								'리그포인트', '승률'
							],
							colModel: [{
								name: 'summoner_name',
								index: 'summoner_name',
								width: 90,
								align: "center",
								key: true,
								formatter: function (
									cellvalue,
									options,
									rowObject) {
									return "<div style = 'text-align : left;'><img style = 'display : inline' src='/resources/img/profileicon/" +
										rowObject.profile_icon_id + ".png'/>" +
										cellvalue;
									"</div>"
								},
								cellattr: function (
									rowId, val,
									rawObject) {
									return "onclick=\"location.href='/summoner/info/?'+val\"";
								}
							}, {
								name: 's_level',
								index: 's_level',
								width: 90,
								align: "center"
							}, {
								name: 'tier',
								index: 'tier',
								width: 90,
								align: "center"
							}, {
								name: 'wins',
								index: 'wins',
								width: 90,
								align: "center"
							}, {
								name: 'losses',
								index: 'losses',
								width: 90,
								align: "center"
							}, {
								name: 'lp',
								index: 'lp',
								width: 90,
								align: "center"
							}, {
								name: 'winrate',
								index: 'winrate',
								width: 90,
								align: "center"
							}],
						})
		}) */
						
		function handleClick(summonerName) {
		    let decodedSummonerName = decodeURIComponent(summonerName);
		    let encodedSummonerName = encodeURIComponent(decodedSummonerName);
		    let redirectUrl = '/summoner/info?summoner_name=' + encodedSummonerName;
		    location.href = redirectUrl;
		}
	</script>

</body>

</html>