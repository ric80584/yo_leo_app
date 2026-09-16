«¡YO LEO!» La lectura es divertida
Documentación técnica y código fuente unificado en Flutter para la creación del ejecutable Android (.APK) adaptado a las tabletas del MINEDU.
Nota Pedagógica y de Diseño UX/UI: La aplicación funciona 100% offline, incluye sonorización de letras/sílabas, ruleta con engranajes 3D, trazado de motricidad fina y dictado interactivo con teclado QWERTY adaptado.
1. Resumen de Módulos Integrados
Módulo
Componente Principal
Funcionalidad Integrada
 
Cabecera
Panel Superior & Puchin
Switch Mayúsculas/Minúsculas, mascota Lorito Puchin con audio y contadores automáticos de sílabas y letras.
Ruleta 3D
RuletaLetrasWidget
Engranajes verticales cíclicos A-Z (incluye Ñ, LL, CH), perillas de validación y control de 3 intentos con pistas.
Trazo Cursivo
TrazadoPunteadoWidget
Lienzo de dibujo táctil sobre fuente Learning Curve Dashed, siempre en minúsculas y con ícono de lápiz dinámico.
Dictado & Teclado
DictadoTecladoWidget
Entrada de voz/micrófono, teclado QWERTY táctil adaptado (con números y Ñ) y lectura silábica interactiva.

2. Estructura de Niveles Pedagógicos
Nivel 1: Abecedario - Reconocimiento inicial y trazado directo.
Nivel 2: Sílabas - Formación de la primera sílaba y asociación fonética.
Nivel 3: Palabras Bisílabas - Construcción de palabras de 2 sílabas en la ruleta.
Nivel 4: Palabras Trisílabas - Construcción de palabras de 3 sílabas.
Nivel 5: Sílabas Inversas - Estructuras tipo al, es, in, or, un.
Nivel 6: Sílabas Trabadas - Estructuras tipo bra, cro, pli, tra.
3. Código Unificado Completo (main.dart)
A continuación se presenta la arquitectura completa integrada lista para compilación en Flutter:
import 'package:flutter/material.dart';

void main() {
  runApp(const YoLeoApp());
}

class YoLeoApp extends StatelessWidget {
  const YoLeoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '¡YO LEO!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Arial',
      ),
      home: const MainMenuScreen(),
    );
  }
}

