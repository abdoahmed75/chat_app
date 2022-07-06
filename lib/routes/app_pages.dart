//import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:chat_app/views/home/home_view.dart';
import 'package:chat_app/views/login/login_view.dart';
import 'package:chat_app/views/mafcod/list_of_mafcod.dart';
import 'package:chat_app/views/loast/lost.dart';
import 'package:chat_app/views/sign/sign.dart';
import 'package:chat_app/views/profile/profile.dart';
import 'package:chat_app/views/find job/find_job.dart';
import 'package:chat_app/views/Joboffer/job_offer.dart';
import 'package:chat_app/views/start/start.dart';
import 'package:chat_app/views/about/aboutP.dart';
import 'package:chat_app/views/findjobprofile/FindJob.dart';
import 'package:chat_app/views/Deliver/Deliver.dart';
import 'package:chat_app/views/DeliverProvider/DeliverProvider.dart';
import 'package:chat_app/views/Deliver_P/Deliver_P.dart';
import 'package:chat_app/views/DeliverPerson/DeliverPerson.dart';
import 'package:chat_app/views/changeDeliverP/changeDeliverP.dart';
import 'package:chat_app/views/Changelost/Changelost.dart';
import 'package:chat_app/views/NeedHelp/NeedHelp.dart';
import 'package:chat_app/views/NeedHelpPofile/Person.dart';
import 'package:chat_app/views/provideHelpProf/provideHelpProf.dart';
import 'package:chat_app/views/provideHelp/provideHelp.dart';
import 'package:chat_app/views/NeedHelpPofile/changeNeed.dart';
import 'package:chat_app/views/ChangeMafcod/ChangeMafcod.dart';
import 'package:chat_app/views/ChangeMafcodP/ChangeMafcodP.dart';
import 'package:chat_app/views/ChangeMafcodP/liker.dart';
import 'package:chat_app/views/findjobprofile/likerJob.dart';
import 'package:chat_app/views/findjobprofile/acceptJob.dart';
import 'package:chat_app/views/findjobprofile/provideJob.dart';
import 'package:chat_app/views/NeedHelpPofile/NeedHelpPofile.dart';
import 'package:chat_app/views/jobofferprofile/likerOffer.dart';
import 'package:chat_app/views/jobofferprofile/acceptOffer.dart';
import 'package:chat_app/views/login/newPassword.dart';
import 'package:chat_app/views/DeliverPersonProfile/DeliverPersonProfile.dart';
import 'package:chat_app/views/chandeDeliverProviderP/chandeDeliverProviderP.dart';
import 'package:chat_app/views/DliverProviderProfile/DliverProviderProfile.dart';
import 'package:chat_app/views/changejobofferprofile/ChangeJobOffer.dart';
import 'package:chat_app/views/jobofferprofile/JobOfferProfile.dart';
import 'package:chat_app/views/jobofferperson/JobOfferPerson.dart';
import 'package:chat_app/views/splash/splash_view.dart';
import 'package:chat_app/views/Deliver_P/likerDeliver.dart';
import 'package:chat_app/views/postProfile/Posts.dart';
import 'package:chat_app/views/profile/Contact.dart';
import 'package:chat_app/views/login/enterEmail.dart';
import 'package:chat_app/views/comments/commentPosts.dart';
import 'package:chat_app/views/postProfile/postUpdate.dart';
import 'package:chat_app/views/NeedHelpPofile/acceptNeed.dart';
import 'package:chat_app/views/Deliver_P/acceptDeliver.dart';
import 'package:chat_app/views/DliverProviderProfile/likerProvider.dart';
import 'package:chat_app/views/DliverProviderProfile/acceptProvider.dart';
import 'package:chat_app/views/about/deliverAbout.dart';
import 'package:chat_app/views/about/helpAbout.dart';
import 'package:chat_app/views/about/jobAbout.dart';
import 'package:chat_app/views/about/mafcodAbout.dart';
import 'package:chat_app/pages/landing_page.dart';

//import 'package:chat_app/views/loast/lost.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => SplashView(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
    ),
    GetPage(
      name: Routes.CONTROL,
      page: () => HomeView(),
    ),
    GetPage(
      name: Routes.mafcod,
      page: () => ListOfMafcode(),
    ),
    GetPage(
      name: Routes.Loast,
      page: () => Lost(),
    ),
