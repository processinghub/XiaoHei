/**
 * <p>Title: 墨白 ElementMo</p>  
 * <p>Description: Processing骚操作第一期</p>  
 * <p>Copyright: Copyright (c) 2018</p>  
 * <p>Company: elementmo.github.io</p>  
 * @author elementmo  
 * @date 2018.11.2  
 * @version 1.0  
 */
import java.awt.*;
import javax.swing.JFrame;
import processing.awt.PSurfaceAWT;
import java.awt.geom.*;

PVector windowPos = new PVector(0, 0);
PVector relative = new PVector(0, 0);
boolean toggle = true;

void setup()
{
  fullScreen();
  noStroke();
  frameRate(60);

  final PSurfaceAWT awtSurface = (PSurfaceAWT)surface;
  final PSurfaceAWT.SmoothCanvas smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();
  final JFrame frame = (JFrame)smoothCanvas.getFrame();

  frame.removeNotify();
  frame.setSize(150, 150);
  frame.setUndecorated(true);
  frame.setAlwaysOnTop(true);
  frame.setShape(drawCat());
  frame.setOpacity(0.9);
  frame.setVisible(true);
  frame.addNotify();
}


void draw()
{
  Point p = MouseInfo.getPointerInfo().getLocation();
  PVector mousePos = new PVector((int)p.getX()-75, (int)p.getY()-70);
  relative = PVector.sub(mousePos, windowPos);
  if (toggle) {
    PVector lerpVector = PVector.lerp(new PVector(0, 0), relative, 0.09);
    windowPos.add(lerpVector);
  }
  surface.setLocation((int)windowPos.x, (int)windowPos.y);

  background(87, 54, 36);
  drawFace();
}

void drawFace()
{
  fillEarsColor();
  fill(0);
  ellipse(75, 70, 105, 85);

  fill(255, 255, 200);
  ellipse(50, 70, 50, 60);
  ellipse(100, 70, 50, 60);

  noStroke();
  beginShape();
  fill(45, 124, 155);
  vertex(68, 99);
  vertex(75, 109);
  vertex(82, 99);
  endShape(CLOSE);

  stroke(87, 54, 36);
  strokeWeight(3);
  strokeCap(ROUND);
  line(68, 99, 75, 109);
  line(75, 109, 82, 99);
  line(82, 99, 68, 99);



  fill(0);
  drawEye(50, 70, relative.copy());
  drawEye(100, 70, relative.copy());
}


void drawEye(int x, int y, PVector relative)
{
  PVector eye_shift = relative;
  eye_shift.add(new PVector(75-x, 0));
  relative.normalize();
  eye_shift.mult(10);
  PVector eye = PVector.add(new PVector(x, y), eye_shift);
  PVector mouse = new PVector(mouseX, mouseY);
  if (PVector.dist(mouse, new PVector(x, y))<10) {
    ellipse(mouseX, mouseY, 28, 38);
  } else {
    ellipse(eye.x, eye.y, 28, 38);
  }
}


Shape drawCat() {
  Shape head = new Ellipse2D.Float(19, 25, 111, 90);
  Polygon earL = new Polygon(new int[]{25, 20, 15, 13, 13, 15, 41, 61}, new int[]{73, 66, 53, 38, 26, 23, 22, 27}, 8);
  Polygon earR = new Polygon(new int[]{126, 131, 137, 139, 139, 137, 134, 107, 93}, new int[]{72, 65, 50, 42, 28, 25, 23, 24, 27}, 9);

  Area headArea = new Area(head);
  Area earLArea = new Area(earL);
  Area earRArea = new Area(earR);
  headArea.add(earLArea);
  headArea.add(earRArea);

  return headArea;
}


void fillEarsColor()
{
  fill(192, 193, 99);
  beginShape();
  vertex(35, 38);
  vertex(26, 31);
  vertex(16, 25);
  vertex(16, 46);
  vertex(21, 66);
  vertex(38, 39);
  endShape();

  fill(0);
  beginShape();
  vertex(22, 24);
  vertex(40, 24);
  vertex(56, 28);
  vertex(40, 40);
  vertex(22, 26);
  endShape();

  fill(192, 193, 99);
  beginShape();
  vertex(135, 27);
  vertex(125, 32);
  vertex(114, 40);
  vertex(128, 64);
  vertex(134, 50);
  vertex(136, 40);  
  vertex(136, 28);
  endShape();

  fill(0);
  beginShape();
  vertex(99, 28);
  vertex(116, 26);
  vertex(133, 26);
  vertex(119, 35);
  vertex(111, 40);
  endShape();
}


void mousePressed()
{
  if (mouseButton == RIGHT) {
    toggle = false;
  } else if (mouseButton == LEFT) {
    toggle = true;
  }
}
