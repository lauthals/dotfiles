// For more information on customizing Oni,
// check out our wiki page:
// https://github.com/onivim/oni/wiki/Configuration

const activate = (oni) => {
    console.log("config activated")

    // Input 
    //
    // Add input bindings here:
    //
    //oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))

    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")
}

const deactivate = () => {
    console.log("config deactivated")
}

module.exports = {
    activate,
    deactivate,

   //"oni.useDefaultConfig": true,
   //"oni.bookmarks": ["~/Documents"],
   //"editor.fontSize": "14px",
   //"editor.fontFamily": "Monaco",
   "oni.loadInitVim": true,

   // UI customizations
    "ui.animations.enabled": true,
    "ui.fontSmoothing": "auto",
    "ui.colorscheme": "monokai",
    "tabs.mode": "tabs"
}

