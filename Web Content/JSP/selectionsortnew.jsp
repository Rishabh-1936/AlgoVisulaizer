<%
String email=(String)session.getAttribute("email");
if(email==null)
{
	response.sendRedirect("index.jsp");
}
else
{	
%>

<!DOCTYPE html>
<html>
  
<head>
    <title>Selection Sort</title>
    <meta charset="UTF-8">
	<script src="js/jqueryForJPrompt.js" type="text/javascript"></script>
     <script src="js/jquery.alerts.js" type="text/javascript"></script>
     <link href="css/jquery.alerts.css" rel="stylesheet" type="text/css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/boxes.css" />
    <script type="text/javascript" src="js/GetElementPosition.js"></script>
    <link rel="stylesheet" type="text/css" href="css/codecolor.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
	body {
        background-color:WhiteSmoke ;
} 
      #highlight {
          background-color: wheat;
          opacity: 1.0;
          color: black;
          weight: bold;
          position:absolute;
		  border-radius: 5px;
          width:315px;
          height: 35px;
          line-height: 25px;
          /*          padding: 3px;
                    margin-top:0px;*/
          top: 79px;
          left: 62px;
      }

      #currentFly {
          background-color:powderblue;
          opacity: 1.0;
          color: black;
          weight: bold;
          position:absolute;
		border-radius: 5px	;
			width:315px;
          height: 45px;
          line-height: 29px;
          text-align: middle;
          /*          padding: 3px;
                    margin-top:0px;*/
          top: 79px;
          left: 62px;
      }

      #sortedFly {
          background-color: #37826C;
          opacity: 0.20;
          color: black;
          weight: bold;
          position:absolute;
		  border-radius: 5px;
          width:315px;
          height: 35px;
          line-height: 25px;
          /*          padding: 3px;
                    margin-top:0px;*/
          top: 79px;
          left: 62px;
      }

      #explanation1 {
          background-color:lightcoral;
          opacity: 1.0;
          color: black;
          weight: bold;
          position:absolute;
		  background-clip: padding-box;border-radius: 5px;
          width:315px;
          height: 35px;
          /*          padding: 3px;
                    margin-top:0px;*/
          top: 79px;
          left: 62px;
      }

      .cell {
          position:absolute;
          width:40px;
          height: 40px;
          left:20px;
          top:40px;
          border-width: 2px;
          border: 1px black solid;
          background-color: white;
          text-align: center;
          display:inline;
      }
	  .center {
			display: block;
			margin-left: auto;
			margin-right: auto;
			width: 55%;
			}


      .cell1 {
          display:inline;
      }

      div.inline { float:left; }
      .clearBoth { clear:both; }

      .button {
          margin-bottom: 0px; margin-top: 0px; background-color: #37826C; color:white;
          /*    width: 70px;
              height: 30px;*/
          display:inline;
          color:#fff;
          font-size: 14px;
          background: #6193CB;
          border: none;
      }

    </style>


  

