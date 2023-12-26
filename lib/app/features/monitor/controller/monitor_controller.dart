import 'package:heart_bpm/heart_bpm.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:pulso_app/app/features/monitor/contract/monitor_contract.dart';

class MonitorControllerImpl implements MonitorController {
  _sendWhatsApp(int avg) async {
    if (avg > 10) {
      var whatsappUrl = "https://api.callmebot.com/whatsapp.php?phone=[]&text=This+is+a+test+from+CallMeBot&apikey=[]";
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl));
      } else {
        throw 'Could not launch $whatsappUrl';
      }
    }
  }

  @override
  void calcBPM(List<SensorValue> bpmList) {
    if (bpmList.isNotEmpty) {
      int sum = 0;
      bpmList.forEach((e) => sum += e.value.toInt());
      int avg = sum ~/ bpmList.length;
      _sendWhatsApp(avg);
    }
  }
}
