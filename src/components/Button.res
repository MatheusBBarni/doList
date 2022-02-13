open Render
open Ancestor.Default

module Styles = {
  open Theme
  open Emotion

  let {toString: colorToString} = module(Colors)

  let button = (~disabled) =>
    css({
      "outline": "none",
      "border": "none",
      "color": Colors.white->colorToString,
      "fontSize": "1.6rem",
      "lineHeight": "2.1rem",
      "letterSpacing": "0rem",
      "backgroundColor": Colors.primary->colorToString,
      "minWidth": "10.5rem",
      "height": "3.8rem",
      "borderRadius": "6px",
      "cursor": disabled ? "not-allowed" : "pointer",
      "transition": "300ms",
      "display": "flex",
      "justifyContent": "center",
      "alignItems": "center",
      "opacity": disabled ? "0.5" : "1",
      "&:hover": {
        "backgroundColor": Colors.primaryDark->colorToString,
      },
    })
}

@react.component
let make = (~children, ~onClick=?, ~loading=false, ~disabled=false) => {
  <button disabled ?onClick className={Styles.button(~disabled)}>
    {switch loading {
    | true => <Base tag=#img src=Assets.spinner width=[xs(2.4->#rem)] />
    | false => children->s
    }}
  </button>
}
