import 'gank_item_data_entity.dart';

class GankTodayDataEntiryEntity {
	List<String> category;
	bool error;
	GankTodayDataEntiryResults results;

	GankTodayDataEntiryEntity({this.category, this.error, this.results});

	GankTodayDataEntiryEntity.fromJson(Map<String, dynamic> json) {
		category = json['category']?.cast<String>();
		error = json['error'];
		results = json['results'] != null ? new GankTodayDataEntiryResults.fromJson(json['results']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['category'] = this.category;
		data['error'] = this.error;
		if (this.results != null) {
      data['results'] = this.results.toJson();
    }
		return data;
	}
}

class GankTodayDataEntiryResults {
	List<GankItemDataEntity> app;
	List<GankItemDataEntity> video;
	List<GankItemDataEntity> meizhi;
	List<GankItemDataEntity> source;
	List<GankItemDataEntity> fe;
	List<GankItemDataEntity> recommend;
	List<GankItemDataEntity> ios;
	List<GankItemDataEntity> android;

	GankTodayDataEntiryResults({this.app, this.video, this.meizhi, this.source, this.fe, this.recommend, this.ios, this.android});

	GankTodayDataEntiryResults.fromJson(Map<String, dynamic> json) {
		if (json['App'] != null) {
			app = new List<GankItemDataEntity>();(json['App'] as List).forEach((v) { app.add(new GankItemDataEntity.fromJson(v)); });
		}
		if (json['休息视频'] != null) {
			video = new List<GankItemDataEntity>();(json['休息视频'] as List).forEach((v) { video.add(new GankItemDataEntity.fromJson(v)); });
		}
		if (json['福利'] != null) {
			meizhi = new List<GankItemDataEntity>();(json['福利'] as List).forEach((v) { meizhi.add(new GankItemDataEntity.fromJson(v)); });
		}
		if (json['拓展资源'] != null) {
			source = new List<GankItemDataEntity>();(json['拓展资源'] as List).forEach((v) { source.add(new GankItemDataEntity.fromJson(v)); });
		}
		if (json['前端'] != null) {
			fe = new List<GankItemDataEntity>();(json['前端'] as List).forEach((v) { fe.add(new GankItemDataEntity.fromJson(v)); });
		}
		if (json['瞎推荐'] != null) {
			recommend = new List<GankItemDataEntity>();(json['瞎推荐'] as List).forEach((v) { recommend.add(new GankItemDataEntity.fromJson(v)); });
		}
		if (json['iOS'] != null) {
			ios = new List<GankItemDataEntity>();(json['iOS'] as List).forEach((v) { ios.add(new GankItemDataEntity.fromJson(v)); });
		}
		if (json['Android'] != null) {
			android = new List<GankItemDataEntity>();(json['Android'] as List).forEach((v) { android.add(new GankItemDataEntity.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.app != null) {
      data['App'] =  this.app.map((v) => v.toJson()).toList();
    }
		if (this.video != null) {
      data['video'] =  this.video.map((v) => v.toJson()).toList();
    }
		if (this.meizhi != null) {
      data['meizhi'] =  this.meizhi.map((v) => v.toJson()).toList();
    }
		if (this.source != null) {
      data['source'] =  this.source.map((v) => v.toJson()).toList();
    }
		if (this.fe != null) {
      data['fe'] =  this.fe.map((v) => v.toJson()).toList();
    }
		if (this.recommend != null) {
      data['recommend'] =  this.recommend.map((v) => v.toJson()).toList();
    }
		if (this.ios != null) {
      data['ios'] =  this.ios.map((v) => v.toJson()).toList();
    }
		if (this.android != null) {
      data['android'] =  this.android.map((v) => v.toJson()).toList();
    }
		return data;
	}
}
