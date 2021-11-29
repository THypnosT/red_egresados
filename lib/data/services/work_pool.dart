import 'dart:convert';
import 'package:red_egresados/domain/models/public_job.dart';
import 'package:red_egresados/domain/services/misiontic_interface.dart';
import 'package:http/http.dart' as http;

class WorkPoolService implements MisionTicService {
  //ACTIVIDAD
  // AÑADA SUS CREDENCIALES PARA CONECTARSE AL SERVICIO EXTERNO
  final String baseUrl = "https://misiontic-2022-uninorte.herokuapp.com/";
  final String apiKey = "ghmfvYNVF.6zBdirZU5ja.JSNZHQ1XFM7JpYusca6eMpwkIDqdrx6";

  @override
  Future<List<PublicJob>> fecthData({int limit = 5, Map? map}) async {
    var queryParameters = {'limit': limit.toString()};

    // Defina la URI para hacer las peticiones al servicio
    var uri = Uri.https(baseUrl, '/jobs', queryParameters);

    // Implemente la solicitud
    final response = await http.get(uri, headers: <String, String>{
      'Content-type': 'aplication/json; charset=UTF-8',
      'Key':apiKey,
    });

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      final List<PublicJob> jobs = [];
      for (var job in res['jobs']) {
        jobs.add(PublicJob.fromJson(job));
      }
      return jobs;
    } else {
      throw Exception('Error on request');
    }
  }
}
