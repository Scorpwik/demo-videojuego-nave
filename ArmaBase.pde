/**
 * Clase ArmaBase (Padre)
 * Define los atributos y comportamientos comunes que todas las armas deben tener.
 * Utiliza encapsulamiento para gestionar el daño y la munición, permitiendo que
 * las subclases hereden esta funcionalidad básica.
 */
class ArmaBase {
  private String tipo;
  private int daño;
  private int numBalas;

  public ArmaBase() {
    tipo = "base";
    daño = 1;
    numBalas = 1;
  }
  public void disparar(PVector posNave, ArrayList<Bala> balas) {
    if (numBalas > 0) {
      balas.add(new Bala(new PVector(posNave.x, posNave.y - 10), new PVector(0, -300), true));
      numBalas--;
    }
  }
  public String leerTipo() {
    return tipo;
  }
  public void escribirTipo(String tipo) {
    this.tipo = tipo;
  }
  public int leerDaño() {
    return daño;
  }
  public void escribirDaño(int daño) {
    this.daño = daño;
  }
  public int leerNumBalas() {
    return numBalas;
  }
  public void escribirNumBalas(int numBalas) {
    this.numBalas = numBalas;
  }
}
