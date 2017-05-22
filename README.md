# Framer-SwipeFlip-module
A Framer module to create flip effect listen in the swipe event


## How to use
1 - Download swipeFlip.coffee and put it in your modules folder.

2 - Import the module.
```coffeescript
swipeFlip = require "swipeFlip"
```

2 - Create a new Layer.
```coffeescript
layer = new Layer
  width: 400
  height: 300
  x: Align.center()
  y: Align.center()
  backgroundColor: "none"
```

3 - Call the swipeFlip function and set the parameters.
```coffeescript
# set parameters ################################
perspective = 2000
drag = 0.8
animOptions = {
  cure: Bezier.ease,
  time: 0.2
}
# call the function ################################
swipeFlip.swipeFlip(layer, perspective, drag, animOptions)
```
## Meanings of parameters
Make sure to plan ahead what you need to show in your prototype. My workflow is:
The swipeFlip function has 4 parameters, they are all necessary
- **layer: ** The layer you want to creat flip effect.
- **perspective: ** see [docs for reference](http://framerjs.com/docs/#layer.perspective)
- **drag: ** This parameter is about sensitivity, Recommended range is from 0.5 to 1.5. You can try finding a fitted value.
- **animOptions: ** This parameter manage how the layer will be animated when you loosen your finger.

