# customers_phones_kev

Mobile App para gestionar clientes y sus números telefónicos.

## Paquetes y librerias

- [get](https://pub.dev/packages/get) (State Management - Dependence Manager)
- [FirebaseAuth](https://pub.dev/packages/firebase_auth) (Gestionar el acceso de los usarios)
- [ObjectBox](https://pub.dev/packages/objectbox) (Almacenamiento local relacional con base para cloud databases)
- [FirebaseAuth](https://pub.dev/packages/firebase_auth) (Gestionar el acceso de los usarios)

## Estructura de los archivos
```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```
Lib es la carpeta principal del desarrollo (clean architecture)
```
lib/
|- const (constantes que se usaron en toda la app)
|- controllers (capa de controladores para las vistas y logica)
|- data (capa de datos para acceder a los repositorios y gestionar el almacenamiento)
|- domain (capa de entidades que son las que estructuran los modelos del software)
|- UI (Capa con las vistas con las que el usuario interactua)
```

## Arquitectura
![Clean Architecture](https://miro.medium.com/max/772/0*ucLr51LpOICwon4Q.jpg)

## Instalacion del proyecto
This project was developed on Flutter v2.10.5 (stable)
```
To run the project:
    |-1 Download the zip code
    |-2 Extract the zip code
    |-3 Rename the extracted folder to 'customers_phones_kev'
    |-4 Open the folder with Visual Code or Android Studio
    |-5 Open the folder's terminal and run 'flutter pub get'
    |-6 Open the 'main.dart' file in the folder 'lib'
    |-7 Press f5 to run the project
```


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
