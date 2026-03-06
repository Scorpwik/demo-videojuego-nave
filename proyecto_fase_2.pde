/**
 * SKETCH PRINCIPAL
 * Este archivo gestiona el ciclo de vida del juego (setup, draw), la lógica global,
 * el control de estados (inicio, juego, game over, victoria) y la detección de colisiones.
 * Integra todas las clases para formar la experiencia interactiva.
 */

import processing.sound.*;

ArrayList<Enemigo> enem;
ArrayList<Bala> balJug;
ArrayList<Bala> balEnem;
ArrayList<PowerUp> powerUps;
Nave nave;
Fondo fondo;
AudioManager audioManager; 
PImage imgJugador, imgEnemigo, imgPower1, imgPower2;
boolean juegoIni = false;
boolean juegoTerm = false;
boolean juegoGan = false;
float td, ti, ta;
float tUltArma = 0;
float tUltVida = 0;
int niv = 1;
int enemDer = 0;
float tUltLevel = 0;
boolean mostLevel = false;
float tMostLevel = 0;
int pts = 0;
int nivRecarga = 0;

void setup() {
  size(850, 400);
  enem = new ArrayList<Enemigo>();
  balJug = new ArrayList<Bala>();
  balEnem = new ArrayList<Bala>();
  powerUps = new ArrayList<PowerUp>();
  nave = new Nave();
  fondo = new Fondo();
  audioManager = new AudioManager(this); 
  imgJugador = loadImage("jugador.png");
  imgEnemigo = loadImage("enemigo.png");
  imgPower1 = loadImage("power1.png");
  imgPower2 = loadImage("power2.png");
  ti = millis();
  tUltLevel = millis();
}

void draw() {
  background(0);
  ta = millis();
  td = (ta - ti) / 1000.0;
  ti = ta;

  if (juegoIni) {
    fondo.actualizar(td);
    fondo.dibujar();
    audioManager.reproducirMusicaJuego(); 
  } else {
    audioManager.pararTodo();
  }

  if (!juegoIni) {
    textAlign(CENTER);
    fill(255, 255, 0);
    textSize(24);
    text("Space Shooter", width/2, height/2 - 120);
    fill(255);
    textSize(16);
    text("Presiona ENTER para iniciar", width/2, height/2 - 90);
    fill(0, 255, 0);
    textSize(14);
    text("Controles:", width/2, height/2 - 60);
    fill(255);
    text("Flechas: Mover nave | ESPACIO: Disparar", width/2, height/2 - 45);
    fill(0, 255, 0);
    text("Mecánicas:", width/2, height/2 - 20);
    fill(255);
    text("Vidas: 3. Pierdes por balas enemigas o colisión.", width/2, height/2 - 5);
    text("Armas: Pistola (30 balas, 1 disparo), Escopeta (60 balas, 3 disparos), Esquivar (0 balas).", width/2, height/2 + 10);
    text("Power-Ups: Arma cada 10s, Vida Extra cada 20s (si tienes 3 vidas, recarga munición).", width/2, height/2 + 25);
    text("Niveles: Sube cada 15 segundos o cada 3 enemigos derrotados. Más enemigos y velocidad.", width/2, height/2 + 40);
    text("Enemigos: Triángulos rojos con 3 vidas. Muestran vida restante. +100 puntos cada uno.", width/2, height/2 + 55);
    text("Victoria: Alcanza nivel 20 o 7,000 puntos. Recarga mitad munición cada 3 niveles.", width/2, height/2 + 70);
    return;
  }

  if (juegoTerm) {
    background(0);
    textAlign(CENTER);
    textSize(20);
    fill(255, 0, 0);
    text("GAME OVER - Presiona R para reiniciar", width/2, height/2);
    audioManager.reproducirPerdida();
    return;
  }

  if (juegoGan) {
    background(0);
    textAlign(CENTER);
    textSize(20);
    fill(0, 255, 0);
    text("YOU WIN! - Presiona R para reiniciar", width/2, height/2);
    audioManager.reproducirVictoria();
    return;
  }

  fill(255);
  textAlign(LEFT);
  textSize(16);
  text("Arma: " + nave.armaActual.leerTipo() + " (" + nave.armaActual.leerNumBalas() + ")", 10, 20);
  textAlign(CENTER);
  text("Nivel: " + niv, width/2, 20);
  text("Puntos: " + pts, width/2, 40);
  fill(255, 0, 0);
  for (int i = 0; i < nave.vidas; i++) {
    circle(width - 30 - i*30, 20, 10);
  }

  if (niv >= 20 || pts >= 7000) {
    juegoGan = true;
  }

  if (millis() - tUltLevel > 15000 || enemDer >= 3) {
    niv++;
    nivRecarga++;
    if (nivRecarga >= 3) {
      if (nave.armaActual.leerTipo().equals("pistola")) {
        int maxBalas = 30;
        int recarga = maxBalas / 2;
        nave.armaActual.escribirNumBalas(min(nave.armaActual.leerNumBalas() + recarga, maxBalas));
      } else if (nave.armaActual.leerTipo().equals("escopeta")) {
        int maxBalas = 60;
        int recarga = maxBalas / 2;
        nave.armaActual.escribirNumBalas(min(nave.armaActual.leerNumBalas() + recarga, maxBalas));
      } else if (nave.armaActual.leerTipo().equals("esquivar")) {
        nave.armaActual.escribirNumBalas(0);
      }
      nivRecarga = 0;
    }
    tUltLevel = millis();
    enemDer = 0;
    mostLevel = true;
    tMostLevel = millis();
  }

  if (mostLevel && millis() - tMostLevel < 2000) {
    textAlign(CENTER);
    textSize(30);
    fill(255, 255, 0);
    text("LEVEL UP", width/2, height/2);
  } else {
    mostLevel = false;
  }

  nave.actualizar(td);
  nave.dibujar();

  float probEnem = 0.01 * niv;
  if (random(1) < probEnem) {
    int velY = 50 + (niv - 1) * 10;
    enem.add(new Enemigo(new PVector(random(width), 0), velY));
  }

  if (millis() - tUltArma > 10000) {
    powerUps.add(new PowerUp(new PVector(random(width), random(height/2)), "arma"));
    tUltArma = millis();
  }
  if (millis() - tUltVida > 20000) {
    powerUps.add(new PowerUp(new PVector(random(width), random(height)), "vida"));
    tUltVida = millis();
  }

  actualizarLista(enem);
  actualizarLista(balJug);
  actualizarLista(balEnem);
  actualizarLista(powerUps);

  for (Enemigo e : enem) {
    if (random(1) < 0.005) {
      balEnem.add(new Bala(new PVector(e.pos.x, e.pos.y), new PVector(0, 100), false));
    }
  }

  detectarColisiones();
}

