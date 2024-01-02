class Texts {
  static const String appTitle = "PulsoApp";
  static const String slogan = "cuidando do seu coração";
  static const String baseUrl = "https://api-dart.herokuapp.com";

  static const String initialRoute = "/";
  static const String monitorRoute = "monitor";
  static const String historyRoute = "history";
  static const String contactsRoute = "contacts";

  static const String monitor = "Monitor";
  static const String history = "Histórico";
  static const String contacts = "Contatos";

  // Contacts
  static const String unavailable = "Indisponível";
  static const String loadingContacts = "Carregando seus contatos";
  static const String contactsError = "Não possível acessar a lista de contatos. Tente mais tarde.";

  // Monitor
  static const String measureBPM = "Medir BPM";
  static const String stopMeasurement = "Parar medição";
  static const String heartbeats = "Batimentos cardíacos";
  static const String systolicPressure = "Pressão sistólica";
  static const String diastolicPressure = "Pressão diastólica";
  static const String bodyHeat = "TEMPERATURA CORPORAL";
  static const String pressureMeasure = "mmHg";
  static const String bodyHeatTopic = "temp";
  static const String systolicTopic = "systolic";
  static const String diastolicTopic = "diastolic";
  static const String celsius = "ºC";

  // History
  static const String bpm = "bpm";
  static const String noData = "--";
  static const String heartPressure = "Pressão arterial";
  static const String temperature = "Temperatura";
  static const String loadingHistory = "Carregando seu histórico";
  static const String historyError = "Não possível acessar o histórico. Tente mais tarde.";
}

class Fonts {
  static const String ubuntu = "Ubuntu";
}