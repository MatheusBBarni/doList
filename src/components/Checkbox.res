@module("../assets/check-icon.svg")
external checkIcon: string = "default"

module Styles = {
  open Theme
  open Emotion

  let {toString: colorToString} = module(Colors)

  let fillAnimation = keyframes({
    "0%": {
      "transform": "scale(0)",
    },
    "50%": {
      "transform": "scale(1.25)",
    },
    "100%": {
      "transform": "scale(1)",
    },
  })

  let checkboxWrapper = css({
    "cursor": "pointer",
    "> input": {
      "display": "none",
    },
    "> div": {
      "position": "relative",
      "width": "2.4rem",
      "height": "2.4rem",
      "border": `2px solid ${Colors.primary->colorToString}`,
      "borderRadius": "6px",
      "> img": {
        "position": "absolute",
        "top": "0.5rem",
        "left": "0.3rem",
        "transform": "scale(0)",
      },
      "&:after": {
        "content": "''",
        "borderRadius": "4px",
        "position": "absolute",
        "width": "100%",
        "height": "100%",
        "top": 0,
        "left": 0,
        "background": Colors.primary->colorToString,
        "transform": "scale(0)",
      },
    },
    "> input:checked + div": {
      "> img": {
        "zIndex": 10,
        "animation": `${fillAnimation} 300ms forwards`,
        "animationDelay": "100ms",
      },
      "&:after": {
        "zIndex": 8,
        "animation": `${fillAnimation} 300ms forwards`,
      },
    },
  })
}

@react.component
let make = (~checked=?, ~onChange=?) => {
  <label className=Styles.checkboxWrapper>
    <input type_="checkbox" ?checked ?onChange />
    <div> <img src=checkIcon alt="Checkbox Icon" /> </div>
  </label>
}