void keyPressed() {
  if (!juegoIni && keyCode == ENTER) {
    juegoIni = true;
  }
  if ((juegoTerm || juegoGan) && key == 'r' || key == 'R') {
    reiniciarJuego();
  }
  nave.manejarTeclas(keyCode, true);
}

void keyReleased() {
  nave.manejarTeclas(keyCode, false);
}

void actualizarLista(ArrayList<? extends Entidad> lista) {
  for (int i = lista.size() - 1; i >= 0; i--) {
    Entidad e = lista.get(i);
    e.actualizar(td);
    e.dibujar();
    if (e.eliminar()) {
      lista.remove(i);
    }
  }
}

void detectarColisiones() {
  for (int i = balJug.size() - 1; i >= 0; i--) {
    Bala b = balJug.get(i);
    for (int j = enem.size() - 1; j >= 0; j--) {
      Enemigo e = enem.get(j);
      if (dist(b.pos.x, b.pos.y, e.pos.x, e.pos.y) < 20) {
        e.vida--;
        balJug.remove(i);
        
        if (e.vida <= 0) {
          audioManager.reproducirExplosion();
        
          enem.remove(j);
          enemDer++;
          pts += 100;
        }
        break;
      }
    }
  }

  for (int i = balEnem.size() - 1; i >= 0; i--) {
    Bala b = balEnem.get(i);
    if (dist(b.pos.x, b.pos.y, nave.pos.x, nave.pos.y) < 20) {
      nave.vidas--;
      audioManager.reproducirGolpe();
      balEnem.remove(i);
      if (nave.vidas <= 0) {
        juegoTerm = true;
      }
    }
  }

  for (Enemigo e : enem) {
    if (dist(nave.pos.x, nave.pos.y, e.pos.x, e.pos.y) < 20) {
      juegoTerm = true;
    }
  }

  // Colisión Nave vs PowerUps
  for (int i = powerUps.size() - 1; i >= 0; i--) {
    PowerUp p = powerUps.get(i);
    if (dist(nave.pos.x, nave.pos.y, p.pos.x, p.pos.y) < 20) {
      audioManager.reproducirPowerUp();
      
      if (p.tipo.equals("arma")) {
        nave.cambiarArmaAleatoria();
      } else if (p.tipo.equals("vida")) {
        if (nave.vidas < 3) {
          nave.vidas = min(nave.vidas + 1, 3);
        } else {
          // Recarga de munición si vida está llena
          if (nave.armaActual.leerTipo().equals("pistola")) {
            nave.armaActual.escribirNumBalas(min(nave.armaActual.leerNumBalas() + 15, 30));
          } else if (nave.armaActual.leerTipo().equals("escopeta")) {
            nave.armaActual.escribirNumBalas(min(nave.armaActual.leerNumBalas() + 30, 60));
          } else if (nave.armaActual.leerTipo().equals("esquivar")) {
            nave.armaActual.escribirNumBalas(0);
          }
        }
      }
      powerUps.remove(i);
    }
  }
}
void reiniciarJuego() {
  juegoIni = false;
  juegoTerm = false;
  juegoGan = false;
  nave = new Nave();
  enem.clear();
  balJug.clear();
  balEnem.clear();
  powerUps.clear();
  tUltArma = 0;
  tUltVida = 0;
  niv = 1;
  enemDer = 0;
  tUltLevel = millis();
  mostLevel = false;
  pts = 0;
  nivRecarga = 0;
  audioManager.reiniciarMusicaJuego();
}