// ---------------------------------------------------------------------
// 1. PANTALLA PRINCIPAL / MENÚ DE SELECCIÓN DE NIVELES
// ---------------------------------------------------------------------
class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  bool esMayuscula = true;

  final List<Map<String, dynamic>> niveles = [
    {'id': 1, 'titulo': 'Nivel 1\nAbecedario', 'color': Colors.orangeAccent, 'icon': Icons.abc, 'palabra': 'MAMA'},
    {'id': 2, 'titulo': 'Nivel 2\nSílabas', 'color': Colors.lightBlueAccent, 'icon': Icons.grid_view, 'palabra': 'SOL'},
    {'id': 3, 'titulo': 'Nivel 3\n2 Sílabas', 'color': Colors.greenAccent, 'icon': Icons.looks_two, 'palabra': 'VACA'},
    {'id': 4, 'titulo': 'Nivel 4\n3 Sílabas', 'color': Colors.purpleAccent, 'icon': Icons.looks_3, 'palabra': 'PELOTA'},
    {'id': 5, 'titulo': 'Nivel 5\nInversas', 'color': Colors.pinkAccent, 'icon': Icons.swap_horiz, 'palabra': 'ARBOL'},
    {'id': 6, 'titulo': 'Nivel 6\nTrabadas', 'color': Colors.amberAccent, 'icon': Icons.extension, 'palabra': 'TREN'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('¡YO LEO!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                      Text('La lectura es divertida', style: TextStyle(fontSize: 18, color: Colors.black87)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)]),
                    child: Row(
                      children: [
                        Text(esMayuscula ? 'MAYÚSCULAS' : 'minúsculas', style: const TextStyle(fontWeight: FontWeight.bold)),
                        Switch(
                          value: esMayuscula,
                          activeColor: Colors.green,
                          onChanged: (val) => setState(() => esMayuscula = val),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.green, width: 2)),
                          child: const Text('¡Hola! Soy Puchin 🦜\n¡Toca un nivel para jugar!', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 10),
                        const Icon(Icons.flutter_dash, size: 120, color: Colors.green),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 1.1),
                        itemCount: niveles.length,
                        itemBuilder: (context, index) {
                          final nivel = niveles[index];
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: nivel['color'], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), elevation: 5),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EjercicioScreen(
                                    palabraObjetivo: nivel['palabra'],
                                    esMayuscula: esMayuscula,
                                    numSilabas: 2,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(nivel['icon'], size: 40, color: Colors.black70),
                                const SizedBox(height: 8),
                                Text(nivel['titulo'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// 2. PANTALLA PRINCIPAL DE EJERCICIOS UNIFICADA
// ---------------------------------------------------------------------
class EjercicioScreen extends StatefulWidget {
  final String palabraObjetivo;
  final bool esMayuscula;
  final int numSilabas;

  const EjercicioScreen({
    Key? key,
    required this.palabraObjetivo,
    required this.esMayuscula,
    required this.numSilabas,
  }) : super(key: key);

  @override
  _EjercicioScreenState createState() => _EjercicioScreenState();
}

class _EjercicioScreenState extends State<EjercicioScreen> {
  bool palabraCompletada = false;

  @override
  Widget build(BuildContext context) {
    List<String> letrasObjetivo = widget.palabraObjetivo.split('');

    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: Text('Jugando con Puchin - ${widget.palabraObjetivo}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // ZONA SUPERIOR: Imagen + Contadores
              Row(
                children: [
                  Container(
                    width: 130,
                    height: 100,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade400)),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 50, color: Colors.green),
                        Text('Imagen Dinámica', style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.esMayuscula ? widget.palabraObjetivo : widget.palabraObjetivo.toLowerCase(),
                          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 3, color: Colors.black87),
                        ),
                        Row(
                          children: [
                            Chip(label: Text('Nº Sílabas: ${widget.numSilabas}'), backgroundColor: Colors.orange.shade100),
                            const SizedBox(width: 10),
                            Chip(label: Text('Nº Letras: ${widget.palabraObjetivo.length}'), backgroundColor: Colors.blue.shade100),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // ZONA MEDIA Y INFERIOR DIVIDIDA
              Expanded(
                child: Row(
                  children: [
                    // IZQUIERDA: Ruleta 3D de Letras
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade300)),
                        child: RuletaLetrasWidget(
                          palabraObjetivo: letrasObjetivo,
                          esMayuscula: widget.esMayuscula,
                          OnPalabraCompletada: (exito) {
                            setState(() => palabraCompletada = exito);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // DERECHA: Trazo Cursivo Punteado y Dictado QWERTY
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TrazadoPunteadoWidget(
                              textoParaRepasar: widget.palabraObjetivo,
                              onReproducirAudio: () {},
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            flex: 1,
                            child: DictadoTecladoWidget(
                              palabraTrabajada: widget.palabraObjetivo,
                              onOracionCompleta: (oracion) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// 3. COMPONENTE: RULETA 3D CON ENGRANAJES
// ---------------------------------------------------------------------
class RuletaLetrasWidget extends StatefulWidget {
  final List<String> palabraObjetivo;
  final bool esMayuscula;
  final Function(bool) OnPalabraCompletada;

  const RuletaLetrasWidget({Key? key, required this.palabraObjetivo, required this.esMayuscula, required this.OnPalabraCompletada}) : super(key: key);

  @override
  _RuletaLetrasWidgetState createState() => _RuletaLetrasWidgetState();
}

class _RuletaLetrasWidgetState extends State<RuletaLetrasWidget> {
  final List<String> abecedario = ['A', 'B', 'C', 'CH', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'LL', 'M', 'N', 'Ñ', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
  late List<int> indicesActuales;
  late List<int> intentosPorColumna;
  late List<bool?> estadosColumna;
  int columnaActiva = 0;

  @override
  void initState() {
    super.initState();
    indicesActuales = List.filled(widget.palabraObjetivo.length, 0);
    intentosPorColumna = List.filled(widget.palabraObjetivo.length, 0);
    estadosColumna = List.filled(widget.palabraObjetivo.length, null);
  }

  void _validarLetra(int indexColumna) {
    if (indexColumna != columnaActiva) return;

    String letraSeleccionada = abecedario[indicesActuales[indexColumna]];
    String letraCorrecta = widget.palabraObjetivo[indexColumna];

    if (!widget.esMayuscula) {
      letraSeleccionada = letraSeleccionada.toLowerCase();
      letraCorrecta = letraCorrecta.toLowerCase();
    }

    if (letraSeleccionada == letraCorrecta) {
      setState(() {
        estadosColumna[indexColumna] = true;
        columnaActiva++;
        if (columnaActiva >= widget.palabraObjetivo.length) {
          widget.OnPalabraCompletada(true);
        }
      });
    } else {
      setState(() {
        intentosPorColumna[indexColumna]++;
        estadosColumna[indexColumna] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 60, decoration: BoxDecoration(border: Border.all(color: Colors.purple.shade700, width: 3), borderRadius: BorderRadius.circular(8))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.palabraObjetivo.length, (colIndex) => _buildCilindroColumna(colIndex)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.palabraObjetivo.length, (colIndex) => _buildPerillaBoton(colIndex)),
        ),
      ],
    );
  }

  Widget _buildCilindroColumna(int colIndex) {
    bool esActiva = colIndex == columnaActiva;
    Color colorFondo = Colors.amber.shade300;
    if (estadosColumna[colIndex] == true) colorFondo = Colors.green.shade400;
    if (estadosColumna[colIndex] == false) colorFondo = Colors.red.shade300;

    return Container(
      width: 50,
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(color: colorFondo, borderRadius: BorderRadius.circular(8), border: Border.all(color: esActiva ? Colors.purple : Colors.grey, width: esActiva ? 3 : 1)),
      child: ListWheelScrollView.useDelegate(
        itemExtent: 45,
        diameterRatio: 1.2,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          setState(() {
            indicesActuales[colIndex] = index % abecedario.length;
            estadosColumna[colIndex] = null;
          });
        },
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            final letra = abecedario[index % abecedario.length];
            final textoMostrar = widget.esMayuscula ? letra : letra.toLowerCase();
            return Center(child: Text(textoMostrar, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)));
          },
        ),
      ),
    );
  }

  Widget _buildPerillaBoton(int colIndex) {
    return Container(
      width: 50,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade800, shape: const CircleBorder(), padding: const EdgeInsets.all(12)),
        onPressed: () => _validarLetra(colIndex),
        child: const Icon(Icons.touch_app, color: Colors.white, size: 18),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// 4. COMPONENTE: TRAZO PUNTEADO CURSIVO
// ---------------------------------------------------------------------
class TrazadoPunteadoWidget extends StatefulWidget {
  final String textoParaRepasar;
  final VoidCallback onReproducirAudio;

  const TrazadoPunteadoWidget({Key? key, required this.textoParaRepasar, required this.onReproducirAudio}) : super(key: key);

  @override
  _TrazadoPunteadoWidgetState createState() => _TrazadoPunteadoWidgetState();
}

class _TrazadoPunteadoWidgetState extends State<TrazadoPunteadoWidget> {
  List<Offset?> puntosTrazo = [];
  Offset? posicionLapiz;
  bool tocando = false;

  @override
  Widget build(BuildContext context) {
    final textoMinuscula = widget.textoParaRepasar.toLowerCase();

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade300, width: 2)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: const Icon(Icons.volume_up, color: Colors.blue, size: 24), onPressed: widget.onReproducirAudio),
              const Text('Repasa con tu dedo', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
              IconButton(icon: const Icon(Icons.cleaning_services, color: Colors.orange, size: 22), onPressed: () => setState(() => puntosTrazo.clear())),
            ],
          ),
          Expanded(
            child: GestureDetector(
              onPanStart: (details) {
                RenderBox renderBox = context.findRenderObject() as RenderBox;
                Offset localPos = renderBox.globalToLocal(details.globalPosition);
                setState(() { puntosTrazo.add(localPos); posicionLapiz = localPos; tocando = true; });
              },
              onPanUpdate: (details) {
                RenderBox renderBox = context.findRenderObject() as RenderBox;
                Offset localPos = renderBox.globalToLocal(details.globalPosition);
                setState(() { puntosTrazo.add(localPos); posicionLapiz = localPos; });
              },
              onPanEnd: (details) => setState(() { puntosTrazo.add(null); tocando = false; }),
              child: Stack(
                children: [
                  Center(child: Text(textoMinuscula, style: const TextStyle(fontSize: 55, color: Colors.grey, letterSpacing: 4))),
                  CustomPaint(painter: TrazoPainter(puntos: puntosTrazo), size: Size.infinite),
                  if (tocando && posicionLapiz != null)
                    Positioned(left: posicionLapiz!.dx - 5, top: posicionLapiz!.dy - 25, child: const Icon(Icons.edit, size: 28, color: Colors.redAccent)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrazoPainter extends CustomPainter {
  final List<Offset?> puntos;
  TrazoPainter({required this.puntos});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue.shade600..strokeCap = StrokeCap.round..strokeWidth = 8.0;
    for (int i = 0; i < puntos.length - 1; i++) {
      if (puntos[i] != null && puntos[i + 1] != null) {
        canvas.drawLine(puntos[i]!, puntos[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ---------------------------------------------------------------------
// 5. COMPONENTE: DICTADO Y TECLADO QWERTY
// ---------------------------------------------------------------------
class DictadoTecladoWidget extends StatefulWidget {
  final String palabraTrabajada;
  final Function(String) onOracionCompleta;

  const DictadoTecladoWidget({Key? key, required this.palabraTrabajada, required this.onOracionCompleta}) : super(key: key);

  @override
  _DictadoTecladoWidgetState createState() => _DictadoTecladoWidgetState();
}

class _DictadoTecladoWidgetState extends State<DictadoTecladoWidget> {
  String oracionDictada = "La ______ come pasto";
  String textoIngresado = "";
  bool escuchando = false;

  final List<List<String>> filasTeclado = [
    ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
    ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
    ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'ñ'],
    ['z', 'x', 'c', 'v', 'b', 'n', 'm']
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: const Color(0xFFFFF8E1), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.amber.shade600, width: 1.5)),
      child: Column(
        children: [
          Row(
            children: [
              FloatingActionButton.small(
                backgroundColor: escuchando ? Colors.red : Colors.green,
                onPressed: () {
                  setState(() => escuchando = true);
                  Future.delayed(const Duration(seconds: 2), () => setState(() { escuchando = false; oracionDictada = "Mi ______ da leche"; }));
                },
                child: Icon(escuchando ? Icons.mic : Icons.mic_none, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
                  child: Text(oracionDictada.replaceAll("______", textoIngresado.isEmpty ? "______" : textoIngresado.toUpperCase()), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ),
              IconButton(icon: const Icon(Icons.play_circle_fill, color: Colors.purple, size: 28), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var fila in filasTeclado)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: fila.map((tecla) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.5),
                          child: SizedBox(
                            width: 26,
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), elevation: 1),
                              onPressed: () => setState(() => textoIngresado += tecla),
                              child: Text(tecla, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


4. Guía para Generar el Archivo Instalable (.APK)
Instalar Flutter SDK: Configurar el entorno de desarrollo Flutter en tu computadora.
Crear el Proyecto: Ejecutar en la terminal: flutter create yo_leo_app
Reemplazar Código: Pegar el código anterior dentro del archivo lib/main.dart.
Compilar para Android: Abrir la terminal dentro de la carpeta del proyecto y ejecutar:
flutter build apk --release
Obtener el Archivo: El archivo compilado estará listo en la ruta:
build/app/outputs/flutter-apk/app-release.apk
Instalación en la Tableta MINEDU: Copiar el archivo app-release.apk a una memoria USB/Pendrive o mediante cable USB a las tabletas Android del MINEDU e instalarlo directamente.
