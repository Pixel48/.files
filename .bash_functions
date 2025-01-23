ok() {
  sudo $(history -p !!)
}

mkcd() {
  mkdir -p $@ && cd ${@:$#}
}
