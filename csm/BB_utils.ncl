;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Very simple routine to give
;; a month numnber a text name
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("month_Name")
function month_Name( x:integer)
local mName
begin
  mNum = x                               
  if(mNum .eq. 1) then 
    mName = "Jan" 
  end if
  if(mNum .eq. 2) then
   mName = "Feb"
  end if
  if(mNum .eq. 3) then 
    mName = "Mar" 
  end if
  if(mNum .eq. 4) then
   mName = "Apr"
  end if
  if(mNum .eq. 5) then 
    mName = "May" 
  end if
  if(mNum .eq. 6) then
   mName = "Jun"
  end if
  if(mNum .eq. 7) then 
    mName = "Jul" 
  end if
  if(mNum .eq. 8) then
   mName = "Aug"
  end if
  if(mNum .eq. 9) then 
    mName = "Sep" 
  end if
  if(mNum .eq. 10) then
   mName = "Oct"
  end if
  if(mNum .eq. 11) then 
    mName = "Nov" 
  end if
  if(mNum .eq. 12) then
   mName = "Dec"
  end if
  if(mNum .ge. 13) then
   mName = "Unk"
  end if
  return(mName)
end
;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Computes the rank of the top 5 average forecasts
; with the actual (verified) forecats. Can never be
; in first or last place because it's a 5 month average.
; the number represents the percentage of actual
; analog forecast that the 5-average beat.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("myRank")
function myRank( x:numeric, y:numeric)
local avgr, cntr, sum, xxxx, sizes, ee, theRank, comp
begin
  comp = tofloat(y)
  xxx = x
  xxxx = dim_pqsort_n(xxx,2,0)
  sizes = dimsizes(x)
  theRank = 0.
  do ee = 0, sizes-1
    if (.not.ismissing(xxx(ee)) .and. comp.gt.xxx(ee)) then
      ;print(comp + "  ,  "+xxxx(ee))
      theRank = ee
    end if
  end do
  theRank = 100 - ((theRank + 1) / (sizes - 2) / 1.0 * 100)
  return(theRank)

end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Performs a Monte Carlo simulation to determin
; the rank of the top 5 average forecasts with 5 randomly
; selected monthly outcomes.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("MonteCarloRank")
function MonteCarloRank( x:numeric, y:numeric)
local avgr, cntr, sum, xxxx, sizes, ee, theRank, comp, ddd, iwo, countBetter, comp1, compAve
begin


ddd = x
sizes = dimsizes(x)
countBetter = 0
totalCounter = 0
comp = tofloat(0)
to5Count = 0
compAve = 0.0


do ee = 0, 3
  iwo = new(sizes,integer)
  iwo = generate_unique_indices(sizes)
  ;iwo = generate_sample_indices(sizes, 0)
  do ff = 0, 6
    if (.not.ismissing(x(iwo(ff))) .and. x(iwo(ff)).gt.0 ) then
      to5Count = to5Count +1
      comp  = comp + x(iwo(ff))
      ;print("Random index = "+ iwo(ff)+" and value = "+x(iwo(ff)))
    end if
    if (to5Count.eq.5) then
      break
    end if
  end do
  comp = comp / 5.0
  compAve = compAve + comp
  ;print("to5Count = "+to5Count+"     ff = "+ff+"  comp = "+comp)
  to5Count=0
  if (y.lt.comp) then
    countBetter = countBetter + 1
  end if
  totalCounter = totalCounter + 1
end do

compAve = compAve / 25
;print("Average of Simulations is = "+sprintf("%6.3f",compAve))

avgr = tofloat(countBetter) / tofloat(totalCounter) * 100
return(avgr)

end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Performs a Monte Carlo simulation to determin
; the rank of the top 5 average forecasts with 5 randomly
; selected monthly outcomes.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("MonteCarloRank2")
function MonteCarloRank2( x:numeric, y:numeric, numAnalogs:numeric)
local avgr, cntr, sum, xxxx, sizes, ee, theRank, comp, ddd, iwo, countBetter, comp1, compAve, rr, eee, theFiveYears
begin

ddd = x
sizes = dimsizes(x)


;print(x+"")
;print(y+"")

validCnt = 0


if  (ismissing(x(sizes-1))) then
  eee = new(sizes-1,float)
end if
if  (.not.ismissing(x(sizes-1))) then
  eee = new(sizes,float)
end if

index = 0
do rr=0,sizes-1
  if (ddd(rr).gt.0) then
    eee(index) = ddd(rr)
    index = index + 1
  end if
end do
sizes = dimsizes(eee)


newSizes = sizes
if  (ismissing(eee(sizes-1))) then
  newSizes = newSizes - 1   ; if this is 1, then the last value of eee is missing.
end if


countBetter = 0
totalCounter = 0
comp = tofloat(0)
to5Count = 0
compAve = 0.0
iterations = 5000



do ee = 0, iterations - 1
  comp = 0
  iwo = new(newSizes,integer)
  iwo = generate_unique_indices(newSizes)


  comp  = (eee(iwo(0)) + eee(iwo(1)) + eee(iwo(2)) + eee(iwo(3)) + eee(iwo(4))) / 5.0
  if (numAnalogs.eq.1) then
    comp  = (eee(iwo(0))) / 1.0
  end if
  if (numAnalogs.eq.2) then
    comp  = (eee(iwo(0)) + eee(iwo(1))) / 2.0
  end if
  if (numAnalogs.eq.3) then
    comp  = (eee(iwo(0)) + eee(iwo(1)) + eee(iwo(2))) / 3.0
  end if
  if (numAnalogs.eq.4) then
    comp  = (eee(iwo(0)) + eee(iwo(1)) + eee(iwo(2)) + eee(iwo(3))) / 4.0
  end if
  ;print("Indicies = "+","+iwo(0)+","+iwo(1)+","+iwo(2)+","+iwo(3)+","+iwo(4))
  compAve = compAve + comp
  if (y.lt.comp) then
    countBetter = countBetter + 1
  end if
  totalCounter = totalCounter + 1
  delete(iwo)
end do

compAve = compAve / iterations
;print("Average of Simulations is = "+sprintf("%6.3f",compAve))

avgr = tofloat(countBetter) / tofloat(iterations) * 100

  return(avgr)




end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Finds the rank of the 5 selected analog years
; if there is a final verification to evaluate 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("VerificationRanks")
function VerificationRanks( x:numeric, y1:numeric, y2:numeric, y3:numeric, y4:numeric, y5:numeric )
local avgr, cntr, sum, xxxx, sizes, ee, theRank, comp, ddd, iwo, countBetter, comp1, compAve, rr, eee, theFiveYears, theFiveRanks
begin


theFiveRanks = new(5,integer)
theFiveYears = new(5,integer)
theFiveYears(0) = toint(y1)
theFiveYears(1) = toint(y2)
theFiveYears(2) = toint(y3)
theFiveYears(3) = toint(y4)
theFiveYears(4) = toint(y5)

ddd = x
sizes = dimsizes(x)


;print("x =")
;print(""+x)
;print("")
;print("y =")
;print(""+y)
;print("")
;print("ddd =")
;print(ddd+"")
;print("")
;print("sizes = "+sizes)
;print("")



if  (ismissing(x(sizes-1))) then
  eee = new(sizes-1,float)
end if
if  (.not.ismissing(x(sizes-1))) then
  eee = new(sizes,float)
end if


index = 0
do rr=0,sizes-1
  if (ddd(rr).gt.0) then
    eee(index) = ddd(rr)
    index = index + 1
  end if
end do
sizes = dimsizes(eee)



ord1 = eee
ord2 = dim_pqsort_n(ord1,2,0)
;print("ord2 = ")
;print(ord1+","+ord2)
do pp=0,4
  comp = theFiveYears(pp) - 1949
  do qq=0,sizes-1
    if(comp.eq.toint(ord2(qq))) then
      comp1 = qq+1
      theFiveRanks(pp) = comp1
      ;print("Rank for "+theFiveYears(pp)+" = "+comp1)
    end if
  end do
end do


return(theFiveRanks)


end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Finds the rank of the 5 selected analog years
; if there is a final verification to evaluate 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("VerificationRanks2")
function VerificationRanks2( x:numeric, y1:numeric )
local avgr, cntr, sum, xxxx, sizes, ee, theRank, comp, ddd, iwo, countBetter, comp1, compAve, rr, eee, theFiveYears, theRank
begin




ddd = x
sizes = dimsizes(x)
;;;eee = new(sizes-1,float)
eee = ddd


sizes = dimsizes(eee)




ord1 = eee
ord2 = dim_pqsort_n(ord1,2,0)

;print(y1+"")
;print(ord1+"  "+ord2)
;exit

  comp = toint(y1) - 1949

  theRank=999

if(.not.ismissing(comp)) then

  do qq=0,sizes-1
    ;print("compare = "+comp+ "ord2(qq) = "+ord2(qq))
      if(comp.eq.toint(ord2(qq))) then
        comp1 = qq+1
        theRank = comp1
        ;print("Rank for "+toint(y1)+" = "+comp1)
      end if
  end do
end if


;exit

return(theRank-1)


end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to calculate weighted averages 
;;; that account for latitudinal convergence.
;;; The value of each lat/lon point is multiplied
;;; by the cosine of the latitude. All adjusted
;;; values are then summed but the new 'n' 
;;; denominator is the sum of cos(lat).
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("W_ave")
function W_ave( x:numeric, ind1:integer, ind2:integer, lat1:integer, lat2:integer,lon1:integer, lon2:integer)
local avgr, rad, clat, coslatsum, pointsum, q, r, s, theArray, thelat, thelon, thedims, timedims, latdims, londims, theCounter
begin

  ;print(dimsizes(x))
  ;print(lat1+"  "+lat2+"  "+lon1+"  "+lat2)
  theArray = x(ind1:ind2,{lat1:lat2},{lon1:lon2})
  
  theCounter = 0

  thelat = theArray&lat
  thelon = theArray&lon
  ;thetime = theArray&time
  thedims = dimsizes(theArray)
  timedims = thedims(0)
  latdims = thedims(1)
  londims = thedims(2)


  rad    = 4.*atan(1.)/180.
  clat   = thelat           
  clat   = sqrt( cos(rad*clat) )               
  coslatsum = 0.
  pointsum = 0.
  q = 0
  r = 0
  s = 0

  do q=0, timedims -1
    do r=0, latdims -1
      do s=0, londims -1
        if(thelat(r).lt.90) then
          if (.not.ismissing(theArray(q,r,s))) then
            theCounter = theCounter + 1
            coslatsum = coslatsum + cos(rad*thelat(r))
            pointsum = pointsum + (cos(rad*thelat(r)) * theArray(q,r,s))
          end if
        end if
      end do
    end do
  end do

  if (theCounter.gt.0) then
    avgr = pointsum / coslatsum / 1.
  end if

  if (theCounter.eq.0) then
    avgr = -999.
  end if


  return(avgr)
