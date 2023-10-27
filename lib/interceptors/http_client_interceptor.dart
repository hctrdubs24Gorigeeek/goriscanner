import 'package:http/http.dart' as http;
/*Autor: Ervin*/
class HttpClientInterceptor {
  Future<http.Response> intercept(http.Request request) async {
    try{
      String? token = "eyJhbGciOiJIUzI1NiJ9.eyJyZWZyZXNoX3Rva2VuIjoiZXlKaGJHY2lPaUpJVXpJMU5pSjkuZXlKemRXSWlPaUpuYjNKcGNHRjVNakF5TTBCbmJXRnBiQzVqYjIwaUxDSmxlSEFpT2pFMk9UazBNamd6TVRnc0ltbGhkQ0k2TVRZNU9EUXlOekF4TUN3aWNtOXNJam9pVWs5TVJWOVZVMFZTSW4wLkdOS3NfMTVnY0lrNVJWcmJ6UFBLZjZfdXZvYUFwMy1tMi1RZFkwMWFEUXciLCJzdWIiOiJnb3JpcGF5MjAyM0BnbWFpbC5jb20iLCJleHAiOjE2OTg5Mjc2NjQsInVzZXIiOiJ7XCJpZFwiOlwiMzM3XCIsXCJub21icmVcIjpcIkdvcmlQYXlcIixcImNvcnJlb1wiOlwiZ29yaXBheTIwMjNAZ21haWwuY29tXCIsXCJudW1UZWxlZm9ub1wiOlwibnVsbFwiLFwic3RhdHVzXCI6XCJVU1VBUklPX1ZFUklGSUNBRE9fRU1BSUxcIn0iLCJpYXQiOjE2OTg0MjcwMTAsInJvbCI6WyJST0xFX1VTRVIiXX0.6sGe7Y1hjduuU8rom2ke2HK4mrwdXHkU9koo3PB0Ejk";
          // Agrega el token de autorización a la solicitud si está disponible
          if (token.isNotEmpty) {
            request.headers['Authorization'] = 'Bearer $token';
          }
          final response = await http.Response.fromStream(await request.send());          
          return response;
    }catch(e){
      return http.Response('ERROR IN COMMUNICATION WITH THE SERVER', 500);
    }   
  }
}