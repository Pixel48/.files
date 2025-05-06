alias functions = vim ~/.config/nushell/functions.nu

def --env fd [id?: int] {
  match $id {
    null => { job unfreeze }
    _ => { job unfreeze $id }
  }
}

def --env jk [id?: int] {
  # job kill $id
  match $id {
    null => {job kill (jobs | first).id}
    _ => {job kill $id}
  }
}

def --env jka [] {
  for $id in (jobs).id {
    jk $id
  }
}

# alias ,. = dirs next
def --env ,. [id?: int] {
  match $id {
    null => { dirs next }
    _ => { dirs goto $id }
  }
}

def --env mkcd [dirname: path] {
  mkdir $dirname
  cd $dirname
}
