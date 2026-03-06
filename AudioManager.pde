/**
 * Clase AudioManager
 * Actúa como un gestor centralizado para todos los recursos sonoros.
 * Se encarga de cargar, reproducir y detener la música de fondo y los efectos
 * de sonido (disparos, explosiones), manteniendo el código principal limpio.
 */
import processing.sound.*;

class AudioManager {
  SoundFile musicaJuego, sonidoVictoria, sonidoPerdida;
  SoundFile sonidoPower, sonidoVida, sonidoExplosion;

  public AudioManager(PApplet app) {
    musicaJuego = new SoundFile(app, "musica.mp3");
    sonidoVictoria = new SoundFile(app, "win.mp3");
    sonidoPerdida = new SoundFile(app, "per.mp3");

    sonidoPower = new SoundFile(app, "power.mp3");
    sonidoVida = new SoundFile(app, "life.mp3");
    sonidoExplosion = new SoundFile(app, "boom.mp3");
  }
  public void reproducirMusicaJuego() {
    if (!musicaJuego.isPlaying()) {
      musicaJuego.loop();
    }
  }
  public void pararTodo() {
    if (musicaJuego.isPlaying()) musicaJuego.stop();
    if (sonidoVictoria.isPlaying()) sonidoVictoria.stop();
    if (sonidoPerdida.isPlaying()) sonidoPerdida.stop();
  }
  public void reproducirVictoria() {
    musicaJuego.stop();
    if (!sonidoVictoria.isPlaying()) {
      sonidoVictoria.play();
    }
  }
  public void reproducirPerdida() {
    musicaJuego.stop();
    if (!sonidoPerdida.isPlaying()) {
      sonidoPerdida.play();
    }
  }
  public void reproducirPowerUp() {
    sonidoPower.play();
  }
  public void reproducirGolpe() {
    sonidoVida.play();
  }
  public void reproducirExplosion() {
    sonidoExplosion.play();
  }
  public void reiniciarMusicaJuego() {
    musicaJuego.stop();
    musicaJuego.cue(0);
  }
}