end
;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to calculate weighted averages 
;;; that account for latitudinal convergence.
;;; The value of each lat/lon point is multiplied
;;; by the cosine of the latitude. All adjusted
;;; values are then summed but the new 'n' 
;;








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to calculate Pearson's R from two 1D arrays 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("R_value")
function R_value( x:numeric, y:numeric)
local R, n, n1 , sumx, sumy, sumxy, sumx2, sumy2, numerator, denominator1, denominator2, temp1
begin
  n1 = dimsizes(x)
  if(dimsizes(x).ne.dimsizes(y)) then  
    print("Houston, we have a problem in the R_value script!")
  end if

  sumx = todouble(0)
  sumy = todouble(0)
  sumxy = todouble(0)
  sumx2 = todouble(0)
  sumy2 = todouble(0)
  n = 0

  do v = 0, n1 - 1
    if (.not.ismissing(x(v)) .and. .not.ismissing(y(v))) then
      n = n+1
      ;print("Index = "+v+"   x = "+x(v)+"   y = "+y(v))
      sumx = sumx + x(v)
      sumy = sumy + y(v)
      sumxy = sumxy + (x(v) * y(v))
      sumx2 = sumx2 + (x(v)*x(v))
      sumy2 = sumy2 + (y(v)*y(v)) 
    end if
  end do


  numerator = (n*sumxy) - (sumx*sumy)
  denominator1 = sqrt((n*sumx2)-(sumx*sumx))
  denominator2 = (sqrt((n*sumy2)-(sumy*sumy)))

  if(denominator1.gt.0 .and. denominator2.gt.0)
    R = numerator / (denominator1*denominator2)
  end if

  if(denominator1.eq.0 .or. denominator2.eq.0)
    R = 9999.
  end if



  return(R)
end
;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to calculate Pearson's R from two 1D arrays 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("R_value2")
function R_value2( b:numeric, red:numeric )
local R, n, d, n1 , n2, sumx, sumy, sumxy, sumx2, sumy2, numerator, denominator1, denominator2, temp1, newblue
begin

  n1 = dimsizes(b)
  n2 = dimsizes(red)

  ; make sure arraws are the same size
  blue=new(n2,float)
  do d=0,n2-1
    blue(d) = b(d+1)
  end do


  if(dimsizes(blue).ne.dimsizes(red)) then  
    print("Houston, we have a problem in the R_value2 script!")
  end if

  sumx = todouble(0)
  sumy = todouble(0)
  sumxy = todouble(0)
  sumx2 = todouble(0)
  sumy2 = todouble(0)
  n = 0

  do v = 0, n2 - 1
    n = n+1
    if (.not.ismissing(blue(v)) .and. .not.ismissing(red(v)) .and. blue(v)>-500 .and. red(v)>-500  ) then
      sumx = sumx + blue(v)
      sumy = sumy + red(v)
      sumxy = sumxy + (blue(v) * red(v))
      sumx2 = sumx2 + (blue(v)*blue(v))
      sumy2 = sumy2 + (red(v)*red(v)) 
    end if
  end do


  numerator = (n*sumxy) - (sumx*sumy)
  denominator1 = sqrt((n*sumx2)-(sumx*sumx))
  denominator2 = (sqrt((n*sumy2)-(sumy*sumy)))

  if(denominator1.gt.0 .and. denominator2.gt.0)
    R = numerator / (denominator1*denominator2)
  end if

  if(denominator1.eq.0 .or. denominator2.eq.0)
    R = 9999.
  end if

  return(R)
end
;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to calculate Pearson's R from two 1D arrays 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("R_value3")
function R_value3( blue:numeric, red:numeric )
local R, n, d, n1 , n2, sumx, sumy, sumxy, sumx2, sumy2, numerator, denominator1, denominator2, temp1, newblue
begin


  n1 = dimsizes(blue)
  n2 = dimsizes(red)




  if(dimsizes(blue).ne.dimsizes(red)) then  
    print("Houston, we have a problem in the R_value2 script!")
  end if

  sumx = todouble(0)
  sumy = todouble(0)
  sumxy = todouble(0)
  sumx2 = todouble(0)
  sumy2 = todouble(0)
  n = 0

  do v = 0, n2 - 1
    n = n+1
    if (.not.ismissing(blue(v)) .and. .not.ismissing(red(v)) .and. blue(v)>-500 .and. red(v)>-500  ) then
      sumx = sumx + blue(v)
      sumy = sumy + red(v)
      sumxy = sumxy + (blue(v) * red(v))
      sumx2 = sumx2 + (blue(v)*blue(v))
      sumy2 = sumy2 + (red(v)*red(v)) 
    end if
  end do


  numerator = (n*sumxy) - (sumx*sumy)
  denominator1 = sqrt((n*sumx2)-(sumx*sumx))
  denominator2 = (sqrt((n*sumy2)-(sumy*sumy)))

  if(denominator1.gt.0 .and. denominator2.gt.0)
    R = numerator / (denominator1*denominator2)
  end if

  if(denominator1.eq.0 .or. denominator2.eq.0)
    R = 9999.
  end if

  return(R)
end
;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to set graphics resources for a variable array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("SetRes1")
function SetRes1(val1:numeric, val2:numeric, val3:numeric, minlat:numeric, cenlon:numeric )
local Res1
begin
  Res1 = True
  Res1@cnLevelSelectionMode = "ManualLevels"	
  Res1@mpDataBaseVersion = "MediumRes"
  Res1@mpCenterLonF      =  cenlon
  Res1@gsnPolar             = "NH"
  Res1@mpMinLatF  = minlat

  Res1@gsnMaximize = True
  Res1@gsnFrame = False
  Res1@gsnDraw  = False
  Res1@mpOutlineBoundarySets     = "geophysicalandusstates"; turn on states
  Res1@mpDataBaseVersion         = "mediumres"             ; select database
  Res1@mpDataSetName             = "Earth..2"
  Res1@mpOutlineOn               = True              ; turn on outline
  Res1@mpUSStateLineThicknessF = 2.0
  Res1@mpGeophysicalLineThicknessF = 2.0
  Res1@cnFillOn                  = True             ; turn off map fill
  Res1@cnMonoFillPattern     = True     ; Turn solid fill back on.
  Res1@cnMonoFillColor       = False    ; Use multiple colors.
  Res1@cnLineLabelsOn        = False    ; Turn off line labels.
  Res1@cnInfoLabelOn         = False    ; Turn off informational
  Res1@cnLinesOn             = True    ; 
  Res1@tiXAxisJust          = "CenterCenter"
  Res1@tiXAxisJust          = "CenterCenter"
  Res1@cnMinLevelValF  = val1	
  Res1@cnMaxLevelValF  = val2	
  Res1@tiMainFontHeightF  = 0.013
  Res1@cnLevelSpacingF = val3
  return (Res1)
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to set graphics resources for a variable array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("SetRes1a")
function SetRes1a(val1:numeric, val2:numeric, val3:numeric )
local Res1
begin
  Res1 = True
  Res1@cnLevelSelectionMode = "ManualLevels"	
  Res1@mpDataBaseVersion = "MediumRes"
  Res1@mpCenterLonF      =  270
  ;Res1@mpCenterLonF      =  210
  Res1@gsnPolar             = "NH"
  Res1@mpMinLatF  = 20
  ;Res1@mpMinLatF  = 50
  Res1@gsnMaximize = True
  Res1@gsnFrame = False
  Res1@gsnDraw  = False
  Res1@mpOutlineBoundarySets     = "geophysicalandusstates"; turn on states
  Res1@mpDataBaseVersion         = "mediumres"             ; select database
  Res1@mpDataSetName             = "Earth..2"
  Res1@mpOutlineOn               = True              ; turn on outline
  Res1@mpUSStateLineThicknessF = 2.0
  Res1@mpGeophysicalLineThicknessF = 2.0
  Res1@cnFillOn                  = True             ; turn off map fill
  Res1@cnMonoFillPattern     = True     ; Turn solid fill back on.
  Res1@cnMonoFillColor       = False    ; Use multiple colors.
  Res1@cnLineLabelsOn        = False    ; Turn off line labels.
  Res1@cnInfoLabelOn         = False    ; Turn off informational
  Res1@cnLinesOn             = True    ; 
  Res1@tiXAxisJust          = "CenterCenter"
  Res1@tiXAxisJust          = "CenterCenter"
  Res1@cnMinLevelValF  = val1	
  Res1@cnMaxLevelValF  = val2	
  Res1@tiMainFontHeightF  = 0.013
  Res1@cnLevelSpacingF = val3
  return (Res1)
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to set graphics resources for a variable array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("SetRes1b")
function SetRes1b(val1:numeric, val2:numeric, val3:numeric )
local Res1
begin
  Res1 = True
  Res1@cnLevelSelectionMode = "ManualLevels"	
  Res1@mpDataBaseVersion = "MediumRes"
  Res1@mpCenterLonF      =  270
  ;Res1@mpCenterLonF      =  210
  Res1@gsnPolar             = "NH"
  Res1@mpMinLatF  = 20
  ;Res1@mpMinLatF  = 50
  Res1@gsnMaximize = True
  Res1@gsnFrame = False
  Res1@gsnDraw  = False
  Res1@mpOutlineBoundarySets     = "geophysicalandusstates"; turn on states
  Res1@mpDataBaseVersion         = "mediumres"             ; select database
  Res1@mpDataSetName             = "Earth..2"
  Res1@mpOutlineOn               = True              ; turn on outline
  Res1@mpUSStateLineThicknessF = 2.0
  Res1@mpGeophysicalLineThicknessF = 2.0
  Res1@cnFillOn                  = True             ; turn off map fill
  Res1@cnMonoFillPattern     = True     ; Turn solid fill back on.
  Res1@cnMonoFillColor       = False    ; Use multiple colors.
  Res1@cnLineLabelsOn        = False    ; Turn off line labels.
  Res1@cnInfoLabelOn         = False    ; Turn off informational
  Res1@cnLinesOn             = True    ; 
  Res1@tiXAxisJust          = "CenterCenter"
  Res1@tiXAxisJust          = "CenterCenter"
  Res1@cnMinLevelValF  = val1	
  Res1@cnMaxLevelValF  = val2	
  Res1@tiMainFontHeightF  = 0.013
  Res1@cnLevelSpacingF = val3
  return (Res1)
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to set graphics resources for a variable array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("SetRes1c")
function SetRes1c(val1:numeric, val2:numeric, val3:numeric, minlat:numeric, cenlon:numeric )
local Res1
begin
  Res1 = True
  Res1@cnLevelSelectionMode = "ManualLevels"	
  Res1@mpDataBaseVersion = "MediumRes"
  Res1@mpCenterLonF      =  cenlon
  if (minlat.ge.0) then
    Res1@gsnPolar             = "NH"
    Res1@mpMinLatF  = minlat
  end if
  if (minlat.lt.0) then
    Res1@gsnPolar             = "SH"
    Res1@mpMaxLatF  = minlat
  end if

  Res1@gsnMaximize = True
  Res1@gsnFrame = False
  Res1@gsnDraw  = False
  Res1@mpOutlineBoundarySets     = "geophysicalandusstates"; turn on states
  Res1@mpDataBaseVersion         = "mediumres"             ; select database
  Res1@mpDataSetName             = "Earth..2"
  Res1@mpOutlineOn               = True              ; turn on outline
  Res1@mpUSStateLineThicknessF = 2.0
  Res1@mpGeophysicalLineThicknessF = 2.0
  Res1@cnFillOn                  = True             ; turn off map fill
  Res1@cnMonoFillPattern     = True     ; Turn solid fill back on.
  Res1@cnMonoFillColor       = False    ; Use multiple colors.
  Res1@cnLineLabelsOn        = False    ; Turn off line labels.
  Res1@cnInfoLabelOn         = False    ; Turn off informational
  Res1@cnLinesOn             = True    ; 
  Res1@tiXAxisJust          = "CenterCenter"
  Res1@tiXAxisJust          = "CenterCenter"
  Res1@cnMinLevelValF  = val1	
  Res1@cnMaxLevelValF  = val2	
  Res1@tiMainFontHeightF  = 0.013
  Res1@cnLevelSpacingF = val3
  return (Res1)
