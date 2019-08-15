class GankHistoryListEntity {
	bool error;
	List<String> results;

	GankHistoryListEntity({this.error, this.results});

	GankHistoryListEntity.fromJson(Map<String, dynamic> json) {
		error = json['error'];
		results = json['results']?.cast<String>();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['error'] = this.error;
		data['results'] = this.results;
		return data;
	}

	static GankHistoryListEntity gankHistoryListEntity;
}
