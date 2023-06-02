import 'dart:convert';

List<getRatingDataListResponse> getRatingDataListResponseFromJsonList(dynamic str) => List<getRatingDataListResponse>.from(json.decode(str).map((x) => getRatingDataListResponse.fromJson(x)));

String getRatingDataListResponseToJsonList(List<getRatingDataListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class getRatingDataListResponse {
  dynamic serviceProvider;
  String? dayStartingTime;
  String? dayEndingTime;
  dynamic address;
  dynamic clinicName;
  dynamic clinicAddress;
  dynamic clinicId;
  dynamic id;
  String? bookingDate;
  String? schedule;
  dynamic appointmentSettingId;
  bool? isBookingConfirmed;
  bool? isBookingCancelledByReceiver;
  bool? isBookingCancelledByProvider;
  dynamic serviceReceiverId;
  dynamic serviceProviderId;
  dynamic appointmentTypeId;
  dynamic appointmentType;
  String? tentativeDate;
  String? tentativeTime;
  String? reportingTime;
  dynamic dayOfWeek;
  dynamic serialNo;
  bool? isProcessed;
  bool? isCancelled;
  String? serviceReceiver;
  String? appointmentDate;
  String? appointmentTime;
  String? receiverImage;
  dynamic providerImage;
  dynamic receiverEmail;
  dynamic receiverPhone;
  dynamic providerEmail;
  dynamic providerPhone;
  dynamic appointmentFees;
  dynamic amount;
  dynamic status;
  bool? isRecurrent;
  dynamic recurringHours;
  dynamic noOfVisits;
  dynamic userPaymentStatus;
  bool? visitConfirmationStatus;
  dynamic paidAmount;
  dynamic doctorcharges;
  dynamic admincomission;
  bool? isActive;
  dynamic startDate;
  dynamic endDate;
  dynamic beneficiaryComment;
  dynamic providerComment;
  dynamic pageSize;
  dynamic pageNumber;
  dynamic specializationName;
  dynamic bookingtype;
  dynamic tentativeBookingDate;
  dynamic isPaymentDone;
  dynamic isnewpatient;
  dynamic appointmentStatus;
  dynamic appointmentTypeName;
  dynamic lastApointmentDate;
  dynamic tentativeAppointmentDate;
  dynamic patientAddress;
  dynamic bloodGroup;
  dynamic age;
  dynamic gender;
  dynamic totalratingpoint;
  dynamic totalreview;
  dynamic ratingpoints;
  String? providerreview;
  dynamic patientName;
  dynamic patientCurrentAddress;
  dynamic callstatus;
  dynamic documentname;
  dynamic booingId;
  dynamic appointmentNo;
  dynamic scheduleAppointmentDate;
  dynamic bookingAppointmentDate;
  dynamic trancurrency;
  String? scheduleStartTime;
  String? scheduleEndTime;
  dynamic scheduleTime;
  dynamic bookingstatus;
  dynamic transno;
  dynamic paybackstatus;
  dynamic srno;
  dynamic paybackid;
  dynamic diognosis;
  dynamic appointmentno;
  dynamic bookingId;
  dynamic serviceType;
  dynamic provider;
  dynamic prescriptiondate;
  dynamic sourcefrom;
  dynamic tranpkid;
  dynamic bankTranId;
  dynamic statuscode;
  dynamic errormessage;

  getRatingDataListResponse(
      {this.serviceProvider,
        this.dayStartingTime,
        this.dayEndingTime,
        this.address,
        this.clinicName,
        this.clinicAddress,
        this.clinicId,
        this.id,
        this.bookingDate,
        this.schedule,
        this.appointmentSettingId,
        this.isBookingConfirmed,
        this.isBookingCancelledByReceiver,
        this.isBookingCancelledByProvider,
        this.serviceReceiverId,
        this.serviceProviderId,
        this.appointmentTypeId,
        this.appointmentType,
        this.tentativeDate,
        this.tentativeTime,
        this.reportingTime,
        this.dayOfWeek,
        this.serialNo,
        this.isProcessed,
        this.isCancelled,
        this.serviceReceiver,
        this.appointmentDate,
        this.appointmentTime,
        this.receiverImage,
        this.providerImage,
        this.receiverEmail,
        this.receiverPhone,
        this.providerEmail,
        this.providerPhone,
        this.appointmentFees,
        this.amount,
        this.status,
        this.isRecurrent,
        this.recurringHours,
        this.noOfVisits,
        this.userPaymentStatus,
        this.visitConfirmationStatus,
        this.paidAmount,
        this.doctorcharges,
        this.admincomission,
        this.isActive,
        this.startDate,
        this.endDate,
        this.beneficiaryComment,
        this.providerComment,
        this.pageSize,
        this.pageNumber,
        this.specializationName,
        this.bookingtype,
        this.tentativeBookingDate,
        this.isPaymentDone,
        this.isnewpatient,
        this.appointmentStatus,
        this.appointmentTypeName,
        this.lastApointmentDate,
        this.tentativeAppointmentDate,
        this.patientAddress,
        this.bloodGroup,
        this.age,
        this.gender,
        this.totalratingpoint,
        this.totalreview,
        this.ratingpoints,
        this.providerreview,
        this.patientName,
        this.patientCurrentAddress,
        this.callstatus,
        this.documentname,
        this.booingId,
        this.appointmentNo,
        this.scheduleAppointmentDate,
        this.bookingAppointmentDate,
        this.trancurrency,
        this.scheduleStartTime,
        this.scheduleEndTime,
        this.scheduleTime,
        this.bookingstatus,
        this.transno,
        this.paybackstatus,
        this.srno,
        this.paybackid,
        this.diognosis,
        this.appointmentno,
        this.bookingId,
        this.serviceType,
        this.provider,
        this.prescriptiondate,
        this.sourcefrom,
        this.tranpkid,
        this.bankTranId,
        this.statuscode,
        this.errormessage});

  getRatingDataListResponse.fromJson(Map<String, dynamic> json) {
    serviceProvider = json['serviceProvider'];
    dayStartingTime = json['dayStartingTime'];
    dayEndingTime = json['dayEndingTime'];
    address = json['address'];
    clinicName = json['clinicName'];
    clinicAddress = json['clinicAddress'];
    clinicId = json['clinicId'];
    id = json['id'];
    bookingDate = json['bookingDate'];
    schedule = json['schedule'];
    appointmentSettingId = json['appointmentSettingId'];
    isBookingConfirmed = json['isBookingConfirmed'];
    isBookingCancelledByReceiver = json['isBookingCancelledByReceiver'];
    isBookingCancelledByProvider = json['isBookingCancelledByProvider'];
    serviceReceiverId = json['serviceReceiverId'];
    serviceProviderId = json['serviceProviderId'];
    appointmentTypeId = json['appointmentTypeId'];
    appointmentType = json['appointmentType'];
    tentativeDate = json['tentativeDate'];
    tentativeTime = json['tentativeTime'];
    reportingTime = json['reportingTime'];
    dayOfWeek = json['dayOfWeek'];
    serialNo = json['serialNo'];
    isProcessed = json['isProcessed'];
    isCancelled = json['isCancelled'];
    serviceReceiver = json['serviceReceiver'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    receiverImage = json['receiverImage'];
    providerImage = json['providerImage'];
    receiverEmail = json['receiverEmail'];
    receiverPhone = json['receiverPhone'];
    providerEmail = json['providerEmail'];
    providerPhone = json['providerPhone'];
    appointmentFees = json['appointmentFees'];
    amount = json['amount'];
    status = json['status'];
    isRecurrent = json['isRecurrent'];
    recurringHours = json['recurringHours'];
    noOfVisits = json['noOfVisits'];
    userPaymentStatus = json['userPaymentStatus'];
    visitConfirmationStatus = json['visitConfirmationStatus'];
    paidAmount = json['paidAmount'];
    doctorcharges = json['doctorcharges'];
    admincomission = json['admincomission'];
    isActive = json['isActive'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    beneficiaryComment = json['beneficiaryComment'];
    providerComment = json['providerComment'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    specializationName = json['specializationName'];
    bookingtype = json['bookingtype'];
    tentativeBookingDate = json['tentativeBookingDate'];
    isPaymentDone = json['isPaymentDone'];
    isnewpatient = json['isnewpatient'];
    appointmentStatus = json['appointmentStatus'];
    appointmentTypeName = json['appointmentTypeName'];
    lastApointmentDate = json['lastApointmentDate'];
    tentativeAppointmentDate = json['tentativeAppointmentDate'];
    patientAddress = json['patientAddress'];
    bloodGroup = json['bloodGroup'];
    age = json['age'];
    gender = json['gender'];
    totalratingpoint = json['totalratingpoint'];
    totalreview = json['totalreview'];
    ratingpoints = json['ratingpoints'];
    providerreview = json['providerreview'];
    patientName = json['patientName'];
    patientCurrentAddress = json['patientCurrentAddress'];
    callstatus = json['callstatus'];
    documentname = json['documentname'];
    booingId = json['booingId'];
    appointmentNo = json['appointmentNo'];
    scheduleAppointmentDate = json['scheduleAppointmentDate'];
    bookingAppointmentDate = json['bookingAppointmentDate'];
    trancurrency = json['trancurrency'];
    scheduleStartTime = json['scheduleStartTime'];
    scheduleEndTime = json['scheduleEndTime'];
    scheduleTime = json['scheduleTime'];
    bookingstatus = json['bookingstatus'];
    transno = json['transno'];
    paybackstatus = json['paybackstatus'];
    srno = json['srno'];
    paybackid = json['paybackid'];
    diognosis = json['diognosis'];
    appointmentno = json['appointmentno'];
    bookingId = json['bookingId'];
    serviceType = json['serviceType'];
    provider = json['provider'];
    prescriptiondate = json['prescriptiondate'];
    sourcefrom = json['sourcefrom'];
    tranpkid = json['tranpkid'];
    bankTranId = json['bank_tran_id'];
    statuscode = json['statuscode'];
    errormessage = json['errormessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceProvider'] = this.serviceProvider;
    data['dayStartingTime'] = this.dayStartingTime;
    data['dayEndingTime'] = this.dayEndingTime;
    data['address'] = this.address;
    data['clinicName'] = this.clinicName;
    data['clinicAddress'] = this.clinicAddress;
    data['clinicId'] = this.clinicId;
    data['id'] = this.id;
    data['bookingDate'] = this.bookingDate;
    data['schedule'] = this.schedule;
    data['appointmentSettingId'] = this.appointmentSettingId;
    data['isBookingConfirmed'] = this.isBookingConfirmed;
    data['isBookingCancelledByReceiver'] = this.isBookingCancelledByReceiver;
    data['isBookingCancelledByProvider'] = this.isBookingCancelledByProvider;
    data['serviceReceiverId'] = this.serviceReceiverId;
    data['serviceProviderId'] = this.serviceProviderId;
    data['appointmentTypeId'] = this.appointmentTypeId;
    data['appointmentType'] = this.appointmentType;
    data['tentativeDate'] = this.tentativeDate;
    data['tentativeTime'] = this.tentativeTime;
    data['reportingTime'] = this.reportingTime;
    data['dayOfWeek'] = this.dayOfWeek;
    data['serialNo'] = this.serialNo;
    data['isProcessed'] = this.isProcessed;
    data['isCancelled'] = this.isCancelled;
    data['serviceReceiver'] = this.serviceReceiver;
    data['appointmentDate'] = this.appointmentDate;
    data['appointmentTime'] = this.appointmentTime;
    data['receiverImage'] = this.receiverImage;
    data['providerImage'] = this.providerImage;
    data['receiverEmail'] = this.receiverEmail;
    data['receiverPhone'] = this.receiverPhone;
    data['providerEmail'] = this.providerEmail;
    data['providerPhone'] = this.providerPhone;
    data['appointmentFees'] = this.appointmentFees;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['isRecurrent'] = this.isRecurrent;
    data['recurringHours'] = this.recurringHours;
    data['noOfVisits'] = this.noOfVisits;
    data['userPaymentStatus'] = this.userPaymentStatus;
    data['visitConfirmationStatus'] = this.visitConfirmationStatus;
    data['paidAmount'] = this.paidAmount;
    data['doctorcharges'] = this.doctorcharges;
    data['admincomission'] = this.admincomission;
    data['isActive'] = this.isActive;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['beneficiaryComment'] = this.beneficiaryComment;
    data['providerComment'] = this.providerComment;
    data['pageSize'] = this.pageSize;
    data['pageNumber'] = this.pageNumber;
    data['specializationName'] = this.specializationName;
    data['bookingtype'] = this.bookingtype;
    data['tentativeBookingDate'] = this.tentativeBookingDate;
    data['isPaymentDone'] = this.isPaymentDone;
    data['isnewpatient'] = this.isnewpatient;
    data['appointmentStatus'] = this.appointmentStatus;
    data['appointmentTypeName'] = this.appointmentTypeName;
    data['lastApointmentDate'] = this.lastApointmentDate;
    data['tentativeAppointmentDate'] = this.tentativeAppointmentDate;
    data['patientAddress'] = this.patientAddress;
    data['bloodGroup'] = this.bloodGroup;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['totalratingpoint'] = this.totalratingpoint;
    data['totalreview'] = this.totalreview;
    data['ratingpoints'] = this.ratingpoints;
    data['providerreview'] = this.providerreview;
    data['patientName'] = this.patientName;
    data['patientCurrentAddress'] = this.patientCurrentAddress;
    data['callstatus'] = this.callstatus;
    data['documentname'] = this.documentname;
    data['booingId'] = this.booingId;
    data['appointmentNo'] = this.appointmentNo;
    data['scheduleAppointmentDate'] = this.scheduleAppointmentDate;
    data['bookingAppointmentDate'] = this.bookingAppointmentDate;
    data['trancurrency'] = this.trancurrency;
    data['scheduleStartTime'] = this.scheduleStartTime;
    data['scheduleEndTime'] = this.scheduleEndTime;
    data['scheduleTime'] = this.scheduleTime;
    data['bookingstatus'] = this.bookingstatus;
    data['transno'] = this.transno;
    data['paybackstatus'] = this.paybackstatus;
    data['srno'] = this.srno;
    data['paybackid'] = this.paybackid;
    data['diognosis'] = this.diognosis;
    data['appointmentno'] = this.appointmentno;
    data['bookingId'] = this.bookingId;
    data['serviceType'] = this.serviceType;
    data['provider'] = this.provider;
    data['prescriptiondate'] = this.prescriptiondate;
    data['sourcefrom'] = this.sourcefrom;
    data['tranpkid'] = this.tranpkid;
    data['bank_tran_id'] = this.bankTranId;
    data['statuscode'] = this.statuscode;
    data['errormessage'] = this.errormessage;
    return data;
  }
}