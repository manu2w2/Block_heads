extends Control

# --- Configuración ---
const API_URL = "https://api.coinbase.com/v2/prices/BTC-USD/spot"
const INTERVALO_API = 10.0        # cada cuánto pide precio real a la API
const INTERVALO_SIM = 1         # cada cuánto simula un movimiento intermedio
const MAX_PUNTOS_GRAFICA = 200     # puntos visibles en la gráfica
const USD_INICIAL = 1000.0

# --- Parámetros de simulación ---
# Qué tan fuerte puede moverse el precio en cada tick simulado (% del precio)
const VOLATILIDAD = 0.008         # 0.8% por tick → movimientos visibles pero no caóticos
# Qué tan fuerte "jala" el precio simulado hacia el precio real de la API
const FUERZA_ANCLA = 0.50         # 15% → se acerca suavemente al real

# --- Estado del juego ---
var precio_actual: float = 0.0
var precio_anterior: float = 0.0
var precio_ancla: float = 0.0     # último precio real de la API
var historial_precios: Array = []
var usd_disponible: float = USD_INICIAL
var btc_disponible: float = 0.0
var ganancia_total: float = 0.0

# --- Referencias a nodos ---
@onready var label_precio = $VBoxContainer/HBoxContainer2/PrecioBit
@onready var label_hora = $"VBoxContainer/HBoxContainer2/Hora y fecha"
@onready var line2d = $VBoxContainer/HBoxContainer/Grafica/PanelContainer/Line2D
@onready var panel_grafica = $VBoxContainer/HBoxContainer/Grafica/PanelContainer
@onready var spinbox_comprar = $VBoxContainer/HBoxContainer/ComprarVender/TabContainer/Comprar/cantidadBTC/SpinBox
@onready var label_ganancia = $VBoxContainer/HBoxContainer/Grafica/btc_usd/Label
@onready var label_ganancia2 = $VBoxContainer/HBoxContainer/Grafica/btc_usd/Label2
@onready var historial_label = $VBoxContainer/HBoxContainer/Historial/Label
@onready var label_usd_disp = $VBoxContainer/HBoxContainer/ComprarVender/balance/USD
@onready var label_btc_disp = $VBoxContainer/HBoxContainer/ComprarVender/balance/BTC
@onready var http_request = HTTPRequest.new()
@onready var timer_api = Timer.new()
@onready var timer_sim = Timer.new()

func _ready():
	add_child(http_request)
	http_request.request_completed.connect(_on_precio_recibido)

	# Timer para llamar la API cada 60s
	add_child(timer_api)
	timer_api.wait_time = INTERVALO_API
	timer_api.timeout.connect(_pedir_precio_real)
	timer_api.start()

	# Timer para simular movimientos cada 3s
	add_child(timer_sim)
	timer_sim.wait_time = INTERVALO_SIM
	timer_sim.timeout.connect(_tick_simulacion)
	# No iniciar hasta tener precio base

	$VBoxContainer/HBoxContainer/ComprarVender/TabContainer/Comprar/BtnComprar.pressed.connect(_comprar)
	$VBoxContainer/HBoxContainer/ComprarVender/TabContainer/Vender/BtnVender.pressed.connect(_vender)

	# Pedir precio real inmediatamente al iniciar
	_pedir_precio_real()
	_actualizar_ui_balance()

# =============================================
#  API: PRECIO REAL CADA 60 SEGUNDOS
# =============================================
func _pedir_precio_real():
	label_hora.text = Time.get_datetime_string_from_system()
	http_request.request(API_URL)

func _on_precio_recibido(_result, response_code, _headers, body):
	if response_code != 200:
		print("API error: ", response_code)
		if precio_ancla == 0.0:
			# Si falla al inicio, usar precio de fallback
			precio_ancla = 65000.0
			precio_actual = precio_ancla
			precio_anterior = precio_ancla
			_iniciar_simulacion()
		return

	var json = JSON.new()
	if json.parse(body.get_string_from_utf8()) != OK:
		return

	var nuevo_precio_real = float(json.get_data()["data"]["amount"])
	precio_ancla = nuevo_precio_real

	# Primera vez: inicializar todo
	if precio_actual == 0.0:
		precio_actual = precio_ancla
		precio_anterior = precio_ancla
		historial_precios.append(precio_actual)
		_actualizar_grafica()
		_actualizar_ui_precio()
		_iniciar_simulacion()

func _iniciar_simulacion():
	timer_sim.start()

