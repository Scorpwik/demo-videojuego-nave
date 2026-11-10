# Space Shooter

Demo de un videojuego de naves hecho en [Processing](https://processing.org/). La nave se mueve por una ventana de 850×400, dispara a enemigos que caen desde arriba y recoge power-ups de arma y de vida. Hay niveles, puntaje, música y efectos de sonido.

El juego muestra el título **Space Shooter** en la pantalla de inicio. Este repositorio se llama `demo-videojuego-nave`; antes se llamaba `DemoVidejuegoNave`. El sketch principal es `proyecto_fase_2.pde`.

## Cómo se juega

Al abrir el sketch aparece la pantalla de inicio y la partida no arranca sola. Presiona **Enter** para empezar.

Durante la partida, arriba a la izquierda se ve el arma y la munición (`pistola`, `escopeta` o `esquivar`). Al centro están el nivel y los puntos. A la derecha, un círculo rojo por cada vida.

### Controles

| Tecla | Acción |
| --- | --- |
| Enter | Empezar desde la pantalla de inicio |
| Flechas | Mover la nave |
| Espacio | Disparar con el arma equipada |
| R | En la pantalla de victoria o de derrota, volver a la pantalla de inicio |

La nave empieza centrada en horizontal, a 50 píxeles del borde inferior, con 3 vidas. Cada flecha la mueve a 200 píxeles por segundo en ese eje, y se puede combinar con otra flecha. La posición se mantiene dentro del rectángulo de 850×400, bordes incluidos.

En la pantalla de victoria o de derrota, R (mayúscula o minúscula) vuelve al inicio. La R mayúscula también reinicia si se presiona durante la partida, porque la condición del teclado la evalúa aparte del estado. Ese reinicio borra enemigos, balas, power-ups, puntos y nivel, repone la nave con la pistola y deja otra vez la pantalla de inicio. Para jugar de nuevo hay que presionar Enter.

### Armas

Se empieza con la pistola. El power-up de arma la reemplaza por una de las tres, elegida al azar (puede salir otra vez la misma), con la munición inicial de esa arma.

| Arma | Munición inicial | Qué hace al disparar |
| --- | --- | --- |
| Pistola | 30 | Un proyectil hacia arriba, a 300 píxeles por segundo. Gasta 1 bala. |
| Escopeta | 60 | Tres proyectiles a la vez: centro, izquierda y derecha. Gasta 3 balas y solo dispara si quedan al menos 3. |
| Esquivar | 0 | No crea proyectiles. En la consola de Processing aparece el texto «¡Esquiva! No disparas.» |

Las balas del jugador se dibujan como una línea vertical de 10 píxeles, de un color al azar tomado de siete tonos del arcoíris. Las de los enemigos son círculos rojos de 5 píxeles de diámetro que bajan a 100 píxeles por segundo.

Cada bala del jugador que pasa a menos de 20 píxeles de un enemigo le quita 1 vida y desaparece.

### Enemigos

Usan el sprite `enemigo.png`, rotado para apuntar hacia abajo. Encima se dibuja la vida que les queda. Empiezan con 3 vidas.

Salen por el borde superior, en una posición horizontal al azar, y bajan en línea recta. En cada fotograma, la probabilidad de que aparezca uno es 0,01 multiplicado por el nivel. La velocidad vertical es `50 + (nivel − 1) × 10` píxeles por segundo: en el nivel 1 bajan a 50 píxeles por segundo.

En cada fotograma, cada enemigo tiene una probabilidad de 0,005 de disparar hacia abajo.

- Si sus vidas llegan a 0, desaparece, suena una explosión y suma 100 puntos. Ese derribo cuenta para subir de nivel.
- Si una bala enemiga se acerca a menos de 20 píxeles de la nave, se pierde 1 vida. Con 0 vidas la partida termina.
- Si la nave se acerca a menos de 20 píxeles de un enemigo, la partida termina en ese momento, aunque todavía queden vidas.

Enemigos y balas se eliminan cuando quedan a más de 50 píxeles fuera de la ventana. Un enemigo que se va por abajo no suma puntos.

### Power-ups

Caen a 50 píxeles por segundo. Se recogen al acercarse a menos de 20 píxeles. Si se alejan más de 50 píxeles del borde, también se eliminan.

| Power-up | Sprite | Cada cuánto aparece | Dónde aparece | Efecto |
| --- | --- | --- | --- | --- |
| Arma | `power2.png` (un rayo) | Más de 10 segundos desde el anterior | Mitad superior de la ventana | Cambia el arma al azar y deja la munición inicial de esa arma |
| Vida | `power1.png` (una gema verde) | Más de 20 segundos desde el anterior | Cualquier punto de la ventana | Suma 1 vida si hay menos de 3. Si ya hay 3, recarga munición |

La recarga con la vida llena suma 15 balas a la pistola (tope 30) o 30 a la escopeta (tope 60). Con esquivar la munición sigue en 0. El máximo de vidas es 3.

Esos relojes no esperan a que se presione Enter. Al abrir el sketch, el de las armas y el de las vidas parten de cero, y el del nivel parte del instante de apertura. El tiempo en la pantalla de inicio también corre. Al reiniciar con R, los de arma y vida vuelven a cero y el de nivel vuelve a empezar.

### Niveles y final de la partida

El nivel empieza en 1 y sube cuando se cumple cualquiera de estas dos condiciones:

- pasaron más de 15 segundos desde el último aumento;
- se derrotaron 3 enemigos desde el último aumento.

Al subir, el conteo de enemigos derrotados vuelve a cero y durante 2 segundos se muestra **LEVEL UP** en amarillo. Con el nivel crecen la frecuencia y la velocidad de los enemigos.

Cada 3 subidas de nivel se añade la mitad de la munición máxima del arma actual, sin pasar del tope: +15 en la pistola (máximo 30) y +30 en la escopeta (máximo 60). Esquivar queda en 0.

La partida se gana al alcanzar el **nivel 20** o **7.000 puntos** (`pts >= 7000`). Como cada enemigo derrotado suma 100 puntos, 7.000 puntos equivalen a 70 derribos. La pantalla de victoria dice **YOU WIN!** en verde.

La partida se pierde si las balas enemigas agotan las vidas o si la nave choca con un enemigo. La pantalla dice **GAME OVER** en rojo.

### Fondo y audio

Con la partida en curso, tres capas se desplazan hacia abajo a distinta velocidad y se repiten: planetas (`planeta.png`, 10 píxeles por segundo), piedras (`piedra.png`, 25 píxeles por segundo) y estrellas (`estrella.png`, 35 píxeles por segundo). La nave del jugador usa `jugador.png`, rotada para apuntar hacia arriba.

| Momento | Audio |
| --- | --- |
| Partida en curso | `musica.mp3` en bucle |
| Enemigo destruido | `boom.mp3` |
| Una bala enemiga impacta la nave | `life.mp3` |
| Se recoge un power-up | `power.mp3` |
| Victoria | `win.mp3` |
| Derrota | `per.mp3` |

En la pantalla de inicio se detiene el audio de la partida. En victoria y en derrota se corta la música y suena el efecto de ese final.

## Tecnologías

- **Processing**, modo Java. El IDE compila los `.pde` directamente. La ventana se crea con `size(850, 400)`.
- Librería **Sound** de Processing (`import processing.sound.*`, clase `SoundFile`) para los MP3.
- Clases del sketch:
  - `Entidad` es abstracta y lleva posición, velocidad y el criterio para borrar lo que sale de la pantalla. `Enemigo`, `Bala` y `PowerUp` heredan de ella.
  - `Nave` es una clase independiente. Guarda las vidas y el arma equipada.
  - `ArmaBase` es la base de `Pistola`, `Escopeta` y `ArmaEsquivar`.
  - `Fondo` dibuja el fondo en capas.
  - `AudioManager` carga y reproduce la música y los efectos.
  - `proyecto_fase_2.pde` une el ciclo `setup`/`draw`, los estados (inicio, partida, derrota y victoria), el teclado y las colisiones.

## Cómo ejecutarlo en Processing

1. Instala el IDE de Processing desde <https://processing.org/download>. El repositorio no fija un número de versión.
2. Instala la librería **Sound**: *Sketch → Import Library → Manage Libraries…*, busca **Sound** (Processing Foundation) e instálala. `proyecto_fase_2.pde` y `AudioManager.pde` importan `processing.sound.*`, y el sketch compila con esa librería instalada.
3. Clona este repositorio. Los sprites y los MP3 están en `data/`. Processing los carga desde esa carpeta por el nombre del archivo.
4. La carpeta del sketch tiene que llamarse igual que el archivo principal. Renombra la carpeta clonada a `proyecto_fase_2` y deja dentro todos los `.pde` junto con `data/`.
5. Abre `proyecto_fase_2.pde` y presiona **Run**.

Desde esa carpeta ya renombrada, con la herramienta de línea de comandos que trae Processing:

```bash
processing-java --sketch="$(pwd)" --run
```

## Estructura del repositorio

```text
demo-videojuego-nave/
├── proyecto_fase_2.pde
├── Entidad.pde
├── Nave.pde
├── Enemigo.pde
├── Bala.pde
├── PowerUp.pde
├── ArmaBase.pde
├── Pistola.pde
├── Escopeta.pde
├── ArmaEsquivar.pde
├── Fondo.pde
├── AudioManager.pde
└── data/
    ├── jugador.png
    ├── enemigo.png
    ├── power1.png
    ├── power2.png
    ├── estrella.png
    ├── piedra.png
    ├── planeta.png
    ├── musica.mp3
    ├── boom.mp3
    ├── life.mp3
    ├── power.mp3
    ├── win.mp3
    └── per.mp3
```

## Autor

Joshua Lozada ([Scorpwik](https://github.com/Scorpwik)).