</head>



  <body onload="init()" onresize="" style="font-family: times new roman;"> 
        <h3 align="center"><b>Selection Sort Animation</b></h3>
		<h4 align="center"> 
		 Usage: Perform selection sort for a list of integers.
	  Click the Input button to start over with input dataset.<br/>
	  	Click the Step button to find the smallest element (highlighted in red) and swap this element with the first element (highlighted in orange)<br/> in the the unsorted sublist. The elements that are already sorted are highlighted in red.

      
		</h4>
		 	<img align ="center" src="images/selection.png" class="center">

 
    <div style="height: 70px; font-size: 200%"></div>
    <div id ="iValue" style="position: absolute; height: 100px;">i: 1</div>
    <div id ="iPosition" style="position: absolute; height: 100px; font-size: 200%">&#8595;</div>

    <div style="display: table; overflow: hidden; width: 90%; margin: 0 auto;">
      <script>
        SIZE = 10;
        for (var i = 0; i < SIZE; i++) {
            document.writeln('<div style="display: table-cell;background-clip: padding-box;border-radius: 5px; vertical-align: middle;' +
                    'border: 1px blue solid; background: white;' +
                    'width: 30px; height: 30px; max-width: 30px; text-align: center;">' +
                    '<div id="list' + i + '" style="color: black; background-clip: padding-box;border-radius: 5px;weight: bold">45</div>' +
                    '</div>');
        }
      </script>      
    </div>

    <div style="display: table; overflow: hidden; width: 90%; margin: 0 auto;">
      <script>
        for (var i = 0; i < SIZE; i++) {
            document.writeln('<div style="display: table-cell; background-clip: padding-box;border-radius: 5px;vertical-align: middle;' +
                    ' background: whitesmoke;' +
                    'width: 30px; height: 10px; max-width: 30px; text-align: center;">' +
                    '<div id="check' + i + '" style="color: #EB0D1B;background-clip: padding-box;border-radius: 5px; weight: bold"></div>' +
                    '</div>');
        }
      </script>      
    </div>

    <div style="display: table-cell; vertical-align: middle;
         background: whitesmoke;
         width: 30px; height: 45px; max-width: 30px; text-align: center;">
      <div id="highlight"></div>
      <div id="currentFly"></div>
      <div id="sortedFly"></div>
    </div>

    <div align="center" >
	
		Dataset:<input name="dataset" id="dataset" type="text">
	  <button id = "reset" type="button" class="button" onclick="reset()">Input</button>
      <button id = "step" type="button" class="button" onclick="step()">Step</button>
    </div>

    <div style="text-align: center; margin-top: 1em">
      <span id = "remark" style = "background-color: chocolate; color: white; alignment-adjust: central; text-align: center; max-wdith: 800px; margin-left: auto; margin-right: auto">
        A list is filled with random numbers.
      </span>
    </div>

    <script>
      slowAnimationSpeed = 400;

      $("#step").click(function () {
          step1();
      });

      function init() {
          reset();
      }

      function reset() {
          isFindFirst = true;
          current = 0;
          minPosition = 0;

          i = 0;
          document.getElementById('highlight').style.visibility = 'hidden';
          document.getElementById('currentFly').style.visibility = 'hidden';
          document.getElementById('sortedFly').style.visibility = 'hidden';
          document.getElementById('iPosition').style.visibility = 'hidden';
          document.getElementById('iValue').style.visibility = 'hidden';
          setRandomValue();
          resetColor();
          document.getElementById('remark').innerHTML = 'Enter the dataset(10 numbers) to perform Sort and click step.';
          document.getElementById('value').disabled = false;

          for (var j = 0; j < SIZE; j++) {
              id = 'check' + j;
              document.getElementById(id).innerHTML = "";
          }
      }

      function resetColor() {
          for (var i = 0; i < SIZE; i++) {
              id = 'list' + i;
              document.getElementById(id).style.backgroundColor = "white";
              document.getElementById(id).style.color = "black";
          }
      }

      function setRandomValue() {
          listValues = [];
		  var value = document.getElementById('dataset').value.trim();
          if (value == "") {
              jAlert("No value entered");
          }
		  else{
		  var str = document.getElementById("dataset").value;
		  var temp = new Array();
		// this will return an array with strings "1", "2", etc.
			temp = str.split(",");
			

         for (var i = 0; i < SIZE; i++) {
              listValues.push(parseInt(temp[i], 10));
          }
         
          for (var i = 0; i < SIZE; i++) {
              id = 'list' + i;
              document.getElementById(id).innerHTML =
                      listValues[i];
          }
      }
	  }

      var k = 0;
      var current = 0;
      var isFindFirst = true;

      function step1() {
          if (current > SIZE - 2) {
              document.getElementById('highlight').style.visibility = 'hidden';
              document.getElementById('currentFly').style.visibility = 'hidden';
			  document.getElementById('dataset').disabled = true;

              document.getElementById('remark').innerHTML = 'The list is now sorted. Click Reset to restart.';
			  jAlert("The given Random list is now Sorted.");

//              current++;
              colorSorted(SIZE);
              return;
          }

          if (isFindFirst) {
              findFirst();
              isFindFirst = false;
          }
          else {
              swap();
              isFindFirst = true;
              current++;
          }
      }

      function colorSorted(size) {
          if (current < 1)
              return;
          p3 = getElementPos(document.getElementById('list0'));
          document.getElementById('sortedFly').style.top =
                  p3.y - 6 + "px";
          document.getElementById('sortedFly').style.left =
                  p3.x + "px";
          document.getElementById('sortedFly').style.width =
                  (p3.w + 7.1) * size + "px";
          document.getElementById('sortedFly').style.height =
                  p3.h + 17 + "px";
          document.getElementById('sortedFly').style.visibility = 'visible';
      }

      function setPointerPosition() {
          document.getElementById('iPosition').style.visibility = 'visible';
          document.getElementById('iValue').style.visibility = 'visible';
          posLoc = getElementPos(document.getElementById('list' + current));
          document.getElementById('iPosition').style.top
                  = posLoc.y - 40 + "px";
          document.getElementById('iPosition').style.left
                  = posLoc.x + posLoc.w / 2 - 5 + "px";

          document.getElementById('iValue').style.top
                  = posLoc.y - 53 + "px";
          document.getElementById('iValue').style.left
                  = posLoc.x + posLoc.w / 2 - 7 + "px";
          document.getElementById('iValue').innerHTML = "i: " + current;
      }

      function findFirst() {
          setPointerPosition();
          colorSorted(current);
          min = listValues[current];
          minPosition = current;

          for (var i = current + 1; i < SIZE; i++) {
              if (min > listValues[i]) {
                  min = listValues[i];
                  minPosition = i;
              }
          }

          setMinPosition();
          setCurrentPosition();

          document.getElementById('remark').innerHTML = 'The minimum value is ' + min + ' and the first value is ' + listValues[current] + ' in the unsorted sublist.';
      }

      function setCurrentPosition() {
          posLoc = getElementPos(document.getElementById('list' + current));
          document.getElementById('currentFly').style.top =
                  posLoc.y - 6 + "px";
          document.getElementById('currentFly').style.left =
                  posLoc.x + "px";
          document.getElementById('currentFly').style.width =
                  posLoc.w + 6 + "px";
          document.getElementById('currentFly').style.height =
                  posLoc.h + 17 + "px";
          document.getElementById('currentFly').innerHTML = listValues[current];
          document.getElementById('currentFly').style.visibility = 'visible';
      }

      function setMinPosition() {
          posLoc = getElementPos(document.getElementById('list' + minPosition));
          document.getElementById('highlight').style.top =
                  posLoc.y - 6 + "px";
          document.getElementById('highlight').style.left =
                  posLoc.x + "px";
          document.getElementById('highlight').style.width =
                  posLoc.w + "px";
          document.getElementById('highlight').style.height =
                  posLoc.h + 11 + "px";
          document.getElementById('highlight').innerHTML = listValues[minPosition];
          document.getElementById('highlight').style.visibility = 'visible';
      }

      function swap() {
          if (minPosition == current) {
              document.getElementById('remark').innerHTML = 'The minimum element is the first element in the remaining list. No swap is needed.';
              return;
          }
          else {
              document.getElementById('remark').innerHTML = min + ' is swapped with ' + listValues[current];
          }

          listValues[minPosition] = listValues[current];
          listValues[current] = min;
          c = current;
          m = minPosition;

          if (current < minPosition) {
              posLoc1 = getElementPos(document.getElementById('list' + current));
              posLoc = getElementPos(document.getElementById('list' + minPosition));

              $("#highlight").animate({top: posLoc.y - 55}, slowAnimationSpeed, function () {
                  $("#highlight").animate({left: posLoc1.x}, slowAnimationSpeed, function () {
                      $("#highlight").animate({top: posLoc1.y - 6, left: posLoc1.x}, slowAnimationSpeed, function () {
                          id = 'list' + c;
                          document.getElementById(id).innerHTML = listValues[c];
                      });
                  });
              });

              $("#currentFly").animate({top: posLoc1.y - 55}, slowAnimationSpeed, function () {
                  $("#currentFly").animate({left: posLoc.x}, slowAnimationSpeed, function () {
                      $("#currentFly").animate({top: posLoc.y - 6, left: posLoc.x}, slowAnimationSpeed, function () {
                          id = 'list' + m;
                          document.getElementById(id).innerHTML = listValues[m];
                      });
                  });
              });
          }
      }
    </script>
  </body>

</html>

<%
}
%>