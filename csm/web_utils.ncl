;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Get web layer name
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("getlayername")
function getlayername( num:integer)
local lName
begin

  if(num .eq. -1) then 
    lName = "end" 
  end if
  if(num .eq. 0) then 
    lName = "end" 
  end if


  if(num .eq. 1) then 
    lName = "airtemp" 
  end if
  if(num .eq. 2) then 
    lName = "t2m" 
  end if
  if(num .eq. 3) then 
    lName = "skin" 
  end if
  if(num .eq. 4) then 
    lName = "giss" 
  end if
  if(num .eq. 5) then 
    lName = "berkeley" 
  end if
  if(num .eq. 6) then 
    lName = "ersst" 
  end if
  if(num .eq. 7) then 
    lName = "oisst" 
  end if
  if(num .eq. 8) then 
    lName = "heat105" 
  end if
  if(num .eq. 9) then 
    lName = "heat303" 
  end if
  if(num .eq. 10) then 
    lName = "slp" 
  end if
  if(num .eq. 11) then 
    lName = "pres_height" 
  end if
  if(num .eq. 12) then 
    lName = "pres_temp" 
  end if
  if(num .eq. 13) then 
    lName = "thickness" 
  end if
  if(num .eq. 14) then 
    lName = "stability" 
  end if
  if(num .eq. 15) then 
    lName = "wind" 
  end if
  if(num .eq. 16) then 
    lName = "uwind" 
  end if
  if(num .eq. 17) then 
    lName = "vwind" 
  end if
  if(num .eq. 18) then 
    lName = "shear" 
  end if
  if(num .eq. 19) then 
    lName = "pw" 
  end if
  if(num .eq. 20) then 
    lName = "precipanom" 
  end if
  if(num .eq. 21) then 
    lName = "preciprate" 
  end if
  if(num .eq. 22) then 
    lName = "rh" 
  end if
  if(num .eq. 23) then 
    lName = "sh" 
  end if
  if(num .eq. 24) then 
    lName = "clouds" 
  end if
  if(num .eq. 25) then 
    lName = "tropopause" 
  end if
  if(num .eq. 26) then 
    lName = "enthalpy" 
  end if
  if(num .eq. 27) then 
    lName = "potvel" 
  end if
  if(num .eq. 28) then 
    lName = "cen20th" 
  end if

  return(lName)
end
;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Get label
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("getlabel")
function getlabel( name:string, num:integer, num2:integer)
local comp, lNum
begin
  comp = 99
  if(name.eq."end") then
    lNum = "End"
    comp = 1
  end if
  if(name.eq."t2m") then
    lNum = "T2M"
    comp = 1
  end if
  if(name.eq."slp") then
    lNum = "SLP"
    comp = 1
  end if
  if(name.eq."pw") then
    lNum = "Precip_Water"
    comp = 1
  end if
;  if(name.eq."rh") then
;    lNum = "Rel_Humidity"+"_"+num
;    comp = 1
;  end if
  if(name.eq."shear") then
    lNum = "Shear"+"_"+num+"_"+num2
    comp = 1
  end if
  if(name.eq."comb") then
    lNum = "SST_T2M"
    comp = 1
  end if
  if(name.eq."heat") then
    lNum = "OceanicHeat"
    comp = 1
  end if
  if(name.eq."skin") then
    lNum = "Skin"
    comp = 1
  end if
  if(name.eq."ersst") then
    lNum = "ERSST"
    comp = 1
  end if
  if(name.eq."ersst") then
    lNum = "ERSST2"
    comp = 1
  end if
  if(name.eq."giss") then
    lNum = "GISS"
    comp = 1
  end if
  if(name.eq."noaa") then
    lNum = "NOAA"
    comp = 1
  end if
  if(name.eq."potvel") then
    lNum = "Potential_Velocity"
    comp = 1
  end if
  if(name.eq."wind") then
    lNum = "Wind"+"_"+num
    comp = 1
  end if
  if(name.eq."thickness") then
    lNum = "Hgt_Diff"+"_"+num+"_"+num2
    comp = 1
  end if
  if(name.eq."stability") then
    lNum = "Temp_Diff"+"_"+num+"_"+num2
    comp = 1
  end if

  if(name.eq."clouds") then
    lNum = "Clouds"
    comp = 1
  end if

  if(name.eq."precip") then
    lNum = "Precip_Rate"
    comp = 1
  end if

  if(name.eq."Enthalpy") then
    lNum = "Enthalpy"
    comp = 1
  end if

  if(comp.eq.99) then
    if(num .eq. 0) then 
      lNum = "1000mb"
    end if
    if(num .eq. 1) then 
      lNum = "925mb" 
    end if
    if(num .eq. 2) then 
      lNum = "850mb" 
    end if
    if(num .eq. 3) then 
      lNum = "700mb" 
    end if
    if(num .eq. 4) then 
      lNum = "600mb" 
    end if
    if(num .eq. 5) then 
      lNum = "500mb" 
    end if
    if(num .eq. 6) then 
      lNum = "400mb" 
    end if
    if(num .eq. 7) then 
      lNum = "300mb" 
    end if
    if(num .eq. 8) then 
      lNum = "250mb" 
    end if
    if(num .eq. 9) then 
      lNum = "200mb" 
    end if
    if(num .eq. 10) then 
      lNum = "150mb" 
    end if
    if(num .eq. 11) then 
      lNum = "100mb" 
    end if
    if(num .eq. 12) then 
      lNum = "70mb" 
    end if
    if(num .eq. 13) then 
      lNum = "50mb" 
    end if
    if(num .eq. 14) then 
      lNum = "30mb" 
    end if
    if(num .eq. 15) then 
      lNum = "20mb" 
    end if
    if(num .eq. 16) then 
      lNum = "10mb" 
    end if
    if(num .gt. 99) then 
      lNum = num+"mb" 
    end if
  end if
  return(lNum)
