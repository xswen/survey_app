import 'package:go_router/go_router.dart';
import 'package:survey_app/database/database.dart';

import '../pages/woody_debris/woody_debris_header_measurements_page.dart';
import '../pages/woody_debris/woody_debris_header_page.dart';
import '../pages/woody_debris/woody_debris_piece/woody_debris_header_piece_main.dart';
import '../pages/woody_debris/woody_debris_piece/woody_debris_piece_accu_odd_page.dart';
import '../pages/woody_debris/woody_debris_piece/woody_debris_piece_round_page.dart';
import '../pages/woody_debris/woody_debris_summary_page.dart';
import 'router_params.dart';

GoRoute goRouteWoodyDebris = GoRoute(
    name: WoodyDebrisSummaryPage.routeName,
    path: "woody-debris/:${RouteParams.wdSummaryIdKey}",
    builder: (context, state) => WoodyDebrisSummaryPage(state),
    routes: [
      GoRoute(
          name: WoodyDebrisHeaderPage.routeName,
          path: "header/:${RouteParams.wdHeaderIdKey}",
          builder: (context, state) => WoodyDebrisHeaderPage(state),
          routes: [
            GoRoute(
              name: WoodyDebrisHeaderMeasurementsPage.routeName,
              path: "measurements",
              builder: (context, state) =>
                  WoodyDebrisHeaderMeasurementsPage(state),
            ),
            GoRoute(
                name: WoodyDebrisHeaderPieceMain.routeName,
                path: "pieces",
                builder: (context, state) {
                  Map<String, dynamic> data =
                      state.extra as Map<String, dynamic>;
                  WoodyDebrisSmallData wdSm =
                      data[WoodyDebrisHeaderPieceMain.keyWdSmall];
                  int transNum = data[WoodyDebrisHeaderPieceMain.keyTransNum];
                  int? decayClass =
                      data[WoodyDebrisHeaderPieceMain.keyDecayClass];
                  bool transComplete =
                      data[WoodyDebrisHeaderPieceMain.keyTransComplete];
                  return WoodyDebrisHeaderPieceMain(
                      wdSmall: wdSm,
                      transNum: transNum,
                      decayClass: decayClass,
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
                        Map<String, dynamic> data =
                            state.extra as Map<String, dynamic>;

                        WoodyDebrisOddCompanion piece =
                            data[WoodyDebrisPieceAccuOddPage.keyPiece];
                        void Function()? deleteFn =
                            data[WoodyDebrisPieceAccuOddPage.keyDeleteFn];

                        return WoodyDebrisPieceAccuOddPage(
                          piece: piece,
                          deleteFn: deleteFn,
                        );
                      }),
                ]),
          ])
    ]);
