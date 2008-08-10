/*
   ------------------------------------------------------
   QWERTZ->Neo umwandlung
   ------------------------------------------------------
*/
; Reihe 1
*VKDCSC029::goto neo_tot1  ; Zirkumflex ^
*VK31SC002::goto neo_1
*VK32SC003::goto neo_2
*VK33SC004::goto neo_3
*VK34SC005::goto neo_4
*VK35SC006::goto neo_5
*VK36SC007::goto neo_6
*VK37SC008::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_7
     else
      {
        keypressed := 1
        goto %gespiegelt_7%
      }
*VK38SC009::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_8
     else
      {
        keypressed := 1
        goto %gespiegelt_8%
      }
*VK39SC00A::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_9
     else
      {
        keypressed := 1
        goto %gespiegelt_9%
      }
*VK30SC00B::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_0
     else
      {
        keypressed := 1
        goto %gespiegelt_0%
      }
*VKDBSC00C:: ; ß
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
*VKDDSC00D::goto neo_tot2  ; Akut			
; Reihe 2
VK09SC00F::goto neo_tab
*VK51SC010:: ; q (x)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_x
  }
  else
  {
     goto neo_q   
  }
*VK57SC011:: ; w (v)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_v
  }
  else
  {
     goto neo_w   
  }
*VK45SC012:: ; e (l)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_l
  }
  else
  {
     goto neo_e   
  }
*VK52SC013:: ; r (c)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_c
  }
  else
  {
     goto neo_r   
  }
*VK54SC014:: ; t (w)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_w
  }
  else
  {
     goto neo_t   
  }
*VK5ASC015:: ; z (k) 
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
*VK55SC016:: ; u (h)
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
*VK49SC017:: ; i (g)
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
*VK4FSC018:: ; o (f)
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
*VK50SC019:: ; p (q)
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
*VKBASC01A:: ; ü (ß)
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
*VKBBSC01B:: ; + (tot3)
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
*VK41SC01E:: ; a (u)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_u
  }
  else
  {
     goto neo_a   
  }
*VK53SC01F:: ; s (i)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_i
  }
  else
  {
     goto neo_s   
  }
*VK44SC020:: ; d (a)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_a
  }
  else
  {
     goto neo_d   
  }
*VK46SC021:: ; f (e)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_e
  }
  else
  {
     goto neo_f   
  }
*VK47SC022:: ; g (o)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_o
  }
  else
  {
     goto neo_g   
  }
*VK48SC023:: ; h (s)
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
*VK4ASC024:: ; j (n)
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
*VK4BSC025:: ; k (r)
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
*VK4CSC026:: ; l (t)
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
*VKC0SC027:: ; ö (d)
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
*VKDESC028:: ; ä (y)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_y
  }
  else
  {
     goto neo_ä
  }

; Reihe 4
*VK59SC02C:: ; y (ü)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_ü
  }
  else
  {
     goto neo_y   
  }
*VK58SC02D:: ; x (ö)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_ö
  }
  else
  {
     goto neo_x   
  }
*VK43SC02E:: ; c (ä)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_ä
  }
  else
  {
     goto neo_c
  }
*VK56SC02F:: ; v (p)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_p
  }
  else
  {
     goto neo_v
  }
*VK42SC030:: ; b (z)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_z
  }
  else
  {
     goto neo_b
  }
*VK4ESC031:: ; n (b)
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
*VK4DSC032:: ; m (m)
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_m
     else
      {
        keypressed := 1
        goto %gespiegelt_m%
      }
*VKBCSC033:: ; , (,)
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_komma
     else
      {
        keypressed := 1
        goto %gespiegelt_komma%
      }
*VKBESC034:: ; . (.)
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_punkt
     else
      {
        keypressed := 1
        goto %gespiegelt_punkt%
      }
*VKBDSC035:: ; - (j)
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
*VK6FSC135::goto neo_NumpadDiv
*VK6ASC037::goto neo_NumpadMult
*VK6DSC04A::goto neo_NumpadSub
*VK6BSC04E::goto neo_NumpadAdd
*VK0DSC11C::goto neo_NumpadEnter

*VK67SC047::                      ; NumPad7    (mit NumLock  und ohne Shift)
*VK24SC047::goto neo_Numpad7      ; NumPadHome (ohne Numlock oder mit Shift)

*VK68SC048::                      ; NumPad8    (mit NumLock  und ohne Shift)
*VK26SC048::goto neo_Numpad8      ; NumPadUp   (ohne Numlock oder mit Shift)

*VK69SC049::                      ; NumPad9    (mit NumLock  und ohne Shift)
*VK21SC049::goto neo_Numpad9      ; NumPadPgUp (ohne Numlock oder mit Shift)

*VK64SC04B::                      ; NumPad4    (mit NumLock  und ohne Shift)
*VK25SC04B::goto neo_Numpad4      ; NumPadLeft (ohne Numlock oder mit Shift)

*VK65SC04C::                      ; NumPad5    (mit NumLock  und ohne Shift)
*VK0CSC04C::goto neo_Numpad5      ; NumPadClear(ohne Numlock oder mit Shift)

*VK66SC04D::                      ; NumPad6    (mit NumLock  und ohne Shift)
*VK27SC04D::goto neo_Numpad6      ; NumPadRight(ohne Numlock oder mit Shift)

*VK61SC04F::                      ; NumPad1    (mit NumLock  und ohne Shift)
*VK23SC04F::goto neo_Numpad1      ; NumPadEnd  (ohne Numlock oder mit Shift)

*VK62SC050::                      ; NumPad2    (mit NumLock  und ohne Shift)
*VK28SC050::goto neo_Numpad2      ; NumPadDown (ohne Numlock oder mit Shift)

*VK63SC051::                      ; NumPad3    (mit NumLock  und ohne Shift)
*VK22SC051::goto neo_Numpad3      ; NumPadPgDn (ohne Numlock oder mit Shift)

*VK60SC052::                      ; NumPad0    (mit NumLock  und ohne Shift)
*VK2DSC052::goto neo_Numpad0      ; NumPadIns  (ohne Numlock oder mit Shift)

*VK6ESC053::                      ; NumPadDot  (mit NumLock  und ohne Shift)
*VK2ESC053::goto neo_NumpadDot    ; NumPadIns  (ohne Numlock oder mit Shift)
