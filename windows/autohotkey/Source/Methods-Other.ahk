deadAsc(val) {
  global
  if !DeadSilence
    send % val
}

deadUni(val) {
  global
  if !DeadSilence
    SendUnicodeChar(val)
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
  SendUnicodeChar(val)
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

CheckCompAsc(d,val) {
  global
  if (PriorCompKey == d) {
    send % val
    return 1
  }
}

CheckCompAsc12(d,val1,val2) {
  global
  if (PriorCompKey == d)
    if (Ebene = 1) and (val1 != "") {
      send % val1
      return 1
    } else if (Ebene = 2) and (val2 != "") {
      send % val2
      return 1
    }
}

CheckCompUni(d,val) {
  global
  if (PriorCompKey == d) {
    SendUnicodeChar(val)
    return 1
  }
}

CheckCompUni12(d,val1,val2){
  global
  if (PriorCompKey == d) {
    if (Ebene = 1) and (val1 != "") {
      SendUnicodeChar(val1)
      return 1
    } else if (Ebene = 2) and (val2 != "") {
      SendUnicodeChar(val2)
      return 1
    }
  }
}

CheckComp3Uni(d,val) {
  global
  if (PriorCompKey == d) {
    SendUnicodeChar(val)
    return 1
  }
}

CheckComp3Uni12(d,val1,val2) {
  global
  if (PriorCompKey == d) {
    if (Ebene = 1) and (val1 != "") {
      SendUnicodeChar(val1)
      return 1
    } else if (Ebene = 2) and (val2 != "") {
      SendUnicodeChar(val2)
      return 1
    }
  }
}

outputChar(val1,val2) {
  global
  if (Ebene = 1)
    c := val1
  else c := val2
  if !(CheckComp(c) and DeadCompose or PriorCompKey)
    if GetKeyState("Shift","P") and isMod2Locked
      send % "{blind}{Shift Up}" . c . "{Shift Down}"
    else send % "{blind}" . c
}

checkComp(d) {
  global
  if (PriorDeadKey = "comp") {
    CompKey := d
    return 1
  }
}
