# Framer-SwipeFlip-module

A Framer module to create flip effect using swipe gestures.

You can check out the demo <a href="https://framer.cloud/sshrf/">here</a>

## How to use

1 - Download swipeFlip.coffee and put it in your modules folder.

2 - Import the module.
```coffeescript
sf = require "swipeFlip"
```

3 - Create a new Layer.
```coffeescript
myLayer = new Layer
  width: 400
  height: 300
  x: Align.center()
  y: Align.center()
  backgroundColor: "none"
```

4 - Call the swipeFlip function and set the parameters.
```coffeescript
# Set parameters ################################
perspective = 2000
drag = 0.8
animOptions = {
  curve: Bezier.ease,
  time: 0.2
}

# Call the function ################################
sf.swipeFlip(myLayer, perspective, drag, animOptions)
```

5 - SwipeFlip will create two child layer: "front" and "back", correspond to front side and back side of the parent layer.
```coffeescript
myLayer.container.front.backgroundColor = "red"

myLayer.container.back.backgroundColor = "blue"
```

With those steps complete, the result is almost like this:

<a href="https://framer.cloud/sshrf/"><img alt="swipeFlip_demo" src="https://github.com/suhehe/suhehe.github.io/blob/master/images/demo.gif" height="225px" /></a>


## Meanings of parameters

The swipeFlip function has 6 parameters, The first four are necessary, and the last two are not:

- **layer:** The layer you want to creat flip effect.

- **perspective:** see [docs for reference](http://framerjs.com/docs/#layer.perspective)

- **drag:** This parameter is about sensitivity, recommended range is from 0.5 to 1.5. You can try finding a fitted value.

- **animOptions:** This parameter manage how the layer will be animated when you loosen your finger.

- **vertical:** Sets whether the layer is flipped vertically. This parameter is not necessary, default value is false.

- **tap:** Sets whether the layer is flipped using tap gestures. This parameter is not necessary, default value is false.

## What's more
You can rewrite these three function below for your needs, as follows:
```coffeescript
sf.swipeStart = (event, layer) ->
   print "swipe start"

sf.swipe = (event, layer) ->
   print "swiping"

sf.swipeEnd = (event, layer) ->
   print "swipe end"
```
Check if the layer is front, return true or false:
```coffeescript
if myLayer.isfront
   print "Is front!"
```
Sets whether the layer can be fliped:
```coffeescript
myLayer.sf_disable = true
```

## References

This module is refer to [framer-flip-card-module](https://github.com/aboutjax/framer-flip-card-module) by aboutjax.