end



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to set graphics resources for statistical significance levels (pos and neg)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("SetRes2")
function SetRes2(maptype:numeric )
local Res2
begin
  Res2 = True
  Res2@cnLevelSelectionMode = "ExplicitLevels"	
  Res2@mpDataBaseVersion = "MediumRes"
  Res2@mpCenterLonF      =  210
  if (maptype.eq.2) then
    Res2@mpMaxLatF  = 85
    Res2@mpMinLatF  = -80
  end if
  if (maptype.eq.1) then
    Res2@gsnPolar             = "NH"
    Res2@mpMinLatF  = 20
  end if
  Res2@gsnMaximize = True
  Res2@gsnFrame = False
  Res2@gsnDraw  = False
  Res2@mpOutlineBoundarySets     = "geophysicalandusstates"; turn on states
  Res2@mpDataBaseVersion         = "mediumres"             ; select database
  Res2@mpDataSetName             = "Earth..2"
  Res2@mpOutlineOn               = True              ; turn on outline
  Res2@mpUSStateLineThicknessF = 2.0
  Res2@mpGeophysicalLineThicknessF = 2.0
  Res2@cnFillOn                  = True             ; turn off map fill
  Res2@cnMonoFillPattern     = True     ; Turn solid fill back on.
  Res2@cnMonoFillColor       = False    ; Use multiple colors.
  Res2@cnLineLabelsOn        = False    ; Turn off line labels.
  Res2@cnInfoLabelOn         = False    ; Turn off informational
  Res2@cnLinesOn             = True    ; 
  Res2@tiXAxisJust          = "TopCenter"
  Res2@tiMainFontHeightF  = 0.015
  pmap = (/"(/0.50, 0.00, 0.00/)","(/1.00, 0.00, 0.00/)","(/1.00, 0.67, 0.00/)","(/1.00, 1.00, 0.00/)","(/1.00, 0.92, 0.46/)","(/0.83, 1.00, 0.74/)","(/0.15, 0.80, 0.35/)","(/0.74, 0.91, 1.00/)","(/0.00, 0.36, 0.90/)","(/1.00, 0.45, 0.87/)","(/0.90, 0.00, 0.66/)","(/0.66, 0.00, 0.52/)"/)  ; white left to red right
  pmap = pmap(::-1) ; reverse the color map 
  Res2@cnFillPalette = pmap
  Res2@cnLevels              =    (/-0.999,-0.99,-0.95,-0.9,-0.5,0,0.5,0.9,0.95,0.99,0.999/)
  Res2@lbLabelStrings   =     (/-1.0,-0.999,-0.99,-0.95,-0.9,-0.8,0,0.8,0.9,0.95,0.99,0.999,1.0/)  
  Res2@lbAutoManage = False
  Res2@tmXBLabelsOn=False
  Res2@tmYLLabelsOn=False
  Res2@tmYROn = False
  Res2@tmXTOn = False
  ;Res2@pmTicMarkDisplayMode="Always"
  
  Res2@mpGridAndLimbOn        = True               ; turn on lat/lon grid lines
  ;Res2@mpGridMaskMode         = "MaskNotOcean"     ; don't draw over land or.
  Res2@mpGridLineColor="grey33"
  Res2@mpGridLineDashPattern=2
  Res2@cnExplicitLabelBarLabelsOn = True
  Res2@cnLabelBarEndStyle    = "IncludeMinMaxLabels"


  return (Res2)
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to set graphics resources for a variable array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("SetRes3")
function SetRes3(val3:numeric, maptype:numeric, sigcor:string)
local Res1
begin
  Res1 = True
  Res1@cnLevelSelectionMode = "ManualLevels"	
  Res1@mpDataBaseVersion = "MediumRes"
  Res1@mpCenterLonF      =  240
  if (maptype.eq.2) then
    Res1@mpMaxLatF  = 85
    Res1@mpMinLatF  = -80
  end if
  if (maptype.eq.1) then
    Res1@gsnPolar             = "NH"
    Res1@mpMinLatF  = 20
  end if
  Res1@gsnMaximize = True
  Res1@gsnFrame = False
  Res1@gsnDraw  = False
  Res1@mpOutlineBoundarySets     = "geophysicalandusstates"; turn on states
  Res1@mpDataBaseVersion         = "mediumres"             ; select database
  Res1@mpDataSetName             = "Earth..2"
  Res1@mpOutlineOn               = True              ; turn on outline
  Res1@mpUSStateLineThicknessF = 2.0
  Res1@mpGeophysicalLineThicknessF = 2.0
  Res1@cnFillOn                  = True             ; turn off map fill
  Res1@cnMonoFillPattern     = True     ; Turn solid fill back on.
  Res1@cnMonoFillColor       = False    ; Use multiple colors.
  Res1@cnLineLabelsOn        = False    ; Turn off line labels.
  Res1@cnInfoLabelOn         = False    ; Turn off informational
  Res1@cnLinesOn             = True    ; 
  Res1@tiXAxisJust          = "CenterCenter"
  Res1@tiXAxisJust          = "CenterCenter"
  Res1@tiMainFontHeightF  = 0.015
  if (sigcor.eq."cor")
    Res1@cnMinLevelValF  = -0.5	
    Res1@cnMaxLevelValF  = 0.5	
    Res1@cnLevelSpacingF = 0.1
  end if
  if (sigcor.eq."sig")
    Res1@cnMinLevelValF  = -1.0	
    Res1@cnMaxLevelValF  = 1.0	
    pmap = (/"(/0.50, 0.00, 0.00/)","(/1.00, 0.00, 0.00/)","(/1.00, 0.67, 0.00/)","(/1.00, 1.00, 0.00/)","(/1.00, 0.92, 0.46/)","(/0.83, 1.00, 0.74/)","(/0.15, 0.80, 0.35/)","(/0.74, 0.91, 1.00/)","(/0.00, 0.36, 0.90/)","(/1.00, 0.45, 0.87/)","(/0.90, 0.00, 0.66/)","(/0.66, 0.00, 0.52/)"/)  ; white left to red right
    pmap = pmap(::-1) ; reverse the color map 
    Res1@cnFillPalette = pmap
    Res1@cnLevels              =    (/-0.999,-0.99,-0.95,-0.9,-0.5,0,0.5,0.9,0.95,0.99,0.999/)
    Res1@lbLabelStrings   =     (/-1.0,-0.999,-0.99,-0.95,-0.9,-0.8,0,0.8,0.9,0.95,0.99,0.999,1.0/)  
  end if
  return (Res1)
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to set graphics resources for a variable array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("SetRes4")
function SetRes4(val1:numeric)
local res2
begin
  res2 = True
  res2@cnLevelSelectionMode = "ManualLevels"	
  res2@mpDataBaseVersion = "MediumRes"
  res2@mpCenterLonF      =  240
  res2@gsnPolar             = "NH"
  res2@mpMinLatF  = 20
  res2@gsnMaximize = True
  res2@gsnFrame = False
  res2@gsnDraw  = False
  res2@mpOutlineBoundarySets     = "geophysicalandusstates"; turn on states
  res2@mpDataBaseVersion         = "mediumres"             ; select database
  res2@mpDataSetName             = "Earth..2"
  res2@mpLandFillColor = "grey50"
  res2@mpOceanFillColor = (/0.54, 0.82, 1.00/)
  res2@mpOceanFillColor = (/0.9, 0.9, 1.00/)
  res2@mpOutlineOn               = True              ; turn on outline
  res2@mpUSStateLineThicknessF = 2.0
  res2@mpGeophysicalLineThicknessF = 2.0
  res2@cnFillOn             = True                  ; turn on color fill
  res2@cnLinesOn            = False

  pmap = (/"(/0.90, 0.90, 0.90/)","(/0.80, 0.76, 0.76/)","(/0.98, 0.96, 0.75/)","(/0.93, 0.72, 1.00/)"/)  

  res2@cnMonoFillPattern     = True     ; Turn solid fill back on.
  res2@cnMonoFillColor       = False    ; Use multiple colors.
  res2@cnLineLabelsOn        = False    ; Turn off line labels.
  res2@cnInfoLabelOn         = False    ; Turn off informational
  res2@tiXAxisJust           = "CenterCenter"

  res2@cnLevelSelectionMode = "ExplicitLevels"   

  res2@tmXBLabelsOn=False
  res2@tmYLLabelsOn=False
  res2@tmYROn = False
  res2@tmXTOn = False
  
  res2@mpGridAndLimbOn        = True               ; turn on lat/lon grid lines
  res2@mpGridLineColor="grey33"
  res2@mpGridLineDashPattern=2

  res2@cnFillPalette = pmap
  res2@cnLevels              =    (/ 0.0289,0.1156,0.2601/)
  res2@lbLabelStrings   =     (/"Not Sig","Weak","Mod","Strong"/)  
  res2@lbLabelAlignment  = "BoxCenters"

  res2@tiMainJust = "CenterCenter"

  res2@pmLabelBarOrthogonalPosF = .10           ; move whole thing down

  res2@cnExplicitLabelBarLabelsOn = True
  res2@cnLabelBarEndStyle    = "IncludeMinMaxLabels"
  res2@cnMinLevelValF = toint(0)
  res2@cnMaxLevelValF = toint(1)
  res2@lbLabelFontHeightF  = 0.055
  res2@lbTitleFontHeightF  = 0.055



  return (res2)
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to set graphics resources for a variable array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("SetRes5")
function SetRes5(val1:numeric)
local res2
begin
  res2 = True
  res2@cnLevelSelectionMode = "ManualLevels"	
  res2@mpDataBaseVersion = "MediumRes"
  res2@mpCenterLonF      =  270
  res2@gsnPolar             = "NH"
  res2@mpMinLatF  = 20
  res2@gsnMaximize = True
  res2@gsnFrame = False
  res2@gsnDraw  = False
  res2@mpOutlineBoundarySets     = "geophysicalandusstates"; turn on states
  res2@mpDataBaseVersion         = "mediumres"             ; select database
  res2@mpDataSetName             = "Earth..2"
  res2@mpLandFillColor = "grey50"
  res2@mpOceanFillColor = (/0.54, 0.82, 1.00/)
  res2@mpOceanFillColor = (/0.9, 0.9, 1.00/)
  res2@mpOutlineOn               = True              ; turn on outline
  res2@mpUSStateLineThicknessF = 2.0
  res2@mpGeophysicalLineThicknessF = 2.0
  res2@cnFillOn             = True                  ; turn on color fill
  res2@cnLinesOn            = False

  pmap = (/"(/0.90, 0.90, 0.90/)","(/0.80, 0.76, 0.76/)","(/0.98, 0.96, 0.75/)","(/1.00, 0.40, 0.00/)","(/0.55, 0.25, 0.00/)"/)  

  res2@cnMonoFillPattern     = True     ; Turn solid fill back on.
  res2@cnMonoFillColor       = False    ; Use multiple colors.
  res2@cnLineLabelsOn        = False    ; Turn off line labels.
  res2@cnInfoLabelOn         = False    ; Turn off informational
  res2@tiXAxisJust           = "CenterCenter"

  res2@cnLevelSelectionMode = "ExplicitLevels"   

  res2@tmXBLabelsOn=False
  res2@tmYLLabelsOn=False
  res2@tmYROn = False
  res2@tmXTOn = False
  
  res2@mpGridAndLimbOn        = True               ; turn on lat/lon grid lines
  res2@mpGridLineColor="grey33"
  res2@mpGridLineDashPattern=2

  res2@cnFillPalette = pmap
  res2@cnLevels              =    (/ 0.1,0.2,0.3,0.4/)
  res2@lbLabelStrings   =     (/"Very Low","Low","Mod","Strong","Very Strong"/)  
  res2@lbLabelAlignment  = "BoxCenters"

  res2@tiMainJust = "CenterCenter"

  res2@pmLabelBarOrthogonalPosF = .10           ; move whole thing down

  res2@cnExplicitLabelBarLabelsOn = True
  res2@cnLabelBarEndStyle    = "IncludeMinMaxLabels"
  res2@cnMinLevelValF = tofloat(0)
  res2@cnMaxLevelValF = tofloat(0.5)
  res2@lbLabelFontHeightF  = 0.055
  res2@lbTitleFontHeightF  = 0.055



  return (res2)
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to set graphics resources for a statistical significance of Multiple R
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("SetRes6")
function SetRes6(val1:numeric, maptype:numeric)
local res2
begin
  res2 = True
  res2@cnLevelSelectionMode = "ManualLevels"	
  res2@mpDataBaseVersion = "MediumRes"
  res2@mpCenterLonF      =  270
  if (maptype.eq.2) then
    res2@mpMaxLatF  = 85
    res2@mpMinLatF  = -80
  end if
  if (maptype.eq.1) then
    res2@gsnPolar             = "NH"
    res2@mpMinLatF  = -30
  end if
  res2@gsnMaximize = True
  res2@gsnFrame = False
  res2@gsnDraw  = False
  res2@mpOutlineBoundarySets     = "geophysicalandusstates"; turn on states
  res2@mpDataBaseVersion         = "mediumres"             ; select database
  res2@mpDataSetName             = "Earth..2"
  res2@mpLandFillColor = "grey50"
  res2@mpOceanFillColor = (/0.54, 0.82, 1.00/)
  res2@mpOceanFillColor = (/0.9, 0.9, 1.00/)
  res2@mpOutlineOn               = True              ; turn on outline
  res2@mpUSStateLineThicknessF = 2.0
  res2@mpGeophysicalLineThicknessF = 2.0
  res2@cnFillOn             = True                  ; turn on color fill
  res2@cnLinesOn            = False

  pmap = (/ "(/0.90, 0.90, 0.90/)","(/0.21, 0.64, 0.00/)","(/1.00, 1.00, 0.00/)","(/1.00, 0.66, 0.00/)","(/1.00, 0.24, 0.24/)","(/0.50, 0.00, 0.00/)"/)

  res2@cnMonoFillPattern     = True     ; Turn solid fill back on.
  res2@cnMonoFillColor       = False    ; Use multiple colors.
  res2@cnLineLabelsOn        = False    ; Turn off line labels.
  res2@cnInfoLabelOn         = False    ; Turn off informational
  res2@tiXAxisJust           = "CenterCenter"

  res2@cnLevelSelectionMode = "ExplicitLevels"   

  res2@tmXBLabelsOn=False
  res2@tmYLLabelsOn=False
  res2@tmYROn = False
  res2@tmXTOn = False
  
  res2@mpGridAndLimbOn        = True               ; turn on lat/lon grid lines
  res2@mpGridLineColor="grey33"
  res2@mpGridLineDashPattern=2

  res2@cnFillPalette = pmap
  res2@cnLevels              =    (/ 0.8,0.9,0.95,0.99,0.999/)
  res2@lbLabelStrings   =     (/"Not Sig","Sig 0.20","Sig 0.10","Sig 0.05","Sig 0.01","Sig 0.001"/)  
  res2@lbLabelAlignment  = "BoxCenters"

  res2@tiMainJust = "CenterCenter"

  res2@pmLabelBarOrthogonalPosF = .10           ; move whole thing down

  res2@cnExplicitLabelBarLabelsOn = True
  res2@cnLabelBarEndStyle    = "IncludeMinMaxLabels"
  res2@cnMinLevelValF = tofloat(0)
  res2@cnMaxLevelValF = tofloat(0.5)
  res2@lbLabelFontHeightF  = 0.055
  res2@lbTitleFontHeightF  = 0.055

  return (res2)
