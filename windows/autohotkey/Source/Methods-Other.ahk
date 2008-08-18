BSSendUnicodeChar(charCode)
{
   send {bs}
   SendUnicodeChar(charCode)
}

CompUnicodeChar(charCode)
{
   send {bs}
   SendUnicodeChar(charCode)
}

Comp3UnicodeChar(charCode)
{
   send {bs}{bs}
   SendUnicodeChar(charCode)
}

deadAsc(val)
{
  global
  if (DeadSilence)
    {} ; keine Ausgabe
  else
    send % "{blind}" . val
}

deadUni(val)
{
  global
  if (DeadSilence)
    {} ; keine Ausgabe
  else
    SendUnicodeChar(val)
}

undeadAsc(val)
{
  global
  if (DeadSilence)
    send % "{blind}" . val
  else
    send % "{blind}{bs}" . val
}

undeadUni(val)
{
  global
  if (DeadSilence)
    {} ; keine ausgabe
  else
    send {bs}
  SendUnicodeChar(val)    
}

CheckDeadAsc(d,val)
{
  global
  if (PriorDeadKey == d)
  {
    undeadAsc(val)
    return 1
  }
  else
    return 0
}

CheckDeadUni(d,val)
{
  global
  if (PriorDeadKey == d)
  {
    undeadUni(val)
    return 1
  }
  else
    return 0
}

CheckDeadAsc12(d,val1,val2)
{
  global
  if (PriorDeadKey == d)
  {
    if      ((Ebene = 1) and (val1 != ""))
    {
      undeadAsc(val1)
      return 1
    }
    else if ((Ebene = 2) and (val2 != ""))
    {
      undeadAsc(val2)
      return 1
    }
    else 
      return 0
  }
  else
    return 0
}

CheckDeadUni12(d,val1,val2)
{
  global
  if (PriorDeadKey == d)
  {
    if      ((Ebene = 1) and (val1 != ""))
    {
      undeadUni(val1)
      return 1
    }
    else if ((Ebene = 2) and (val2 != ""))
    {
      undeadUni(val2)
      return 1
    }
    else 
      return 0
  }
  else
    return 0
}

compAsc(val)
{
  global
  if (DeadCompose)
    {} ; keine Ausgabe
  else
    send % "{blind}" . val
}

compUni(val)
{
  global
  if (DeadCompose)
    {} ; keine Ausgabe
  else
    SendUnicodeChar(val)
}

uncompAsc(val)
{
  global
  if (DeadCompose)
    send % "{blind}" . val
  else
    send % "{blind}{bs}" . val
}

uncompUni(val)
{
  global
  if (DeadCompose)
    {} ; keine ausgabe
  else
    send {bs}
  SendUnicodeChar(val)    
}

uncomp3Uni(val)
{
  global
  if (DeadCompose)
    {} ; keine ausgabe
  else
    send {bs}{bs}
  SendUnicodeChar(val)    
}

CheckCompAsc(d,val)
{
  global
  if (PriorCompKey == d)
  {
    uncompAsc(val)
    return 1
  }
  else
    return 0
}

CheckCompAsc12(d,val1,val2)
{
  global
  if (PriorCompKey == d)
    if      ((Ebene = 1) and (val1 != ""))
    {
      uncompAsc(val1)
      return 1
    }
    else if ((Ebene = 2) and (val2 != ""))
    {
      uncompAsc(val2)
      return 1
    }
    else 
      return 0
  else
    return 0
}

CheckCompUni(d,val)
{
  global
  if (PriorCompKey == d)
  {
    uncompUni(val)
    return 1
  }
  else
    return 0
}

CheckCompUni12(d,val1,val2)
{
  global
  if (PriorCompKey == d)
  {
    if      ((Ebene = 1) and (val1 != ""))
    {
      uncompUni(val1)
      return 1
    }
    else if ((Ebene = 2) and (val2 != ""))
    {
      uncompUni(val2)
      return 1
    }
    else 
      return 0
  }
  else
    return 0
}

CheckComp3Uni(d,val)
{
  global
  if (PriorCompKey == d)
  {
    uncomp3Uni(val)
    return 1
  }
  else
    return 0
}

CheckComp3Uni12(d,val1,val2)
{
  global
  if (PriorCompKey == d)
  {
    if      ((Ebene = 1) and (val1 != ""))
    {
      uncomp3Uni(val1)
      return 1
    }
    else if ((Ebene = 2) and (val2 != ""))
    {
      uncomp3Uni(val2)
      return 1
    }
    else
      return 0
  }
  else
    return 0
}

outputChar(val1,val2)
{
  global
  if (Ebene = 1)
    c := val1
  else
    c := val2
  if GetKeyState("Shift","P") and isMod2Locked
    send % "{blind}{Shift Up}" . c . "{Shift Down}"
  else
    send % "{blind}" . c
  if (PriorDeadKey = "comp")
    CompKey := c
}


