/*
   ------------------------------------------------------
   QWERTZ->Neo umwandlung
   ------------------------------------------------------
*/
; Reihe 1
*SC029::goto neo_tot1  ; Zirkumflex ^
*1::goto neo_1
*2::goto neo_2
*3::goto neo_3
*4::goto neo_4
*5::goto neo_5
*6::goto neo_6
*7::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_7
     else
      {
        keypressed := 1
        goto %gespiegelt_7%
      }
return
*8::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_8
     else
      {
        keypressed := 1
        goto %gespiegelt_8%
      }
return
*9::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_9
     else
      {
        keypressed := 1
        goto %gespiegelt_9%
      }
return
*0::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_0
     else
      {
        keypressed := 1
        goto %gespiegelt_0%
      }
return
*SC00C::  ; ß
  if ( not(ahkTreiberKombi) )
  {
       if( not(einHandNeo) or not(spacepressed) )
       goto neo_strich
     else
      {
        keypressed := 1
        goto %gespiegelt_strich%
      }
   }
  else
  {
     goto neo_sz   
  }
*SC00D::goto neo_tot2  ; Akut			
; Reihe 2
*Tab::goto neo_tab
*q::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_x
  }
  else
  {
     goto neo_q   
  }
*w::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_v
  }
  else
  {
     goto neo_w   
  }
*e::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_l
  }
  else
  {
     goto neo_e   
  }
*r::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_c
  }
  else
  {
     goto neo_r   
  }
*t::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_w
  }
  else
  {
     goto neo_t   
  }
*SC015::  ; z 
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_k
     else
      {
        keypressed := 1
        goto %gespiegelt_k%
      }
  }
  else
  {
     goto neo_z   
  }
*u::
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_h
     else
      {
        keypressed := 1
        goto %gespiegelt_h%
      }
  }
  else
  {
     goto neo_u   
  }
*i::
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_g
     else
      {
        keypressed := 1
        goto %gespiegelt_g%
      }
  }
  else
  {
     goto neo_i   
  }
*o::
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_f
     else
      {
        keypressed := 1
        goto %gespiegelt_f%
      }
  }
  else
  {
     goto neo_o   
  }
*p::
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_q
     else
      {
        keypressed := 1
        goto %gespiegelt_q%
      }
  }
  else
  {
     goto neo_p   
  }
*SC01A:: ; ü
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_sz
     else
      {
        keypressed := 1
        goto %gespiegelt_sz%
      }
  }
  else
  {
     goto neo_ü   
  }
*SC01B::  ; +
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_tot3
     else
      {
        keypressed := 1
        goto %gespiegelt_tot3%
      }
  }
  else
  { } ; this should never happen
; Reihe 3
*a::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_u
  }
  else
  {
     goto neo_a   
  }
*s::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_i
  }
  else
  {
     goto neo_s   
  }
*d::goto neo_a
  if ( not(ahkTreiberKombi) )
  {
     goto neo_a
  }
  else
  {
     goto neo_d   
  }
*f::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_e
  }
  else
  {
     goto neo_f   
  }
*g::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_o
  }
  else
  {
     goto neo_g   
  }
*h::
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_s
     else
      {
        keypressed := 1
        goto %gespiegelt_s%
      }
  }
  else
  {
     goto neo_h   
  }
*j::
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_n
     else
      {
        keypressed := 1
        goto %gespiegelt_n%
      }
  }
  else
  {
     goto neo_j   
  }
*k::
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_r
     else
      {
        keypressed := 1
        goto %gespiegelt_r%
      }
  }
  else
  {
     goto neo_k   
  }
*l::
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_t
     else
      {
        keypressed := 1
        goto %gespiegelt_t%
      }
  }
  else
  {
     goto neo_l   
  }
*SC027::  ; ö
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_d
     else
      {
        keypressed := 1
        goto %gespiegelt_d%
      }
  }
  else
  {
     goto neo_ö   
  }
*SC028::  ; ä
  if ( not(ahkTreiberKombi) )
  {
     goto neo_y
  }
  else
  {
     goto neo_ä
  }
; Reihe 4
*SC02C::  ; y
  if ( not(ahkTreiberKombi) )
  {
     goto neo_ü
  }
  else
  {
     goto neo_y   
  }
*x::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_ö
  }
  else
  {
     goto neo_x   
  }
*c::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_ä
  }
  else
  {
     goto neo_c
  }
*v::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_p
  }
  else
  {
     goto neo_v
  }
*b::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_z
  }
  else
  {
     goto neo_b
  }
*n::
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_b
     else
      {
        keypressed := 1
        goto %gespiegelt_b%
      }
  }
  else
  {
     goto neo_n
  }
*m::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_m
     else
      {
        keypressed := 1
        goto %gespiegelt_m%
      }
return
*SC033::  ; Komma ,
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_komma
     else
      {
        keypressed := 1
        goto %gespiegelt_komma%
      }
return
*SC034::  ; Punkt .
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_punkt
     else
      {
        keypressed := 1
        goto %gespiegelt_punkt%
      }
return
*SC035::  ; Minus -
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_j
     else
      {
        keypressed := 1
        goto %gespiegelt_j%
      }
  }
  else
  {
     goto neo_strich
  }
; Numpad
*NumpadDiv::goto neo_NumpadDiv
*NumpadMult::goto neo_NumpadMult
*NumpadSub::goto neo_NumpadSub
*NumpadAdd::goto neo_NumpadAdd
*NumpadEnter::goto neo_NumpadEnter
*Numpad7::goto neo_Numpad7
*Numpad8::goto neo_Numpad8
*Numpad9::goto neo_Numpad9
*Numpad4::goto neo_Numpad4
*Numpad5::goto neo_Numpad5
*Numpad6::goto neo_Numpad6
*Numpad1::goto neo_Numpad1
*Numpad2::goto neo_Numpad2
*Numpad3::goto neo_Numpad3
*Numpad0::goto neo_Numpad0
*NumpadDot::goto neo_NumpadDot
*NumpadHome::goto neo_NumpadHome
*NumpadUp::goto neo_NumpadUp
*NumpadPgUp::goto neo_NumpadPgUp
*NumpadLeft::goto neo_NumpadLeft
*NumpadClear::goto neo_NumpadClear
*NumpadRight::goto neo_NumpadRight
*NumpadEnd::goto neo_NumpadEnd
*NumpadDown::goto neo_NumpadDown
*NumpadPgDn::goto neo_NumpadPgDn
*NumpadIns::goto neo_NumpadIns
*NumpadDel::goto neo_NumpadDel



