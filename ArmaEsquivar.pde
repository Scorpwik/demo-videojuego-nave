/**
 * Clase ArmaEsquivar (Subclase de ArmaBase)
 * Representa una mecánica especial donde el jugador no dispara, sino que entra
 * en un modo de evasión. Sobrescribe el método disparar para anular el ataque.
 */
class ArmaEsquivar extends ArmaBase {
  public ArmaEsquivar() {
    super();
    escribirTipo("esquivar");
    escribirDaño(0);
    escribirNumBalas(0);
  }

  @Override
  public void disparar(PVector posNave, ArrayList<Bala> balas) {
    println("¡Esquiva! No disparas.");
  }
}
