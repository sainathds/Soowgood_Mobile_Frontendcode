class ApiConstant{

  // static String baseUrl = 'http://204.93.160.159:8080/api/';
  // static String fileBaseUrl = 'http://204.93.160.159:8080/';

  static String baseUrl = 'https://api.soowgood.com/api/';
  static String fileBaseUrl = 'https://api.soowgood.com/';

  static String googleProfileApi = 'https://www.googleapis.com/auth/userinfo.profile';

  static String profilePicFolder = 'img/';
  static String documentImgFolder = 'ProviderDocument/';
  static String clinicImgFolder = 'clinicpic/';
  static String appointmentDocFolder = 'appointmentdoc/';

  static String verifyUserApi = '${baseUrl}Users/verifyuser';

  static String confirmVerificationApi = '${baseUrl}Users/confirmverification';

  static String setChangedPasswordApi = '${baseUrl}Users/changePassword';

  static String loginApi = '${baseUrl}Users/login';

  static String forgotPasswordApi = '${baseUrl}Users/forgotPassword';

  static String profileDataApi = '${baseUrl}Users/getuserdatabyid';
  
  static String ratingDataApi = '${baseUrl}Users/getProvideReviewRating';
  
  static String ratingListDataApi = '${baseUrl}Bookings/getReviewAndRating';
  
  static String deleteAccountApi = '${baseUrl}Users/deleteuserprofiledata';

  static String uploadProfilePicApi = '${baseUrl}Users/ProfilePicture';

  static String updateUserProfileApi = '${baseUrl}Users/updateUserProfile';

  static String addDegreeApi = '${baseUrl}Degrees/Degree';
  static String updateDegreeApi = '${baseUrl}Degrees/UpdateDegree';
  static String getDegreeApi = '${baseUrl}Degrees/GetDegree';
  static String deleteDegreeApi = '${baseUrl}Degrees/DeleteDegree';

  static String providerProfileStatusApi = '${baseUrl}Users/GetUser';
  static String providerProfileScoreApi = '${baseUrl}Users/getUserProfileCompletionStatus';

  static String getExperienceApi = '${baseUrl}Experiences/GetExperience';
  static String addExperienceApi = '${baseUrl}Experiences/Experience';
  static String updateExperienceApi = '${baseUrl}Experiences/UpdateExperience';
  static String deleteExperienceApi = '${baseUrl}Experiences/DeleteExperience';

  static String getAwardApi = '${baseUrl}Awards/GetAward';
  static String addAwardApi = '${baseUrl}Awards/Awards';
  static String updateAwardApi = '${baseUrl}Awards/UpdateAward';
  static String deleteAwardApi = '${baseUrl}Awards/DeleteAward';

  static String getMembershipApi = '${baseUrl}Memberships/GetMembership';
  static String addMembershipApi = '${baseUrl}Memberships/Membership';
  static String updateMembershipApi = '${baseUrl}Memberships/UpdateMembership';
  static String deleteMembershipApi = '${baseUrl}Memberships/DeleteMembership';

  static String getSpecializationApi = '${baseUrl}Specializations/GetSpecialization';
  static String serviceListApi = '${baseUrl}Specializations/ServiceList';
  static String categoryListApi = '${baseUrl}ProviderCategoryInfoes/GetProviderType';
  static String specializationTypeListApi = '${baseUrl}Specializations/SpecializationList';
  static String addSpecializationApi = '${baseUrl}Specializations/Information';
  static String updateSpecializationApi = '${baseUrl}Specializations/UpdateInformation';
  static String deleteSpecializationApi = '${baseUrl}Specializations/deleteSpecialization';


  static String uploadDocumentApi = '${baseUrl}ProviderDocuments/saveProviderDocument';
  static String getDocumentApi = '${baseUrl}ProviderDocuments/GetProviderDocument';
  static String updateDocumentApi = '${baseUrl}ProviderDocuments/updateProviderDocument';
  static String deleteDocumentApi = '${baseUrl}ProviderDocuments/deleteProviderDocumentDetails';


  static String getClinicsApi = '${baseUrl}Clinics/GetClinic';
  static String addClinicApi = '${baseUrl}Clinics/saveClinicInformation';
  static String editClinicApi = '${baseUrl}Clinics/updateClinicInformation';
  static String deleteClinicApi = '${baseUrl}Clinics/deleteProviderClinicInfo';


  static String getConsultancyTypeApi = '${baseUrl}AppointmentTypes/AppointmentType';
  static String getScheduleTypeApi = '${baseUrl}TaskTypes/TaskType';
  static String getScheduleListApi = '${baseUrl}AppointmentSettings/AppointmentList';
  static String addEditScheduleApi = '${baseUrl}AppointmentSettings/Appointment';
  static String checkScheduleDuplicationApi = '${baseUrl}AppointmentSettings/CheckAppointmentDetails';
  static String getAdminChargesApi = '${baseUrl}Pricings/DefaultPricingPlan';
  static String deleteScheduleApi = '${baseUrl}AppointmentSettings/deleteCurrentSchedule';
  static String scheduleDetailApi = '${baseUrl}AppointmentSettings/getAppointmentDetailData';



  static String beneficiaryProvidersApi = '${baseUrl}Searches/Provider';
  static String beneficiarySpecializationApi = '${baseUrl}ProviderCategoryInfoes/AllServices';
  static String searchProvidersApi = '${baseUrl}Searches/GlobalSearch';

  static String scheduleForBookingApi = '${baseUrl}AppointmentSettings/AppointmentListForBooking';
  static String addEditBookingApi = '${baseUrl}Bookings/BookingInfo';
  static String addEditBookingDocApi = '${baseUrl}Bookings/addupdateBookingDocument';
  static String updatePatientDataApi = '${baseUrl}Bookings/updatePatientInfoIntoBooking';

  static String getBookingSummaryApi = '${baseUrl}Bookings/getbookinghistoryforpayment';
  static String getPaymentProcessApi = '${baseUrl}Bookings/processPayment';

  static String getDoctorCountApi = '${baseUrl}Dashboard/VisitedDoctor';
  static String getAppointmentCountApi = '${baseUrl}Dashboard/AllAppointment';
  static String getAppointmentListApi = '${baseUrl}Bookings/patientAppointmentHistory';
  static String getCancelAppointmentApi = '${baseUrl}Bookings/cancelBookingByPatient';

  static String getRemoveBookingApi = '${baseUrl}Bookings/removeAppointmentBeforePayment';


  static String getTodayAppointmentCountApi = '${baseUrl}Dashboard/TodayTotalAppointment';
  static String getNextScheduleCountApi = '${baseUrl}Dashboard/UpcomingTotalAppointment';
  static String getYourOfClinicCountApi = '${baseUrl}Dashboard/NoOfClinic';
  static String getTodayBillAmountApi = '${baseUrl}Dashboard/TotalAppointmentBill';
  static String getProfileCompletionCountApi = '${baseUrl}Users/getUserProfileCompletionStatus';

  static String getProviderDashboardAppointmentsApi = '${baseUrl}Bookings/providerAppointmentHistory';

  static String getProviderAppointmentListApi = '${baseUrl}Bookings/getProviderAppointments';

  static String checkAppointmentCancelApi = '${baseUrl}Bookings/checkAppointmentCancellation';
  static String providerCancelAppointmentApi = '${baseUrl}Bookings/cancelBookingByProvider';
  static String beneficiaryCancelAppointmentApi = '${baseUrl}Bookings/cancelBookingByPatient';


  static String getPrescriptionListApi = '${baseUrl}Bookings/getPrescription'; //use for provider and beneficiary
  static String patientPrescriptionDataApi = '${baseUrl}Bookings/getServiceReceiverForPrescription'; //use for provider and beneficiary

  static String beneficiaryGetDrugApi = '${baseUrl}Bookings/getprescriptiondurgdetails';
  static String beneficiaryGetMedicalTestApi = '${baseUrl}Bookings/getprescriptionmedicaltestdetails';
  static String beneficiaryGetAdviceApi = '${baseUrl}Bookings/getprescriptionadvicetestdetails';


  static String providerVisitedDoctorApi = '${baseUrl}Bookings/getDoctorVisitForPatient';
  static String getPatientDocumentHistoryApi = '${baseUrl}Bookings/getPatientAppointmentDocumentHistory';

  static String addEditPrescriptionApi = '${baseUrl}Bookings/savePrescriptionInformation';

  //
  static String billingSetupApi = '${baseUrl}ProviderBillInformation/saveProviderBillInformation';
  static String getBillingSetupInfoApi = '${baseUrl}ProviderBillInformation/getProviderBillInformation';
  static String deleteBillingSetupApi = '${baseUrl}ProviderBillInformation/deleteProviderBillInformation';

  static String billingHistoryApi = '${baseUrl}Bookings/getProviderBookingBillDetails';


  static String patientListApi = '${baseUrl}Bookings/getProviderPatients';
  static String notificationListApi = '${baseUrl}Dashboard/getNotification';
  static String readAllNotificationsApi = '${baseUrl}Dashboard/markallnotificationasread';
  static String deleteAllNotificationsApi = '${baseUrl}Dashboard/deleteAllNotification';

  static String makePaymentRequestApi = '${baseUrl}Bookings/makeRequestForPayBack';

  static String twilioAccessToken = 'https://meet.soowgood.com/api/twilio/token';  //twilioVideoCall api

  static String saveUpdateFcmDataApi = '${baseUrl}Users/AddUpdateDeviceInformation';


  static String dummyPaymentApi = '${baseUrl}Bookings/updatepaymentransaction';

}
