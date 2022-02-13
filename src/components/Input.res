module Styles = {
  open Theme
  open Emotion

  let {toString: colorToString} = module(Colors)

  let input = css({
    "outline": "none",
    "border": "none",
    "color": Colors.white->colorToString,
    "fontSize": "1.8rem",
    "padding": "1.6rem 1.6rem",
    "borderRadius": "6px",
    "width": "100%",
    "background": Colors.grayDark->colorToString,
    "transition": "300ms",
    "&:placeholder": {
      "color": Colors.grayLight->colorToString,
    },
    "&:focus": {
      "transition": "300ms",
      "boxShadow": `0 0 0 2px ${Colors.primary->colorToString}`,
    },
  })
}

@react.component
let make = (~onChange=?, ~name=?, ~placeholder=?, ~value=?) => {
  <input ?onChange ?name ?placeholder className=Styles.input ?value />
}
