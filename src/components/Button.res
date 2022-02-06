open Render

module Styles = {
  open Theme
  open Emotion

  let {toString: colorToString} = module(Colors)

  let button = css({
    "outline": "none",
    "border": "none",
    "color": Colors.white->colorToString,
    "fontSize": "1.6rem",
    "lineHeight": "2.1rem",
    "letterSpacing": "-0.35rem",
    "backgroundColor": Colors.primary->colorToString,
    "minWidth": "10.5rem",
    "height": "3.8rem",
    "borderRadius": "6px",
    "cursor": "pointer",
    "transition": "300ms",
    "&:hover": {
      "backgroundColor": Colors.primaryDark->colorToString,
    },
  })
}

@react.component
let make = (~children, ~onClick=?) => {
  <button ?onClick className=Styles.button> {children->s} </button>
}
