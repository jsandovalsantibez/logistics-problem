---INTEGRANTES---
Matías Riveros
Diego Troncoso
Diego Pizarro 
Jorge Sandoval

(define (domain despacho-carga)
  (:requirements :strips :typing)
  (:types
    ciudad vehiculo carga contenedor paquete - object
  )
  (:predicates
    (en-ciudad ?c - carga ?ci - ciudad)
    (en-vehiculo ?v - vehiculo ?c - carga)
    (puerto-en-ciudad ?p - vehiculo ?ci - ciudad)
    (aeropuerto-en-ciudad ?a - vehiculo ?ci - ciudad)
    (puede-llevar-contenedor ?v - vehiculo)
    (puede-llevar-paquete ?v - vehiculo)
    (detalles-carga ?c - carga ?peso - number ?volumen - number) ; Detalles adicionales de carga
    (capacidad-carga ?v - vehiculo ?capacidad - number) ; Capacidad de carga del vehículo
  )

  (:action cargar
    :parameters (?v - vehiculo ?c - carga ?ci - ciudad ?peso - number ?volumen - number)
    :precondition (and 
                   (en-ciudad ?c ?ci) 
                   (en-vehiculo ?v ?c) 
                   (or 
                    (and (puede-llevar-contenedor ?v) (not (exists (?c2 - carga) (and (en-vehiculo ?v ?c2) (different ?c ?c2)))))
                    (and (puede-llevar-paquete ?v) (not (exists (?c2 - carga) (and (en-vehiculo ?v ?c2) (different ?c ?c2)))))
                   )
                   (detalles-carga ?c ?peso ?volumen) ; Agregado para detallar carga
                   (capacidad-carga ?v ?capacidad) ; Agregado para limitar la capacidad del vehículo
    )
    :effect (and (not (en-ciudad ?c ?ci)) (not (en-vehiculo ?v ?c)) (en-vehiculo ?v ?c))
  )
)

(define (problem ejemplo1-modelo1)
  (:domain despacho-carga)
  (:objects
    valparaiso santiago tokyo - ciudad
    camioneta camion barco avion - vehiculo
    contenedor1 contenedor2 contenedor3 - contenedor
    paquete1 paquete2 paquete3 - paquete
  )
  (:init
    ; condiciones iniciales
    (en-ciudad contenedor1 valparaiso)
    (en-ciudad contenedor2 tokyo)
    (en-ciudad contenedor3 santiago)

    (en-ciudad paquete1 valparaiso)
    (en-ciudad paquete2 santiago)
    (en-ciudad paquete3 tokyo)

    (en-vehiculo camion contenedor1)
    (en-vehiculo barco contenedor2)
    (en-vehiculo avion paquete1)
    (en-vehiculo camion paquete2)

    ; Restricciones adicionales
    (puede-llevar-contenedor camion)
    (puede-llevar-contenedor barco)
    (puede-llevar-paquete avion)
    (puede-llevar-paquete camioneta)

    ; Detalles adicionales de carga y capacidad de carga de vehículos
    (detalles-carga contenedor1 100 200) ; Contenedor1 tiene 100 de peso y 200 de volumen
    (detalles-carga contenedor2 150 250) ; Contenedor2 tiene 150 de peso y 250 de volumen
    (detalles-carga paquete1 20 30)      ; Paquete1 tiene 20 de peso y 30 de volumen
    (detalles-carga paquete2 30 40)      ; Paquete2 tiene 30 de peso y 40 de volumen

    (capacidad-carga camion 200)         ; Camion puede cargar hasta 200 de capacidad
    (capacidad-carga barco 300)          ; Barco puede cargar hasta 300 de capacidad
    (capacidad-carga avion 50)           ; Avion puede cargar hasta 50 de capacidad
    (capacidad-carga camioneta 40)       ; Camioneta puede cargar hasta 40 de capacidad
  )
  (:goal (and 
          (en-ciudad contenedor1 tokyo)
          (en-ciudad contenedor2 valparaiso)
          (en-ciudad paquete1 santiago)
          (en-ciudad paquete2 valparaiso)
          (en-ciudad paquete3 santiago)
        ))
)