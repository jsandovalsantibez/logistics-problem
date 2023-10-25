---INTEGRANTES---
Matías Riveros
Diego Troncoso
Diego Pizarro 
Jorge Sandoval

(define (domain despacho-carga-modelo2)
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
    (contenedor-en-paquete ?cont - contenedor ?p - paquete)
    (detalles-carga ?c - carga ?peso - number ?volumen - number)
    (capacidad-carga ?v - vehiculo ?capacidad - number)
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
                   (detalles-carga ?c ?peso ?volumen)
                   (capacidad-carga ?v ?capacidad)
    )
    :effect (and (not (en-ciudad ?c ?ci)) (not (en-vehiculo ?v ?c)) (en-vehiculo ?v ?c))
  )

  (:action cargar-contenedor
    :parameters (?v - vehiculo ?c - contenedor ?ci - ciudad ?peso - number ?volumen - number ?p1 - paquete ?p2 - paquete)
    :precondition (and 
                   (en-ciudad ?c ?ci) 
                   (en-vehiculo ?v ?c) 
                   (puede-llevar-contenedor ?v) 
                   (not (exists (?c2 - carga) (and (en-vehiculo ?v ?c2) (different ?c ?c2))))
                   (contenedor-en-paquete ?c ?p1) 
                   (contenedor-en-paquete ?c ?p2)
                   (detalles-carga ?c ?peso ?volumen)
                   (capacidad-carga ?v ?capacidad)
    )
    :effect (and 
             (not (en-ciudad ?c ?ci)) 
             (not (en-vehiculo ?v ?c)) 
             (en-vehiculo ?v ?c) 
             (not (contenedor-en-paquete ?c ?p1)) 
             (not (contenedor-en-paquete ?c ?p2))
            )
  )
)

(define (problem ejemplo1-modelo2)
  (:domain despacho-carga-modelo2)
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

    (detalles-carga contenedor1 100 200)
    (detalles-carga contenedor2 150 250)
    (detalles-carga paquete1 20 30)
    (detalles-carga paquete2 30 40)

    (capacidad-carga camion 200)
    (capacidad-carga barco 300)
    (capacidad-carga avion 50)
    (capacidad-carga camioneta 40)

    (contenedor-en-paquete contenedor1 paquete1)
    (contenedor-en-paquete contenedor1 paquete2)
    (contenedor-en-paquete contenedor2 paquete3)
  )
  (:goal (and 
          (en-ciudad contenedor1 tokyo)
          (en-ciudad contenedor2 valparaiso)
          (en-ciudad paquete1 santiago)
          (en-ciudad paquete2 valparaiso)
          (en-ciudad paquete3 santiago)
        ))
)