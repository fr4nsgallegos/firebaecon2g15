import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  int id;
  String name;
  String services;
  LatLng position;
  String urlImage;

  PlaceModel({
    required this.id,
    required this.name,
    required this.services,
    required this.position,
    required this.urlImage,
  });
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: "Museo Larco",
    services:
        "Fundado en 1926, el Museo Larco exhibe un panorama excepcional de 5,000 años de desarrollo de la historia del Perú precolombino.",
    position: LatLng(-12.063769959046716, -77.07790984541732),
    urlImage:
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1b/4f/c6/a5/fachada-del-museo-larco.jpg",
  ),

  PlaceModel(
    id: 2,
    name: "Circuito del agua",
    services:
        "El lugar es muy lindo, las fuentes super imponentes y son un spot ideal para fotos.",
    position: LatLng(-12.064448416743035, -77.07452866323781),
    urlImage:
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/df/aa/c2/img-20190813-192834-largejpg.jpg?w=700&h=400&s=1",
  ),
  PlaceModel(
    id: 3,
    name: "Barranco",
    services:
        "cafés y restaurantes donde podés parar a comer o tomar algo mientras disfrutás del ambiente bohemio del barrio.",
    position: LatLng(-12.064561492858811, -77.07615944568053),
    urlImage:
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/11/ce/ad/e9/alrededores-de-barranco.jpg?w=700&h=-1&s=1",
  ),
];
