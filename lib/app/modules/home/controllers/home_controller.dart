import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/db_name.dart';
import 'package:pasuhisab/app/core/repositories/all_repositories.dart';
import 'package:pasuhisab/app/core/repositories/chall_record_respositiories.dart';
import 'package:pasuhisab/app/core/repositories/challa_dead_repositories.dart';
import 'package:pasuhisab/app/core/service/ad_helper.dart';
import 'package:pasuhisab/app/data/model/balance_model.dart';
import 'package:pasuhisab/app/data/model/category.dart';
import 'package:pasuhisab/app/data/model/chall_dead.dart';
import 'package:pasuhisab/app/data/model/challa_record.dart';
import 'package:pasuhisab/app/data/model/total_model.dart';
import 'package:pasuhisab/app/modules/chickensell/bindings/chickensell_binding.dart';
import 'package:pasuhisab/app/modules/chickensellreport/views/chickensellreport_view.dart';
import 'package:pasuhisab/app/modules/dana/bindings/dana_binding.dart';
import 'package:pasuhisab/app/modules/dana/views/dana_view.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/Other_report.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/egg_report.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/electricity_rend_water_add.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/medical_report.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/mol_report.dart';
import 'package:pasuhisab/app/modules/widgets/dialog_box.dart';

class HomeController extends GetxController {
  AllRepo allRepo = new AllRepositories();
  DeadChallaRepo deadChallaRepo = new DeadChallaRepositories();
  ChallRecordRepo challrepo = new ChallRepositories();
  TextEditingController amountcontroller = new TextEditingController();
  TextEditingController remarksController = new TextEditingController();
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  RxInt challid = 0.obs;

  RxInt totalChalla = 0.obs;
  RxInt deadchalla = 0.obs;
  RxInt lossamount = 0.obs;

  RxInt totalExpenditure = 0.obs;
  RxInt balance = 0.obs;
  RxInt profitandloss = 0.obs;
  RxInt remaning = 0.obs;
  RxInt totalIncome = 0.obs;
  RxBool challInfoLoading = false.obs;
  RxInt challLoss = 0.obs;

  RxInt totalDana = 0.obs;
  RxInt totalb0 = 0.obs;
  RxInt totalb1 = 0.obs;
  RxInt totalb2 = 0.obs;
  RxInt totall3 = 0.obs;
  RxInt tatallabor = 0.obs;
  RxInt totalmedicine = 0.obs;
  RxInt totalbhush = 0.obs;
  RxInt totalchickenqty = 0.obs;
  RxInt totalchickenkg = 0.obs;
  RxInt maxrate = 0.obs;
  int index = 0;

  RxList<TotalModel> totalExpenditureList =
      List<TotalModel>.empty(growable: true).obs;

  List<ChallDead> deadchallList = [];
  RxList<Banner>? bannerList; //only in home page
  RxBool isloading = false.obs;
  RxBool isChall = false.obs;
  RxList<ChallaRecord> challRecordList =
      List<ChallaRecord>.empty(growable: true).obs;

  RxBool loadExpenses = false.obs;
  RxBool loadIncome = false.obs;
  RxList<TotalModel> totalIncomeList =
      new List<TotalModel>.empty(growable: true).obs;

  Balance? balanceB;

  loadingChicks() async {
    isloading.toggle();

    List<ChallaRecord> cr = await challrepo.getChallRecord();
    if (challRecordList.isNotEmpty) challRecordList.clear();
    if (cr != null) {
      challRecordList = cr.obs;
      if (challRecordList.isNotEmpty) {
        challid.value = challRecordList[0].id;
      }
      index = 0;
    }
    balanceB = await allRepo.getBalance();
    balance.value = balanceB?.total ?? 0;
    await loadSingleChallInof(challid.value);
    print('Loading alue');
    print(isloading.value);
    isloading.toggle();
  }

  loadBalance() async {
    balanceB = await allRepo.getBalance();
    if (balanceB != null) selectBalanceForUpdate();
  }

  selectBalanceForUpdate() {
    amountcontroller.text = balanceB?.total.toString() ?? '0';
    remarksController.text = balanceB?.remarks ?? '';
  }

