
# let interns = [asudyka, azajac, ggrzyb, jbeltowski, jklimek, jkucaba, kgarbacki, mrzezawski, spigon, ssynal, snowak, spajak, sszewczyk]
let interns = ['asudyka', 'azajac', 'ggrzyb', 'jbeltowski', 'jklimek', 'jkucaba', 'kgarbacki', 'mrzezawski', 'spigon', 'ssynal', 'snowak', 'spajak', 'sszewczyk']
def ginterns [] {
  for intern in $interns {
    echo "\t\e[0;1'7m$intern\e[m" and (glab repos -u $intern)
  }
}