GetPage(
  name: Routes.sign,
  page: () => Sign(),
),
  GetPage(
  name: Routes.start,
  page: () => Start(),
  ),
    GetPage(
      name: Routes.profile,
      page: () => Profile(),
    ),
    GetPage(
      name: Routes.find_job,
      page: () => FindJob(),

    ),
    GetPage(
      name: Routes.job_offer,
      page: () => JobOffer(),
    ),
    GetPage(
      name: Routes.findjobprofile,
      page: () => FindJobP(),
    ),
    GetPage(
      name: Routes.jobofferprofile,
      page: () => JobOfferP(),
    ),
    GetPage(
      name: Routes.changejobofferprofile,
      page: () => ChangeJobOffer(),
    ),
    GetPage(
      name: Routes.jobofferperson,
      page: () => JobOfferPerson(),
    ),
    GetPage(
      name: Routes.about,
      page: () => AboutP(),
    ),
    GetPage(
      name: Routes.deliver,
      page: () => Deliver(),
    ),
    GetPage(
      name: Routes.deliverprovider,
      page: () => DeliverProvider(),
    ),
    GetPage(
      name: Routes.deliverP,
      page: () => Deliver_P(),
    ),
    GetPage(
      name: Routes.DeliverProviderProfile,
      page: () => DeliverProviderProfile(),
    ),
    GetPage(
      name: Routes.changeDeliverP,
      page: () => changeDeliverP(),
    ),
    GetPage(
      name: Routes.DeliverPerson,
      page: () => DeliverPerson(),
    ),
    GetPage(
      name: Routes.changeDeliverProviderP,
      page: () => changeDeliverProviderP(),
    ),
    GetPage(
      name: Routes.DeliverPersonProfile,
      page: () => DeliverPersonProfile(),
    ),
    GetPage(
      name: Routes.Changelost,
      page: () => Changelost(),
    ),
    GetPage(
      name: Routes.ChangeMafcod,
      page: () => ChangeMafcod(),
    ),
    GetPage(
      name: Routes.ChangeMafcodP,
      page: () => ChangeMafcodP(),
    ),
    GetPage(
      name: Routes.NeedHelp,
      page: () => NeedHelp(),
    ),
    GetPage(
      name: Routes.provideHelp,
      page: () => provideHelp(),
    ),
    GetPage(
      name: Routes.NeedHelpPofile,
      page: () => NeedHelpPofile(),
    ),
    GetPage(
      name: Routes.provideHelpProf,
      page: () => provideHelpProf(),
    ),
    GetPage(
      name: Routes.changeNeed,
      page: () => changeNeed(),
    ),
    GetPage(
      name: Routes.Person,
      page: () => Person(),
    ),
    GetPage(
      name: Routes.liker,
      page: () => liker(),
    ),
    GetPage(
      name: Routes.likerJob,
      page: () => likerJob(),
    ),
    GetPage(
      name: Routes.acceptJob,
      page: () => acceptJob(),
    ),
    GetPage(
      name: Routes.provideJob,
      page: () => provideJob(),
    ),
    GetPage(
      name: Routes.likerOffer,
      page: () => likerOffer(),
    ),
    GetPage(
      name: Routes.acceptOffer,
      page: () => acceptOffer(),
    ),
    GetPage(
      name: Routes.likerDeliver,
      page: () => likerDeliver(),
    ),
    GetPage(
      name: Routes.acceptDeliver,
      page: () => acceptDeliver(),
    ),
    GetPage(
      name: Routes.likerProvider,
      page: () => likerProvider(),
    ),
    GetPage(
      name: Routes.acceptProvider,
      page: () => acceptProvider(),
    ),
    GetPage(
      name: Routes.acceptNeed,
      page: () => acceptNeed(),
    ),
    GetPage(
      name: Routes.mafcodAbout,
      page: () => mafcodAbout(),
    ),
    GetPage(
      name: Routes.jobAbout,
      page: () => jobAbout(),
    ),
    GetPage(
      name: Routes.deliverAbout,
      page: () => deliverAbout(),
    ),
    GetPage(
      name: Routes.helpAbout,
      page: () => helpAbout(),
    ),
    GetPage(
      name: Routes.Posts,
      page: () =>posts(),
    ),
    GetPage(
      name: Routes.postUpdate,
      page: () =>postUpdate(),
    ),
    GetPage(
      name: Routes.enterEmail,
      page: () =>enterEmail(),
    ),
    GetPage(
      name: Routes.newPassword,
      page: () =>newPassword(),
    ),
    GetPage(
      name: Routes.commentPost,
      page: () =>commentPost(),
    ),
    GetPage(
      name: Routes.Contact,
      page: () =>Contact(),
    ),
    GetPage(
      name: Routes.LandingPage,
      page: () =>LandingPage(),
    ),
  ];
}
