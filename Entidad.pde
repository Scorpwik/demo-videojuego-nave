/**
 * Clase Abstracta Entidad
 * Es la base de todos los objetos dinámicos del juego (Nave, Enemigos, Balas, PowerUps).
 * Define vectores de posición y velocidad, y obliga a las subclases a implementar
 * su propia forma de dibujarse (Polimorfismo).
 */
abstract class Entidad {
  PVector pos;
  PVector vel;
  public Entidad(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
  }
  public void actualizar(float td) {
    pos.add(PVector.mult(vel, td));
  }
  public abstract void dibujar();
  public boolean eliminar() {
    return pos.y > height + 50 || pos.y < -50 || pos.x < -50 || pos.x > width + 50;
  }
}
