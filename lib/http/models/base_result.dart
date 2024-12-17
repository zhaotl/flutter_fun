import 'package:fun_fluter/generated/json/base/json_convert_content.dart';
import 'package:fun_fluter/generated/json/base/json_field.dart';
import 'dart:convert';

@JsonSerializable()
class BaseResult<T> {
  late T? data;
  late int? code;
  late String? msg;

  BaseResult();

  BaseResult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] != 'null') {
      try {
        data = JsonConvert.fromJsonAsT<T>(json['data']);
      } catch (e) {
        data = List<String>.from(json['data']) as T;
      }
    }

    code = json['code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (this.data != null) {
      map['data'] = this.data;
    }
    map['code'] = this.code;
    map['msg'] = this.msg;
    return map;
  }

  bool isSuccess() => this.code == 200;

  bool isEmpty() {
    if (data == null) {
      return true;
    } else {
			if (data is List) {
				return (data as List).isEmpty;
			} else {
			  return false;
			}
		}
  }

	bool noMoreData(int pageSize) {
		if (data == null) {
			return true;
		} else {
			if (data is List) {
				return (data as List).length < pageSize;
			} else {
				return false;
			}
		}
	}

  @override
  String toString() {
    return jsonEncode(this);
  }
}
