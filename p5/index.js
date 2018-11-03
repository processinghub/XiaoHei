/**
 * This code is the p5 version demo, port from processing source.
 * Just follow souce code.
 *
 * @author Rabbit
 * @flow
 */

/// code

export default function sketch(p) {
  let windowPos = p.createVector(0, 0)
  let relative = p.createVector(0, 0)
  let toggle = true
  let canvas

  function setup() {
    p.fullscreen()
    p.noStroke()
    p.frameRate(60)
    p.strokeCap(p.ROUND)
    createShape()
    canvas = p.createCanvas(150, 150)
    canvas.style('clipPath', `url(#cross)`)
  }

  function draw() {
    const mousePos = p.createVector(p.winMouseX - 75, p.winMouseY - 70)
    relative = mousePos.sub(windowPos)

    if (toggle) {
      const lerpVector = p.createVector(0, 0).lerp(relative, 0.09)
      windowPos.add(lerpVector)
    }

    canvas.position(windowPos.x, windowPos.y)
    p.background(87, 54, 36)
    drawFace()
  }

  function drawFace() {
    fillEarsColor()
    p.fill(0)
    p.ellipse(75, 70, 105, 85)

    p.fill(255, 255, 200)
    p.ellipse(50, 70, 50, 60)
    p.ellipse(100, 70, 50, 60)

    p.stroke(87, 54, 36)
    p.strokeWeight(3)
    p.fill(45, 124, 155)
    p.beginShape()
    p.vertex(68, 99)
    p.vertex(75, 109)
    p.vertex(82, 99)
    p.endShape(p.CLOSE)

    p.fill(0)
    drawEye(50, 70, relative.copy())
    drawEye(100, 70, relative.copy())
  }

  function drawEye(x, y, relative) {
    const eye_shift = relative
    eye_shift.add(p.createVector(75-x, 0))
    relative.normalize()
    eye_shift.mult(10)
    const eye = p.createVector(x, y).add(eye_shift)
    const mouse = p.createVector(p.mouseX, p.mouseY)

    if (mouse.dist(p.createVector(x, y)) < 10) {
      p.ellipse(p.mouseX, p.mouseY, 28, 38)
    } else {
      p.ellipse(eye.x, eye.y, 28, 38)
    }
  }

  function fillEarsColor() {
    p.fill(192, 193, 99)
    p.beginShape()
    p.vertex(35, 38)
    p.vertex(26, 31)
    p.vertex(16, 25)
    p.vertex(16, 46)
    p.vertex(21, 66)
    p.vertex(38, 39)
    p.endShape()

    p.fill(0)
    p.beginShape()
    p.vertex(22, 24)
    p.vertex(40, 24)
    p.vertex(56, 28)
    p.vertex(40, 40)
    p.vertex(22, 26)
    p.endShape()

    p.fill(192, 193, 99)
    p.beginShape()
    p.vertex(135, 27)
    p.vertex(125, 32)
    p.vertex(114, 40)
    p.vertex(128, 64)
    p.vertex(134, 50)
    p.vertex(136, 40)
    p.vertex(136, 28)
    p.endShape()

    p.fill(0)
    p.beginShape()
    p.vertex(99, 28)
    p.vertex(116, 26)
    p.vertex(133, 26)
    p.vertex(119, 35)
    p.vertex(111, 40)
    p.endShape()
  }

  function mousePressed() {
    if (p.mouseButton == p.RIGHT) {
      toggle = false
    } else if (p.mouseButton == p.LEFT) {
      toggle = true
    }
  }

  function createShape() {
    const shape = document.createElementNS('http://www.w3.org/2000/svg', 'svg')
    shape.style.position = 'absolute'
    shape.style.zIndex = '-1'
    shape.style.left = '-150px'
    shape.style.top = '-150px'
    shape.innerHTML = `
  <defs>
    <clipPath id="cross">
      <ellipse cx="74.5" cy="70" rx="55.5" ry="45"></ellipse>
      <polygon points="25,73, 20,66 15,53 13,38 13,26 15,23 41,22 61,27"></polygon>
      <polygon points="126,72 131,65 137,50 139,42 139,28 137,25 134,23 107,24 93,27"></polygon>
    </clipPath>
  </defs>
`
    document.body.appendChild(shape)
  }


  p.setup = setup
  p.draw = draw
  p.mousePressed = mousePressed
}