end





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to set graphics resources for the ice concentration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("SetIceRes")
function SetIceRes( str1:string, str2:string )
local IceRes1
begin
  IceRes1 = True
  IceRes1@gsnTickMarksOn   = False	; no tickmarks
  IceRes1@gsnDraw          = False	; don't draw
  IceRes1@gsnFrame         = False	; don't advance frame
  IceRes1@gsnLeftString    = ""	        ; no titles
  IceRes1@gsnRightString   = ""
  IceRes1@tiXAxisString    = ""
  IceRes1@tiYAxisString    = ""
  IceRes1@cnLineThicknessF = 0.1	; thicker contours
  IceRes1@cnLineLabelsOn   = False	; no line labels
  IceRes1@cnInfoLabelOn = False
  IceRes1@cnMonoFillPattern = 17
  IceRes1@tiXAxisString = str2
  return (IceRes1)
end



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to set graphics resources for line resources 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("SetBoxRes")
function SetBoxRes( str1:string )
local boxres1
begin
    boxres1 = True
  if(str1.eq."NavyBlue") then
    boxres1                   = True         ; Set some line options
    boxres1@gsLineThicknessF  = 3.0          ; default is 1.0
    boxres1@gsLineColor       = "NavyBlue"   ; default is black
    boxres1@gsLineLabelString= ""
  end if
  if(str1.eq."Red") then
    boxres1                   = True         ; Set some line options
    boxres1@gsLineThicknessF  = 3.0          ; default is 1.0
    boxres1@gsLineColor       = "Red"        ; default is black
    boxres1@gsLineLabelString= ""
    boxres1@gsFillIndex = 0                            ; stipple
    boxres1@gsFillColor = "Red" 
    boxres1@gsFillScaleF     = 0.5
  end if
  if(str1.eq."darkgreen") then
    boxres1                   = True         ; Set some line options
    boxres1@gsLineThicknessF  = 3.0          ; default is 1.0
    boxres1@gsLineColor       = "darkgreen"   ; default is black
    boxres1@gsLineLabelString= ""
  end if
  if(str1.eq."yellow") then
    boxres1                   = True         ; Set some line options
    boxres1@gsLineThicknessF  = 3.0          ; default is 1.0
    boxres1@gsLineColor       = "yellow"   ; default is black
    boxres1@gsLineLabelString= ""
  end if
  if(str1.eq."cyan") then
    boxres1                   = True         ; Set some line options
    boxres1@gsLineThicknessF  = 10.0          ; default is 1.0
    boxres1@gsLineColor       = "cyan"        ; default is black
    boxres1@gsLineLabelString= ""
    boxres1@gsFillIndex = 0                            ; stipple
    boxres1@gsFillColor = "cyan" 
    boxres1@gsFillScaleF     = 0.5
  end if
  if(str1.eq."cyan2") then
    boxres1                   = True         ; Set some line options
    boxres1@gsLineThicknessF  = 10.0          ; default is 1.0
    boxres1@gsLineColor       = "cyan"   ; default is black
    boxres1@gsLineLabelString= ""
  end if
  return (boxres1)
end
;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to set graphics resources for scatter plot 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("SetScatterRes")
function SetScatterRes( str1:string )
local sres1
begin
sres1 = True
sres1@gsnMaximize       = True                     ; maximize plot
sres1@tiMainString      = "Scatter Plot"           ; add title
sres1@xyMarkLineMode    = "Markers"                ; choose to use markers
sres1@xyMarkers         =  16                      ; choose type of marker  
sres1@xyMarkerColor     = "NavyBlue"               ; Marker color
sres1@tiMainFontHeightF  = 0.015
sres1@lgLabelFontHeightF= 0.01
sres1@xyMonoMarkerColor = False ; tells NCL you will be assigning multiple colors 
sres1@gsnFrame = False
sres1@gsnDraw  = False
return (sres1)
end
;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to set graphics resources for percentage above/below normal 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("SetPercentRes")
function SetPercentRes( int1:numeric, minlat:numeric, cenlon:numeric )
local spres
begin

  spres = True
  spres@cnLevelSelectionMode = "ManualLevels"	
  spres@mpDataBaseVersion = "MediumRes"

  spres@mpCenterLonF      =  cenlon
  if (minlat.ge.0) then
    spres@gsnPolar             = "NH"
    spres@mpMinLatF  = minlat
  end if
  if (minlat.lt.0) then
    spres@gsnPolar             = "SH"
    spres@mpMaxLatF  = minlat
  end if


  spres@gsnMaximize = True
  spres@gsnFrame = False
  spres@gsnDraw  = False
  spres@mpOutlineBoundarySets     = "geophysicalandusstates"; turn on states
  spres@mpDataBaseVersion         = "mediumres"             ; select database
  spres@mpDataSetName             = "Earth..2"
  spres@mpLandFillColor = "grey50"
  spres@mpOutlineOn               = True              ; turn on outline
  spres@mpUSStateLineThicknessF = 2.0
  spres@mpGeophysicalLineThicknessF = 2.0
  spres@cnFillOn             = True                  ; turn on color fill
  spres@cnLinesOn            = False
  spres@cnMonoFillPattern     = True     ; Turn solid fill back on.
  spres@cnMonoFillColor       = False    ; Use multiple colors.
  spres@cnLineLabelsOn        = False    ; Turn off line labels.
  spres@cnInfoLabelOn         = False    ; Turn off informational
  spres@tiXAxisJust           = "CenterCenter"
  spres@cnLevelSelectionMode = "ExplicitLevels"   
  spres@tmXBLabelsOn=False
  spres@tmYLLabelsOn=False
  spres@tmYROn = False
  spres@tmXTOn = False
  spres@mpGridAndLimbOn        = True               ; turn on lat/lon grid lines
  spres@mpGridLineColor="grey33"
  spres@mpGridLineDashPattern=2
  cmap2 = (/"(/0.02, 0.01, 0.85/)","(/0.12, 0.31, 1.00/)","(/0.25, 0.59, 1.00/)","(/0.43, 0.76, 1.00/)","(/0.61, 0.93, 1.00/)","(/0.81, 1.00, 1.00/)","(/1.00, 1.00, 0.28/)","(/1.00, 0.92, 0.00/)","(/1.00, 0.56, 0.00/)","(/1.00, 0.28, 0.00/)","(/1.00, 0.00, 0.00/)","(/0.62, 0.00, 0.00/)"/)
  spres@cnFillPalette = cmap2
  spres@tiMainJust = "CenterCenter"
  spres@lbTitleOn        = True                  ; turn on title
  spres@pmLabelBarOrthogonalPosF = .10           ; move whole thing down
  spres@cnExplicitLabelBarLabelsOn = True
  spres@cnLabelBarEndStyle    = "IncludeMinMaxLabels"
  spres@cnMaxLevelValF = 0
  spres@cnMaxLevelValF = 100
  spres@lbLabelFontHeightF = 0.02
  ;spres@lgLabelFontHeightF= 0.02
  return (spres)


