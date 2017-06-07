exports.swipe = (event, layer) ->
exports.swipeStart = (event, layer) ->
exports.swipeEnd = (event, layer) ->

exports.swipeFlip = (layer, perspective, drag, animationOptions, vertical = false, tap = false) ->
    # Variable ###########################################
    rotation_start = 0
    layer.perspective = perspective
    layer.isfront = true
    layer.sf_disable = false

    if !vertical
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
    if !tap
        container.on Events.Swipe, swipeHandler = (event, target) ->
            if layer.sf_disable
                return
            swipe()
            exports.swipe(event, layer)

        container.on Events.SwipeStart, swipeStartHandler = (event, target) ->
            if container.isAnimating
                container.animateStop()
            exports.swipeStart(event, layer)
            if layer.sf_disable
                return
            swipeStart()

        container.on Events.SwipeEnd, swipeEndHandler = (event, target) ->
            if layer.sf_disable
                return
            swipeEnd()
            exports.swipeEnd(event, layer)

    else
        container.on Events.Tap, tapHandler = (event, target) ->
            if layer.sf_disable
                return
            Tap()


    # Function ###########################################
    Tap = () ->
        if layer.isfront
            container.setRotation(180)
        else
            container.setRotation(0)
        layer.isfront = !layer.isfront

    swipe = () ->
        if !vertical
            range = [-container.width * drag, container.width * drag]
            t = Utils.modulate(event.point.x - event.start.x, range, [-180, 180], true)
        else
            range = [-container.height * drag, container.height * drag]
            t = Utils.modulate(event.point.y - event.start.y, range, [180, -180], true)
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
        if !vertical
            container.animate
                rotationY: angle
        else
            container.animate
                rotationX: angle
