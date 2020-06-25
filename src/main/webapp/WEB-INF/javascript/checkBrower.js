function checkbrower() {
    var browse = navigator.userAgent.toLowerCase(); 
    
    if( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {        
         $("body").prepend("<div class ='waringBrower'><h3> Internet Explorer에서는 일부 기능이 동작하지 않을 수 있습니다.</h3></div>");    
    }
}