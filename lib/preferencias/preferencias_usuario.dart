import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  //instancia singleton para crear una sola instancia en toda la aplicación de 
  //Sharedpreferences
  static final Preferences _instancia = new Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  SharedPreferences _prefs;
 
  Preferences._internal();

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  clearPreferences() async {
    await _prefs.clear();
  }

  get idUser {
    return _prefs.getString('codinspector');
  }

  set idUser(String value) {
    _prefs.setString('codinspector', value);
  }

 get usuario {
    return _prefs.getString('login');
  }

  set usuario(String value) {
    _prefs.setString('login', value);
  }

  //nombre  
  get personName {
    return _prefs.getString('p_n');
  }

  set personName(String value) {
    _prefs.setString('p_n', value);
  }
//Sede
  get idsede {
    return _prefs.getString('codsede');
  }

  set idsede(String value) {
    _prefs.setString('codsede', value);
  }
//id empresa
  get idEmpresa {
    return _prefs.getString('codemp');
  }

  set idEmpresa(String value) {
    _prefs.setString('codemp', value);
  }

 //id ciclo
  get idCiclo {
    return _prefs.getString('codciclo');
  }

  set idCiclo(String value) {
    _prefs.setString('codciclo', value);
  }

  //habilitado para conslutar clientes
  get asigConsulta {
    return _prefs.getString('asignadoaConsulta');
  }

  set asigConsulta(String value) {
    _prefs.setString('asignadoaConsulta', value);
  }
  
  //año 
  get anio {
    return _prefs.getString('anio');
  }

  set anio(String value) {
    _prefs.setString('anio', value);
  }

  //mes
  get mes {
    return _prefs.getString('mes');
  }

  set mes(String value) {
    _prefs.setString('mes', value);
  }


  get idRoleUser {
    return _prefs.getString('ru');
  }

  set idRoleUser(String value) {
    _prefs.setString('ru', value);
  }

  get roleName {
    return _prefs.getString('rn');
  }

  set roleName(String value) {
    _prefs.setString('rn', value);
  }

  get idPerson {
    _prefs.getString('c_p');
  }

  set idPerson(String value) {
    _prefs.setString('c_p', value);
  }

  get userNickname {
    return _prefs.getString('_n');
  }

  set userNickname(String value) {
    _prefs.setString('_n', value);
  }

  get userEmail {
    return _prefs.getString('u_e');
  }

  set userEmail(String value) {
    _prefs.setString('u_e', value);
  }

  get userImage {
    return _prefs.getString('u_i');
  }

  set userImage(String value) {
    _prefs.setString('u_i', value);
  }


  get token {
    return _prefs.getString('token');
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  
 
}
