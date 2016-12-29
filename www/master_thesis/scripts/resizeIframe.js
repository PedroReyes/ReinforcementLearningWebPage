function resizeIframe(obj) {
    heightPixels = $(window).height()-($(window).height()*0.13);// - $("#headerDiv").height();
    //alert(heightPixels);
    obj.style.height = heightPixels + 'px';
    obj.style.width = '100%';
    
    //$( "#tabsetMasterThesis" ).style.height = 200;
}


/*
$(document).ready(function() {
   // executes when HTML-Document is loaded and DOM is ready
  alert(jQuery('Window ready > Height: ' + window.innerHeight));
  document.getElementById("tabsetMasterThesis").innerHeight = window.innerHeight;
  //document.getElementById("tabsetMasterThesis").onload = function() {alert("good");};
});


$(window).load(function() {
 // executes when complete page is fully loaded, including all frames, objects and images
 alert(jQuery('Window loaded > Height: ' + window.innerHeight));
 document.getElementById("tabsetMasterThesis").innerHeight = window.innerHeight;
});
*/