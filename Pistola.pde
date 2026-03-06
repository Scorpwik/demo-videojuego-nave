/**
 * Clase Pistola (Subclase de ArmaBase)
 * Representa el arma estándar del juego con disparo lineal único.
 * Define la configuración específica de daño y capacidad de munición inicial.
 */
class Pistola extends ArmaBase {
  public Pistola() {
    super();
    escribirTipo("pistola");
    escribirDaño(1);
    escribirNumBalas(30);
  }

  @Override
  public void disparar(PVector posNave, ArrayList<Bala> balas) {
    if (leerNumBalas() > 0) {
      balas.add(new Bala(new PVector(posNave.x, posNave.y - 10), new PVector(0, -300), true));
      escribirNumBalas(leerNumBalas() - 1);
    }
  }
}