end
;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Get level number
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("maptype")
function maptype( num:integer)
begin
  if(num.eq.-1) then
    return("C")
  end if
  if(num.eq.1) then
    return("C")
  end if
  if(num.eq.2) then
    return("P")
  end if
  if(num.eq.3) then
    return("L")
  end if

end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Get pressure level
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("getlev")
function getlev( num:integer)
local comp, lNum
begin
    if(num .eq. 0) then 
      lNum = "1000mb"
    end if
    if(num .eq. 1) then 
      lNum = "925mb" 
    end if
    if(num .eq. 2) then 
      lNum = "850mb" 
    end if
    if(num .eq. 3) then 
      lNum = "700mb" 
    end if
    if(num .eq. 4) then 
      lNum = "600mb" 
    end if
    if(num .eq. 5) then 
      lNum = "500mb" 
    end if
    if(num .eq. 6) then 
      lNum = "400mb" 
    end if
    if(num .eq. 7) then 
      lNum = "300mb" 
    end if
    if(num .eq. 8) then 
      lNum = "250mb" 
    end if
    if(num .eq. 9) then 
      lNum = "200mb" 
    end if
    if(num .eq. 10) then 
      lNum = "150mb" 
    end if
    if(num .eq. 11) then 
      lNum = "100mb" 
    end if
    if(num .eq. 12) then 
      lNum = "70mb" 
    end if
    if(num .eq. 13) then 
      lNum = "50mb" 
    end if
    if(num .eq. 14) then 
      lNum = "30mb" 
    end if
    if(num .eq. 15) then 
      lNum = "20mb" 
    end if
    if(num .eq. 16) then 
      lNum = "10mb" 
    end if
  return(lNum)
end
;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Get pressure level
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("getlevvalue")
function getlevvalue( num:integer)
local comp, lNum
begin
    if(num .eq. 0) then 
      lNum = "1000"
    end if
    if(num .eq. 1) then 
      lNum = "925" 
    end if
    if(num .eq. 2) then 
      lNum = "850" 
    end if
    if(num .eq. 3) then 
      lNum = "700" 
    end if
    if(num .eq. 4) then 
      lNum = "600" 
    end if
    if(num .eq. 5) then 
      lNum = "500" 
    end if
    if(num .eq. 6) then 
      lNum = "400" 
    end if
    if(num .eq. 7) then 
      lNum = "300" 
    end if
    if(num .eq. 8) then 
      lNum = "250" 
    end if
    if(num .eq. 9) then 
      lNum = "200" 
    end if
    if(num .eq. 10) then 
      lNum = "150" 
    end if
    if(num .eq. 11) then 
      lNum = "100" 
    end if
    if(num .eq. 12) then 
      lNum = "70" 
    end if
    if(num .eq. 13) then 
      lNum = "50" 
    end if
    if(num .eq. 14) then 
      lNum = "30" 
    end if
    if(num .eq. 15) then 
      lNum = "20" 
    end if
    if(num .eq. 16) then 
      lNum = "10" 
    end if
  return(lNum)
end
;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;