end








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to create spatial array of top 5 analogs 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("Spatial5Array")
function Spatial5Array( var:numeric, ind:integer)
local monthnum, month, qq, theVar, abc
begin
  theVar = var(0:4,:,:)
  ;theVar@_FillValue = -9999
  ;theVar(:,:,:) = theVar@_FillValue
  do qq=1,5  ; loop through and populate top 5 SLP and H500 analog month groups into template arrays
    theVar(qq-1,:,:) = dim_avg_n_Wrap(var(ind(qq-1):ind(qq-1+5),:,:),0)
  end do
  return(theVar)
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to create spatial array of top 5 analogs 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("Spatial5ArrayAnalogs")
function Spatial5ArrayAnalogs( var:numeric, ind:integer, fn1:integer, fn2:integer)
local monthnum, month, qq, theVar
begin
  theVar = var(0:4,:,:)
  ;theVar@_FillValue = -9999
  ;theVar(:,:,:) = theVar@_FillValue
  do qq=1,5  ; loop through and populate top 5 SLP and H500 analog month groups into template arrays
    theVar(qq-1,:,:) = dim_avg_n_Wrap(var(ind(qq-1-fn1):ind(qq-1+5-fn1-fn2+1),:,:),0)
  end do
  return(theVar)
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to create spatial array of top 5 analogs anomalies 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("Spatial5ArrayAnom")
function Spatial5ArrayAnom( var1:numeric, ind1:integer, var2:numeric, ind2:integer)
local monthnum, month, qq, theVar, anomVar
begin
  var1!0 = "time"
  var2!0 = "time"
  theVar = var2(0:4,:,:)
  do qq=1,5  ; loop through and populate top 5 SLP and H500 analog month groups into template arrays
    theVar(qq-1,:,:) = dim_avg_n_Wrap(var1(ind1(qq-1):ind1(qq-1+5),:,:),0) - dim_avg_n_Wrap(var2(ind2(qq-1):ind2(qq-1+5),:,:),0)
  end do
  theVar@info = "Top 5 Analog Anomaly"
  return(theVar)
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to generate month string(s) with year
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("MonthStr1")
function MonthStr1( num1:integer, num2:integer, endYear: integer, flag:integer)
local monthArray, begnum, endnum, str1, str2, returnStr, begYear
begin
  begnum = num1
  endnum = num2
  
  begYear = endYear

  if (begnum.gt.12) then
    begnum = begnum - 12
  end if
  if (begnum.lt.1) then
    begnum = begnum + 12
    begYear = endYear - 1
  end if
  if (endnum.gt.12) then
    endnum = endnum - 12
  end if

  if (begnum .eq. 1) then
    str1 = "Jan"
  end if
  if (endnum .eq. 1) then
    str2 = "Jan"
  end if
  if (begnum .eq. 2) then
    str1 = "Feb"
  end if
  if (endnum .eq. 2) then
    str2 = "Feb"
  end if
  if (begnum .eq. 3) then
    str1 = "Mar"
  end if
  if (endnum .eq. 3) then
    str2 = "Mar"
  end if
  if (begnum .eq. 4) then
    str1 = "Apr"
  end if
  if (endnum .eq. 4) then
    str2 = "Apr"
  end if
  if (begnum .eq. 5) then
    str1 = "May"
  end if
  if (endnum .eq. 5) then
    str2 = "May"
  end if
  if (begnum .eq. 6) then
    str1 = "Jun"
  end if
  if (endnum .eq. 6) then
    str2 = "Jun"
  end if
  if (begnum .eq. 7) then
    str1 = "Jul"
  end if
  if (endnum .eq. 7) then
    str2 = "Jul"
  end if
  if (begnum .eq. 8) then
    str1 = "Aug"
  end if
  if (endnum .eq. 8) then
    str2 = "Aug"
  end if
  if (begnum .eq. 9) then
    str1 = "Sep"
  end if
  if (endnum .eq. 9) then
    str2 = "Sep"
  end if
  if (begnum .eq. 10) then
    str1 = "Oct"
  end if
  if (endnum .eq. 10) then
    str2 = "Oct"
  end if
  if (begnum .eq. 11) then
    str1 = "Nov"
  end if
  if (endnum .eq. 11) then
    str2 = "Nov"
  end if
  if (begnum .eq. 12) then
    str1 = "Dec"
  end if
  if (endnum .eq. 12) then
    str2 = "Dec"
  end if

  if (flag.eq.1) then  ; include year in string
    returnStr = str1+" "+begYear+" - "+str2+" "+endYear
    if (num1 .eq. num2) then
      returnStr = str1 +" "+endYear
    end if
    return(returnStr)
  end if

  if (flag.eq.2) then  ; do not include year in string
    returnStr = str1+"-"+str2
    if (num1 .eq. num2) then
      returnStr = str1
    end if
    return(returnStr)
  end if


end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to generate percentile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

undef("Percentile") 
function Percentile(x:numeric,P:float) 
begin 
if(P.gt.0) then 
  P = P/100. 
end if 
x@_FillValue = default_fillvalue(typeof(x)) 
;print("Rain rates for project greater than 0 and less than 1000...") 
x = where((x.gt.0 .and. x.lt.1000.),x,x@_FillValue) 
nx = Crop(ndtooned(x)) 
index = round(P*dimsizes(nx),3) 
;print("Index of percentile: "+index+ " of size: "+dimsizes(nx)) 
ib = dim_pqsort(nx,2) 
;print("The "+P*100+" percentile: "+nx(index)) 
return(nx(index)) 
end 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to generate month string(s) with year
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("MonthStr2")
function MonthStr2( num1:integer, num2:integer, endYear: integer, flag:integer)
local monthArray, begnum, endnum, str1, str2, returnStr, begYear
begin
  begnum = num1
  endnum = num2
  
  begYear = endYear

  if (begnum.gt.12) then
    begnum = begnum - 12
  end if
  if (begnum.lt.1) then
    begnum = begnum + 12
    begYear = endYear - 1
  end if
  if (endnum.gt.12) then
    endnum = endnum - 12
  end if

  if (begnum .eq. 1) then
    str1 = "January"
  end if
  if (endnum .eq. 1) then
    str2 = "January"
  end if
  if (begnum .eq. 2) then
    str1 = "February"
  end if
  if (endnum .eq. 2) then
    str2 = "February"
  end if
  if (begnum .eq. 3) then
    str1 = "March"
  end if
  if (endnum .eq. 3) then
    str2 = "March"
  end if
  if (begnum .eq. 4) then
    str1 = "April"
  end if
  if (endnum .eq. 4) then
    str2 = "April"
  end if
  if (begnum .eq. 5) then
    str1 = "May"
  end if
  if (endnum .eq. 5) then
    str2 = "May"
  end if
  if (begnum .eq. 6) then
    str1 = "June"
  end if
  if (endnum .eq. 6) then
    str2 = "June"
  end if
  if (begnum .eq. 7) then
    str1 = "July"
  end if
  if (endnum .eq. 7) then
    str2 = "July"
  end if
  if (begnum .eq. 8) then
    str1 = "August"
  end if
  if (endnum .eq. 8) then
    str2 = "August"
  end if
  if (begnum .eq. 9) then
    str1 = "September"
  end if
  if (endnum .eq. 9) then
    str2 = "September"
  end if
  if (begnum .eq. 10) then
    str1 = "October"
  end if
  if (endnum .eq. 10) then
    str2 = "October"
  end if
  if (begnum .eq. 11) then
    str1 = "November"
  end if
  if (endnum .eq. 11) then
    str2 = "November"
  end if
  if (begnum .eq. 12) then
    str1 = "December"
  end if
  if (endnum .eq. 12) then
    str2 = "December"
  end if

  if (flag.eq.1) then  ; include year in string
    returnStr = str1+" "+begYear+" - "+str2+" "+endYear
    if (num1 .eq. num2) then
      returnStr = str1 +" "+endYear
    end if
    return(returnStr)
  end if

  if (flag.eq.2) then  ; do not include year in string
    returnStr = str1+" - "+str2
    if (num1 .eq. num2) then
      returnStr = str1
    end if
    return(returnStr)
  end if


end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to generate month string(s) with year
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("MonthStr3")
function MonthStr3( num1:integer, num2:integer, endYear: integer, flag:integer)
local monthArray, begnum, endnum, str1, str2, returnStr, begYear
begin
  begnum = num1
  endnum = num2
  
  begYear = endYear

  if (begnum.gt.12) then
    begnum = begnum - 12
  end if
  if (begnum.lt.1) then
    begnum = begnum + 12
    begYear = endYear - 1
  end if
  if (endnum.gt.12) then
    endnum = endnum - 12
  end if

  if (begnum .eq. 1) then
    str1 = "Jan"
  end if
  if (endnum .eq. 1) then
    str2 = "Jan"
  end if
  if (begnum .eq. 2) then
    str1 = "Feb"
  end if
  if (endnum .eq. 2) then
    str2 = "Feb"
  end if
  if (begnum .eq. 3) then
    str1 = "Mar"
  end if
  if (endnum .eq. 3) then
    str2 = "Mar"
  end if
  if (begnum .eq. 4) then
    str1 = "Apr"
  end if
  if (endnum .eq. 4) then
    str2 = "Apr"
  end if
  if (begnum .eq. 5) then
    str1 = "May"
  end if
  if (endnum .eq. 5) then
    str2 = "May"
  end if
  if (begnum .eq. 6) then
    str1 = "Jun"
  end if
  if (endnum .eq. 6) then
    str2 = "Jun"
  end if
  if (begnum .eq. 7) then
    str1 = "Jul"
  end if
  if (endnum .eq. 7) then
    str2 = "Jul"
  end if
  if (begnum .eq. 8) then
    str1 = "Aug"
  end if
  if (endnum .eq. 8) then
    str2 = "Aug"
  end if
  if (begnum .eq. 9) then
    str1 = "Sep"
  end if
  if (endnum .eq. 9) then
    str2 = "Sep"
  end if
  if (begnum .eq. 10) then
    str1 = "Oct"
  end if
  if (endnum .eq. 10) then
    str2 = "Oct"
  end if
  if (begnum .eq. 11) then
    str1 = "Nov"
  end if
  if (endnum .eq. 11) then
    str2 = "Nov"
  end if
  if (begnum .eq. 12) then
    str1 = "Dec"
  end if
  if (endnum .eq. 12) then
    str2 = "Dec"
  end if

  if (flag.eq.1) then  ; include year in string
    returnStr = str1+" "+begYear+" - "+str2+" "+endYear
    if (num1 .eq. num2) then
      returnStr = str1 +" "+endYear
    end if
    return(returnStr)
  end if

  if (flag.eq.2) then  ; do not include year in string
    returnStr = str1+" - "+str2
    if (num1 .eq. num2) then
      returnStr = str1
    end if
    return(returnStr)
  end if


end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to generate Rank Category 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("AssignRank")
function AssignRank( num1:integer)
local num2
begin
  num2 = 99
  if(num1.eq.1) then
    num2 =1
  end if
  if(num1.eq.2) then
    num2 = 2
  end if
  if(num1.eq.3) then
    num2 = 3
  end if
  if(num1.ge.4.and.num1.le.9) then
    num2 = 4
  end if
  if(num1.ge.10.and.num1.le.15) then
    num2 = 5
  end if
  if(num1.ge.16.and.num1.le.21) then
    num2 = 6
  end if
  if(num1.ge.22.and.num1.le.24) then
    num2 = 7
  end if
  if(num1.ge.28.and.num1.le.34) then
    num2 = 8
  end if
  if(num1.ge.35.and.num1.le.41) then
    num2 = 9
  end if
  if(num1.ge.42.and.num1.le.47) then
    num2 = 10
  end if
  if(num1.ge.48.and.num1.le.53) then
    num2 = 11
  end if
  if(num1.ge.54.and.num1.le.59) then
    num2 = 12
  end if
  if(num1.ge.60.and.num1.le.65) then
    num2 = 13
  end if
  if(num1.eq.66) then
    num2 = 14
  end if
  if(num1.eq.67) then
    num2 = 15
  end if
  if(num1.eq.68) then
    num2 = 16
  end if
  
  return(num2)
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to calculate weighted averages 
;;; that account for latitudinal convergence.
;;; The value of each lat/lon point is multiplied
;;; by the cosine of the latitude. All adjusted
;;; values are then summed but the new 'n' 
;;; denominator is the sum of cos(lat).
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("W_ave_Index")
function W_ave_Index( x:numeric, ind1:integer, ind2:integer )
local avgr, cntr, sum
begin
  cntr = 0
  sum = 0.0
  do qq=ind1,ind2
    cntr = cntr +1
    sum = sum + x(qq)
  end do

  if (cntr.gt.0) then
    avgr = sum / cntr / 1.0
  end if
  if (cntr.eq.0) then
    avgr = -9999 / 1.0
  end if
  return(avgr)
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to calculate weighted averages 
;;; that account for latitudinal convergence.
;;; The value of each lat/lon point is multiplied
;;; by the cosine of the latitude. All adjusted
;;; values are then summed but the new 'n' 
;;; denominator is the sum of cos(lat).
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("SeaIceTrend")
function SeaIceTrend( x:numeric, y:numeric, clm1:integer, clm2: integer)
local sizes, cntr, ret, v, w, x1, y1, regress, xclm, yclm, stind, endind, clmyears, analog, analog2, goodYearsCount, goodYearsSum, est, depart, theSlope, theYintercept
begin


  ; Flag tells the function which value to return
  ret = new(2,float)
  cntr = 0

  sizes = dimsizes(y)
  do v=0,sizes-1
  if (.not.ismissing(y(v))) then
    cntr = cntr+1
  end if  
  end do



  est = new(sizes,float)
  depart = new(sizes,float)

  stind = clm1-1948
  endind = stind+clm2-clm1
  clmyears = endind-stind+1


  xclm = new(clmyears,float)
  yclm = new(clmyears,float)

  do b=0,clmyears-1
    xclm(b) = x(b+stind)
    yclm(b) = y(b+stind)
  end do


  regress = regline(xclm,yclm)

  ret(0) = regress
  ret(1) = regress@yintercept



