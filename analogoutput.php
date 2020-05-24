<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Output</title>
  </head>
  <body >

<style type="text/css">

.tg  {border-collapse:collapse;border-spacing:0;border-color:#999;vertical-align: middle;width: 600px;}
.tg tr{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#999;color:#444;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#999;color:#444;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#999;color:#fff;background-color:#26ADE4;height: 30px;}
.tg .tg-s6z2{text-align:center}
.tg .tg-yw4l{vertical-align:text-middle;text-align:center}



</style>





<?php

$prefix = "./outputs/";

$meta1 = file($prefix . '/text1.txt');
$meta2 = file($prefix . 'text1a.txt');
$analogyears = file($prefix . 'text2.txt');
$weight = file($prefix . 'text3.txt');
$month1 = file($prefix . 'month1.txt');
$mtext1 = file($prefix . 'mtext1.txt');
$mtext2 = file($prefix . 'mtext2.txt');
$var1 = file($prefix . 'var.txt');
$year1 = file($prefix . 'year1.txt');
$year2 = file($prefix . 'year2.txt');
$year3 = file($prefix . 'year3.txt');
$year4 = file($prefix . 'year4.txt');
$year5 = file($prefix . 'year5.txt');
$my1 = file($prefix . 'my1.txt');
$my2 = file($prefix . 'my2.txt');
$useryear1 = file($prefix . 'useryear1.txt');
$useryear2 = file($prefix . 'useryear2.txt');
$verstr = file($prefix . 'verstr.txt');
$compstr = file($prefix . 'compstr.txt');
$correlations = file($prefix . 'correlations.txt');
$slpyears = file($prefix . 'slpyears.txt');
$h500years = file($prefix . 'h500years.txt');
$t2myears = file($prefix . 't2myears.txt');
$t925years = file($prefix . 't925years.txt');
$sstyears = file($prefix . 'sstyears.txt');
$iceyears = file($prefix . 'iceyears.txt');
$heightlev = file($prefix . 'heightlevel.txt');
$templev = file($prefix . 'templevel.txt');
?>


<br>
<table class="tg">
  <tr>
    <th class="tg-s6z2" colspan="5"><font size="+1"><?php echo "<b>$meta1[0]</b>";?><br><?php echo "<b>$meta2[0]</b>";?><br><b>Selection Month(s): </b><?php echo "<b>$my1[0]</b>";?><b> - Forecast Month: </b><?php echo "<b>$my2[0]</b>";?></font></th>
  </tr>
  <tr>
    <td class="tg-yw4l" colspan="5" ><font size="+1"><?php echo "<b>$analogyears[0]</b>";?> </font></td>
  </tr>
  <tr>
    <td class="tg-yw4l" colspan="5" ><font size="-1"><b>Weights: </b><?php echo "<b>$weight[0]</b>";?> </font></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l"><?php echo "<b>$mtext1[0]</b>";?></td>
    <td class="tg-yw4l"><b>Following </b><?php echo "<b>$mtext2[0]</b>";?></td>
    <td class="tg-yw4l"><b>Verification</b></td>
    <td class="tg-yw4l"><b>Sea Ice Forecast</b></td>
  </tr>
  <tr>
    <td class="tg-yw4l"><font color="ff7a7a"><b>Selected<br><?php echo "<b>$my1[0]</b>";?><br>for Analysis</font><br><br><font color="00cc00"><b>5 Analog<br>Composite<br>Forecast for<br><?php echo "<b>$my2[0]</b></font>";?></b></font><br><br><font color="#7a7aff"><b>Verification</b></font></td>
    <td class="tg-yw4l" bgcolor="#ff7a7a"><a href="<?php echo($prefix)?>/a.png"><img src="<?php echo($prefix)?>a.png" width="150" height="188"></a></td>
    <td class="tg-yw4l" bgcolor="#00cc00"><a href="<?php echo($prefix)?>b.png"><img src="<?php echo($prefix)?>b.png" width="150" height="188"></a></td>
    <td class="tg-yw4l" bgcolor="#7a7aff"><a href="<?php echo($prefix)?>v.png"><img src="<?php echo($prefix)?>v.png" width="150" height="188"></a></td>
    <td class="tg-yw4l" bgcolor="#ccccff"><a href="<?php echo($prefix)?>ice1.png"><img src="<?php echo($prefix)?>ice1.png" width="150" height="150"></a></td>
  </tr>
  <tr>
    <td class="tg-yw4l"><b>Analog 1:</b><br><?php echo "<b>$year1[0]</b>";?></td>
    <td class="tg-yw4l" bgcolor="#ffaaaa"><a href="<?php echo($prefix)?>a1.png"><img src="<?php echo($prefix)?>a1.png" width="150" height="188"></a></td>
    <td class="tg-yw4l" bgcolor="#aaffaa"><a href="<?php echo($prefix)?>b1.png"><img src="<?php echo($prefix)?>b1.png" width="150" height="188"></a></td>
    <td class="tg-yw4l" bgcolor="#7a7aff"><a href="<?php echo($prefix)?>v3.png"><img src="<?php echo($prefix)?>v3.png" width="150" height="188"></a></td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"><b>Analog 2:</b><br><?php echo "<b>$year2[0]</b>";?></td>
    <td class="tg-yw4l" bgcolor="#ffaaaa"><a href="<?php echo($prefix)?>a2.png"><img src="<?php echo($prefix)?>a2.png" width="150" height="188"></a></td>
    <td class="tg-yw4l" bgcolor="#aaffaa"><a href="<?php echo($prefix)?>b2.png"><img src="<?php echo($prefix)?>b2.png" width="150" height="188"></a></td>
    <td class="tg-yw4l"><?php echo "<b>$verstr[0]</b>";?></td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"><b>Analog 3:</b><br><?php echo "<b>$year3[0]</b>";?></td>
    <td class="tg-yw4l" bgcolor="#ffaaaa"><a href="<?php echo($prefix)?>a3.png"><img src="<?php echo($prefix)?>a3.png" width="150" height="188"></a></td>
    <td class="tg-yw4l" bgcolor="#aaffaa"><a href="<?php echo($prefix)?>b3.png"><img src="<?php echo($prefix)?>b3.png" width="150" height="188"></a></td>
    <td class="tg-yw4l"><?php echo "<b>$compstr[0]</b>";?></td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"><b>Analog 4:</b><br><?php echo "<b>$year4[0]</b>";?></td>
    <td class="tg-yw4l" bgcolor="#ffaaaa"><a href="<?php echo($prefix)?>a4.png"><img src="<?php echo($prefix)?>a4.png" width="150" height="188"></a></td>
    <td class="tg-yw4l" bgcolor="#aaffaa"><a href="<?php echo($prefix)?>b4.png"><img src="<?php echo($prefix)?>b4.png" width="150" height="188"></a></td>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"><b>Analog 5:</b><br><?php echo "<b>$year5[0]</b>";?></td>
    <td class="tg-yw4l" bgcolor="#ffaaaa"><a href="<?php echo($prefix)?>a5.png"><img src="<?php echo($prefix)?>a5.png" width="150" height="188"></a></td>
    <td class="tg-yw4l" bgcolor="#aaffaa"><a href="<?php echo($prefix)?>b5.png"><img src="<?php echo($prefix)?>b5.png" width="150" height="188"></a></td>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"><b>All Years</b></td>
    <td class="tg-yw4l">Click <a href="<?php echo($prefix)?>matches1.txt">HERE</a> to see the pattern match ranking for all years.</td>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">Click <a href="<?php echo($prefix)?>matches2.txt">HERE</a> to see the verification ranking for all years.</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l" colspan="5"><u>The multiple linear regression using domain averages produced the following variable R-values</u><br><?php echo "<b>$correlations[0]</b>";?> </td>
  </tr>
  <tr>
    <td class="tg-yw4l" colspan="5"><u>Here are the top match years based on selection/forecast domains</u><br>
    <b>Sea Level Pressure: </b><?php echo "$slpyears[0]";?><br>
    <b></b><?php echo "<b>$heightlev[0]</b>";?> <b>mb Height: </b><?php echo "$h500years[0]";?><br>
    <b>2-Meter Temps: </b><?php echo "$t2myears[0]";?><br>
    <b></b><?php echo "<b>$templev[0]</b>";?> <b>mb Temps: </b><?php echo "$t925years[0]";?><br>
    <b>Sea Surface Temperatures: </b><?php echo "$sstyears[0]";?><br>
    <b>Ice Concentration (always 60-90N): </b><?php echo "$iceyears[0]";?><br>
    </td>
  </tr>
</table>
<br><br>

</body>
</html>

