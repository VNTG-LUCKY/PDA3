import '../../core/config/env.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  // Base URLs
  static String baseUrl = dotenv.env['BASE_URL'] ?? 'fallback_url_not_found';

  // Auth endpoints
  static const String login = '/pdaLoginRedirect.do';
  static const String logout = '/pdaLogout';
  static const String memberLogin = '/memberLoginChk';

  // Main endpoints
  static const String index = '/index';
  static const String notice = '/pdaNotice';
  static const String moveDate = '/moveDate';
  static const String schRead4Ajax = '/schRead4Ajax';

  // Shipment endpoints
  static const String shipmentMenu = '/ShipmentMenu';
  static const String ndmShipment = '/NdmShipment';
  static const String ndmShipmentAjax = '/NdmShipmentAjaxProc';
  static const String expShipment = '/ExpShipment';
  static const String expShipmentAjax = '/ExpShipmentAjaxProc';
  static const String expShipmentProg = '/ExpShipmentProg';
  static const String expShipmentProgAjax = '/ExpShipmentProgAjaxProc';
  static const String stockView = '/StockView';
  static const String stockViewAjax = '/StockViewAjaxProc';
  static const String procHistInquiry = '/ProcHistInquiry';
  static const String procHistInquiryAjax = '/ProcHistInquiryAjaxProc';
  static const String plantTrans = '/PlantTrans';
  static const String plantTransAjax = '/PlantTransAjaxProc';

  // Coil endpoints
  static const String coilMenu = '/CoilMenu';
  static const String coilInput = '/CoilInput';
  static const String coilInputAjax = '/CoilInputAjaxProc';
  static const String coilPositionChange = '/CoilPositionChange';
  static const String coilPositionChangeAjax = '/CoilPositionChangeAjaxProc';
  static const String coilPositionChange2 = '/CoilPositionChange2';
  static const String coilPositionChange2Ajax = '/CoilPositionChange2AjaxProc';
  static const String coilPositionChangePo = '/CoilPositionChangePo';
  static const String coilPositionChangePoAjax =
      '/CoilPositionChangePoAjaxProc';

  // Location endpoints
  static const String locationMenu = '/LocationMenu';
  static const String location = '/Location';
  static const String locationAjax = '/LocationAjaxProc';
  static const String locationInput = '/LocationInput';
  static const String locationInputAjax = '/LocationInputAjaxProc';
  static const String locationHistory = '/LocationHistory';
  static const String locationHistoryAjax = '/LocationHistoryAjaxProc';
  static const String locationInputCoil = '/LocationInputCoil';
  static const String locationInputCoilAjax = '/LocationInputCoilAjaxProc';
  static const String locationHistoryCoil = '/LocationHistoryCoil';
  static const String locationHistoryCoilAjax = '/LocationHistoryCoilAjaxProc';

  // Board endpoints
  static const String boardList = '/boardList';
  static const String boardRead = '/boardRead';
  static const String noticeAjax = '/NoticeAjaxProc';
}
