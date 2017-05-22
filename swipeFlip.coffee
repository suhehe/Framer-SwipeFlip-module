exports.swipe = (event, layer) ->
exports.swipeStart = (event, layer) ->
exports.swipeEnd = (event, layer) ->

exports.swipeFlip = (layer, perspective, drag, animationOptions) ->
    # Variable ###########################################
    rotationY_start = 0
    layer.perspective = perspective
    layer.isfront = true
    layer.disable = false

    layer.container = new Layer
        parent: layer, name: "container"
        width: layer.width, height: layer.height
        x: Align.center(), y: Align.center()
        originX: 0.5
        backgroundColor: "none"
    container = layer.container

    container.back = new Layer
        parent: container, name: "back"
        x: Align.center(), y: Align.center(), z: -1
        originX: 0.5
        width: container.width, height: container.height
    container.front = new Layer
        parent: container, name: "front"
        x: Align.center(), y: Align.center(), z: 1
        originX: 0.5
        width: container.width, height: container.height
    back = container.back
    front = container.front

    back.rotationY = 180
    container.animationOptions = animationOptions

    # Events ###########################################
    container.on(Events.Swipe, fswipeHandler = (event, target) ->
        if layer.disable
            return
        swipe()
        exports.swipe(event, layer))
    container.on(Events.SwipeStart, fswipeStartHandler = (event, target) ->
        exports.swipeStart(event, layer)
        if layer.disable
            return
        swipeStart())
    container.on(Events.SwipeEnd, fswipeEndHandler = (event, target) ->
        if layer.disable
            return
        swipeEnd()
        exports.swipeEnd(event, layer))

    # Function ###########################################
    swipe = () ->
        range = [-container.width * drag, container.width * drag]
        t = Utils.modulate(event.point.x - event.start.x, range, [-180, 180], true)
        container.rotationY = t + rotationY_start

    swipeEnd = () ->
        if container.rotationY > 360
            container.rotationY -= 360
        if container.rotationY < -360
            container.rotationY += 360
        if (container.rotationY >= 0 && container.rotationY < 90)
            layer.isfront = true
            setRotation(0)
        else if (container.rotationY >= 90 && container.rotationY < 180)
            layer.isfront = false
            setRotation(180)
        else if (container.rotationY >= 180 && container.rotationY < 270)
            layer.isfront = false
            setRotation(180)
        else if (container.rotationY >= 270 && container.rotationY < 360)
            layer.isfront = true
            setRotation(360)
        else if (container.rotationY < 0 && container.rotationY > -90)
            layer.isfront = true
            setRotation(0)
        else if (container.rotationY <= -90 && container.rotationY > -180)
            layer.isfront = false
            setRotation(-180)
        else if (container.rotationY <= -180 && container.rotationY > -270)
            layer.isfront = false
            setRotation(-180)
        # else if (container.rotationY <= -270 && container.rotationY > -360)
        else
            layer.isfront = true
            setRotation(-360)

    swipeStart = () ->
        rotationY_start = container.rotationY

    setRotation = (angle) ->
        container.animate
            rotationY: angle