;print("Analog trendline departure = "+analog)
;print("Analog sea ice forecast = "+analog2)
;print("Actual trendline departure = "+depart(sizes-1))
;print("Actual trendline value = "+est(sizes-1))
;print("Actual sea ice value = "+y(sizes-1))
;print(xyz)
  
return(ret)

end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to calculate weighted averages 
;;; that account for latitudinal convergence.
;;; The value of each lat/lon point is multiplied
;;; by the cosine of the latitude. All adjusted
;;; values are then summed but the new 'n' 
;;; denominator is the sum of cos(lat).
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("SeaIceCalcs")
function SeaIceCalcs( x:numeric, y:numeric, clm1:integer, clm2: integer)
local sizes, cntr, ret, v, w, x1, y1, regress, regress2, xclm, yclm, xclm2, yclm2, stind, endind, stind2, endind2, clmyears, analog, analog2, goodYearsCount, goodYearsSum, est, depart, theSlope, theYintercept
begin

;print(x+" , "+y)
;print("")

yalt = new(80,float)
xalt = new(80,float)

ysize = dimsizes(y)

do sd = 0, ysize(0)-1
  yalt(sd) = y(sd)
  xalt(sd) = x(sd)
end do



  ;ret = new((/6,70/),float)


  ret = new((/6,80/),float)

  year = new(80,float)
  seaice = new(80,float)
  slope = new(80,float)
  intercept = new(80,float)
  trend = new(80,float)
  depart = new(80,float)

  stind = clm1-1948
  endind = stind+clm2-clm1
  clmyears = endind-stind+1
  xclm = new(clmyears,float)
  yclm = new(clmyears,float)
  do b=0,clmyears-1
    xclm(b) = xalt(b+stind)
    yclm(b) = yalt(b+stind)
  end do
  regress = regline(xclm,yclm)

  stind2 = 0
  endind2 = stind-1
  clmyears2 = endind2-stind2+1
  xclm2 = new(clmyears2,float)
  yclm2 = new(clmyears2,float)
  do b2=0,endind2
    xclm2(b2) = xalt(b2+stind2)
    yclm2(b2) = yalt(b2+stind2)
  end do
  regress2 = regline(xclm2,yclm2)

  cntr = 1
  do b3 = 1, endind2
    year(cntr) = xclm2(b3)
    seaice(cntr) = yclm2(b3)
    slope(cntr) = regress2
    intercept(cntr) = regress2@yintercept
    trend(cntr) = (regress2*xclm2(b3))+regress2@yintercept
    depart(cntr) = yclm2(b3) - ((regress2*xclm2(b3))+regress2@yintercept)
    cntr = cntr+1
  end do
  do b4 = 0, clmyears-1
    year(cntr) = xclm(b4)
    seaice(cntr) = yclm(b4)
    slope(cntr) = regress
    intercept(cntr) = regress@yintercept
    trend(cntr) = (regress*xclm(b4))+regress@yintercept
    depart(cntr) = yclm(b4) - ((regress*xclm(b4))+regress@yintercept)
    cntr = cntr+1
  end do
  year(68) = 2016
  year(69) = 2017
  year(70) = 2018
  year(71) = 2019
  year(72) = 2020
  year(73) = 2021
  year(74) = 2022
  year(75) = 2023
  slope(68) = regress
  slope(69) = regress
  slope(70) = regress
  slope(71) = regress
  slope(72) = regress
  slope(73) = regress
  slope(74) = regress
  slope(75) = regress
  intercept(68) = regress@yintercept
  intercept(69) = regress@yintercept
  intercept(70) = regress@yintercept
  intercept(71) = regress@yintercept
  intercept(72) = regress@yintercept
  intercept(73) = regress@yintercept
  intercept(74) = regress@yintercept
  intercept(75) = regress@yintercept
  trend(68) = (regress*year(68))+regress@yintercept
  trend(69) = (regress*year(69))+regress@yintercept
  trend(70) = (regress*year(70))+regress@yintercept
  trend(71) = (regress*year(71))+regress@yintercept
  trend(72) = (regress*year(72))+regress@yintercept
  trend(73) = (regress*year(73))+regress@yintercept
  trend(74) = (regress*year(74))+regress@yintercept
  trend(75) = (regress*year(75))+regress@yintercept
  ;if (.not.ismissing(y(68))) then
    seaice(68) = yalt(68)
    seaice(69) = yalt(69)
    seaice(70) = yalt(70)
    seaice(71) = yalt(71)
    seaice(72) = yalt(72)
    seaice(73) = yalt(73)
    seaice(74) = yalt(74)
    seaice(75) = yalt(75)
  ;end if
  depart(68) = seaice(68)-trend(68)
  depart(69) = seaice(69)-trend(69)
  depart(70) = seaice(70)-trend(70)
  depart(71) = seaice(71)-trend(71)
  depart(72) = seaice(72)-trend(72)
  depart(73) = seaice(73)-trend(73)
  depart(74) = seaice(74)-trend(74)
  depart(75) = seaice(75)-trend(75)




  ;ret(0) = regress
  ;ret(1) = regress@yintercept

  ;print(year + ", "+seaice + ", "+slope + ", "+intercept + ", "+trend)
  ret(0,:) = year
  ret(1,:) = seaice     ; actual sea ice
  ret(2,:) = slope      ; slope coefficient of line equation
  ret(3,:) = intercept  ; y-intercept of line equation
  ret(4,:) = trend      ; trend line value of sea ice for the month. (1948-1987 or 1979-present)
  ret(5,:) = depart
  ;print(ret)


return(ret)



;print("Analog trendline departure = "+analog)
;print("Analog sea ice forecast = "+analog2)
;print("Actual trendline departure = "+depart(sizes-1))
;print("Actual trendline value = "+est(sizes-1))
;print("Actual sea ice value = "+y(sizes-1))
;print(xyz)
  

end



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to calculate weighted averages 
;;; that account for latitudinal convergence.
;;; The value of each lat/lon point is multiplied
;;; by the cosine of the latitude. All adjusted
;;; values are then summed but the new 'n' 
;;; denominator is the sum of cos(lat).
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("deleteVars")
function deleteVars( ind:integer )
local avgr, cntr, sum
begin
  delete(slpAnalysisBlue1)
  delete(h500AnalysisBlue1)
  delete(t2mAnalysisBlue1)
  delete(t925AnalysisBlue1)
  delete(sstAnalysisBlue1)
  delete(slpAnalysisRed1)
  delete(h500AnalysisRed1)
  delete(t2mAnalysisRed1)
  delete(t925AnalysisRed1)
  delete(sstAnalysisRed1)
  delete(pdoAnalysis1)
  delete(npmAnalysis1)
  delete(soiAnalysis1)
  delete(slpAnalysisBlue2)
  delete(h500AnalysisBlue2)
  delete(t2mAnalysisBlue2)
  delete(t925AnalysisBlue2)
  delete(sstAnalysisBlue2)
  delete(slpAnalysisRed2)
  delete(h500AnalysisRed2)
  delete(t2mAnalysisRed2)
  delete(t925AnalysisRed2)
  delete(sstAnalysisRed2)
  delete(pdoAnalysis2)
  delete(npmAnalysis2)
  delete(soiAnalysis2)
  delete(weightedAnalysisBlue2)
  delete(weightedAnalysisRed2)
  delete(xx1)
  delete(xx2)
  delete(xx3)
  delete(xx4)
  delete(xx5)
  delete(xx6)
  delete(xx7)
  delete(xx8)
  delete(slpArrayforRMS)
  delete(h500ArrayforRMS)
  delete(t2mArrayforRMS)
  delete(t925ArrayforRMS)
  delete(sstArrayforRMS)
  delete(YearArrayforRMS)
  delete(AKslpArray) 
  delete(AKh500Array) 
  delete(AKt2mArray) 
  delete(AKt925Array) 
  delete(AKsstArray) 
  delete(AKboxslpArray3)
  delete(AKboxh500Array3)
  delete(AKboxt2mArray3)
  delete(AKboxt925Array3)
  delete(AKboxsstArray3)
  delete(AKboxslpArray4)
  delete(AKboxh500Array4)
  delete(AKboxt2mArray4)
  delete(AKboxt925Array4)
  delete(AKboxsstArray4)
  delete(slpBlueBoxMatchYears)
  delete(h500BlueBoxMatchYears)
  delete(t2mBlueBoxMatchYears)
  delete(t925BlueBoxMatchYears)
  delete(sstBlueBoxMatchYears)
  delete(slpRedBoxMatchYears)
  delete(h500RedBoxMatchYears)
  delete(t2mRedBoxMatchYears)
  delete(t925RedBoxMatchYears)
  delete(sstRedBoxMatchYears)
  delete(YearArrayMatchYears)
  delete(f)
  delete(g)

end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Routine to calculate weighted averages 
;;; that account for latitudinal convergence.
;;; The value of each lat/lon point is multiplied
;;; by the cosine of the latitude. All adjusted
;;; values are then summed but the new 'n' 
;;; denominator is the sum of cos(lat).
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("W_ave_pct")
function W_ave_pct( x:numeric, ind1:integer, ind2:integer, lat1:integer, lat2:integer,lon1:integer, lon2:integer, val:numeric, res:numeric)
local avgr, rad, clat, coslatsum, coslat, thetemp, over30sum, pointsum, q, r, s, theArray, thelat, thelon, thedims, timedims, latdims, londims, theCounter
begin

; res = the spatial resolution in degrees. ERSSTv4 is 2.0 degrees.

  theArray = x(ind1:ind2,{lat1:lat2},{lon1:lon2})
  
  theCounter = 0

  thelat = theArray&lat
  thelon = theArray&lon
  ;thetime = theArray&time
  thedims = dimsizes(theArray)
  timedims = thedims(0)
  latdims = thedims(1)
  londims = thedims(2)


  rad    = 4.*atan(1.)/180.
  clat   = thelat           
  clat   = sqrt( cos(rad*clat) )               
  coslatsum = 0.
  over30sum = 0.
  pointsum = 0.
  q = 0
  r = 0
  s = 0

  do q=0, timedims -1
    do r=0, latdims -1
      do s=0, londims -1
        if(thelat(r).lt.90) then
          if (.not.ismissing(theArray(q,r,s))) then
            theCounter = theCounter + 1
            coslat = cos(rad*thelat(r))
            thetemp = theArray(q,r,s)
            if (thetemp.ge.val) then
              over30sum = over30sum + ((tofloat(coslat)*111.32*tofloat(res))*(112.19*tofloat(res)))
            end if
            ;coslatsum = coslatsum + cos(rad*thelat(r))
            ;pointsum = pointsum + (cos(rad*thelat(r)) * theArray(q,r,s))
          end if
        end if
      end do
    end do
  end do

  ;if (theCounter.gt.0) then
  ;  avgr = pointsum / coslatsum / 1.
  ;end if

  if (theCounter.eq.0) then
    avgr = 9999.
  end if

  over30sum = over30sum / 1000000

  return(over30sum)
