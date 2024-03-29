import 'package:pulso_app/app/features/login/model/user.dart';

class Texts {
  static const String appTitle = "PulsoApp";
  static const String slogan = "cuidando do seu coração";
  static const String baseUrl = "https://api-dart.herokuapp.com";
  static const String refreshTopic = "refresh_pulso_app";

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
  static const String user = "user";
  static const String username = "Nome de usuário";
  static const String password = "Senha";
  static const String currentRoute = "current_route";
  static const String usernameMsg = "Insira seu nome de usuário!";
  static const String passwordMsg = "Insira sua senha!";
  static const String loginExceptionMsg = "Dados inválidos!";
  static const String enter = "Entrar";
  static const String loginTopic = "login_pulso_app";
  static const String logoutTopic = "logout_pulso_app";
  static const String browserLoginMsg =
      "É preciso estar logado no celular para usar a versão web!";

  // Monitor
  static const String instruction =
      "Coloque o dedo sob o flash e a câmera por 30 segundos para medir seus batimentos";
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
  static String cardiacReport =
      "*RELATÓRIO CARDÍACO*\n\nPaciente: ${UserSession.instance.user?.name}\n";
  static const String bpmTitle = "*BPM* (batimentos por minuto):";
  static const String pressureTitle = "*Pressão arterial*:";
  static const String tempTitle = "*Temperatura corporal*:";
  static const String whatsAppMsgSuccess = "Relatório enviado com sucesso!";
  static const String whatsAppMsgException =
      "Nâo foi possível enviar o relatório!";

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
      "Histórico vazio ou inacessível. Tente mais tarde!";
  static const String historyListException = "Falha ao carregar o histórico";
  static const String postHistoryException = "Erro ao incluir histórico";
  static const String loadHistoryMsg = "Erro ao carregar histórico!";
  static const String historyDateFormat = "dd/MM/yy";
  static const String historyTimeFormat = "HH:mm";
  static const String saveHistorySuccessMsg = "Histórico salvo com sucesso!";
  static const String saveHistoryErrorMsg = "Erro ao salvar histórico!";
  static const String sendReport = "Enviar relatório";
  static const String deleteHistory = "Deletar registro";
  static const String deleteAllHistory = "Deletar todo o histórico";
  static const String deleteHistoryErrorMsg = "Erro ao deletar histórico!";

  // Contacts
  static const String name = "Nome";
  static const String telephone = "Número de celular";
  static const String unavailable = "Indisponível";
  static const String addContact = "Adicionar contato";
  static const String loadingContacts = "Carregando seus contatos";
  static const String nameMsg = "Insira o nome de contato!";
  static const String phoneMsg = "Insira um número de telefone!";
  static const String contactsError =
      "Lista de contatos vazia ou inacessível. Tente mais tarde!";
  static const String contactsListException = "Falha ao carregar os contatos";
  static const String deleteContactException = "Erro ao excluir o contato";
  static const String loadContactsErrorMsg = "Erro ao carregar contatos!";
  static const String saveContactSuccessMsg = "Contato salvo com sucesso!";
  static const String saveContactErrorMsg = "Erro ao salvar contato!";
  static const String deleteAllContacts = "Deletar todos os contatos";
  static const String deleteContactErrorMsg = "Erro ao deletar contato!";
  static const String deleteContactListErrorMsg = "Erro ao deletar lista de contatos!";
}

class Fonts {
  static const String ubuntu = "Ubuntu";
}
