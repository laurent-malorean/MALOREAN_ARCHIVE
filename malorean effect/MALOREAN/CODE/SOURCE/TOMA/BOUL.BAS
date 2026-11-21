x% = 160: y% = 100: xx% = 2: yy% = 2
aa% = xx% / 2: bb% = yy% / 2: a% = x% + aa%: b% = y% + bb%
x1% = 160: y1% = 100: xx1% = 4: yy1% = -2
aa1% = xx1% / 2: bb1% = yy1% / 2: a1% = x1% + aa1%: b1% = y1% + bb1%
r = 10: r1% = 30: rr% = 1: rr1% = 1
i% = 1
DIM t(1 TO 138) AS STRING * 20
t$(1) = "         <>"
t$(2) = "        <  >"
t$(3) = "       <    >"
t$(4) = "      <      >"
t$(5) = "     <        >"
t$(6) = "    <          >"
t$(7) = "   <            >"
t$(8) = "  <              >"
t$(9) = " <               D>"
t$(10) = "<               DEM>"
t$(11) = "<              DEMO>"
t$(12) = "<             DEMO >"
t$(13) = "<            DEMO  >"
t$(14) = "<           DEMO   >"
t$(15) = "<          DEMO    >"
t$(16) = "<         DEMO     >"
t$(17) = "<        DEMO      >"
t$(18) = "<       DEMO       >"
t$(19) = "<      D EM O      >"
t$(20) = "<       DEMO       >"
t$(21) = "<      D EM O      >"
t$(22) = "<     D E  M O     >"
t$(23) = "<      D EM O      >"
t$(24) = "<       DEMO       >"
t$(25) = "<      D EM O      >"
t$(26) = "<     D E  M O     >"
t$(27) = "<    D E    M O    >"
t$(28) = "<     D E  M O     >"
t$(29) = "<      D EM O      >"
t$(30) = "<       DEMO       >"
t$(31) = "<      D EM O      >"
t$(32) = "<     D E  M O     >"
t$(33) = "<    D E    M O    >"
t$(34) = "<   D  E    M  O   >"
t$(35) = "<    D E    M O    >"
t$(36) = "<     D E  M O     >"
t$(37) = "<      D EM O      >"
t$(38) = "<       DEMO       >"
t$(39) = "<      D EM O      >"
t$(40) = "<     D E  M O     >"
t$(41) = "<    D E    M O    >"
t$(42) = "<   D  E    M  O   >"
t$(43) = "<  D  E      M   O >"
t$(44) = "<   D  E    M  O   >"
t$(45) = "<    D E    M O    >"
t$(46) = "<     D E  M O     >"
t$(47) = "<      D EM O      >"
t$(48) = "<       DEMO       >"
t$(49) = "<      D EM O      >"
t$(50) = "<     D E  M O     >"
t$(51) = "<    D E    M O    >"
t$(52) = "<   D  E    M  O   >"
t$(53) = "<  D  E      M   O >"
t$(54) = "<D    E      M    O>"
t$(55) = "<DD   EE    MM   OO>"
t$(56) = "<DDD  EEE  MMM  OOO>"
t$(57) = "<DDDD EEEE MMMM OOO>"
t$(58) = "<DDDDDEEEEMMMMMOOOO>"
t$(59) = "<dDDDDEEEEMMMMMOOOO>"
t$(60) = "<ddDDDEEEEMMMMMOOOO>"
t$(61) = "<dddDDEEEEMMMMMOOOO>"
t$(62) = "<ddddDEEEEMMMMMOOOO>"
t$(63) = "<dddddEEEEMMMMMOOOO>"
t$(64) = "<dddddeEEEMMMMMOOOO>"
t$(65) = "<dddddeeEEMMMMMOOOO>"
t$(66) = "<dddddeeeEMMMMMOOOO>"
t$(67) = "<dddddeeeeMMMMMOOOO>"
t$(68) = "<dddddeeeemMMMMOOOO>"
t$(69) = "<dddddeeeemmMMMOOOO>"
t$(70) = "<dddddeeeemmmMMOOOO>"
t$(71) = "<dddddeeeemmmmMOOOO>"
t$(72) = "<dddddeeeemmmmmOOOO>"
t$(73) = "<dddddeeeemmmmmoOOO>"
t$(74) = "<dddddeeeemmmmmooOO>"
t$(75) = "<dddddeeeemmmmmoooO>"
t$(76) = "<dddddeeeemmmmmoooo>"
t$(77) = "<ddddd*eeemmmmmoooo>"
t$(78) = "<ddddd eeemm*mmoooo>"
t$(79) = "<*dddd e*emm mmoooo>"
t$(80) = "< ddd* e emm mmoo*o>"
t$(81) = "< *dd  e em* mmoo o>"
t$(82) = "<  dd  * em  mmoo o>"
t$(83) = "<  dd    em  mm*o o>"
t$(84) = "<  dd    em  *m o o>"
t$(85) = "<  d*    e*   m o o>"
t$(86) = "<  d     e    m * o>"
t$(87) = "<  *     e    m   o>"
t$(88) = "<        e    m   *>"
t$(89) = "<        *    m    >"
t$(90) = "<             *    >"
t$(91) = "<                 .>"
t$(92) = "<                ..>"
t$(93) = "<               ...>"
t$(93) = "<              ... >"
t$(94) = "<             ... I>"
t$(95) = "<            ... I'>"
t$(96) = "<           ... I'm>"
t$(97) = "<          ... I'm >"
t$(98) = "<         ... I'm t>"
t$(99) = "<        ... I'm th>"
t$(100) = "<       ... I'm the>"
t$(101) = "<      ... I'm the >"
t$(102) = "<     ... I'm the B>"
t$(103) = "<    ... I'm the Be>"
t$(104) = "<   ... I'm the Bes>"
t$(105) = "<  ... I'm the Best>"
t$(106) = "< ... I'm the Best >"
t$(107) = "<... I'm the Best .>"
t$(108) = "<.. I'm the Best ..>"
t$(109) = "<.. I'm the Best ..>"
t$(110) = "<...I'm the Best ..>"
t$(111) = "< ...'m the Best ..>"
t$(112) = "<t ...m the Best ..>"
t$(113) = "<st ... the Best ..>"
t$(114) = "<est ...the Best ..>"
t$(115) = "<Rest ...he Best ..>"
t$(116) = "< Rest ...e Best ..>"
t$(117) = "<e Rest ... Best ..>"
t$(118) = "<he Rest ...Best ..>"
t$(119) = "<the Rest ...est ..>"
t$(120) = "< the Rest ...st ..>"
t$(121) = "<k the Rest ...t ..>"
t$(122) = "<ck the Rest ... ..>"
t$(123) = "<uck the Rest .....>"
t$(124) = "<Fuck the Rest ....>"
t$(125) = "< Fuck the Rest ...>"
t$(126) = "<I Fuck the Rest ..>"
t$(127) = "< I Fuck the Rest .>"
t$(128) = "<  I Fuck the Rest >"
t$(129) = " < I Fuck the Rest> "
t$(130) = "  <I Fuck the Res> "
t$(131) = "   < Fuck the Re> "
t$(132) = "    <Fuck the R> "
t$(133) = "     <uck the > "
t$(134) = "      <ck the> "
t$(135) = "       <k th> "
t$(136) = "        < t> "
t$(137) = "         <> "
t$(138) = "         <>"
1
SCREEN 7, , 0, 1
CIRCLE (x%, y%), r%, 0
CIRCLE (x1%, y1%), r1%, 0
CIRCLE (320 - x%, 200 - y%), 50 - r%, 0
CIRCLE (320 - x1%, 200 - y1%), 50 - r1%, 0
CLS
r% = r% + rr%: IF r% > 49 OR r% < 1 THEN rr% = -rr%
r1% = r1% + rr1%: IF r1% > 49 OR r1% < 1 THEN rr1% = -rr1%
x% = x% + xx%: y% = y% + yy%
IF x% < 0 OR x% > 310 THEN
  xx% = -xx%
  aa% = -aa%
  x% = x% + 2 * xx%
