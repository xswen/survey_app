import 'package:go_router/go_router.dart';
import 'package:survey_app/database/database.dart';

import '../pages/woody_debris/wood_debris_header_measurements_page.dart';
import '../pages/woody_debris/woody_debris_header_page.dart';
import '../pages/woody_debris/woody_debris_piece/woody_debris_header_piece_main.dart';
import '../pages/woody_debris/woody_debris_piece/woody_debris_piece_accu_odd_page.dart';
import '../pages/woody_debris/woody_debris_piece/woody_debris_piece_round_page.dart';
import '../pages/woody_debris/woody_debris_summary_page.dart';

GoRoute goRouteWoodyDebris = GoRoute(
    name: WoodyDebrisSummaryPage.routeName,
    path: "woody-debris",
    builder: (context, state) {
      Map<String, dynamic> data = state.extra as Map<String, dynamic>;
      WoodyDebrisSummaryData wd = data[WoodyDebrisSummaryPage.keyWdSummary];
      List<WoodyDebrisHeaderData> transList =
          data[WoodyDebrisSummaryPage.keyTransList];
      return WoodyDebrisSummaryPage(wd: wd, transList: transList);
    },
    routes: [
      GoRoute(
          name: WoodyDebrisHeaderPage.routeName,
          path: "header",
          builder: (context, state) {
            Map<String, dynamic> data = state.extra as Map<String, dynamic>;
            WoodyDebrisHeaderData wdh = data[WoodyDebrisHeaderPage.keyWdHeader];
            bool summaryComplete =
                data[WoodyDebrisHeaderPage.keySummaryComplete];

            return WoodyDebrisHeaderPage(
                wdh: wdh, summaryComplete: summaryComplete);
          },
          routes: [
            GoRoute(
                name: WoodyDebrisHeaderMeasurements.routeName,
                path: "measurements",
                builder: (context, state) {
                  WoodyDebrisHeaderData data =
                      state.extra as WoodyDebrisHeaderData;
                  return WoodyDebrisHeaderMeasurements(wdh: data);
                }),
            GoRoute(
                name: WoodyDebrisHeaderPieceMain.routeName,
                path: "pieces",
                builder: (context, state) {
                  Map<String, dynamic> data =
                      state.extra as Map<String, dynamic>;
                  WoodyDebrisSmallData wdSm =
                      data[WoodyDebrisHeaderPieceMain.keyWdSmall];
                  int transNum = data[WoodyDebrisHeaderPieceMain.keyTransNum];
                  bool transComplete =
                      data[WoodyDebrisHeaderPieceMain.keyTransComplete];
                  return WoodyDebrisHeaderPieceMain(
                      wdSmall: wdSm,
                      transNum: transNum,
                      transComplete: transComplete);
                },
                routes: [
                  GoRoute(
                      name: WoodyDebrisPieceRoundPage.routeName,
                      path: "round",
                      builder: (context, state) {
                        Map<String, dynamic> data =
                            state.extra as Map<String, dynamic>;

                        WoodyDebrisRoundCompanion piece =
                            data[WoodyDebrisPieceRoundPage.keyPiece];
                        void Function()? deleteFn =
                            data[WoodyDebrisPieceRoundPage.keyDeleteFn];
                        return WoodyDebrisPieceRoundPage(
                          piece: piece,
                          deleteFn: deleteFn,
                        );
                      }),
                  GoRoute(
                      name: WoodyDebrisPieceAccuOddPage.routeName,
                      path: "oddOrAccu",
                      builder: (context, state) {
                        WoodyDebrisOddCompanion data =
                            state.extra as WoodyDebrisOddCompanion;
                        return WoodyDebrisPieceAccuOddPage(piece: data);
                      }),
                ]),
          ])
    ]);