# =============================================
#  SIMULACIÓN: TICK CADA 3 SEGUNDOS
# =============================================
func _tick_simulacion():
	if precio_actual == 0.0 or precio_ancla == 0.0:
		return

	label_hora.text = Time.get_datetime_string_from_system()
	precio_anterior = precio_actual

	# 1. Ruido aleatorio (volatilidad)
	var ruido = randf_range(-VOLATILIDAD, VOLATILIDAD) * precio_actual

	# 2. Fuerza que jala hacia el precio real (ancla)
	var diferencia = precio_ancla - precio_actual
	var ancla = diferencia * FUERZA_ANCLA

	# 3. Precio nuevo = actual + ruido + fuerza ancla
	precio_actual = precio_actual + ruido + ancla
	precio_actual = max(precio_actual, 1000.0)

	historial_precios.append(precio_actual)
	if historial_precios.size() > MAX_PUNTOS_GRAFICA:
		historial_precios.pop_front()

	_actualizar_grafica()
	_actualizar_ui_precio()

# =============================================
#  DIBUJAR GRÁFICA EN LINE2D
# =============================================
func _actualizar_grafica():
	if historial_precios.size() < 2:
		return

	await get_tree().process_frame

	var ancho = panel_grafica.size.x
	var alto = panel_grafica.size.y
	var margen = 8.0

	if ancho <= 0 or alto <= 0:
		return

	var precio_min = historial_precios.min()
	var precio_max = historial_precios.max()
	var rango = precio_max - precio_min
	if rango < 1.0:
		rango = 1.0

	var puntos: PackedVector2Array = []
	for i in range(historial_precios.size()):
		var t = float(i) / float(historial_precios.size() - 1)
		var x = margen + t * (ancho - margen * 2.0)
		var norm_y = (historial_precios[i] - precio_min) / rango
		var y = (alto - margen) - norm_y * (alto - margen * 2.0)
		puntos.append(Vector2(x, y))

	line2d.points = puntos
	line2d.width = 2.0

	if historial_precios[-1] >= historial_precios[-2]:
		line2d.default_color = Color(0.0, 1.0, 0.4)  # verde
	else:
		line2d.default_color = Color(1.0, 0.3, 0.3)  # rojo

# =============================================
#  ACTUALIZAR UI
# =============================================
func _actualizar_ui_precio():
	label_precio.text = "BTC/USD: $%.2f" % precio_actual

	var cambio = precio_actual - precio_anterior
	var simbolo = "▲" if cambio >= 0 else "▼"
	label_ganancia.text = "BTC/USD"
	label_ganancia2.text = "%s $%.2f" % [simbolo, abs(cambio)]

func _actualizar_ui_balance():
	label_usd_disp.text = "USD disponible: $%.2f" % usd_disponible
	label_btc_disp.text = "BTC disponible: %.6f" % btc_disponible

	ganancia_total = (usd_disponible + btc_disponible * precio_actual) - USD_INICIAL
	var signo = "+" if ganancia_total >= 0 else ""
	historial_label.text = "Ganancia total: %s$%.2f" % [signo, ganancia_total]

# =============================================
#  LÓGICA DE COMPRA / VENTA
# =============================================
func _comprar():
	if precio_actual <= 0:
		return
	var cantidad = spinbox_comprar.value
	if cantidad <= 0:
		return
	var costo = cantidad * precio_actual
	if costo > usd_disponible:
		print("No tienes suficientes USD")
		return
	usd_disponible -= costo
	btc_disponible += cantidad
	_registrar_transaccion("COMPRA", cantidad, precio_actual)
	_actualizar_ui_balance()

func _vender():
	if precio_actual <= 0:
		return
	var spinbox_vender = $VBoxContainer/HBoxContainer/ComprarVender/TabContainer/Vender/cantidadBTC/SpinBox
	var cantidad = spinbox_vender.value
	if cantidad <= 0:
		return
	if cantidad > btc_disponible:
		print("No tienes suficiente BTC")
		return
	btc_disponible -= cantidad
	usd_disponible += cantidad * precio_actual
	_registrar_transaccion("VENTA", cantidad, precio_actual)
	_actualizar_ui_balance()

func _registrar_transaccion(tipo: String, cantidad: float, precio: float):
	var hora = Time.get_time_string_from_system()
	var linea = "[%s] %s %.4f BTC @ $%.2f\n" % [hora, tipo, cantidad, precio]
	historial_label.text = linea + historial_label.text
	var lineas = historial_label.text.split("\n")
	if lineas.size() > 8:
		historial_label.text = "\n".join(lineas.slice(0, 8))
