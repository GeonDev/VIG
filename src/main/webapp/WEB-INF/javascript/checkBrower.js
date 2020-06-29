function checkBrower() {
    var browse = navigator.userAgent.toLowerCase();    
    if( (navigator.appName == 'Netscape' && browse.indexOf('trident') != -1) || (browse.indexOf("msie") != -1)) {        
         $("body").prepend("<div class ='waringBrower'><h4 style='background-color:LemonChiffon; width : 125%; padding-top:5px; padding-bottom:5px;'> Internet Explorer에서는 일부 기능이 동작하지 않을 수 있습니다.</h4></div>");    
    }
}



