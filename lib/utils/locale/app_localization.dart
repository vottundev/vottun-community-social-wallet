import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../l10n/messages_all_locales.dart';



/// https://medium.com/@puneetsethi25/flutter-internationalization-switching-locales-manually-f182ec9b8ff0
/// Comando para generar int_messages => copy all intl_message content and paste to intl_es
/// flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/utils/locale/app_localization.dart
///
/// Comando para grabar traducciones de los archivos intl_es,intl_en...etc, se ejecuta despues de haber añadido las traducciones en los archivos intl_languagecode.arb
/// flutter pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/intl_messages.arb lib/l10n/intl_es.arb lib/utils/locale/app_localization.dart
class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name = locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  //region login screnn
  String get loginText {
    return Intl.message('Iniciar sesión', name: 'loginText');
  }

  String get emailText {
    return Intl.message('Email', name: 'emailText');
  }

  String get usernameText {
    return Intl.message('Username', name: 'usernameText');
  }

  String get emailTextInstructions {
    return Intl.message('Introduce tu email', name: 'emailTextInstructions');
  }

  String get passwordText {
    return Intl.message('Contraseña', name: 'passwordText');
  }

  String get otpCodeLabelText {
    return Intl.message('OTP Code', name: 'otpCodeLabelText');
  }

  String get otpCodeHint {
    return Intl.message('Introduce el código OTP', name: 'otpCodeHint');
  }

  String get passwordTextInstructions {
    return Intl.message('Introduce tu contraseña', name: 'passwordTextInstructions');
  }

  String get forgottenPassText {
    return Intl.message('¿Olvidaste tu contraseña?', name: 'forgottenPassText');
  }

  String get exploreText {
    return Intl.message('Explorar', name: 'exploreText');
  }

  String get appFundedByText {
    return Intl.message('Aplicación financiada por', name: 'appFundedByText');
  }

  String get recoverPassTitle {
    return Intl.message('Recupera tu contraseña.', name: 'recoverPassTitle');
  }

  String get forgetPassInstructionsText {
    return Intl.message('A continuación, escribe la dirección de correo electrónico con la que te registraste en la APP y recibirás un mensaje con las instrucciones para recuperar la contraseña.',
        name: 'forgetPassInstructionsText');
  }

  String get recoverPassInputText {
    return Intl.message('Escribe tu correo', name: 'recoverPassInputText');
  }

  String get forgetPssSuccessMessageText {
    return Intl.message(
        'Revisa tu correo electrónico. Te hemos enviado un enlace para recuperar tu contraseña. Revisa la carpeta Spam si no lo encuentras.',
        name: 'forgetPssSuccessMessageText');
  }

  String get incorrectCredentialsTitle {
    return Intl.message('Credenciales incorrectas', name: 'incorrectCredentialsTitle');
  }

  String get incorrectCredentialsText {
    return Intl.message('Credenciales incorrectas. Inténtalo de nuevo o ponte en contacto con tu sede para resolver la situación.',
        name: 'incorrectCredentialsText');
  }
  //endregion

  //region main screen
  String get homeText {
    return Intl.message('Inicio',
        name: 'homeText');
  }
  String get chatText {
    return Intl.message('Chat',
        name: 'chatText');
  }
  String get profileText {
    return Intl.message('Perfil',
        name: 'profileText');
  }
  String get activeProfileText {
    return Intl.message('Perfil activo:',
        name: 'activeProfileText');
  }
  //endregion main screen

  //region home screen
  String get actualityText {
    return Intl.message('Actualidad',
        name: 'actualityText');
  }
  //endregion home screen

  //region onboarding screen
  String get onBoardingTitle1 {
    return Intl.message('Mensajería instantánea', name: 'onBoardingTitle1');
  }

  String get onBoardingText1 {
    return Intl.message(
        'Con el chat te conectarás directamente con tu persona de referencia de la FSG que te dará soporte y resolverá tus consultas de manera rápida y eficiente. Estamos aquí para ayudarte en todo momento. ¡Comencemos!',
        name: 'onBoardingText1');
  }

  String get onBoardingTitle2 {
    return Intl.message('Gestiona tus citas', name: 'onBoardingTitle2');
  }

  String get onBoardingText2 {
    return Intl.message(
        'Podrás pedir cita con tu persona de referencia siempre que lo necesites. ¡Te contestaremos enseguida!',
        name: 'onBoardingText2');
  }

  String get onBoardingTitle3 {
    return Intl.message('Te propondremos', name: 'onBoardingTitle3');
  }

  String get onBoardingText3 {
    return Intl.message('Información personalizada sobre cursos, becas, actividades, datos de interés…ajustadas a tus necesidades.',
        name: 'onBoardingText3');
  }

  String get onBoardingTitle4 {
    return Intl.message('Gestor de documentos ', name: 'onBoardingTitle4');
  }

  String get onBoardingText4 {
    return Intl.message(
        'Envía de forma fácil documentos y encuentra lo que necesitas rápidamente. ¡Comienza a gestionar tus documentos de manera eficiente con tu persona de referencia de la FSG!',
        name: 'onBoardingText4');
  }

  String get onBoardingTitle5 {
    return Intl.message('Videollamadas', name: 'onBoardingTitle5');
  }

  String get onBoardingText5 {
    return Intl.message(
        'Si quieres hablar con tu persona de referencia por videollamada debes tener instalada en tu móvil la aplicación gratuita Microsoft TEAMS.',
        name: 'onBoardingText5');
  }

  String get onBoardingText5DownloadText {
    return Intl.message('Si no la tienes instalada pulsa aquí para descargarla.', name: 'onBoardingText5DownloadText');
  }

  String get mainOnBoardingTitle {
    return Intl.message('Te damos la bienvenida', name: 'mainOnBoardingTitle');
  }

  String get mainOnBoardingText {
    return Intl.message('Esta App es una nueva forma de comunicarte con la Fundación Secretariado Gitanos y te ayudará a mantenerte informado de todo lo que pasa en la fundación.', name: 'mainOnBoardingText');
  }

  String get startButtonText {
    return Intl.message('Empezar', name: 'startButtonText');
  }

  String get weProposeText {
    return Intl.message('Te proponemos', name: 'weProposeText');
  }

  String get pendingTasksText {
    return Intl.message('Tareas pendientes', name: 'pendingTasksText');
  }
  String get appointmentsText {
    return Intl.message('Tus citas', name: 'appointmentsText');
  }
  String get manageDocumentsText {
    return Intl.message('Gestor de documentos', name: 'manageDocumentsText');
  }
  String get surveysText {
    return Intl.message('Encuestas', name: 'surveysText');
  }

  String get interestedText {
    return Intl.message('Me interesa', name: 'interestedText');
  }

  String get notInterestedText {
    return Intl.message('No me interesa', name: 'notInterestedText');
  }

  //endregion

  //region common texts
  String get moreInfoText {
    return Intl.message('+ info', name: 'moreInfoText');
  }

  String get closeSessionWarningMessage {
    return Intl.message('¿Estás seguro de que quiere cerrar tu sesión?', name: 'closeSessionWarningMessage');
  }

  String get yesText {
    return Intl.message('Sí', name: 'yesText');
  }

  String get noText {
    return Intl.message('No', name: 'noText');
  }

  String get helloText {
    return Intl.message('Hola',
        name: 'helloText');
  }
  String get notRegisteredToolbarMessage {
    return Intl.message('Para ver todo el contenido debes registrarte. Ponte en contacto con tu técnico',
        name: 'notRegisteredToolbarMessage');
  }

  String get byText {
    return Intl.message('Por',
        name: 'byText');
  }

  String get continueText {
    return Intl.message('Continuar', name: 'continueText');
  }

  String get backText {
    return Intl.message('Volver', name: 'backText');
  }

  String get acceptButtonText {
    return Intl.message('Aceptar', name: 'acceptButtonText');
  }

  String get cancelButtonText {
    return Intl.message('Cancelar', name: 'cancelButtonText');
  }

  String get skipText {
    return Intl.message('Saltar', name: 'skipText');
  }

  String get nextText {
    return Intl.message('Siguiente', name: 'nextText');
  }

  //endregion

  //region chat screen
  String get writeYourMessageHere {
    return Intl.message('Escriba el mensaje aquí...', name: 'writeYourMessageHere');
  }
  String get notTechAssignedText {
    return Intl.message('Sin técnico asignado', name: 'notTechAssignedText');
  }
  String get numPhoneText {
    return Intl.message('Nº teléfono', name: 'numPhoneText');
  }
  String get youHaveToRegisterChatMessage {
    return Intl.message('Tienes que registrarte para poder utilizar el chat, ponte en contacto con tu técnico asignado', name: 'youHaveToRegisterChatMessage');
  }
  //endregion chat screen

  //region profile screen
  String get myProfileText {
    return Intl.message('Mi perfil', name: 'myProfileText');
  }
  String get changePassText {
    return Intl.message('Cambiar contraseña', name: 'changePassText');
  }
  String get logoutText {
    return Intl.message('Cerrar sesión', name: 'logoutText');
  }
  //endregion

  //region notifications screen
  String get notificationTitle {
    return Intl.message('Notificaciones', name: 'notificationTitle');
  }
  String get notificationsEmptyMessage {
    return Intl.message('¡Estás al día! \n No tienes notificaciones pendientes.', name: 'notificationsEmptyMessage');
  }
  String get deleteNotiText {
    return Intl.message('Borrar', name: 'deleteNotiText');
  }
  String get personalDataText {
    return Intl.message('Datos personales', name: 'personalDataText');
  }
  String get editProfileText {
    return Intl.message('Editar', name: 'editProfileText');
  }
  String get editPersonalDataText {
    return Intl.message('Editar datos personales', name: 'editPersonalDataText');
  }
  String get requestChangePersonalDataButtonText {
    return Intl.message('Solicitar cambio de datos personales', name: 'requestChangePersonalDataButtonText');
  }
  String get programPortalIdText {
    return Intl.message('ID portal programa', name: 'programPortalIdText');
  }
  String get nameText {
    return Intl.message('Nombre', name: 'nameText');
  }
  String get firstNameText {
    return Intl.message('Primer apellido', name: 'firstNameText');
  }
  String get secondNameText {
    return Intl.message('Segundo apellido', name: 'secondNameText');
  }
  String get idDocumentText {
    return Intl.message('Documento identificativo', name: 'idDocumentText');
  }
  String get referenceAssistantText {
    return Intl.message('Persona de referencia', name: 'referenceAssistantText');
  }
  String get addMemberToFamilyText {
    return Intl.message('Añadir miembros de la unidad familiar', name: 'addMemberToFamilyText');
  }
  String get changePassMessage {
    return Intl.message('Recuerda que esta contraseña te permite acceder a la aplicación y es personal e intransferible.  Puedes cambiarla en cualquier momento.', name: 'changePassMessage');
  }
  String get currentPassText {
    return Intl.message('Contraseña actual', name: 'currentPassText');
  }
  String get newPassText {
    return Intl.message('Nueva contraseña', name: 'newPassText');
  }
  String get passRestrictionsText {
    return Intl.message('Mínimo 8 caracteres. Mínimo 1 letra mayúscula, 1 minúscula, 1 número y 1 carácter especial (¡-%&/_*+)', name: 'passRestrictionsText');
  }
  String get changePersonalDataRequestTitle {
    return Intl.message('Solicitud de cambio de datos personales', name: 'changePersonalDataRequestTitle');
  }
  String get changePersonalDataRequestMessage {
    return Intl.message('Has notificado a tu persona de referencia los cambios en tus datos personales. ¡Los revisaremos y te informaremos!', name: 'changePersonalDataRequestMessage');
  }
  String get resetPasswordText {
    return Intl.message('Restablecer contraseña', name: 'resetPasswordText');
  }
  String get changedPasswordSuccessText {
    return Intl.message('Contraseña cambiada correctamente.', name: 'changedPasswordSuccessText');
  }
  String get deleteNotificationTitle {
    return Intl.message('Borrar notificaciones', name: 'deleteNotificationTitle');
  }
  String get deleteNotificationMessage {
    return Intl.message('Aprende a limpiar tus notificaciones con un simple gesto hacia la izquierda.', name: 'deleteNotificationMessage');
  }
  String get understandText {
    return Intl.message('Entendido', name: 'understandText');
  }

  String requestPaymentToYouMessage(
      String ownerUsername,
      String amountToPay,
      String currencySymbol,
      String currencyName) {
    return Intl.message(
        '$ownerUsername has requested you to PAY $amountToPay $currencySymbol (x\$). \n\nReason: $currencyName',
        args: [ownerUsername, amountToPay, currencySymbol, currencyName],
        name: 'requestPaymentToYouMessage');
  }

  String requestedPaymentMessage(
      String totalAmount,
      String currencySymbol,
      String participantsUsername,
      String currencyName) {
    return Intl.message(
        'Requested $totalAmount $currencySymbol (x\$) to: $participantsUsername \n\nReason: $currencyName',
        args: [totalAmount, currencySymbol, participantsUsername, currencyName],
        name: 'requestedPaymentMessage');
  }

  //endregion

  //region we propose screen
  String get pendingText {
    return Intl.message('Nuevas', name: 'pendingText');
  }
  String get requestsText {
    return Intl.message('Solicitadas', name: 'requestsText');
  }
  String get seeDetailText {
    return Intl.message('Ver detalle', name: 'seeDetailText');
  }
  String get jobOfferDetailText {
    return Intl.message('Detalles oferta de trabajo', name: 'jobOfferDetailText');
  }
  String get maintenanceBossText {
    return Intl.message('Jefe de mantenimiento', name: 'maintenanceBossText');
  }
  String get deleteText {
    return Intl.message('Eliminar', name: 'deleteText');
  }
  String get sendTagText {
    return Intl.message('Enviado', name: 'sendTagText');
  }
  String get pendingTagText {
    return Intl.message('Pendiente', name: 'pendingTagText');
  }
  String get emptyFormationsMessage {
    return Intl.message('¡Aún no te has inscrito a ninguna oferta / formación!', name: 'emptyFormationsMessage');
  }
  //endregion

  //region pending tasks screen
  String get pendingTaskListText {
    return Intl.message('Listado tareas pendientes', name: 'pendingTaskListText');
  }
  String get emptyPendingTasksMessage {
    return Intl.message('¡Genial, no tienes tareas pendientes!', name: 'emptyPendingTasksMessage');
  }

  String get logOutText {
    return Intl.message('Log out', name: 'logOutText');
  }

  //endregion

  //region manage documents screen
  String get requestedDocumentText {
    return Intl.message('Documentos pedidos', name: 'requestedDocumentText');
  }
  String get receivedDocumentText {
    return Intl.message('Documentos recibidos', name: 'receivedDocumentText');
  }
  String get documentDetailText {
    return Intl.message('Detalle documento solicitado', name: 'documentDetailText');
  }
  String get stateText {
    return Intl.message('Estado', name: 'stateText');
  }
  String get uploadFileInstructionsText {
    return Intl.message('Busque y elija los archivos que desea enviar a tu técnico. (JPG, DOC, PDF). Tamaño máximo: 100 MB', name: 'uploadFileInstructionsText');
  }
  String get downloadFileText {
    return Intl.message('Descargar archivo', name: 'downloadFileText');
  }
  String get confirmSendText {
    return Intl.message("Confirmar envío", name: 'confirmSendText');
  }
  String get uploadProfilePhotoText {
    return Intl.message('Busque y suba la fotografía de perfil\n(JPG y JPEG)' , name: 'uploadProfilePhotoText');
  }
  String get addFileButtonText {
    return Intl.message('Añadir archivo', name: 'addFileButtonText');
  }
  String get uploadFileText {
    return Intl.message('Subir archivo', name: 'uploadFileText');
  }
  String get uploadFileAgainText {
    return Intl.message('Subir archivo de nuevo', name: 'uploadFileAgainText');
  }
  String get uploadedFileText {
    return Intl.message('Archivo subido', name: 'uploadedFileText');
  }
  String get emptyDocumentsMessage {
    return Intl.message('¡Te damos la bienvenida! Aquí encontrarás toda la documentación requerida por tu técnico.', name: 'emptyDocumentsMessage');
  }
  //endregion

  //region surveys tasks screen
  String get yourSurveysText {
    return Intl.message('Tus encuestas', name: 'yourSurveysText');
  }
  String get answerText {
    return Intl.message('Responder', name: 'answerText');
  }
  String get emptySurveysText {
    return Intl.message('¡Esperando nuevas encuestas!\n¡Sé paciente y prepara tus respuestas!', name: 'emptySurveysText');
  }

  //endregion

  //region appointments screen
  String get yourNextAppointmentsText {
    return Intl.message('Tus próximas citas', name: 'yourNextAppointmentsText');
  }
  String get addAppointmentText {
    return Intl.message('Agendar nueva cita', name: 'addAppointmentText');
  }
  String get addAppointmentTitleText {
    return Intl.message('Agendar cita', name: 'addAppointmentTitleText');
  }
  String get confirmedTagText {
    return Intl.message('Confirmado', name: 'confirmedTagText');
  }
  String get rejectedTagText {
    return Intl.message('Rechazada', name: 'rejectedTagText');
  }
  String get rescheduleTagText {
    return Intl.message('Reprogramada', name: 'rescheduleTagText');
  }
  String get chooseModalityText {
    return Intl.message('Elegir modalidad', name: 'chooseModalityText');
  }
  String get onSiteText {
    return Intl.message('Presencial', name: 'onSiteText');
  }
  String get phoneText {
    return Intl.message('Teléfono', name: 'phoneText');
  }
  String get videocallText {
    return Intl.message('Videollamada', name: 'videocallText');
  }
  String get availableDateText {
    return Intl.message('Elige una fecha', name: 'availableDateText');
  }
  String get timeAvailableText {
    return Intl.message('Elige un horario', name: 'timeAvailableText');
  }
  String get appointmentReasonTitle {
    return Intl.message('Quieres la cita para...', name: 'appointmentReasonTitle');
  }
  String get appointmentReasonHintText {
    return Intl.message('ayúdanos a preparar tu cita, cuéntanos qué necesitas...', name: 'appointmentReasonHintText');
  }
  String get sendAppointmentRequestText {
    return Intl.message('Enviar solicitud', name: 'sendAppointmentRequestText');
  }
  String get sendText {
    return Intl.message('Enviar', name: 'sendText');
  }
  String get appointRequestSendDialogTitle {
    return Intl.message('Solicitud de cita enviada', name: 'appointRequestSendDialogTitle');
  }
  String get appointRequestSendDialogMessage {
    return Intl.message('Hemos enviado a tu técnico la solicitud de cita. Te notificaremos a través de la app el estado de tu solicitud lo antes posible.', name: 'appointRequestSendDialogMessage');
  }
  String get seeMyAppointmentsText {
    return Intl.message('Ver mis citas', name: 'seeMyAppointmentsText');
  }
  String get videocallServiceText {
    return Intl.message('Servicio videollamadas', name: 'videocallServiceText');
  }
  String get videocallServiceMessage {
    return Intl.message('Si quieres hablar con tu persona de referencia por videollamada debes tener instalada en tu móvil la aplicación gratuita Microsoft TEAMS. Si no la tienes instalada pulsa aquí para descargarla.', name: 'videocallServiceMessage');
  }
  String get reasonBaseMessage1 {
    return Intl.message(
        'Porfavor, ¿podemos tener una cita el próximo ',
        name: 'reasonBaseMessage1'
    );
  }
  String get ofText {
    return Intl.message(
        'entre las ',
        name: 'ofText'
    );
  }
  String get onModalityText {
    return Intl.message(
        'Modalidad: ',
        name: 'onModalityText'
    );
  }
  String get thanksText {
    return Intl.message(
        '¡Gracias!',
        name: 'thanksText'
    );
  }
  String get appointmentSummaryTitle {
    return Intl.message('Resumen de tu cita', name: 'appointmentSummaryTitle');
  }
  String get emptyAppointmentsMessage {
    return Intl.message('¡No tienes ninguna cita pendiente!', name: 'emptyAppointmentsMessage');
  }
  String get notShowAgainText {
    return Intl.message('No volver a mostrar', name: 'notShowAgainText');
  }
  //endregion

  //region error messages
  String get emptyErrorMessage {
    return Intl.message('Error', name: 'emptyErrorMessage');
  }

  String get registerErrorMessage {
    return Intl.message('Error on register user', name: 'registerErrorMessage');
  }

  String get errorText {
    return Intl.message('Error', name: 'errorText');
  }
//endregion
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final Locale overriddenLocale;

  const AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => ['es'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
