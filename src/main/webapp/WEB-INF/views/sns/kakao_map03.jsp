<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오지도(내위치 마커표시, 인포윈도우표시)</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=565289884e57884810393fd3717ba4d3"></script>
<script type="text/javascript">
	// 위도와 경도 구하기
	navigator.geolocation.getCurrentPosition(function(position) {
		const lat = position.coords.latitude;
		const lng = position.coords.longitude;
		
		geo_map(lat, lng);
	});
	
</script>
</head>
<body>
	 
<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:100%;height:350px;"></div>

<script>
function geo_map(lat, lng) {
	// 지도 생성하기
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표 (위도, 경도)
	        level: 3 // 지도의 확대 레벨
	    };
	
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	
	// 마커 생성하기
	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(lat, lng); 

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});

	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	
	
	// 마커에 인포윈도우 표시하기
	var iwContent = '<div style="padding:5px;"><a href="https://ictedu.co.kr" style="color:blue" target="_blank">한국ICT인재개발원</a></div>', 
    iwPosition = new kakao.maps.LatLng(lat, lng); //인포윈도우 표시 위치입니다

	// 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
	    position : iwPosition, 
	    content : iwContent 
	});
	  
	// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
	infowindow.open(map, marker); 
	
}

</script>
</body>
</html>