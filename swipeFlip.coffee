exports.swipe = (event, layer) ->
exports.swipeStart = (event, layer) ->
exports.swipeEnd = (event, layer) ->

exports.swipeFlip = (layer, perspective, drag, animationOptions, horizontal = true) ->
    # Variable ###########################################
    rotation_start = 0
    layer.perspective = perspective
    layer.isfront = true
    layer.disable = false

    if horizontal
        rotat = "rotationY"
    else
        rotat = "rotationX"

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

    back[rotat] = 180
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
        if horizontal
            range = [-container.width * drag, container.width * drag]
            t = Utils.modulate(event.point.x - event.start.x, range, [-180, 180], true)
        else
            range = [-container.height * drag, container.height * drag]
            t = Utils.modulate(event.point.y - event.start.y, range, [-180, 180], true)
        container[rotat] = t + rotation_start

    swipeEnd = () ->
        if container[rotat] > 360
            container[rotat] -= 360
        if container[rotat] < -360
            container[rotat] += 360
        if (container[rotat] >= 0 && container[rotat] < 90)
            layer.isfront = true
            container.setRotation(0)
        else if (container[rotat] >= 90 && container[rotat] < 180)
            layer.isfront = false
            container.setRotation(180)
        else if (container[rotat] >= 180 && container[rotat] < 270)
            layer.isfront = false
            container.setRotation(180)
        else if (container[rotat] >= 270 && container[rotat] < 360)
            layer.isfront = true
            container.setRotation(360)
        else if (container[rotat] < 0 && container[rotat] > -90)
            layer.isfront = true
            container.setRotation(0)
        else if (container[rotat] <= -90 && container[rotat] > -180)
            layer.isfront = false
            container.setRotation(-180)
        else if (container[rotat] <= -180 && container[rotat] > -270)
            layer.isfront = false
            container.setRotation(-180)
        # else if (container[rotat] <= -270 && container[rotat] > -360)
        else
            layer.isfront = true
            container.setRotation(-360)

    swipeStart = () ->
        rotation_start = container[rotat]

    container.setRotation = (angle) ->
        container.animate
            rotationY: angle
