/**
 * Clase PowerUp (Hereda de Entidad)
 * Objetos recolectables que otorgan beneficios al jugador.
 * Pueden ser de tipo "vida" (recuperar salud) o "arma" (cambiar aleatoriamente el arma).
 */
class PowerUp extends Entidad {
  String tipo;

  public PowerUp(PVector pos, String tipo) {
    super(pos, new PVector(0, 50));
    this.tipo = tipo;
  }

  public void dibujar() {
    pushMatrix();
    translate(pos.x, pos.y);
    if (tipo.equals("arma")) {
      float escala = 30.0 / imgPower2.width; 
      scale(escala);
      imageMode(CENTER);
      image(imgPower2, 0, 0);
    } else if (tipo.equals("vida")) {
      float escala = 30.0 / imgPower1.width;  
      scale(escala);
      imageMode(CENTER);
      image(imgPower1, 0, 0);
    }
    popMatrix();
  }
}
