AIRPORT FINDER APP

Esta es una aplicación iOS que te permite buscar aeropuertos dentro de un radio específico desde tu ubicación actual. Utiliza el servicio de la API Aviation Reference Data para obtener datos sobre los aeropuertos cercanos.

CARACTERISTICAS:

Slider de Radio: Permite al usuario ajustar el radio de búsqueda en kilómetros.
Mapa de Aeropuertos: Muestra los aeropuertos encontrados en un mapa con pines.
Lista de Aeropuertos: Presenta los mismos aeropuertos en formato de lista para una vista detallada.

ARQUITECTURA:

La aplicación está desarrollada utilizando el patrón VIPER (View, Interactor, Presenter, Entity, Router). VIPER asegura una separación clara de responsabilidades y mejora la escalabilidad y la testabilidad del código.

TECNOLOGIAS UTILIZADAS:

Swift: Lenguaje de programación nativo para iOS.

CoreLocation: Para obtener la ubicación actual del usuario.

MapKit: Para mostrar el mapa y los pines de los aeropuertos.

URLSession: Para comunicarse con la API Aviation Reference Data.

PARA EJECUTAR SIGUE LOS SIGUIENTES PASOS:

-Clona este repositorio

-Abre el archivo del proyecto airport-locator-app.xcodeproj en Xcode.

-Compila y ejecuta la aplicación en un simulador o dispositivo iOS.

USO:

En la pantalla principal, utiliza el slider para ajustar el radio de búsqueda en kilómetros.
Presiona el botón "Search".
Serás llevado a un TabBarController con dos pestañas:

Mapa: Muestra los aeropuertos encontrados en un mapa interactivo.

Lista: Muestra los aeropuertos encontrados en formato de lista para una vista detallada.
