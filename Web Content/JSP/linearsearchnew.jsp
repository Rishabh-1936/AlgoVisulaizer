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
    <title>Linear Search</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/boxes.css" />
    <script type="text/javascript" src="js/GetElementPosition.js"></script>
    <link rel="stylesheet" type="text/css" href="css/codecolor.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/jquery.ui.touch-punch.min.js"></script>
<script src="js/jquery.alerts.js"></script> 
<link href="css/jquery.alerts.css" rel="stylesheet" type="text/css" media="screen" />
    <style>
	body {
        background-color:WhiteSmoke ;
} 
      #highlight {
          background-color:lightcoral;
          opacity: 0.5;
          color: black;
          weight: bold;
          position:absolute;
          width:315px;
          height: 35px;
          /*          padding: 3px;
                    margin-top:0px;*/
          top: 79px;
          left: 62px;
      }

      #explanation1 {
          background-color:blue;
          opacity: 1.0;
          color: black;
          weight: bold;
          position:absolute;
          width:315px;
          height: 35px;
          /*          padding: 3px;
                    margin-top:0px;*/
          top: 79px;
          left: 62px;
      }
		.center {
			display: block;
			margin-left: auto;
			margin-right: auto;
			width: 40%;
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

    <script>
      function init() {
          reset();
      }

      function reset() {
          i = 0;
          document.getElementById('highlight').style.visibility = 'hidden';
          document.getElementById('iPosition').style.visibility = 'hidden';
          document.getElementById('iValue').style.visibility = 'hidden';
          setRandomValue();
          resetColor();
          document.getElementById('remark').innerHTML = 'A new random list is created';
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
              document.getElementById(id).style.color = "#37826C";
          }
      }

      function setRandomValue() {
          for (var i = 0; i < SIZE; i++) {
              id = 'list' + i;
              document.getElementById(id).innerHTML =
                      Math.floor(Math.random() * 100);
          }
      }

      function draw() {
          var count = 0;
          for (var i = 0; i < 1; i++) {
              for (var j = 0; j < 20; j++) {
                  id = 'cell' + j;
                  // document.write(id.toString());
                  document.getElementById(id).style.top = (i + 1) * 40 + 30 + "px";
                  document.getElementById(id).style.left = (j + 1) * 40 + "px";
//                  if (count++ % 2 == 0)
//                      document.getElementById(id).style.backgroundColor = "#37826C";
//                  else
//                      document.getElementById(id).style.backgroundColor = "lightGray";

                  document.getElementById(id).innerHTML = "2";
              }
              count++;
          }
      }

      var k = 0;
      var queens = [-1, -1, -1, -1, -1, -1, -1, -1];
      /** Search for a solution */
      function search() {
          // k - 1 indicates the number of queens placed so far
          // We are looking for a position in the kth row to place a queen

          // Find a position to place a queen in the kth row
          var j = findPosition(k);
          if (j < 0) {
              displayQueens();
              document.getElementById('highlight').style.visibility = 'visible';
              document.getElementById('highlight').style.top = y + (k) * 40 + "px";
              document.getElementById('highlight').style.left = x + "px";
              queens[k] = -1;
              k--; // back track to the previous row


              document.getElementById('status').innerHTML
                      = "No queen can be placed in row " + (k + 2)
                      + ". Backtrack to the row " + (k + 1);
          } else {
              queens[k] = j;
              k++;
              displayQueens();
              if (k == 8) {
                  document.getElementById('status').innerHTML
                          = "A solution is found.";
              }
              else {
                  document.getElementById('status').innerHTML
                          = "A queen is placed in row " + k;
              }
          }
      }

      function findPosition(k) {
          var start = queens[k] + 1; // Search for a new placement

          for (var j = start; j < 8; j++) {
              if (isValid(k, j))
                  return j; // (k, j) is the place to put the queen now
          }

          return -1;
      }

      /** Return true if a queen can be placed at (row, column) */
      function isValid(row, column) {
          for (var i = 1; i <= row; i++)
              if (queens[row - i] == column // Check column
                      || queens[row - i] == column - i // Check upleft diagonal
                      || queens[row - i] == column + i) // Check upright diagonal
                  return false; // There is a conflict
          return true; // No conflict
      }

      function next() {
          if (k == 8) {
              document.getElementById('status').innerHTML
                      = "A solution is already found. Click Restart to start over.";
          }
          search();
//          displayQueens();
      }

      function restart() {
          document.getElementById('status').innerHTML
                  = "";
          k = 0;
          queens = [-1, -1, -1, -1, -1, -1, -1, -1];
          displayQueens();
          document.getElementById('highlight').style.visibility = 'hidden';
      }

      function step() {
          document.getElementById('iPosition').style.visibility = 'visible';
          document.getElementById('iValue').style.visibility = 'visible';
          document.getElementById('value').disabled = true;
          var key = document.getElementById('value').value;
          var id = 'list' + i;
          posLoc = getElementPos(document.getElementById(id));

          document.getElementById('iPosition').style.top
                  = posLoc.y - 40 + "px";
          document.getElementById('iPosition').style.left 
                  = posLoc.x + posLoc.w / 2 - 5 + "px";

          document.getElementById('iValue').style.top
                  = posLoc.y - 53 + "px";
          document.getElementById('iValue').style.left 
                  = posLoc.x + posLoc.w / 2 - 7 + "px";
          document.getElementById('iValue').innerHTML = "i: " + i;  

          document.getElementById('highlight').style.top =
                  posLoc.y + posLoc.h + 30 + "px";
          document.getElementById('highlight').style.left =
                  posLoc.x + "px";
          document.getElementById('highlight').style.width =
                  posLoc.w + "px";
          document.getElementById('highlight').style.height =
                  posLoc.h + 10 + "px";
          document.getElementById('highlight').innerHTML = key;
          document.getElementById('highlight').style.visibility = 'visible';
          resetColor();
          document.getElementById(id).style.backgroundColor =
                  "wheat";
          document.getElementById(id).style.color = "black";
          if (key == document.getElementById(id).innerHTML) {
              var id1 = 'check' + i;
              document.getElementById(id1).innerHTML = "&#x2713;";
              document.getElementById('remark').innerHTML = 'Test if ' +
                      key + ' == ' + document.getElementById(id).innerHTML + '. ' +
                      'A key is found';
              jAlert("A key is found with the index " + i);
          }
          else if (i == SIZE - 1) {
              var id1 = 'check' + i;
              document.getElementById(id1).innerHTML = "&#x2717;";

              document.getElementById('remark').innerHTML = 'Test if ' +
                      key + ' == ' + document.getElementById(id).innerHTML + '. ' +
                      'No match and the search is exhausted.';
              jAlert("A key is not found. The method will abort.");
          }
          else {
              var id1 = 'check' + i;
              document.getElementById(id1).innerHTML = "&#x2717;";

              document.getElementById('remark').innerHTML = 'Test if ' +
                      key + ' == ' + document.getElementById(id).innerHTML + '. ' +
                      'No match and continue to search for the next match.';
              i++;
          }
      }

      function init1() {
          posLoc = getElementPos(document.getElementById('program'));
          x = posLoc.x;
          y = posLoc.y;
          for (var i = 0; i < 1; i++) {
              for (var j = 0; j < 20; j++) {
                  var id = 'cell' + j;
//                document.getElementById(id).style.visibility = "hidden";
                  document.getElementById(id).style.top = y + i * 40 + "px";
                  document.getElementById(id).style.left = x + j * 40 + "px";
//                  $(id).css("top", y + 90 + j * 40)
//                          .css("left", x + 115 - 3 / 2 + i * 40);
              }
          }
      }

    </script>
  


