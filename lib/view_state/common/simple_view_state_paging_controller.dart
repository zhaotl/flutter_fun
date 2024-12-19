import 'package:fun_fluter/http/models/base_result.dart';
import 'package:fun_fluter/view_state/view_state_paging_controller.dart';
import 'package:get/get.dart';

abstract class SimpleViewStatePagingController<T>
    extends ViewStatePagingController {
  RxList dataList = <T>[].obs;

  @override
  void loadData() {
    sendRequest(requestFuture("1"),
        checkEmpty: (value) => checkEmpty(value!),
        onSuccess: (data) {
          List<T> list = convertResult(data);
          if (list.length < pageSize) {
            refreshController?.loadNoData();
          }
          dataList.clear();
          dataList.addAll(list);
        });
  }

  @override
  void loadMorePaging() {
    sendLoadMorePagingRequest(requestFuture("${curPage + 1}"),
        onCheckMoreData: (value) => checkNoMoreData(value!),
        onSuccess: (data) {
          dataList.addAll(convertResult(data));
        });
  }

  @override
  void refreshPaging() {
    sendRefreshPagingRequest(requestFuture("1"), onSuccess: (data) {
      dataList.clear();
      dataList.addAll(convertResult(data));
    });
  }

  Future<BaseResult<dynamic>> requestFuture(String pageNum);

  bool checkEmpty(BaseResult<dynamic> result) => result.isEmpty();

  bool checkNoMoreData(BaseResult<dynamic> result) {
    return result.noMoreData(pageSize);
  }

  List<T> convertResult(dynamic originResult) {
    return originResult as List<T>;
  }
}
