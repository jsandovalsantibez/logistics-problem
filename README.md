# logistics-problem

I. Objetivo.
El objetivo de este proyecto es evaluar tu capacidad para:
- AE2: Aplicar técnicas de representación del conocimiento para crear sistemas de
razonamiento automático.
- Diseñar sistemas computacionales basados en agentes inteligentes.
- Implementar sistemas inteligentes orientados a resolver problemas reales.
II. Enunciado.
En este proyecto deberás modelar usando PDDL problemas de logística. Una vez modelados
los problemas, deberás generar un plan que resuelva cada uno de los problemas propuestos
usando algunos de los planificadores vistos en clases.
Tu modelo debe representar un dominio de despacho de carga en el que existe una flota de
camiones, camionetas, barcos y aviones para transportarla:
1. La carga puede viajar entre las ciudades de Valparaíso, Santiago y Tokio.
2. En Valparaíso y Tokio hay puertos.
3. En Santiago y Tokio hay aeropuertos.
4. Entre Santiago y Valparaíso hay rutas para camiones y camionetas.
5. La carga pueden ser contenedores o paquetes.
6. Los contenedores pueden viajar solamente por barco y camión.
7. Los paquetes pueden viajar solamente por avión y camioneta.
   
Modelo 1: En este modelo un camión o un barco solamente pueden llevar un contenedor a la
vez, y las camionetas y los aviones pueden llevar solamente un paquete a la vez.
Genera tres ejemplos de problemas, con diferente cantidad de paquetes, contenedores,
aviones y barcos, ubícalos en las ciudades propuestas y resuélvelos usando tu modelo.

Modelo 2: En este modelo, además de lo anterior, hasta dos paquetes pueden viajar dentro
de un contenedor.
Genera tres ejemplos de problemas, con diferente cantidad de paquetes, contenedores,
aviones y barcos, ubícalos en las ciudades propuestas y resuélvelos usando tu modelo.