  updatebalance() async {
    if (formkey.currentState?.validate() ?? false) {
      Balance b = new Balance(
          id: balanceB?.id ?? 0,
          total: int.parse(amountcontroller.text),
          remarks: remarksController.text,
          enterdate: DateTime.now());
      int res = await allRepo.updateBalance(b);
      if (res > 0) {
        Get.snackbar(info.tr, updateMessage.tr, backgroundColor: Colors.white);
        balanceB = b;
        balance.value = b.total;
        clearData();
      } else {
        Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.white);
      }
    }
  }

  clearData() {
    amountcontroller.text = '';
    remarksController.text = '';
  }

  loadSingleChallInof(int challid) async {
    challInfoLoading.toggle();
    totalExpenditure.value = 0;
    totalIncome.value = 0;
    totalChalla.value = 0;
    deadchalla.value = 0;
    lossamount.value = 0;
    await loadOtherDetails();
    calcaulateProfitLoss();
    challInfoLoading.toggle();
  }

  calcaulateProfitLoss() {
    profitandloss.value =
        (balance.value + totalIncome.value) - totalExpenditure.value;
    remaning.value =
        profitandloss.value > 0 ? balance.value + profitandloss.value : 0;
  }

  Future totalIncomeMethod() async {
    loadIncome.toggle();
    if (totalIncomeList.isNotEmpty) totalIncomeList.clear();
    List<TotalModel> totalInc = [];

    TotalModel? chsel = await allRepo.getChickenSell(
        Dbname.ChickenSelling_TABLE, Dbname.Kg, Dbname.Rate, challid.value);
    if (chsel == null) chsel = new TotalModel(qty: 0, rate: 0, total: 0);
    chsel?.name = ch.tr + ' ' + selling.tr;
    TotalModel tms = new TotalModel(
        name: chsel.name,
        qty: chsel.qty,
        rate: chsel.rate,
        total: chsel.total,
        onTap: () {
          Get.to(() => ChickensellreportView(), binding: ChickensellBinding());
        });

    totalInc.add(tms);

    totalchickenkg.value = chsel.qty;
    maxrate.value = chsel.rate;
    int res = await allRepo.totalof(
        Dbname.ChickenSelling_TABLE, Dbname.Piece, challid.value);
    totalchickenqty.value = res;

    TotalModel? moll = await allRepo.getChickenSell(
        Dbname.Mol_TABLE, Dbname.Qty, Dbname.Rate, challid.value);
    if (moll == null)
      moll = new TotalModel(name: mol.tr, qty: 0, rate: 0, total: 0);
    moll?.name = mol.tr;
    TotalModel tmm = new TotalModel(
        name: moll.name,
        qty: moll.qty,
        rate: moll.rate,
        total: moll.total,
        onTap: () {
          Get.bottomSheet(MolReport());
        });
    totalInc.add(tmm);

    TotalModel? eggs = await allRepo.getChickenSell(
        Dbname.Egg_TABLE, Dbname.Qty, Dbname.Rate, challid.value);
    if (eggs == null) eggs = new TotalModel(qty: 0, rate: 0, total: 0);
    eggs?.name = egg.tr;
    TotalModel tme = new TotalModel(
        name: eggs.name,
        qty: eggs.qty,
        rate: eggs.rate,
        total: eggs.total,
        onTap: () {
          Get.bottomSheet(EggReport());
        });
    totalInc.add(tme);

    int otherinc = await allRepo.totaloftwoid(
        Dbname.Other_TABLE, Dbname.Total, Dbname.Inout, challid.value, '1');
    TotalModel extras = new TotalModel(
        name: other.tr + ' ' + extra.tr,
        qty: 0,
        rate: 0,
        total: otherinc > 0 ? otherinc : 0,
        onTap: () {
          Get.bottomSheet(OtherReport(inout: true));
        });

    //dana return
    TotalModel? dane = await allRepo.getChickenSell(
        Dbname.DANA_TABLE, Dbname.Dreturn, Dbname.Rate, challid.value);
    if (dana == null)
      dane = new TotalModel(
          name: dana.tr + ' ' + ret.tr, qty: 0, rate: 0, total: 0);

    TotalModel dms = new TotalModel(
      name: dana.tr + ' ' + ret.tr,
      qty: dane?.qty ?? 0,
      rate: dane?.rate ?? 0,
      total: dane?.total ?? 0,
    );

    totalInc.add(dms);

    totalInc.add(extras);
    if (totalInc != null) totalIncomeList = totalInc.obs;

    totalInc.forEach((element) {
      totalIncome.value += element?.total ?? 0;
    });

    loadIncome.toggle();
  }

  Future totalExpenses() async {
    loadExpenses.toggle();
    if (totalExpenditureList.isNotEmpty) totalExpenditureList.clear();

    List<TotalModel> totalexp = [];

    TotalModel? chicks = await allRepo.getTotalSingle(
        Dbname.CHALLRECORD_TABLE, Dbname.Qty, Dbname.Rate, challid.value,
        ch: true);

    if (chicks == null)
      chicks = new TotalModel(name: chick.tr, qty: 0, rate: 0, total: 0);
    chicks?.name = chick.tr;
    totalexp.add(chicks);

    TotalModel? bhusmodel = await allRepo.getTotalSingle(
        Dbname.Bhush_TABLE, Dbname.Qty, Dbname.Rate, challid.value);

    if (bhusmodel == null)
      bhusmodel = new TotalModel(name: bhus.tr, qty: 0, rate: 0, total: 0);
    bhusmodel?.name = bhus.tr;
    totalexp.add(bhusmodel);

    totalbhush.value = bhusmodel.qty * bhusmodel.rate;

    //Dana
    TotalModel? b0m = await allRepo.getTotalDana(Dbname.DANA_TABLE, Dbname.Qty,
        Dbname.Rate, Dbname.Dana, challid.value, 'B0');
    TotalModel? b1m = await allRepo.getTotalDana(Dbname.DANA_TABLE, Dbname.Qty,
        Dbname.Rate, Dbname.Dana, challid.value, 'B1');
    TotalModel? b2m = await allRepo.getTotalDana(Dbname.DANA_TABLE, Dbname.Qty,
        Dbname.Rate, Dbname.Dana, challid.value, 'B2');
    TotalModel? l3m = await allRepo.getTotalDana(Dbname.DANA_TABLE, Dbname.Qty,
        Dbname.Rate, Dbname.Dana, challid.value, 'L3');

    totalb0.value = (b0m?.qty ?? 0) > 0 ? (b0m?.qty ?? 0) : 0;
    totalb1.value = (b1m?.qty ?? 0) > 0 ? (b1m?.qty ?? 0) : 0;

    totalb2.value = (b2m?.qty ?? 0) > 0 ? (b2m?.qty ?? 0) : 0;

    totall3.value = (l3m?.qty ?? 0) > 0 ? (l3m?.qty ?? 0) : 0;

    totalDana.value =
        (b0m?.qty ?? 0) + (b1m?.qty ?? 0) + (b2m?.qty ?? 0) + (l3m?.qty ?? 0);

    TotalModel danamodel = new TotalModel(
        name: dana.tr,
        qty: ((b0m?.qty ?? 0) +
                (b1m?.qty ?? 0) +
                (b2m?.qty ?? 0) +
                (l3m?.qty ?? 0))
            .toInt(),
        rate: b0m?.rate ?? 0,
        total: (b0m?.total ?? 0) +
            (b1m?.total ?? 0) +
            (b2m?.total ?? 0) +
            (l3m?.total ?? 0),
        onTap: () {
          Get.to(() => DanaView(), binding: DanaBinding());
        });
    totalexp.add(danamodel);

    //labour
    int l = await allRepo.singleValue(
        Dbname.LABOR_TABLE, Dbname.Total, challid.value);
    TotalModel labore = new TotalModel(qty: 0, rate: 0, total: l > 0 ? l : 0);
    labore.name = labor.tr;
    totalexp.add(labore);

    tatallabor.value = l > 0 ? l : 0;

    int m = await allRepo.totalof(
        Dbname.MEDICINE_TABLE, Dbname.Total, challid.value);
    TotalModel tm = new TotalModel(
        qty: 0,
        rate: 0,
        total: m > 0 ? m : 0,
        onTap: () {
          Get.bottomSheet(MedicalReport());
        });
    tm.name = medicine.tr;
    totalexp.add(tm);
    totalmedicine.value = m > 0 ? m : 0;

    //electricity

    int elr = await allRepo.electricity(challid.value);
    TotalModel elem = new TotalModel(
        name: el.tr + re.tr + wat.tr,
        qty: 0,
        rate: 0,
        total: elr > 0 ? elr : 0,
        onTap: () {
          Get.bottomSheet(EleRentWater());
        });
    totalexp.add(elem);

    //otherexta
    int ext = await allRepo.totaloftwoid(Dbname.Other_TABLE, Dbname.Total,
        Dbname.Inout, challid.value, '0'); //( Dbname.Total, challid);
    TotalModel extras = new TotalModel(
        name: other.tr + ' ' + extra.tr,
        qty: 0,
        rate: 0,
        total: ext ?? 0,
        onTap: () {
          Get.bottomSheet(OtherReport(inout: false));
        });

    totalexp.add(extras);

    int costs = await allRepo.totalof(
        Dbname.ChickenSelling_TABLE, Dbname.Travel, challid.value);
    TotalModel tv = new TotalModel(qty: 0, rate: 0, total: costs);
    tv.name = travel.tr + ' ' + cost.tr;

    totalexp.add(tv);
    totalExpenditure.value = 0;
    totalexp.forEach((element) {
      totalExpenditure.value += element?.total ?? 0;
    });
    if (totalexp != null) totalExpenditureList = totalexp.obs;

    loadExpenses.toggle();
  }

  sumofDeadChick() {
    deadchalla.value = 0;
    lossamount.value = 0;
    if (deadchallList != null)
      for (var su in deadchallList) {
        deadchalla.value += su.qty;
        lossamount.value += su.price;
      }
  }

  @override
  void onInit() {
    super.onInit();
    // loadingChicks();
    initGoogleMobileAds();
    loadAds();
    loadAds1();
    loadAds2();
    loadAds3();
    loadInterstitialAd();
  }

  deleteChalla(BuildContext context, int index) async {
    bool resu = await dialogBox(context,
        title: 'Warning !',
        message: 'Are you sure to delete this lot?',
        btnname: 'Delete');
    if (resu) {
      ChallaRecord cr = challRecordList[index];
      int r = await allRepo.deleteAll(cr.id);
      final result = await challrepo.deleteChallRecord(cr.id);
      if (result >= 0) {
        if (r >= 0) {
          Get.snackbar(info.tr, deleteMessage.tr, backgroundColor: Colors.blue);
          await loadingChicks();
        }

        //loadChallRecord();
      } else {
        Get.snackbar(error.tr, errorMessage.tr, backgroundColor: Colors.blue);
      }
    }
  }

  String categoryfindbyId(int id) {
    switch (id) {
      case 1:
        return boiler.tr;
      case 2:
        return parent.tr;
      case 3:
        return bhale.tr;
      case 4:
        return turkey.tr;
      case 5:
        return quail.tr;
      case 6:
        return kadaknath.tr;
      default:
        return '';
    }
  }

  String categoryid(int id) {
    switch (id) {
      case 1:
        return boiler;
      case 2:
        return parent;
      case 3:
        return bhale;
      case 4:
        return turkey;
      case 5:
        return quail;
      case 6:
        return kadaknath;
      default:
        return '';
    }
  }

  String check(Category ct, int id) {
    if (ct.id == id)
      return ct.categoryname;
    else
      return '';
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future loadOtherDetails() async {
    //Load dead Challa
    ChallaRecord? c = await challrepo.getSingleChallRecord(challid.value);
    totalChalla.value = c?.qty ?? 0;

    deadchallList = await deadChallaRepo.getChallaDead(challid.value);
    if (deadchallList != null) sumofDeadChick();
    await totalExpenses();
    await totalIncomeMethod();
  }

  InterstitialAd? interstitialAd;
  bool isInterstitialAdReady = false;

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this.interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              loadInterstitialAd();
            },
          );

          isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          isInterstitialAdReady = false;
        },
      ),
    );
  }

  BannerAd? ad;
  BannerAd? ad1;
  BannerAd? ad2;
  BannerAd? ad3;
  RxBool isAdLoaded = false.obs;
  RxBool isAdLoaded1 = false.obs;
  RxBool isAdLoaded2 = false.obs;
  RxBool isAdLoaded3 = false.obs;

  Future<InitializationStatus> initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  loadAds() {
    ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isAdLoaded.value = true; //reactive
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
        },
      ),
    );
    ad?.load();
  }

  loadAds1() {
    ad1 = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId1,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isAdLoaded1.value = true; //reactive
        },
        onAdFailedToLoad: (ad1, error) {
          // Releases an ad resource when it fails to load
          ad1.dispose();
        },
      ),
    );
    ad1?.load();
  }

  loadAds2() {
    ad2 = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId2,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isAdLoaded2.value = true; //reactive
        },
        onAdFailedToLoad: (ad2, error) {
          // Releases an ad resource when it fails to load
          ad2.dispose();
        },
      ),
    );
    ad2?.load();
  }

  loadAds3() {
    ad3 = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId3,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isAdLoaded3.value = true; //reactive
        },
        onAdFailedToLoad: (ad3, error) {
          // Releases an ad resource when it fails to load
          ad3.dispose();
        },
      ),
    );
    ad3?.load();
  }

  @override
  void onClose() {
    ad?.dispose();
    interstitialAd?.dispose();
    remarksController.dispose();
    amountcontroller.dispose();
  }
}
