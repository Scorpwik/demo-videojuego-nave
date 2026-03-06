/**
 * Clase Escopeta (Subclase de ArmaBase)
 * Implementa un comportamiento de disparo específico: genera tres proyectiles
 * simultáneos en diferentes ángulos, consumiendo más munición que el arma base.
 */
class Escopeta extends ArmaBase {
  public Escopeta() {
    super();
    escribirTipo("escopeta");
    escribirDaño(1);
    escribirNumBalas(60);  
  }

  @Override
  public void disparar(PVector posNave, ArrayList<Bala> balas) {
    if (leerNumBalas() >= 3) {
      balas.add(new Bala(new PVector(posNave.x - 10, posNave.y - 10), new PVector(-50, -300), true));
      balas.add(new Bala(new PVector(posNave.x, posNave.y - 10), new PVector(0, -300), true));
      balas.add(new Bala(new PVector(posNave.x + 10, posNave.y - 10), new PVector(50, -300), true));
      escribirNumBalas(leerNumBalas() - 3);
    }
  }
}
