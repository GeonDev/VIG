<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>

<link rel="stylesheet" href="http://jcrop-cdn.tapmodo.com/v2.0.0-RC1/css/Jcrop.css" type="text/css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="http://jcrop-cdn.tapmodo.com/v2.0.0-RC1/js/Jcrop.js"></script>
<script>
var showCoords = function(c)
{
    $('#x').val(c.x);
    $('#y').val(c.y);
    $('#w').val(c.w);
    $('#h').val(c.h);
};

// JCrop 호출
$('#img').Jcrop({
    setSelect: [0,0,width,height],
    onChange: showCoords,
    onSelect: showCoords
});
</script>




<style>

</style>




  </head>
  

    
  </head>
  <body>
		<form action="/crop">
     <input type="hidden" name="x" id="x" />
     <input type="hidden" name="y" id="y" />
     <input type="hidden" name="w" id="w" />
     <input type="hidden" name="h" id="h" />
</form>

<img src="" id="img">






  </body>
</html>