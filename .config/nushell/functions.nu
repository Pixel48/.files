alias functions = vim ~/.config/nushell/functions.nu

def fd [id?: int] {
  match $id {
    null => { job unfreeze }
    _ => { job unfreeze $id }
  }
}
