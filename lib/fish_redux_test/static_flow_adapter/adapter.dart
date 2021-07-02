import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';

class CSStaticFlowAdapter extends StaticFlowAdapter<CSStaticFlowState> {
  CSStaticFlowAdapter()
      : super(
          slots:<Dependent<CSStaticFlowState>>[

          ],
          reducer: buildReducer(),
        );
}
