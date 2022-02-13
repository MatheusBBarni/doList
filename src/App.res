open Ancestor.Default

Emotion.injectGlobal({
  "html": {
    "fontSize": "10px",
  },
  "html, body, #root": {
    "width": "100%",
    "height": "100%",
    "margin": "0",
    "padding": "0",
  },
  "*": {
    "boxSizing": "border-box",
    "fontFamily": Theme.Constants.fontFamily,
  },
})

let client = ReactQuery.Provider.createClient()

@react.component
let make = () => {
  <ReactQuery.Provider client>
    <Box
      py=[xs(9)]
      px=[xs(9)]
      width=[xs(100.0->#pct)]
      minH=[xs(100.0->#pct)]
      bgColor=[xs(Theme.Colors.black)]>
      <Tasks />
    </Box>
  </ReactQuery.Provider>
}