</head>



  <body onload="init()" style="font-family: times new roman;"> 
    <h3 align="center"><b>Linear Search Animation</b> 
	</h3>
	<h4 align="center"> 
	
      Usage: Enter a key as a number. Click the Step button to perform one comparison.<br/>
	  Click the Reset button to start over with a new random list of integers. <br/>
	  You may enter a new key for a new search.
	</h4>
    
	<img align ="center" src="images/linearsearch.png" class="center">
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
                    '<div id="list' + i + '" style="color: wheat; background-clip: padding-box;height: 30px;border-radius: 5px;weight: bold">45</div>' +
                    '</div>');
        }
      </script>      
    </div>

    <div style="display: table; overflow: hidden; width: 90%; margin: 0 auto;">
      <script>
        SIZE = 10;
        for (var i = 0; i < SIZE; i++) {
            document.writeln('<div style="display: table-cell;background-clip: padding-box;border-radius: 5px; vertical-align: middle;' +
                    ' background: whitesmoke;' +
                    'width: 30px; height: 30px; max-width: 30px; text-align: center;">' +
                    '<div id="check' + i + '" style="color: lightcoral; background-clip: padding-box;border-radius: 5px;weight: bold"></div>' +
                    '</div>');
        }
      </script>      
    </div>

    <div style="display: table-cell; vertical-align: middle;
         background: whitesmoke;
         width: 30px; height: 45px; max-width: 30px; text-align: center;">
      <div id="highlight"></div>
    </div>
    
    <div align="center" >
      Key: <input type="text" size="5" value="8" id="value" style="text-align: right"></input>
      <button type="button" class="button" onclick="step()">Step</button>
      <button type="button" class="button" onclick="reset()">Reset</button></div>

    <div style="text-align: center; margin-top: 1em">
      <span id = "remark" style = "background-color: chocolate; color: white; alignment-adjust: central; text-align: center; max-wdith: 800px; margin-left: auto; margin-right: auto">
        A list is filled with random numbers.
      </span>
    </div>
  </body>

</html>

<%
}
%>