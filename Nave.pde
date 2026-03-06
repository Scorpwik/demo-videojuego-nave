/**
 * Clase Nave
 * Representa al avatar del jugador. Gestiona la entrada del teclado para el movimiento,
 * el sistema de vidas, y utiliza composición para manejar el arma que tiene equipada actualmente.
 */
class Nave {
  PVector pos;
  PVector vel;
  int vidas;
  ArmaBase armaActual;
  boolean movIzq, movDer, movArriba, movAbajo;

  public Nave() {
    pos = new PVector(width/2, height - 50);
    vel = new PVector(0, 0);
    vidas = 3;
    armaActual = new Pistola();
  }

  public void actualizar(float td) {
    vel.set(0, 0);
    if (movIzq) vel.x -= 200;
    if (movDer) vel.x += 200;
    if (movArriba) vel.y -= 200;
    if (movAbajo) vel.y += 200;
    pos.add(PVector.mult(vel, td));
    pos.x = constrain(pos.x, 0, width);
    pos.y = constrain(pos.y, 0, height);
  }

  public void dibujar() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-HALF_PI); 
    float escala = 30.0 / imgJugador.width; 
    scale(escala);
    imageMode(CENTER);
    image(imgJugador, 0, 0);
    popMatrix();
  }

  public void manejarTeclas(int keyCode, boolean pressed) {
    if (keyCode == LEFT) movIzq = pressed;
    if (keyCode == RIGHT) movDer = pressed;
    if (keyCode == UP) movArriba = pressed;
    if (keyCode == DOWN) movAbajo = pressed;
    if (keyCode == 32 && pressed) {
      disparar();
    }
  }

  public void disparar() {
    armaActual.disparar(pos, balJug);
  }

  public void cambiarArmaAleatoria() {
    int rand = (int) random(3);
    switch (rand) {
      case 0: armaActual = new Pistola(); break;
      case 1: armaActual = new Escopeta(); break;
      case 2: armaActual = new ArmaEsquivar(); break;
    }
  }
}
