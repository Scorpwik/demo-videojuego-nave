/**
 * Clase Bala (Hereda de Entidad)
 * Representa los proyectiles disparados tanto por el jugador como por los enemigos.
 * Gestiona su propia velocidad, dirección y diferenciación visual (color/forma)
 * dependiendo de quién la disparó.
 */
class Bala extends Entidad {
  boolean esJug;
  color colorLaser;
  public Bala(PVector pos, PVector vel, boolean esJug) {
    super(pos, vel);
    this.esJug = esJug;
    if (esJug) {
      color[] colores = {color(255, 0, 0), color(255, 165, 0), color(255, 255, 0), color(0, 255, 0), color(0, 0, 255), color(75, 0, 130), color(238, 130, 238)};
      colorLaser = colores[(int) random(colores.length)];
    }
  }
  public void dibujar() {
    if (esJug) {
      stroke(colorLaser);
      strokeWeight(2);
      line(pos.x, pos.y, pos.x, pos.y - 10);
      noStroke();
    } else {
      fill(255, 0, 0);
      circle(pos.x, pos.y, 5);
    }
  }
}
