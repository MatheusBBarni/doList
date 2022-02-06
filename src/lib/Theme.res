module Colors = {
  let primary = #hex("#743AF0")
  let primaryDark = #hex("#5820CF")
  let primaryLight = #hex("#6F5A9A")

  let white = #hex("#FFFFFF")
  let black = #hex("#070707")
  let red = #hex("#FF1B51")

  let gray = #hex("#3A3939")
  let grayDark = #hex("#242424")
  let grayLight = #hex("#A7A7A7")

  let toString = color =>
    switch color {
    | #hex(color) => color
    }
}

module Constants = {
  let fontFamily = "'DM Sans', sans-serif"
}