END IF
IF y% < 0 OR y% > 190 THEN
  yy% = -yy%
  bb% = -bb%
  y% = y% + 2 * yy%
END IF
x1% = x1% + xx1%: y1% = y1% + yy1%
IF x1% < 0 OR x1% > 310 THEN
  xx1% = -xx1%
  aa1% = -aa1%
  x1% = x1% + 2 * xx1%
END IF
IF y1% < 0 OR y1% > 190 THEN
  yy1% = -yy1%
  bb1% = -bb1%
  y1% = y1% + 2 * yy1%
END IF
LOCATE 10, 10: PRINT t$(i%)
CIRCLE (x%, y%), r%, 9
CIRCLE (x1%, y1%), r1%, 10
CIRCLE (320 - x%, 200 - y%), 50 - r%, 11
CIRCLE (320 - x1%, 200 - y1%), 50 - r1%, 12
SCREEN 7, , 1, 0
CIRCLE (a%, b%), ar%, 0
CIRCLE (a1%, b1%), ar1%, 0
CIRCLE (320 - a%, 200 - b%), 50 - ar%, 0
CIRCLE (320 - a1%, 200 - b1%), 50 - ar1%, 0
i% = i% + 1: IF i% > 138 THEN i% = 1
ar% = r%: ar1% = r1%
a% = x% + aa%: b% = y% + bb%
a1% = x1% + aa1%: b1% = y1% + bb1%
LOCATE 10, 10: PRINT t$(i%)
CIRCLE (a%, b%), ar%, 9
CIRCLE (a1%, b1%), ar1%, 10
CIRCLE (320 - a%, 200 - b%), 50 - ar%, 11
CIRCLE (320 - a1%, 200 - b1%), 50 - ar1%, 12
GOTO 1

