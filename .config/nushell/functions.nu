alias functions = vim ~/.config/nushell/functions.nu

def fd [id?: int] {
  match $id {
    null => { job unfreeze }
    _ => { job unfreeze $id }
  }
}

def jk [id?: int] {
  # job kill $id
  match $id {
    null => {job kill (jobs | first).id}
    _ => {job kill $id}
  }
}

def jka [] {
  for $id in (jobs).id {
    jk $id
  }
}

# alias ,. = dirs next
def ,. [id?: int] {
  match $id {
    null => { dirs next }
    _ => { dirs goto $id }
  }
}