end
;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Get pressure level
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef ("getlev")
function getlev( num:integer)
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




;************************************
;************************************
undef ("Significance")
function Significance( x:numeric, aveArray:numeric)
local latindex, lonindex, intlatdeg, intlondeg, total, count, w1, z1, z2, minDegVal, maxDegVal
begin

newArray = aveArray(0,:,:)
x_sizes = dimsizes(x)
aveArray_sizes = dimsizes(aveArray)
timedims = aveArray_sizes(0)
latdims = aveArray_sizes(1)
londims = aveArray_sizes(2)

x_count = 0
do w = 0, x_sizes - 1
  if (.not.ismissing(x(w))) then
    x_count = x_count + 1

  end if
end do

do r=0, latdims -1
  do s=0, londims -1
    if (.not.ismissing(aveArray(0,r,s))) then
      rl = regline(aveArray(:,r,s),x)
      rldf = rl@nptxy-2 
      prob = (1 - betainc(rldf/(rldf+rl@tval^2), rldf/2.0, 0.5) )
      if (ismissing(rl)) then
        rl = 0
        prob = 0
      end if
      newArray(toint(r),toint(s)) = prob
      if(rl.lt.0) then
        newArray(toint(r),toint(s)) = 0 - prob
      end if
    end if
  end do
end do

;print("Temporary Break")
;exit

newArray({-88:-88},{210:220}) = -1.0
newArray({-88:-88},{30:40}) = 1.0


return(newArray)
delete(newArray)



end

;************************************
;************************************
undef ("LatLonString")
function LatLonString( nlat:numeric, slat:numeric, llon:numeric, rlon:numeric)
local latindex, lonindex, intlatdeg, intlondeg, total, count, w1, z1, z2, minDegVal, maxDegVal
begin

;;;  Make texst strings for lat/long using N-E-S-W
  if (nlat.ge.0) then
    nlatstr = nlat+"N"
  end if
  if (slat.ge.0) then
    slatstr = slat+"N"
  end if
  if (nlat.lt.0) then
    nlatstr = abs(nlat)+"S"
  end if
  if (slat.lt.0) then
    slatstr = abs(slat)+"S"
  end if
  if (rlon.ge.180) then
    rlonstr = (180-(rlon-180))+"W"
  end if
  if (llon.ge.180) then
    llonstr = (180-(llon-180))+"W"
  end if
  if (rlon.lt.180) then
    rlonstr = rlon+"E"
  end if
  if (llon.lt.180) then
    llonstr = llon+"E"
  end if
 
  llstring = "Lat: "+slatstr+" to "+nlatstr+" and Lon: "+llonstr+" to "+rlonstr
  return(llstring)


end

;************************************
;************************************
undef ("UpdateDoY")
function UpdateDoY( nyear:numeric, ndoy:numeric, nadd:numeric)
local latindex, lonindex, newDoY
begin

  if(isleapyear(nyear).eq.True) then
    newDoY = ndoy
  end if
  if(isleapyear(nyear).eq.False) then
    if(ndoy.le.58) then
      newDoY = ndoy
    end if
    if(ndoy.gt.58) then
      newDoY = ndoy + 1
    end if
  end if

  newDoY = newDoY + nadd
  
  if (newDoY.gt.365) then
    newDoY = newDoY - 366
  end if

  return(newDoY)
end

;************************************
;************************************
undef ("DailyNormalsFromMonthlyData")
function DailyNormalsFromMonthlyData(x[*][*][*]:numeric)
local dimx, ntim, nlat, mlon, i, nmo, nmos, monAveLLT, aveMonth
begin

  xxx = tofloat(x)
  copy_VarMeta(xxx,x)
  copy_VarAtts(xxx,x)
  xxx!0="time"
  xxx!1="lat"
  xxx!2="lon"
  myLat = x&lat
  myLon = x&lon
  myTime = x&time
  xxx&lat = myLat
  xxx&lon = myLon
  xxx&time = myTime


  dimx = dimsizes(xxx)
  ntim = dimx(0)

  nmos  = 12
  modCheck ("DailyNormalsFromMonthlyData", ntim, nmos)   ; error check
  nlat = dimx(1)
  mlon = dimx(2)
  aveMonth = new((/nmos,nlat,mlon/),typeof(xxx) )                        ;;;; this is a (12,:,:) size array. 0=Jan, 1=Feb, etc.
  do nmo = 0, 11
     aveMonth(nmo,:,:) = dim_avg_n( xxx(nmo:ntim-1:nmos,:,:), 0 )
  end do
  copy_VarAtts (xxx,aveMonth)
;  printVarSummary(x)
;  printVarSummary(xxx)
;  printVarSummary(aveMonth)




  do i=1,2
     if (.not.ismissing(xxx!i)) then
         aveMonth!i = xxx!i
         if (iscoord(xxx,xxx!i)) then
             aveMonth&$aveMonth!i$ = xxx&$xxx!i$
         end if
     end if
  end  do
  aveMonth!0     = "month"           ; create a "month" named dim
  aveMonth&month = ispan(0,nmos-1,1) ; create a month coord var




  normDaily = new((/365,nlat,mlon/),typeof(xxx) ) 
  Jan1 = new((/1,nlat,mlon/),typeof(xxx) ) 

  yin = new((/24,nlat,mlon/),typeof(xxx) ) 
  do gg = 0, 5
    yin(gg,:,:) = (/ aveMonth(gg+6,:,:) /)
  end do
  do gg = 6, 17
    yin(gg,:,:) = (/ aveMonth(gg-6,:,:) /)
  end do
  do gg = 18, 23
    yin(gg,:,:) = (/ aveMonth(gg-18,:,:) /)
  end do

  xin = new(24,integer)
  xin = (/16,47,77,108,138,169,200,230,259,289,320,350,381,412,442,473,503,534,565,595,625,655,686,716/)
  sig = new(24,float)
  sig(0) = 0.0
  sig(23) = 0.0
  do gg = 1, 22
    sig(gg) = (/     tofloat((xin(gg)-xin(gg-1))) / tofloat((xin(gg+1)-xin(gg-1)))       /)
  end do

  yti = new((/24,nlat,mlon/),typeof(xxx) ) 
  yti(0,:,:) = 0.0
  yti(23,:,:) = 0.0
  p = new((/24,nlat,mlon/),typeof(xxx) ) 
  do gg = 1, 22
    p(gg,:,:)   = (/ tofloat(tofloat(sig(gg)*yti(gg-1,:,:))+2.0) /)
    yti(gg,:,:) =  (/       tofloat(tofloat(sig(gg) - 1.0) /  p(gg,:,:))        /)
  end do
  ui1 = new((/24,nlat,mlon/),typeof(xxx) ) 
  do gg = 1, 22
    ui1(gg,:,:)= (/ tofloat(tofloat(yin(gg+1,:,:)-yin(gg,:,:))/tofloat(xin(gg+1)-xin(gg))) - tofloat(tofloat((yin(gg,:,:)-yin(gg-1,:,:)))/tofloat(xin(gg)-xin(gg-1))) /)
  end do
  ui2 = new((/24,nlat,mlon/),typeof(xxx) ) 
  ui2(0,:,:) = 0.0
  do gg = 1, 22
    ui2(gg,:,:)=tofloat(tofloat(tofloat(tofloat(6.0*ui1(gg,:,:))/tofloat(xin(gg+1)-xin(gg-1)))-tofloat(sig(gg)*ui2(gg-1,:,:))) / p(gg,:,:))
  end do
  ytk = new((/24,nlat,mlon/),typeof(xxx) ) 
  ytk(0,:,:) = 0.0
  ytk(23,:,:) = 0.0
  do gg = 22, 0, 1
    ytk(gg,:,:) = tofloat(tofloat(yti(gg,:,:)*ytk(gg+1,:,:)) + ui2(gg,:,:))
  end do


  xx = new(365,float)
  do gg = 0, 364
    xx(gg) = tofloat(gg+185)
  end do
  cntr = 6


  h = new(365,float)
  a = new(365,float)
  b = new(365,float)
  y = new((/365,nlat,mlon/),typeof(xxx) ) 

  do gg = 0, 15
    h(gg) = tofloat(xin(cntr)-xin(cntr-1))
    a(gg) = tofloat(tofloat(xin(cntr)-xx(gg)) / h(gg))
    b(gg) = tofloat(tofloat(xx(gg)-xin(cntr-1)) / h(gg))
    y(gg,:,:) = tofloat(a(gg)*yin(cntr-1,:,:))    +    tofloat(b(gg)*yin(cntr,:,:))      +      (     tofloat(a(gg)^3-a(gg))         *   ytk(cntr-1,:,:)    +      tofloat(b(gg)^3 - b(gg))  *   ytk(cntr,:,:)   )    *    tofloat(h(gg)^2 / 6.0)
  end do
  cntr = cntr+1

  do gg = 16, 45
    h(gg) = tofloat(xin(cntr)-xin(cntr-1))
    a(gg) = tofloat(tofloat(xin(cntr)-xx(gg)) / h(gg))
    b(gg) = tofloat(tofloat(xx(gg)-xin(cntr-1)) / h(gg))
    y(gg,:,:) = tofloat(a(gg)*yin(cntr-1,:,:))    +    tofloat(b(gg)*yin(cntr,:,:))      +      (     tofloat(a(gg)^3-a(gg))         *   ytk(cntr-1,:,:)    +      tofloat(b(gg)^3 - b(gg))  *   ytk(cntr,:,:)   )    *    tofloat(h(gg)^2 / 6.0)
  end do
  cntr = cntr+1

  do gg = 46, 74
    h(gg) = tofloat(xin(cntr)-xin(cntr-1))
    a(gg) = tofloat(tofloat(xin(cntr)-xx(gg)) / h(gg))
    b(gg) = tofloat(tofloat(xx(gg)-xin(cntr-1)) / h(gg))
    y(gg,:,:) = tofloat(a(gg)*yin(cntr-1,:,:))    +    tofloat(b(gg)*yin(cntr,:,:))      +      (     tofloat(a(gg)^3-a(gg))         *   ytk(cntr-1,:,:)    +      tofloat(b(gg)^3 - b(gg))  *   ytk(cntr,:,:)   )    *    tofloat(h(gg)^2 / 6.0)
  end do
  cntr = cntr+1

  do gg = 75, 104
    h(gg) = tofloat(xin(cntr)-xin(cntr-1))
    a(gg) = tofloat(tofloat(xin(cntr)-xx(gg)) / h(gg))
    b(gg) = tofloat(tofloat(xx(gg)-xin(cntr-1)) / h(gg))
    y(gg,:,:) = tofloat(a(gg)*yin(cntr-1,:,:))    +    tofloat(b(gg)*yin(cntr,:,:))      +      (     tofloat(a(gg)^3-a(gg))         *   ytk(cntr-1,:,:)    +      tofloat(b(gg)^3 - b(gg))  *   ytk(cntr,:,:)   )    *    tofloat(h(gg)^2 / 6.0)
  end do
  cntr = cntr+1

  do gg = 105, 134
    h(gg) = tofloat(xin(cntr)-xin(cntr-1))
    a(gg) = tofloat(tofloat(xin(cntr)-xx(gg)) / h(gg))
    b(gg) = tofloat(tofloat(xx(gg)-xin(cntr-1)) / h(gg))
    y(gg,:,:) = tofloat(a(gg)*yin(cntr-1,:,:))    +    tofloat(b(gg)*yin(cntr,:,:))      +      (     tofloat(a(gg)^3-a(gg))         *   ytk(cntr-1,:,:)    +      tofloat(b(gg)^3 - b(gg))  *   ytk(cntr,:,:)   )    *    tofloat(h(gg)^2 / 6.0)
  end do
  cntr = cntr+1

  do gg = 135, 165
    h(gg) = tofloat(xin(cntr)-xin(cntr-1))
    a(gg) = tofloat(tofloat(xin(cntr)-xx(gg)) / h(gg))
    b(gg) = tofloat(tofloat(xx(gg)-xin(cntr-1)) / h(gg))
    y(gg,:,:) = tofloat(a(gg)*yin(cntr-1,:,:))    +    tofloat(b(gg)*yin(cntr,:,:))      +      (     tofloat(a(gg)^3-a(gg))         *   ytk(cntr-1,:,:)    +      tofloat(b(gg)^3 - b(gg))  *   ytk(cntr,:,:)   )    *    tofloat(h(gg)^2 / 6.0)
  end do
  cntr = cntr+1

  do gg = 166, 196
    h(gg) = tofloat(xin(cntr)-xin(cntr-1))
    a(gg) = tofloat(tofloat(xin(cntr)-xx(gg)) / h(gg))
    b(gg) = tofloat(tofloat(xx(gg)-xin(cntr-1)) / h(gg))
    y(gg,:,:) = tofloat(a(gg)*yin(cntr-1,:,:))    +    tofloat(b(gg)*yin(cntr,:,:))      +      (     tofloat(a(gg)^3-a(gg))         *   ytk(cntr-1,:,:)    +      tofloat(b(gg)^3 - b(gg))  *   ytk(cntr,:,:)   )    *    tofloat(h(gg)^2 / 6.0)
  end do
  cntr = cntr+1

  do gg = 197, 227
    h(gg) = tofloat(xin(cntr)-xin(cntr-1))
    a(gg) = tofloat(tofloat(xin(cntr)-xx(gg)) / h(gg))
    b(gg) = tofloat(tofloat(xx(gg)-xin(cntr-1)) / h(gg))
    y(gg,:,:) = tofloat(a(gg)*yin(cntr-1,:,:))    +    tofloat(b(gg)*yin(cntr,:,:))      +      (     tofloat(a(gg)^3-a(gg))         *   ytk(cntr-1,:,:)    +      tofloat(b(gg)^3 - b(gg))  *   ytk(cntr,:,:)   )    *    tofloat(h(gg)^2 / 6.0)
  end do
  cntr = cntr+1

  do gg = 228, 257
    h(gg) = tofloat(xin(cntr)-xin(cntr-1))
    a(gg) = tofloat(tofloat(xin(cntr)-xx(gg)) / h(gg))
    b(gg) = tofloat(tofloat(xx(gg)-xin(cntr-1)) / h(gg))
    y(gg,:,:) = tofloat(a(gg)*yin(cntr-1,:,:))    +    tofloat(b(gg)*yin(cntr,:,:))      +      (     tofloat(a(gg)^3-a(gg))         *   ytk(cntr-1,:,:)    +      tofloat(b(gg)^3 - b(gg))  *   ytk(cntr,:,:)   )    *    tofloat(h(gg)^2 / 6.0)
  end do
  cntr = cntr+1

  do gg = 258, 288
    h(gg) = tofloat(xin(cntr)-xin(cntr-1))
    a(gg) = tofloat(tofloat(xin(cntr)-xx(gg)) / h(gg))
    b(gg) = tofloat(tofloat(xx(gg)-xin(cntr-1)) / h(gg))
    y(gg,:,:) = tofloat(a(gg)*yin(cntr-1,:,:))    +    tofloat(b(gg)*yin(cntr,:,:))      +      (     tofloat(a(gg)^3-a(gg))         *   ytk(cntr-1,:,:)    +      tofloat(b(gg)^3 - b(gg))  *   ytk(cntr,:,:)   )    *    tofloat(h(gg)^2 / 6.0)
  end do
  cntr = cntr+1

  do gg = 289, 318
    h(gg) = tofloat(xin(cntr)-xin(cntr-1))
    a(gg) = tofloat(tofloat(xin(cntr)-xx(gg)) / h(gg))
    b(gg) = tofloat(tofloat(xx(gg)-xin(cntr-1)) / h(gg))
    y(gg,:,:) = tofloat(a(gg)*yin(cntr-1,:,:))    +    tofloat(b(gg)*yin(cntr,:,:))      +      (     tofloat(a(gg)^3-a(gg))         *   ytk(cntr-1,:,:)    +      tofloat(b(gg)^3 - b(gg))  *   ytk(cntr,:,:)   )    *    tofloat(h(gg)^2 / 6.0)
  end do
  cntr = cntr+1

  do gg = 319, 349
    h(gg) = tofloat(xin(cntr)-xin(cntr-1))
    a(gg) = tofloat(tofloat(xin(cntr)-xx(gg)) / h(gg))
    b(gg) = tofloat(tofloat(xx(gg)-xin(cntr-1)) / h(gg))
    y(gg,:,:) = tofloat(a(gg)*yin(cntr-1,:,:))    +    tofloat(b(gg)*yin(cntr,:,:))      +      (     tofloat(a(gg)^3-a(gg))         *   ytk(cntr-1,:,:)    +      tofloat(b(gg)^3 - b(gg))  *   ytk(cntr,:,:)   )    *    tofloat(h(gg)^2 / 6.0)
  end do
  cntr = cntr+1

  do gg = 350, 364
    h(gg) = tofloat(xin(cntr)-xin(cntr-1))
    a(gg) = tofloat(tofloat(xin(cntr)-xx(gg)) / h(gg))
    b(gg) = tofloat(tofloat(xx(gg)-xin(cntr-1)) / h(gg))
    y(gg,:,:) = tofloat(a(gg)*yin(cntr-1,:,:))    +    tofloat(b(gg)*yin(cntr,:,:))      +      (     tofloat(a(gg)^3-a(gg))         *   ytk(cntr-1,:,:)    +      tofloat(b(gg)^3 - b(gg))  *   ytk(cntr,:,:)   )    *    tofloat(h(gg)^2 / 6.0)
  end do
  cntr = cntr+1


  return (y)

