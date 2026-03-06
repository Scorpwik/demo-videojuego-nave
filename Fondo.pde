/**
 * Clase Fondo
 * Crea un efecto visual de profundidad (Parallax) utilizando múltiples capas
 * de imágenes (estrellas, piedras, planetas) que se mueven a diferentes velocidades
 * para simular el desplazamiento espacial.
 */
class Fondo {
  PImage estrella, piedra, planeta;
  float posYEstrella, posYPiedra, posYPlaneta;
  float velEstrella = 35;  // Rápida
  float velPiedra = 25;    // Media
  float velPlaneta = 10;   // Lenta

  public Fondo() {
    estrella = loadImage("estrella.png");
    piedra = loadImage("piedra.png");
    planeta = loadImage("planeta.png");
    if (estrella == null) println("Error: estrella.png no se cargó");
    if (piedra == null) println("Error: piedra.png no se cargó");
    if (planeta == null) println("Error: planeta.png no se cargó");
    posYEstrella = 0;
    posYPiedra = 0;
    posYPlaneta = 0;
  }

  public void actualizar(float td) {
    posYEstrella += velEstrella * td;
    posYPiedra += velPiedra * td;
    posYPlaneta += velPlaneta * td;

    if (estrella != null && posYEstrella >= estrella.height * 0.5) posYEstrella -= estrella.height * 0.5;
    if (piedra != null && posYPiedra >= piedra.height * 0.5) posYPiedra -= piedra.height * 0.5;
    if (planeta != null && posYPlaneta >= planeta.height * 0.5) posYPlaneta -= planeta.height * 0.5;
  }

  public void dibujar() {
    if (planeta != null) {
      image(planeta, 0, posYPlaneta, planeta.width * 0.5, planeta.height * 0.5);
      image(planeta, 0, posYPlaneta - planeta.height * 0.5, planeta.width * 0.5, planeta.height * 0.5);  
    }
    if (piedra != null) {
      image(piedra, 0, posYPiedra, piedra.width * 0.5, piedra.height * 0.5);
      image(piedra, 0, posYPiedra - piedra.height * 0.5, piedra.width * 0.5, piedra.height * 0.5);
    }
    if (estrella != null) {
      image(estrella, 0, posYEstrella, estrella.width * 0.5, estrella.height * 0.5);
      image(estrella, 0, posYEstrella - estrella.height * 0.5, estrella.width * 0.5, estrella.height * 0.5);
    }
    if (planeta == null && piedra == null && estrella == null) {
      fill(0);
      rect(0, 0, width, height);
    }
  }
}
