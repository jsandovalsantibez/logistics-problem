% -----------------------------------------------------------------------------------------------------------
%TAREA Nº2
%Razonamiento, Conocimiento y Planificación.
%CINF103 Fundamentos de IA

%---INTEGRANTES---
%Matías Riveros
%Diego Troncoso
%Diego Pizarro 
%Jorge Sandoval

% -----------------------------------------------------------------------------------------------------------
% 											***HECHOS INICIALES***
% 	Hechos que establecen la ubicación de contenedores, paquetes y vehículos al inicio del problema.
% -----------------------------------------------------------------------------------------------------------
en_ciudad(contenedor1, valparaiso).
en_ciudad(contenedor2, tokyo).
en_ciudad(contenedor3, santiago).

en_ciudad(paquete1, valparaiso).
en_ciudad(paquete2, santiago).
en_ciudad(paquete3, tokyo).

en_vehiculo(camion, contenedor1).
en_vehiculo(barco, contenedor2).
en_vehiculo(avion, paquete1).
en_vehiculo(camion, paquete2).

puede_llevar_contenedor(camion).
puede_llevar_contenedor(barco).
puede_llevar_paquete(avion).
puede_llevar_paquete(camioneta).

% -----------------------------------------------------------------------------------------------------------
% 												***DETALLES DE CARGA***
% 			Hechos que representan detalles específicos de la carga, como peso y volumen.
% -----------------------------------------------------------------------------------------------------------
detalles_carga(contenedor1, 100, 200).
detalles_carga(contenedor2, 150, 250).
detalles_carga(paquete1, 20, 30).
detalles_carga(paquete2, 30, 40).
% -----------------------------------------------------------------------------------------------------------
% 								***CAPACIDAD DE CARGA Y CONTENIDO DE UN VEHÍCULO***
% 				Hechos que establecen la capacidad de carga de diferentes tipos de vehículos.
% -----------------------------------------------------------------------------------------------------------
capacidad_carga(camion, 200).
capacidad_carga(barco, 300).
capacidad_carga(avion, 50).
capacidad_carga(camioneta, 40).

contenedor_en_paquete(Contenedor, Paquete) :-
    en_vehiculo(Contenedor, Paquete),
    carga_paquete(Paquete).

carga_paquete(Paquete) :-
    paquete(Paquete).

paquete(Paquete) :- en_ciudad(Paquete, _).

% -----------------------------------------------------------------------------------------------------------
% 											***REGLAS DE CARGA***
% 			Reglas que definen cómo se realiza la carga de contenedores y paquetes en vehículos.
% -----------------------------------------------------------------------------------------------------------
cargar_modelo1(Vehiculo, Carga, Ciudad, Peso, Volumen) :-
    en_ciudad(Carga, Ciudad),
    en_vehiculo(Vehiculo, Carga),
    (puede_llevar_contenedor(Vehiculo) ; puede_llevar_paquete(Vehiculo)),
    detalles_carga(Carga, Peso, Volumen),
    capacidad_carga(Vehiculo, Capacidad),
    Peso =< Capacidad.

cargar_modelo2(Vehiculo, Carga, Ciudad, Peso, Volumen) :-
    cargar_modelo1(Vehiculo, Carga, Ciudad, Peso, Volumen),
    (not(puede_llevar_contenedor(Vehiculo)) ; not(contenedor_en_paquete(Carga, _))).

% -----------------------------------------------------------------------------------------------------------
% 										***REGLAS PARA GENERAR UN PLAN***
% Regla que genera un plan resolviendo el problema de logística con tres elementos para el Modelo 1 Y 2
% -----------------------------------------------------------------------------------------------------------
generar_plan_modelo1 :-
    cargar_modelo1(Vehiculo1, Carga1, Ciudad1, Peso1, Volumen1),
    cargar_modelo1(Vehiculo2, Carga2, Ciudad2, Peso2, Volumen2),
    cargar_modelo1(Vehiculo3, Carga3, Ciudad3, Peso3, Volumen3),
    Carga2 \= Carga1,
    Carga3 \= Carga1, Carga3 \= Carga2,
    write('Plan generado (Modelo 1): '), nl,
    write_plan_modelo1(Vehiculo1, Carga1, Ciudad1, Peso1, Volumen1),
    write_plan_modelo1(Vehiculo2, Carga2, Ciudad2, Peso2, Volumen2),
    write_plan_modelo1(Vehiculo3, Carga3, Ciudad3, Peso3, Volumen3).

