import 'package:quiver/strings.dart';

class Gank{
    static const today_url = 'http://gank.io/api/today';
    static const _history_day_url = 'http://gank.io/api/day/';
    static const _model_list_api = 'http://gank.io/api/data/';
    //获取提交的历史记录
    static const String gankHistoryApi = 'http://gank.io/api/day/history';
    //http://gank.io/api/data/数据类型/请求个数/第几页
    static String getGankDataModelApi(String name, int pageSize, int pageName) {
        print(name + " " + pageSize.toString() + " " + pageName.toString());
        assert((isNotEmpty(name) && pageSize > 0 && pageName > 0), 'name is not empty and pageSize > 0 pageName > 0');
        return _model_list_api + name + '/' + pageSize.toString() + '/' + pageName.toString();
    }
    //http://gank.io/api/day/2019/04/10
    static String getGankHistoryDayApi(String time) {
        return _history_day_url + time.replaceAll('-', '/');
    }


    static const gank_data_type = {
        "ios": "iOS",
        "source": "拓展资源",
        "recommend": "瞎推荐",
        "android": "Android",
        "app": "App",
        "fe": "前端",
        "meizhi": "福利",
        "video": "休息视频",
    };
}