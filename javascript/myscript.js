/* JavaScript Foundations: Variables */

var color = "red";

var myDiv = document.getElementById('myDiv');
myDiv.style.background = "black";
myDiv.style.color = "#fff";

function doSomething(doit) {
    var color = "blue";
    if (doit) {
    color = "red";
    console.log("Color in if(){}",color);
    }
    console.log("Color after if(){}",color);
}
doSomething(false);
//doSomething(true);