deadAsc(val1, val2, a) {
  global
  if !DeadSilence
    OutputChar(val1, val2)
  DeadKey := a
}

deadUni(val1, val2, a) {
  global
  if !DeadSilence
    SendUnicodeChar(val1, val2)
  DeadKey := a
}

undeadAsc(val) {
  global
  if DeadSilence
    send % val
  else
    send % "{bs}" . val
}

undeadUni(val){
  global
  if !DeadSilence
    send {bs}
  SendUnicodeChar(val, "")
}

CheckDeadAsc(d,val) {
  global
  if (PriorDeadKey == d) {
    undeadAsc(val)
    return 1
  }
}

CheckDeadUni(d,val) {
  global
  if (PriorDeadKey == d) {
    undeadUni(val)
    return 1
  }
}

CheckDeadAsc12(d,val1,val2) {
  global
  if (PriorDeadKey == d){
    if (Ebene = 1) and (val1 != "") {
      undeadAsc(val1)
      return 1
    } else if (Ebene = 2) and (val2 != "") {
      undeadAsc(val2)
      return 1
    }
  }
}

CheckDeadUni12(d,val1,val2) {
  global
  if(PriorDeadKey == d) {
    if (Ebene = 1) and (val1 != "") {
      undeadUni(val1)
      return 1
    } else if (Ebene = 2) and (val2 != "") {
      undeadUni(val2)
      return 1
    }
  }
}

CheckCompUni(d,val) {
  global
  if (CompKey == d) {
    PriorCompKey =
    CompKey =
    if !DeadCompose
      send {bs}
    isFurtherCompkey = 0
    SendUnicodeChar(val, "")
    return 1
  }
}

OutputChar(val1,val2) {
  global
  if !(CheckComp(val2) and DeadCompose)
    send % "{blind}" . val1
}

OutputChar12(val1,val2,val3,val4) {
  global
  if (Ebene = 1)
    c := val1
  else c := val2
  if (Ebene = 1)
    d := val3
  else d := val4
  if !(CheckComp(d) and DeadCompose)
    if GetKeyState("Shift","P") and isMod2Locked
      send % "{blind}{Shift Up}" . c . "{Shift Down}"
    else send % "{blind}" . c
}

CheckComp(d) {
  global
  if isFurtherCompkey {
    CompKey := PriorCompKey . " " . "<" . d . ">"
    isFurtherCompkey = 0
    CheckCompose()
    if (CompKey = "")
      return 1
    else CompKey =
  } else if PriorCompKey {
    CompKey := PriorCompKey . " " . "<" . d . ">"
    CheckCompose()
    if CompKey
      isFurtherCompKey = 1
    return 1
  } else if (PriorDeadKey = "comp") {
    CompKey := "<" . d . ">"
    return 1
  }
}
