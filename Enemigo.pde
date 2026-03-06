/**
 * Clase Enemigo (Hereda de Entidad)
 * Define a los oponentes del juego. Gestiona su visualización (con rotación de sprite),
 * su movimiento vertical y su sistema de salud individual.
 */
class Enemigo extends Entidad {
  int vida;

  public Enemigo(PVector pos, int velY) {
    super(pos, new PVector(0, velY));
    vida = 3;
  }

  public void dibujar() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(HALF_PI); 
    float escala = 30.0 / imgEnemigo.width;  
    scale(escala);
    imageMode(CENTER);
    image(imgEnemigo, 0, 0);
    popMatrix();
    fill(255);
    textAlign(CENTER);
    text(vida, pos.x, pos.y - 20);
  }
}