end

;************************************
;************************************
undef ("Reshape")
function Reshape( x:numeric, oldvarmeta:numeric, newvarmeta:numeric, lonArray:numeric, latArray:numeric, newLongName:string, newUnits:string)
local x2
begin

  copy_VarCoords(oldvarmeta(0,:,:), x)
  copy_VarMeta(oldvarmeta(0,:,:), x)
  x2 = x(::-1,:)
  x2lat = tofloat(x2&lat)
  x2lon = tofloat(x2&lon)
  x3    = tofloat(area_conserve_remap_Wrap (x2lon, x2lat, x2, lonArray, latArray, False))
  x4    = tofloat(x3(::-1,:))
  copy_VarCoords(newvarmeta(0,:,:), x4)
  x4@long_name = newLongName
  x4@units = newUnits
  delete(x2)
  delete(x3)
  return(x4)
end
;************************************
;************************************ 
undef ("ReshapeR1")
function ReshapeR1(name:string, origdims:numeric, newdims:numeric)
local x2
begin
  origdims2 = origdims(:,::-1,:)
  origdims3 = where(ismissing(origdims2),tofloat(99999),tofloat(origdims2))
  origdims3!0="time"
  origdims3!1="lat"
  origdims3!2="lon"
  origdims3&time = origdims&time
  origdims3&lat = origdims2&lat
  origdims3&lon = origdims2&lon

  origdims3time = origdims3&time
  origdims3lat = tofloat(origdims3&lat)
  origdims3lon = tofloat(origdims3&lon)
  newdims2 = newdims(:,::-1,:)
  newdims2lat = tofloat(newdims2&lat)
  newdims2lon = tofloat(newdims2&lon)
  reshapeddims    = tofloat(area_conserve_remap_Wrap (origdims3lon, origdims3lat, origdims3, newdims2lon, newdims2lat, False))
  reshapeddims2 = reshapeddims(:,::-1,:)
  reshapeddims3 = where(reshapeddims2.ge.100,origdims@_FillValue,reshapeddims2)
  reshapeddims3!0="time"
  reshapeddims3!1="lat"
  reshapeddims3!2="lon"
  reshapeddims3&time = origdims3time
  reshapeddims3&lat = newdims&lat
  reshapeddims3&lon = newdims&lon
  reshapeddims3&time@units = origdims&time@units
  reshapeddims3&lat@units = origdims&lat@units
  reshapeddims3&lon@units = origdims&lon@units
  reshapeddims3@_FillValue = origdims@_FillValue
  
  delete ([/origdims2, newdims2, reshapeddims , reshapeddims2 /]) 
  return(reshapeddims3)
end

;************************************
;************************************
undef ("QuickProb")
function QuickProb( x:numeric, y:numeric)
begin


thesizes_x = dimsizes(x)
thesizes_y = dimsizes(y)

missVals = 0
do gg = 0, thesizes_x - 1
  if (ismissing(x(gg))) then
    missVals = missVals + 1
  end if
  if (ismissing(y(gg))) then
    missVals = missVals + 1
  end if
end do


if (missVals.eq.0) then
  rl = regline(x,y)
  rldf = rl@nptxy-2
  prob = (1 - betainc(rldf/(rldf+rl@tval^2), rldf/2.0, 0.5) )
  newprob = prob
  if(rl.lt.0) then
    newprob = 0 - prob
  end if
end if

if (missVals.gt.0) then
  newprob = y@_FillValue
end if
return(newprob)

end

;************************************
;************************************
undef ("QuickProb2")
function QuickProb2( x:numeric, y:numeric)
begin


thesizes_x = dimsizes(x)
thesizes_y = dimsizes(y)

missVals = 0
do gg = 0, thesizes_x - 1
  if (ismissing(x(gg))) then
    missVals = missVals + 1
  end if
  if (ismissing(y(gg))) then
    missVals = missVals + 1
  end if
end do


if (missVals.eq.0) then
  newprob = 0.0
  rangex = tofloat(max(x)) - tofloat(min(x))
  rangey = tofloat(max(y)) - tofloat(min(y))
  if (rangex.gt.0.and.rangey.gt.0) then
    rls = regline_stats(x,y)
    rls_pval = rls@F_pval
    prob = (1 - rls_pval )
    newprob = prob
    if(rls.lt.0) then
      newprob = 0 - prob
    end if
  end if
end if

if (missVals.gt.0) then
  newprob = y@_FillValue
end if
return(newprob)

end


;************************************
;************************************
undef ("reg_multlin_with_missing")
function reg_multlin_with_missing( dependent:numeric, independents:numeric, theopt:logical)
begin

  independents_sizes = dimsizes(independents)


  dependent_sizes = dimsizes(dependent)
  non_missing_count = 0

  do gg = 0, dependent_sizes - 1
    if (.not.ismissing(dependent(gg))) then
      non_missing_count = non_missing_count + 1
    end if
  end do

  newdependent = new (non_missing_count,"float")

  newX = new ((/non_missing_count,independents_sizes(1)/),"float")

  newcount = 0


  do hh = 0, independents_sizes(0) - 1            ; each year count
    if (.not.ismissing(dependent(hh))) then
      newdependent(newcount) = dependent(hh)
      do ii = 0, independents_sizes(1) - 1            ; each var count
        newX(newcount,ii) = independents(hh,ii)
      end do
      newcount = newcount + 1
    end if
  end do


  newbeta = reg_multlin_stats(newdependent,newX,theopt)


  return(newbeta)

end