generar_plan_modelo2 :-
    cargar_modelo2(Vehiculo1, Carga1, Ciudad1, Peso1, Volumen1),
    cargar_modelo2(Vehiculo2, Carga2, Ciudad2, Peso2, Volumen2),
    cargar_modelo2(Vehiculo3, Carga3, Ciudad3, Peso3, Volumen3),
    Carga2 \= Carga1,
    Carga3 \= Carga1, Carga3 \= Carga2,
    write('Plan generado (Modelo 2): '), nl,
    write_plan_modelo2(Vehiculo1, Carga1, Ciudad1, Peso1, Volumen1),
    write_plan_modelo2(Vehiculo2, Carga2, Ciudad2, Peso2, Volumen2),
    write_plan_modelo2(Vehiculo3, Carga3, Ciudad3, Peso3, Volumen3).

% -----------------------------------------------------------------------------------------------------------
% 										***REGLAS PARA IMPRIMIR UN PLAN***
% 			Reglas que imprimen en consola los detalles de un plan generado para el Modelo 1 y 2.
% -----------------------------------------------------------------------------------------------------------
write_plan_modelo1(Vehiculo, Carga, Ciudad, Peso, Volumen) :-
    write('  Vehiculo: '), write(Vehiculo), nl,
    write('  Carga: '), write(Carga), nl,
    write('  Ciudad: '), write(Ciudad), nl,
    write('  Peso: '), write(Peso), nl,
    write('  Volumen: '), write(Volumen), nl.

write_plan_modelo2(Vehiculo, Carga, Ciudad, Peso, Volumen) :-
    write('  Vehiculo: '), write(Vehiculo), nl,
    write('  Carga: '), write(Carga), nl,
    write('  Ciudad: '), write(Ciudad), nl,
    write('  Peso: '), write(Peso), nl,
    write('  Volumen: '), write(Volumen), nl.
% -----------------------------------------------------------------------------------------------------------
% 										***ACCIONES APLICABLES***
% 				Regla que verifica si cargar una carga en un vehículo es aplicable.
% -----------------------------------------------------------------------------------------------------------
accion_aplicable_modelo1(Vehiculo, Carga, Ciudad, Peso, Volumen) :-
    cargar_modelo1(Vehiculo, Carga, Ciudad, Peso, Volumen),
    write('La acción es aplicable para los siguientes parámetros en el Modelo 1: '), nl,
    write_plan_modelo1(Vehiculo, Carga, Ciudad, Peso, Volumen).

accion_aplicable_modelo2(Vehiculo, Carga, Ciudad, Peso, Volumen) :-
    cargar_modelo2(Vehiculo, Carga, Ciudad, Peso, Volumen),
    write('La acción es aplicable para los siguientes parámetros en el Modelo 2: '), nl,
    write_plan_modelo2(Vehiculo, Carga, Ciudad, Peso, Volumen).
% -----------------------------------------------------------------------------------------------------------
% 										***EJEMPLO DE REGLA PARA EXPLORAR SITUACIONES***
% 	Regla que explora la situación donde contenedor1 y paquete2 se cargan en un camión en el Modelo 2.
% -----------------------------------------------------------------------------------------------------------
explorar_situacion_modelo1('Cargar contenedor1 y paquete2 en un camión') :-
    en_ciudad(contenedor1, valparaiso),
    en_ciudad(paquete2, santiago),
    en_vehiculo(camion, contenedor1),
    en_vehiculo(camion, paquete2),
    capacidad_carga(camion, Capacidad),
    detalles_carga(contenedor1, PesoContenedor, _),
    detalles_carga(paquete2, PesoPaquete, _),
    PesoContenedor + PesoPaquete =< Capacidad,
    write('Situación posible: Contenedor1 y paquete2 pueden ser cargados en un camión.'), nl.

explorar_situacion_modelo2('Escenario 1 en el Modelo 2') :-
    en_ciudad(contenedor1, valparaiso),
    en_ciudad(paquete2, santiago),
    en_vehiculo(camion, contenedor1),
    en_vehiculo(camion, paquete2),
    capacidad_carga(camion, Capacidad),
    detalles_carga(contenedor1, PesoContenedor, _),
    detalles_carga(paquete2, PesoPaquete, _),
    PesoContenedor + PesoPaquete =< Capacidad,
    cargar_modelo2(camion, contenedor1, valparaiso, PesoContenedor, 200),
    cargar_modelo2(camion, paquete2, santiago, PesoPaquete, 40),
    write('Situación posible en el Modelo 2: Contenedor1 y paquete2 pueden ser cargados en un camión.'), nl.
% -----------------------------------------------------------------------------------------------------------


