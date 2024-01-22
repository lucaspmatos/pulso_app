class Texts {
  static const String appTitle = "PulsoApp";
  static const String slogan = "cuidando do seu coração";
  static const String baseUrl = "https://api-dart.herokuapp.com";

  static const String loginRoute = "/";
  static const String splashRoute = "splash";
  static const String monitorRoute = "monitor";
  static const String historyRoute = "history";
  static const String contactsRoute = "contacts";

  // Drawer
  static const String login = "Login";
  static const String monitor = "Monitor";
  static const String history = "Histórico";
  static const String contacts = "Contatos";
  static const String years = "anos";
  static const String logout = "Sair do app";

  // Login
  static const String username = "Nome de usuário";
  static const String password = "Senha";
  static const String usernameMsg = "Insira seu nome de usuário!";
  static const String passwordMsg = "Insira sua senha!";
  static const String loginExceptionMsg = "Dados inválidos!";
  static const String enter = "Entrar";

  // Monitor
  static const String measureBPM = "Medir BPM";
  static const String stopMeasurement = "Parar medição";
  static const String heartbeats = "Batimentos cardíacos";
  static const String systolicPressure = "Pressão sistólica";
  static const String diastolicPressure = "Pressão diastólica";
  static const String bodyHeat = "TEMPERATURA CORPORAL";
  static const String pressureMeasure = "mmHg";
  static const String bpmTopic = "bpm_pulso_app";
  static const String bodyHeatTopic = "temp_pulso_app";
  static const String systolicTopic = "systolic_pulso_app";
  static const String diastolicTopic = "diastolic_pulso_app";
  static const String celsius = "ºC";
  static const String server = "test.mosquitto.org";
  static const String browserServer = "ws://test.mosquitto.org";
  static const String clientIdentifier = "";
  static const String phone = "556281211293";
  static const String apiKey = "7075847";
  static const String cardiacReport = "*RELATÓRIO CARDÍACO*\n";
  static const String bpmTitle = "*BPM* (batimentos por minuto):";
  static const String pressureTitle = "*Pressão arterial*:";
  static const String tempTitle = "*Temperatura corporal*:";
  static const String whatsAppMsgSuccess = "Relatório enviado com sucesso!";
  static const String whatsAppMsgException = "Nâo foi possível enviar o relatório!";

  static String whatsAppUrl(String phone, String text, String apiKey) =>
      "https://api.callmebot.com/whatsapp.php?phone=$phone&text=$text&apikey=$apiKey";
  static String urlError(String url) => "Could not launch $url";
  static String topicLog(String topic, String payload) =>
      "EXAMPLE:: topic is <$topic>, payload is <-- $payload -->";
  static String clientException(String e) => "EXAMPLE::client exception - $e";
  static String socketException(String e) => "EXAMPLE::socket exception - $e";

  // History
  static const String noData = "--";
  static const String heartPressure = "Pressão arterial";
  static const String temperature = "Temperatura";
  static const String loadingHistory = "Carregando seu histórico";
  static const String historyError =
      "Não possível acessar o histórico. Tente mais tarde.";
  static const String historyListException = "Falha ao carregar o histórico";
  static const String postHistoryException = "Erro ao incluir histórico";
  static const String loadHistoryMsg = "Erro ao carregar histórico!";
  static const String historyDateFormat = "dd/MM/yy";
  static const String historyTimeFormat = "HH:mm";
  static const String saveHistorySuccessMsg = "Histórico salvo com sucesso!";
  static const String saveHistoryErrorMsg = "Erro ao salvar histórico!";

  // Contacts
  static const String unavailable = "Indisponível";
  static const String loadingContacts = "Carregando seus contatos";
  static const String contactsError =
      "Não possível acessar a lista de contatos. Tente mais tarde.";
  static const String contactsListException = "Falha ao carregar os contatos";
  static const String deleteContactException = "Erro ao excluir o contato";
  static const String loadContactsErrorMsg = "Erro ao carregar contatos!";
  static const String deleteContactErrorMsg = "Erro ao deletar contato!";
}

class Fonts {
  static const String ubuntu = "Ubuntu";
}
