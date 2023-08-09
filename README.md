# Flutter Currency Converter Clean Architecture
<i> In this project we use [Currency Converter Api](https://www.currencyconverterapi.com/)
The project is implementing  a clean architecture & bloc for state management so that it’s easy to understand and easy to change as the project grows in the future and implement new technologies or packages.
</i>



## Table of Contents
- [Setup](#intro)
- [Run](#run)
- [Modules](#modules)
- [Implementation](#implementation)
  - [Image](#hive) 
  - [Hive](#hive)
  



## Setup
 - Flutter 3.10.5
 - Dart 3.0.5
 - State Management: [bloc](https://pub.dev/packages/flutter_bloc)
 - Service Locator: [get_it](https://pub.dev/packages/get_it)
 - Image Loader [cached_network_image](https://pub.dev/packages/cached_network_image)
 - Local Database [hive](https://pub.dev/packages/hive)
 - *Packages*
   - [dartz](https://pub.dev/packages/freezed)
   - [equatable](https://pub.dev/packages/equatable)

## Run
Starting the terminal
---------------------
Change directory to project path
then run this:
```
$ flutter run
```


## Implementation
### Image
provides a widget named `CachedNetworkImage` the image displayed with this widget will be downloaded and stored in the cache directory of the app for a period of time. It will be available for offline use without an internet connection
### Hive
is a lightweight and blazing fast key-value database written in pure Dart.
Hive having the idea of `boxes` (which store data).

Hive stores its data in boxes containing key-value sets `Hive.box`
You can call 