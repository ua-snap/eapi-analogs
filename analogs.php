<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Analogs</title>
  </head>
  <body bgcolor="#f2f2f2"><h3>
    Use the forms below to enter parameters for the analog forecast application &nbsp;&nbsp;&nbsp;(<a href="https://youtu.be/z-I5xpGmwGY" target=\"_blank\">YouTube Video Instructions</a> 7:40)
    </h3><b>EXPERIMENTAL. USE AT YOUR OWN RISK.</b>
    <form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">


<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;background-color:#f6e3ce;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg .tg-yw4m{vertical-align:top;background-color:#ffe6e6;}
.tg .tg-yw4n{vertical-align:top;background-color:#ffcccc;}
.tg .tg-yw4o{vertical-align:top;background-color:#ffb3b3;}
.tg .tg-yw4p{vertical-align:top;background-color:#ccffdd;}
.tg .tg-yw4q{vertical-align:top;background-color:#b3ecff;}
.tg .tg-yw4r{vertical-align:top;background-color:#ffff99;}
.tg .tg-yw4s{vertical-align:top;background-color:#99ff99;}
.tg .tg-yw4r{vertical-align:top;background-color:#99ffff;}
.tg .tg-yw4l{vertical-align:top;}
</style>


<table class="tg">

<tr>
<td class="tg-yw4m" colspan="1"><B>Look for Analog Matches in This Box</B><br><br>
North Lat <input type="number" name="a2_y2" min="-90" max="90" style="width: 50px;"<?php if(empty($_POST['a2_y2'])) {echo "value=\"90\"";} else {echo "value=\"" . $_POST['a2_y2'] . "\"";}?>>
West Lon <input type="number" name="a2_x1" min="0" max="360" style="width: 50px;"<?php if(empty($_POST['a2_x1'])) {echo "value=\"0\"";} else {echo "value=\"" . $_POST['a2_x1'] . "\"";}?>>
<br>South Lat <input type="number" name="a2_y1" min="-90" max="90" style="width: 50px;"<?php if(empty($_POST['a2_y1'])) {echo "value=\"0\"";} else {echo "value=\"" . $_POST['a2_y1'] . "\"";}?>>
East Lon <input type="number" name="a2_x2" min="0" max="360" style="width: 50px;"<?php if(empty($_POST['a2_x2'])) {echo "value=\"360\"";} else {echo "value=\"" . $_POST['a2_x2'] . "\"";}?>>
<br><br>Remember that longitude runs from 0 to 360 (no E-W).
<br>Click <a href="MapGrid900dpi.jpg" target="_blank">HERE</a> for a blank map with labelled grid lines.
</td>

<td class="tg-yw4n" colspan="1"><B>Forecast is for This Box</B><br><br>
North Lat <input type="number" name="a2_AK2" min="-90" max="90" style="width: 50px;"<?php if(empty($_POST['a2_AK2'])) {echo "value=\"90\"";} else {echo "value=\"" . $_POST['a2_AK2'] . "\"";}?>>
West Lon <input type="number" name="a2_AK3" min="0" max="360" style="width: 50px;"<?php if(empty($_POST['a2_AK3'])) {echo "value=\"0\"";} else {echo "value=\"" . $_POST['a2_AK3'] . "\"";}?>>
<br>South Lat <input type="number" name="a2_AK1" min="-90" max="90" style="width: 50px;"<?php if(empty($_POST['a2_AK1'])) {echo "value=\"70\"";} else {echo "value=\"" . $_POST['a2_AK1'] . "\"";}?>>
East Lon <input type="number" name="a2_AK4" min="0" max="360" style="width: 50px;"<?php if(empty($_POST['a2_AK4'])) {echo "value=\"360\"";} else {echo "value=\"" . $_POST['a2_AK4'] . "\"";}?>>
</td>


<td class="tg-yw4o" colspan="4">
<B>Last month</B> to start evaluation (e.g., 4 for April):
<select name="a2_usermonth">
<?php
/// Generate drop-down options for month 1-12.
foreach(range(1, 12) as $a2_usermonth) {echo "<option value=\"$a2_usermonth\">$a2_usermonth</option>";}
?>
</select><br>
<B>Number of Months</B> (up to 12) to evaluate for analog matches (e.g., 2 for Mar-Apr):
<select name="a2_exmth">
<?php
/// Generate drop-down options for number of months 1-12.
foreach(range(1, 12) as $a2_exmth) {
  echo "<option value=\"$a2_exmth\">$a2_exmth</option>";
}
?>
</select><br>
<B>Year</B> of last month to start evaluation:
<select name="a2_useryear">
<?php
// Generate drop-down options for years 1949-2020.
foreach(range(2020, 1949) as $a2_useryear) {
  echo "<option value=\"$a2_useryear\">$a2_useryear</option>";
}
?>
</select><br>
<B>Start Months Ahead</B> (up to 12) to generate forecast:
<select name="a2_fmnths">
<?php
/// Generate drop-down options for number of months 1-12.
foreach(range(1, 12) as $a2_fmnths) {
  echo "<option value=\"$a2_fmnths\">$a2_fmnths</option>";
}
?>
</select>
&nbsp;&nbsp;<B>Months to Forecast</B>:
<select name="a2_fmnths2">
<?php
/// Generate drop-down options for number of months 1-12.
foreach(range(1, 12) as $a2_fmnths2) {
  echo "<option value=\"$a2_fmnths2\">$a2_fmnths2</option>";
}
?>
</select>
<br><B>Number of Analogs</B> to use for the analogs forecast (1-5):
<select name="a2_howmanyyears">
<?php
// Generate drop-down options for years 1949-2016.
foreach(range(5, 1) as $a2_howmanyyears) {
  echo "<option value=\"$a2_howmanyyears\">$a2_howmanyyears</option>";
}
?>
</select><br>

<br><font color="#000000">
For example, to forecast Feb-Mar 2017 using Nov 2016 - Jan 2017 data, choose 1 (Jan
<br>is the last month for the pattern match), 3 (using 3 months of pattern matching), 2017 (the
<br>last month for pattern matching is Jan 2017), 1 (you forecast start month is Feb, which is 1
<br>month after your last pattern match month of Jan), and 2 (you are forecasting for 2 months,
<br>Feb and Mar).</font>


</td>
</tr>



<tr>
<td class="tg-031e" colspan="6"><B>Theme to Forecast:</b>
1 = SLP, 2 = Pressure level height (enter below), 3 = 2-Meter Temps, 4 = Pressure level temp (enter below), 5 = SST, 6 = Precip
&nbsp;&nbsp;&nbsp;Choose Variable (1-6):
<select name="a2_variable">
<?php
/// Generate drop-down options for layers 1-4.
foreach(range(0, 6) as $a2_variable) {
  echo "<option value=\"$a2_variable\">$a2_variable</option>";
}
?>
</select>

</td>


</tr>



<tr>
<td class="tg-yw4p" colspan="6"><B>Pressure Levels:</b>
0 = 1000mb, 1 = 925mb, 2 = 850mb, 3 = 700mb, 4 = 600mb, 5 = 500mb, 
6 = 400mb, 7 = 300mb, 8 = 250mb, 9 = 200mb, 10 = 150mb, 11 = 100mb, 12 = 70mb,
13 = 50mb, 14 = 30mb, 15 = 20mb, 16 = 10mb <br>
<b>Enter Pressure Level for Height Analysis:</b> (see above)&nbsp;&nbsp;<input type="number" name="a2_heightlev" min="0" max="16" style="width: 50px;"<?php if(empty($_POST['a2_heightlev'])) {echo "value=\"5\"";} else {echo "value=\"" . $_POST['a2_heightlev'] . "\"";}?>>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Enter Pressure Level for Temp Analysis:</b> (see above)&nbsp;&nbsp;<input type="number" name="a2_templev" min="1" max="16" style="width: 50px;"<?php if(empty($_POST['a2_templev'])) {echo "value=\"1\"";} else {echo "value=\"" . $_POST['a2_templev'] . "\"";}?>>


</td>
</tr>



<tr>
<td class="tg-yw4q" colspan="6"><B>Weighting for Analog Selections (-100 to 100):</B> <br><br>
SLP <input type="number" name="a2_slpwgt1" min="-100" max="100" style="width: 50px;"<?php if(empty($_POST['a2_slpwgt1'])) {echo "value=\"100\"";} else {echo "value=\"" . $_POST['a2_slpwgt1'] . "\"";}?>>
Pressure Height <input type="number" name="a2_h500wgt1" min="-100" max="100" style="width: 50px;"<?php if(empty($_POST['a2_h500wgt1'])) {echo "value=\"0\"";} else {echo "value=\"" . $_POST['a2_h500wgt1'] . "\"";}?>>
T2M <input type="number" name="a2_t2mwgt1" min="-100" max="100" style="width: 50px;"<?php if(empty($_POST['a2_t2mwgt1'])) {echo "value=\"0\"";} else {echo "value=\"" . $_POST['a2_t2mwgt1'] . "\"";}?>>
Pressure Temp <input type="number" name="a2_t925wgt1" min="-100" max="100" style="width: 50px;"<?php if(empty($_POST['a2_t925wgt1'])) {echo "value=\"0\"";} else {echo "value=\"" . $_POST['a2_t925wgt1'] . "\"";}?>>
SST <input type="number" name="a2_sstwgt1" min="-100" max="100" style="width: 50px;"<?php if(empty($_POST['a2_sstwgt1'])) {echo "value=\"0\"";} else {echo "value=\"" . $_POST['a2_sstwgt1'] . "\"";}?>>
&nbsp;&nbsp;Use Index for Matching (1=PDO, 2=NPM, 3=SOI, 4=EOF1, 5=EOF2, 6=EOF3, 7=Combined EOFs)
<select name="a2_indexchoice">
<?php
/// Generate drop-down options for month 1-12.
foreach(range(0, 0) as $a2_indexchoice) {echo "<option value=\"$a2_indexchoice\">$a2_indexchoice</option>";}
?>
</select>
<br><br>
</select>
<B>Auto Weight</b> (0 = No, 1 = Yes):<select name="a2_autoWgt">

<?php
/// Generate drop-down options for auto weighting 0-1.
foreach(range(0, 1) as $a2_autoWgt) {
  echo "<option value=\"$a2_autoWgt\">$a2_autoWgt</option>";
}
?>
</select>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<B>Detrend Data</b> (0 = No, 1 = Yes):<select name="a2_detrend">
<?php
/// Generate drop-down options for detrending 0-1.
foreach(range(0, 1) as $a2_detrend) {
  echo "<option value=\"$a2_detrend\">$a2_detrend</option>";
}
?>
</select>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<B>Pearson or RMS Match</b> (0 = RMS, 1 = Pearson):<select name="a2_pearsonrms">
<?php
/// Generate drop-down options for detrending 0-1.
foreach(range(0, 1) as $a2_pearsonrms) {
  echo "<option value=\"$a2_pearsonrms\">$a2_pearsonrms</option>";
}
?>
</select>


<br><br>Note 1: If the analysis OR forecast box is entirely over land, program might crash due to no SST data.
<br>Note 2: Weights must be whole numbers. Total need not add to 100.
&nbsp;&nbsp;&nbsp;Note 3: Index choices supercede other numbers.
<br>Note 4: Index: 1=PDO, 2=NPM, 3=SOI, 4=EOF1, 5=EOF2, 6=EOF3, 7=Combined EOF.
<br>Note 5: Auto weighting uses a multiple linear regression to find the best historical correlations. Manual weights are ignored.
<br>
</td>
</tr>

<tr>
<td class="tg-yw4t" colspan="6">
<B>EOF Parameters</b> 


&nbsp;&nbsp;&nbsp;Choose Theme (1-5 [see list above: 5 = SST]):
<select name="a2_eofvariable">
<?php
/// Generate drop-down options for layers 1-5.
foreach(range(1, 5) as $a2_eofvariable) {
  echo "<option value=\"$a2_eofvariable\">$a2_eofvariable</option>";
}
?>
</select>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;North Lat <input type="number" name="a2_eofnlat" min="-90" max="90" style="width: 50px;"<?php if(empty($_POST['eofnlat'])) {echo "value=\"66\"";}  else {echo "value=\"" . $_POST['eofnlat'] . "\"";}?>>
&nbsp;&nbsp;South Lat                   <input type="number" name="a2_eofslat" min="-90" max="90" style="width: 50px;"<?php if(empty($_POST['eofslat'])) {echo "value=\"20\"";}  else {echo "value=\"" . $_POST['eofslat'] . "\"";}?>>
&nbsp;&nbsp;West Lon                    <input type="number" name="a2_eofllon" min="0" max="360"  style="width: 50px;"<?php if(empty($_POST['eofllon'])) {echo "value=\"110\"";} else {echo "value=\"" . $_POST['eofllon'] . "\"";}?>>
&nbsp;&nbsp;East Lon                    <input type="number" name="a2_eofrlon" min="0" max="360"  style="width: 50px;"<?php if(empty($_POST['eofrlon'])) {echo "value=\"260\"";} else {echo "value=\"" . $_POST['eofrlon'] . "\"";}?>>

</td>


</tr>


<tr>
<td class="tg-yw4p" colspan="6">
<B>Just Plot Correlations </b>  (0 = No, 1 = R-Value Maps, 2 = R2-Value Maps, 3 = Multiple R Correlation):<select name="a2_justcorrelations">
<?php
/// Generate drop-down options for detrending 0-1.
foreach(range(0, 3) as $a2_justcorrelations) {
  echo "<option value=\"$a2_justcorrelations\">$a2_justcorrelations</option>";
}
?>
</select>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Options 1 & 2 are mostly not useful. Option 3 is much more useful and takes 2 mins.)

</td>

</tr>




<tr>
<td class="tg-yw4r" colspan="6">



<B>Override Selection Criteria and Manually Choose 5 Match Years:</B> <br><br>

<B>Manual Override</b> (0 = No, 1 = Yes):<select name="a2_manualyesno">
<?php foreach(range(0, 1) as $a2_manualyesno) {echo "<option value=\"$a2_manualyesno\">$a2_manualyesno</option>";}?></select>


&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;Year 1 <select name="a2_manyear1"> <?php foreach(range(1949, 2020) as $a2_manyear1) {echo "<option value=\"$a2_manyear1\">$a2_manyear1</option>";}?></select>
&nbsp;&nbsp;&nbsp;Year 2 <select name="a2_manyear2"> <?php foreach(range(1949, 2020) as $a2_manyear2) {echo "<option value=\"$a2_manyear2\">$a2_manyear2</option>";}?></select>
&nbsp;&nbsp;&nbsp;Year 3 <select name="a2_manyear3"> <?php foreach(range(1949, 2020) as $a2_manyear3) {echo "<option value=\"$a2_manyear3\">$a2_manyear3</option>";}?></select>
&nbsp;&nbsp;&nbsp;Year 4 <select name="a2_manyear4"> <?php foreach(range(1949, 2020) as $a2_manyear4) {echo "<option value=\"$a2_manyear4\">$a2_manyear4</option>";}?></select>
&nbsp;&nbsp;&nbsp;Year 5 <select name="a2_manyear5"> <?php foreach(range(1949, 2020) as $a2_manyear5) {echo "<option value=\"$a2_manyear5\">$a2_manyear5</option>";}?></select>



<br><br>Note 1: Make sure that your match year is not for a month that is in the future!
&nbsp;&nbsp;&nbsp;Note 2: All weightings will be ignored. 
&nbsp;&nbsp;&nbsp;Note 3: Make sure that all years are different.

</td>
</tr>

</table>


<p><input name="a2_submit" type="submit" value="Generate">&nbsp;&nbsp;&nbsp;(to reset form, select "Theme to Forecast" 0 and press button)</p>
<br>Once it starts, DO NOT HIT REFRESH.
<br>The program takes up to 1 minutes to run,
<br>Wait for completion message and URL link below.

    </form>

    <?php
      // This code executes only after the user clicks the Generate button.
      if($_SERVER['REQUEST_METHOD'] == 'POST') {
        // Assume input is valid until proven otherwise.
        $a2_valid = true;

        // Year must be exactly 4 numeric characters.
        if(preg_match('/^[0-9]{4}$/', $_POST['a2_useryear'])) {
          $a2_useryear = $_POST['a2_useryear'];
        } else {
          echo "<p>Useryear has invalid characters.</p>";
          $a2_valid = false;
        }

        // Layer must be 1 numeric characters
        if(preg_match('/^[0-9]{1}$/', $_POST['a2_variable'])) {
          $a2_variable = $_POST['a2_variable'];
        } else {
          echo "<p>Variable has invalid characters.</p>";
          $a2_valid = false;
        }

        // Month must be 1-2 numeric characters
        if(preg_match('/^[0-9]{1,2}$/', $_POST['a2_usermonth'])) {
          $a2_usermonth = $_POST['a2_usermonth'];
        } else {
          echo "<p>Usermonth number has invalid characters.</p>";
          $a2_valid = false;
        }

        // Exmth must be 1-2 numeric characters
        if(preg_match('/^[0-9]{1,2}$/', $_POST['a2_exmth'])) {
          $a2_exmth = $_POST['a2_exmth'];
        } else {
          echo "<p>Exmonths months has invalid characters.</p>";
          $a2_valid = false;
        }

        // fmnths must be 1-2 numeric characters
        if(preg_match('/^[0-9]{1,2}$/', $_POST['a2_fmnths'])) {
          $a2_fmnths = $_POST['a2_fmnths'];
        } else {
          echo "<p>fmnths months has invalid characters.</p>";
          $a2_valid = false;
        }

        // fmnths must be 1-2 numeric characters
        if(preg_match('/^[0-9]{1,2}$/', $_POST['a2_fmnths2'])) {
          $a2_fmnths2 = $_POST['a2_fmnths2'];
        } else {
          echo "<p>fmnths months has invalid characters.</p>";
          $a2_valid = false;
        }

        // y1 must be 1-3 numeric characters
        if(preg_match('/^[\-0-9]{1,3}$/', $_POST['a2_y1'])) {
          $a2_y1 = $_POST['a2_y1'];
        } else {
          echo "<p>y1 has invalid characters.</p>";
          $a2_valid = false;
        }

        // y2 must be 1-3 numeric characters
        if(preg_match('/^[\-0-9]{1,3}$/', $_POST['a2_y2'])) {
          $a2_y2 = $_POST['a2_y2'];
        } else {
          echo "<p>y2 has invalid characters.</p>";
          $a2_valid = false;
        }

        // x1 must be 1-3 numeric characters
        if(preg_match('/^[0-9]{1,3}$/', $_POST['a2_x1'])) {
          $a2_x1 = $_POST['a2_x1'];
        } else {
          echo "<p>x1 has invalid characters.</p>";
          $a2_valid = false;
        }

        // x2 must be 1-3 numeric characters
        if(preg_match('/^[0-9]{1,3}$/', $_POST['a2_x2'])) {
          $a2_x2 = $_POST['a2_x2'];
        } else {
          echo "<p>x2 has invalid characters.</p>";
          $a2_valid = false;
        }


        // AK1 must be 1-2 numeric characters
        if(preg_match('/^[\-0-9]{1,3}$/', $_POST['a2_AK1'])) {
          $a2_AK1 = $_POST['a2_AK1'];
        } else {
          echo "<p>AK1 has invalid characters.</p>";
          $a2_valid = false;
        }

        // AK2 must be 1-2 numeric characters
        if(preg_match('/^[\-0-9]{1,3}$/', $_POST['a2_AK2'])) {
          $a2_AK2 = $_POST['a2_AK2'];
        } else {
          echo "<p>AK2 has invalid characters.</p>";
          $a2_valid = false;
        }

        // AK3 must be 1-3 numeric characters
        if(preg_match('/^[0-9]{1,4}$/', $_POST['a2_AK3'])) {
          $a2_AK3 = $_POST['a2_AK3'];
        } else {
          echo "<p>AK3 has invalid characters.</p>";
          $a2_valid = false;
        }

        // AK4 must be 1-3 numeric characters
        if(preg_match('/^[0-9]{1,4}$/', $_POST['a2_AK4'])) {
          $a2_AK4 = $_POST['a2_AK4'];
        } else {
          echo "<p>AK4 has invalid characters.</p>";
          $a2_valid = false;
        }

        // slpwgt1 must be 1-3 numeric characters
        if(preg_match('/^[\-0-9]{1,4}$/', $_POST['a2_slpwgt1'])) {
          $a2_slpwgt1 = $_POST['a2_slpwgt1'];
        } else {
          echo "<p>slpwgt1 has invalid characters.</p>";
          $a2_valid = false;
        }

        // h500wgt1 must be 1-3 numeric characters
        if(preg_match('/^[\-0-9]{1,4}$/', $_POST['a2_h500wgt1'])) {
          $a2_h500wgt1 = $_POST['a2_h500wgt1'];
        } else {
          echo "<p>h500wgt1 has invalid characters.</p>";
          $a2_valid = false;
        }

        // t2mwgt1 must be 1-3 numeric characters
        if(preg_match('/^[\-0-9]{1,4}$/', $_POST['a2_t2mwgt1'])) {
          $a2_t2mwgt1 = $_POST['a2_t2mwgt1'];
        } else {
          echo "<p>t2mwgt1 has invalid characters.</p>";
          $a2_valid = false;
        }

        // t925wgt1 must be 1-3 numeric characters
        if(preg_match('/^[\-0-9]{1,4}$/', $_POST['a2_t925wgt1'])) {
          $a2_t925wgt1 = $_POST['a2_t925wgt1'];
        } else {
          echo "<p>t925wgt1 has invalid characters.</p>";
          $a2_valid = false;
        }

        // sstwgt1 must be 1-3 numeric characters
        if(preg_match('/^[\-0-9]{1,4}$/', $_POST['a2_sstwgt1'])) {
          $a2_sstwgt1 = $_POST['a2_sstwgt1'];
        } else {
          echo "<p>sstwgt1 has invalid characters.</p>";
          $a2_valid = false;
        }


        // autoWgt must be 1-2 numeric characters
        if(preg_match('/^[0-9]{1,2}$/', $_POST['a2_autoWgt'])) {
          $a2_autoWgt = $_POST['a2_autoWgt'];
        } else {
          echo "<p>autoWgt has invalid characters.</p>";
          $a2_valid = false;
        }

        // autoWgt must be 1-2 numeric characters
        if(preg_match('/^[0-9]{1,2}$/', $_POST['a2_justcorrelations'])) {
          $a2_justcorrelations = $_POST['a2_justcorrelations'];
        } else {
          echo "<p>a2_justcorrelations has invalid characters.</p>";
          $a2_justcorrelations = false;
        }

        // detrend must be 1 numeric characters
        if(preg_match('/^[0-9]{1,2}$/', $_POST['a2_detrend'])) {
          $a2_detrend = $_POST['a2_detrend'];
        } else {
          echo "<p>detrend has invalid characters.</p>";
          $a2_valid = false;
        }

        // pearsonrms must be 1 numeric characters
        if(preg_match('/^[0-9]{1,2}$/', $_POST['a2_pearsonrms'])) {
          $a2_pearsonrms = $_POST['a2_pearsonrms'];
        } else {
          echo "<p>pearsonrms has invalid characters.</p>";
          $a2_valid = false;
        }


        // howmanyyears must be 1 numeric characters
        if(preg_match('/^[0-9]{1,2}$/', $_POST['a2_howmanyyears'])) {
          $a2_howmanyyears = $_POST['a2_howmanyyears'];
        } else {
          echo "<p>howmanyyears has invalid characters.</p>";
          $a2_valid = false;
        }

        // ID must be 1-3 numeric characters
        //if(preg_match('/^[0-9]{1,3}$/', $_POST['ID'])) {
        //  $ID = $_POST['ID'];
        //} else {
        //  echo "<p>ID has invalid characters.</p>";
        //  $valid = false;
        //}

        // heightlev must be 1-2 numeric characters
        if(preg_match('/^[0-9]{1,2}$/', $_POST['a2_heightlev'])) {
          $a2_heightlev = $_POST['a2_heightlev'];
        } else {
          echo "<p>heightlev has invalid characters.</p>";
          $a2_valid = false;
        }

        // templev must be 1-2 numeric characters
        if(preg_match('/^[0-9]{1,2}$/', $_POST['a2_templev'])) {
          $a2_templev = $_POST['a2_templev'];
        } else {
          echo "<p>templev has invalid characters.</p>";
          $a2_valid = false;
        }

        // manualyesno must be 1-2 numeric characters
        if(preg_match('/^[0-9]{1,2}$/', $_POST['a2_manualyesno'])) {
          $a2_manualyesno = $_POST['a2_manualyesno'];
        } else {
          echo "<p>manualyesno has invalid characters.</p>";
          $a2_valid = false;
        }


        // Year must be exactly 4 numeric characters.
        if(preg_match('/^[0-9]{4}$/', $_POST['a2_manyear1'])) {
          $a2_manyear1 = $_POST['a2_manyear1'];
        } else {
          echo "<p>manyear1 has invalid characters.</p>";
          $a2_valid = false;
        }

        // Year must be exactly 4 numeric characters.
        if(preg_match('/^[0-9]{4}$/', $_POST['a2_manyear2'])) {
          $a2_manyear2 = $_POST['a2_manyear2'];
        } else {
          echo "<p>manyear2 has invalid characters.</p>";
          $a2_valid = false;
        }

        // Year must be exactly 4 numeric characters.
        if(preg_match('/^[0-9]{4}$/', $_POST['a2_manyear3'])) {
          $a2_manyear3 = $_POST['a2_manyear3'];
        } else {
          echo "<p>manyear3 has invalid characters.</p>";
          $a2_valid = false;
        }

        // Year must be exactly 4 numeric characters.
        if(preg_match('/^[0-9]{4}$/', $_POST['a2_manyear4'])) {
          $a2_manyear4 = $_POST['a2_manyear4'];
        } else {
          echo "<p>manyear4 has invalid characters.</p>";
          $a2_valid = false;
        }

        // Year must be exactly 4 numeric characters.
        if(preg_match('/^[0-9]{4}$/', $_POST['a2_manyear5'])) {
          $a2_manyear5 = $_POST['a2_manyear5'];
        } else {
          echo "<p>manyear5 has invalid characters.</p>";
          $a2_valid = false;
        }




        // eofnlat must be 1-3 numeric characters
        if(preg_match('/^[\-0-9]{1,3}$/', $_POST['a2_eofnlat'])) {
          $a2_eofnlat = $_POST['a2_eofnlat'];
        } else {
          echo "<p>eofnlat has invalid characters.</p>";
          $a2_valid = false;
        }

        // eofslat must be 1-3 numeric characters
        if(preg_match('/^[\-0-9]{1,3}$/', $_POST['a2_eofslat'])) {
          $a2_eofslat = $_POST['a2_eofslat'];
        } else {
          echo "<p>eofslat has invalid characters.</p>";
          $a2_valid = false;
        }

        // eofllon must be 1-3 numeric characters
        if(preg_match('/^[0-9]{1,3}$/', $_POST['a2_eofllon'])) {
          $a2_eofllon = $_POST['a2_eofllon'];
        } else {
          echo "<p>eofllon has invalid characters.</p>";
          $a2_valid = false;
        }

        // eofrlon must be 1-3 numeric characters
        if(preg_match('/^[0-9]{1,3}$/', $_POST['a2_eofrlon'])) {
          $a2_eofrlon = $_POST['a2_eofrlon'];
        } else {
          echo "<p>eofrlon has invalid characters.</p>";
          $a2_valid = false;
        }


        // eofvariable must be 1 numeric characters
        if(preg_match('/^[0-9]{1}$/', $_POST['a2_eofvariable'])) {
          $a2_eofvariable = $_POST['a2_eofvariable'];
        } else {
          echo "<p>eofvariable has invalid characters.</p>";
          $a2_valid = false;
        }


        // indexchoice must be 1 numeric characters
        if(preg_match('/^[0-9]{1}$/', $_POST['a2_indexchoice'])) {
          $a2_indexchoice = $_POST['a2_indexchoice'];
        } else {
          echo "<p>indexchoice has invalid characters.</p>";
          $a2_valid = false;
        }





        $a2_ID = rand(201,999);





$a2_command = 'ncl';
$a2_output = `ps -e -o pid,cmd,etimes`;
$a2_regex = '/^\s*([0-9]+)\s+ncl\s+\S+\s+([0-9]+)$/m';

$a2_regex2 = '/^\s*([0-9]+)\s+\/home\/bbrettschneider\/ncl\-6\s+([0-9]+)$/m';echo '<br>';

$a2_valid2=true;
if(preg_match_all($a2_regex2, $a2_output, $a2_matches, PREG_SET_ORDER)) {
  foreach($a2_matches as $a2_match) {

    $a2_pid = $a2_match[1];
    $a2_elapsed_seconds = $a2_match[2];
    //print 'pid = '.$a2_pid.' was started '.$a2_elapsed_seconds.' seconds ago';echo '<br>';
    if($a2_elapsed_seconds < 250) {
      $a2_valid2=false;
      //print 'Process started '.$a2_elapsed_seconds.' seconds ago.';
    }
  }
}

//print $a2_matches[0][0];
$a2_matchesexist = $a2_matches[0][0];

//$a2_valid2=false;

if($a2_matchesexist){
  if($a2_valid2==false){
    $a2_valid=false;
    echo '<br>';
    print 'There is another process running, please try again in a few minutes.';
    echo '<br>';
  }
} 





         // Only execute system command if inputs are valid.
        if($a2_valid) {
          // Run a system command, like running a command from a terminal.
          // It's safe to use $a2_year and $a2_month here because we know they are
          // purely numeric strings of appropriate lengths. The 2>&1 part at
          // the end redirects stderr into stdout. It makes it possible to see
          // error messages from the system command during development.

          //exec("/bin/echo \"$a2_year $a2_layer\" 2>&1", $a2_output);

          putenv("NCARG_ROOT=/home/bbrettschneider/ncl-6.3.0");
          putenv("NCARG_NCARG=/home/bbrettschneider/ncl-6.3.0/lib/ncarg");
          putenv("NCARG_COLORMAPS=/home/bbrettschneider/ncl-6.3.0/lib/ncarg/colormaps");

          if ($a2_indexchoice>=4) $a2_eofbox = 1;
          if ($a2_indexchoice<=3) $a2_eofbox = 0;
          if ($a2_pearsonrms == 0) exec("/home/bbrettschneider/ncl-6.3.0/bin/ncl -n -Q fromweb=\"1\"  txtareayesno=\"2\"  eofbox=\"$a2_eofbox\" eofnlat=\"$a2_eofnlat\" eofslat=\"$a2_eofslat\" eofllon=\"$a2_eofllon\" eofrlon=\"$a2_eofrlon\" eofvariable=\"$a2_eofvariable\" detrend=\"$a2_detrend\" howmanyyears=\"$a2_howmanyyears\" heightlev=\"$a2_heightlev\" templev=\"$a2_templev\" seaiceyesno=\"0\" manualyesno=\"$a2_manualyesno\" manyear1=\"$a2_manyear1\" manyear2=\"$a2_manyear2\" manyear3=\"$a2_manyear3\" manyear4=\"$a2_manyear4\" manyear5=\"$a2_manyear5\" variable=\"$a2_variable\" useryear=\"$a2_useryear\" fmnths=\"$a2_fmnths\" fmnths2=\"$a2_fmnths2\" slpwgt1=\"$a2_slpwgt1\" h500wgt1=\"$a2_h500wgt1\" t2mwgt1=\"$a2_t2mwgt1\" t925wgt1=\"$a2_t925wgt1\" sstwgt1=\"$a2_sstwgt1\" icewgt1=\"100\" indexchoice=\"$a2_indexchoice\" autoWgt=\"$a2_autoWgt\" y1=\"$a2_y1\" y2=\"$a2_y2\" x1=\"$a2_x1\" x2=\"$a2_x2\" AK1=\"$a2_AK1\" AK2=\"$a2_AK2\" AK3=\"$a2_AK3\" AK4=\"$a2_AK4\" usermonth=\"$a2_usermonth\" exmth=\"$a2_exmth\" justcorrelations=\"$a2_justcorrelations\" ID=\"$a2_ID\" specialnum=\"99\" /home/bbrettschneider/SeaIceSelectPercents4bRMS.ncl", $a2_output);

          if ($a2_pearsonrms == 1){
            if ($a2_fmnths2 == 1){
              exec("/home/bbrettschneider/ncl-6.3.0/bin/ncl -n -Q fromweb=\"1\" eofbox=\"$a2_eofbox\" eofnlat=\"$a2_eofnlat\" eofslat=\"$a2_eofslat\" eofllon=\"$a2_eofllon\" eofrlon=\"$a2_eofrlon\" eofvariable=\"$a2_eofvariable\" detrend=\"$a2_detrend\" howmanyyears=\"$a2_howmanyyears\" heightlev=\"$a2_heightlev\" templev=\"$a2_templev\" seaiceyesno=\"0\" manualyesno=\"$a2_manualyesno\" manyear1=\"$a2_manyear1\" manyear2=\"$a2_manyear2\" manyear3=\"$a2_manyear3\" manyear4=\"$a2_manyear4\" manyear5=\"$a2_manyear5\" variable=\"$a2_variable\" useryear=\"$a2_useryear\" fmnths=\"$a2_fmnths\" fmnths2=\"$a2_fmnths2\" slpwgt1=\"$a2_slpwgt1\" h500wgt1=\"$a2_h500wgt1\" t2mwgt1=\"$a2_t2mwgt1\" t925wgt1=\"$a2_t925wgt1\" sstwgt1=\"$a2_sstwgt1\" icewgt1=\"100\" indexchoice=\"$a2_indexchoice\" autoWgt=\"$a2_autoWgt\" y1=\"$a2_y1\" y2=\"$a2_y2\" x1=\"$a2_x1\" x2=\"$a2_x2\" AK1=\"$a2_AK1\" AK2=\"$a2_AK2\" AK3=\"$a2_AK3\" AK4=\"$a2_AK4\" usermonth=\"$a2_usermonth\" exmth=\"$a2_exmth\" ID=\"$a2_ID\" specialnum=\"99\" /home/bbrettschneider/SeaIceSelectPercents4bPearson.ncl", $a2_output);
            }
          }

          if ($a2_pearsonrms == 1){
            if ($a2_fmnths2 > 1){
              echo "<p>With the Pearsons option, the months to forecast has to equal 1</p>";
            }
          }

          //echo "<p>Layer options 10 and higher take aboput 2 minutes.</p>";
          //echo "<p>Wait for completion message at bottom. DO NOT REFRESH.</p>";

          // Display the output (and errors) from the system command. This is
          // strictly for development. Once the command is working as intended,
          // these three lines should be removed or commented out to avoid
          // showing the raw system output to the user.

          $linkbig1 =  "/maps/cor_big1.jpg";         
          $linkbig2 =  "/maps/cor_big2.jpg"; 
          $linkbig3 =  "/maps/MultipleR.jpg"; 
          $linkbig4 =  "/maps/SingleRSLP.jpg"; 
          $linkbig5 =  "/maps/SingleRH500.jpg"; 
          $linkbig6 =  "/maps/SingleRT2M.jpg"; 
          $linkbig7 =  "/maps/SingleRT925.jpg"; 
          $linkbig8 =  "/maps/SingleRSST.jpg"; 
          $width = "646";        
          $height = "800";        

          //echo "<p>Command output:</p>";
          $a2_combined = implode("<br>", $a2_output);
          echo $a2_combined;

          if ($a2_variable != 0) echo "<br>Click <a href=\"analogoutput.php\" target=\"_blank\">Here</a> for analog output and forecast - may need to refresh linked page.<br>";
          //if ($a2_variable > 15) echo "<br>Click <a href=\"correlations.php\" target=\"_blank\">Here</a> for correlation maps - may need to refresh linked page.<br>";
          if ($a2_indexwgt > 0) echo "<br>Click <a href=\"eofs.php\" target=\"_blank\">Here</a> for EOF maps and EOF time series - may need to refresh linked page.<br><br>";
          if ($a2_justcorrelations > 0 && $a2_justcorrelations < 3 && a2_variable<=6) echo "<img src=\"$linkbig1\" width=\"$width\" height=\"$height\"><br>";
          if ($a2_justcorrelations > 0 && $a2_justcorrelations < 3 && a2_variable<=6) echo "<img src=\"$linkbig2\" width=\"$width\" height=\"$height\"><br>";
          if ($a2_justcorrelations > 2)  echo "<br><br>Click <a href=\"correlationsnew.php\" target=\"_blank\">Here</a> for correlation maps - may need to refresh linked page.<br>";

 
        }
      }
    ?>


  </body>
</html>

