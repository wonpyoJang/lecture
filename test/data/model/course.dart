import 'package:flutter_test/flutter_test.dart';
import 'package:lecture/data/model/course.dart';
import 'dart:convert';

void main() {
  group('Class Course', () {
    test('json parsing test', () {
      String jsonString =
          '{"auto_completion_condition":{"normal_lecture_progress":80,"op":"and","test_lecture_score":70},"begin_datetime":1518274800000,"class_times":[],"class_type":0,"code":"","complete_datetime":null,"course_type":0,"discount_begin_datetime":null,"discount_end_datetime":null,"discount_rate":null,"discount_title":null,"discounted_price":"0","discounted_price_usd":"0.00","end_datetime":null,"enroll_begin_datetime":1517410800000,"enroll_end_datetime":null,"enroll_limit_number":null,"enroll_type":4,"enrollable_subscription_products":[{"id":2,"level":20,"title":"골든키"},{"id":1,"level":10,"title":"퍼플키"},{"id":3,"level":30,"title":"블랙키"},{"id":4,"level":40,"title":"마스터키"},{"id":5,"level":10,"title":"바우처2개월"},{"id":6,"level":10,"title":"바우처6개월"},{"id":7,"level":10,"title":"바우처10개월"},{"id":8,"level":10,"title":"바우처12개월"},{"id":9,"level":10,"title":"바우처3개월"}],"enrolled_role_begin_datetime":null,"enrolled_role_end_datetime":null,"enrolled_role_period":null,"enrolled_student_count":0,"enrolled_user_count":3,"id":11064,"info_summary_visibility_dict":{"auto_completion_condition":true,"class_times":false,"class_type":true,"enrolled_student_count":true,"exercise_page_count":true,"lecture_page_access_period":true,"level":true,"period":false,"programming_language":true,"total_video_duration":true},"instructors":[],"is_chat_room_disabled":false,"is_datetime_enrollable":true,"is_discounted":false,"is_encoding_video_exist":false,"is_exercise_deprecated":false,"is_free":false,"is_libcourse_slave":false,"is_post_student_email_enabled":false,"is_post_student_info_visible":false,"is_post_tutor_email_enabled":false,"is_recommended":true,"last_course_info_id":66448,"last_review_status":0,"lecture_page_read_info":null,"live_status":null,"logo_file_url":"https://elice-api-cdn.azureedge.net/api/file/1bacbf3effd94e3aa97fd779577e773b/data-analysis.png?se=2021-06-03T00%3A15%3A00Z&sp=rt&sv=2020-06-12&sr=b&sig=kRF/rs2cp%2BVElyz/SrPBP/AU9eA27mWqWivsIpyhDJk%3D","normal_lecture_count":7,"period":4,"preference":{"chatting":false,"helpcenter":true,"live_streaming":false,"tab_menus_visibility":{"boards":true,"configs":false,"dashboard":true,"helpcenter":true,"info":true,"lectureroom":false,"lectures":true,"manage":true,"tutoring":true}},"price":"0","price_usd":"0.00","promote_video_url":null,"release_datetime":null,"short_description":"트럼프대통령트윗~넷플릭스데이터까지!실제데이터를자유자재로다뤄보는과목.","status":0,"subscription_level":10,"taglist":["데이터분석"],"tags":[{"id":10,"name":"python","tag_type":2},{"id":3,"name":"intermediate","tag_type":0},{"id":13,"name":"dataScientist","tag_type":3}],"test_lecture_count":3,"title":"실제데이터를활용한파이썬데이터분석","tracks":[],"user_course_power":0,"user_course_role":{"is_enrolled":false,"is_taking":false,"power":0},"version":2}';

      var test = Course.fromJson(json.decode(jsonString));

      print(test.title);
      print(test.logoFileUrl);

      var ground = Course("실제데이터를활용한파이썬데이터분석",
          "https://elice-api-cdn.azureedge.net/api/file/1bacbf3effd94e3aa97fd779577e773b/data-analysis.png?se=2021-06-03T00%3A15%3A00Z&sp=rt&sv=2020-06-12&sr=b&sig=kRF/rs2cp%2BVElyz/SrPBP/AU9eA27mWqWivsIpyhDJk%3D");

      expect(test, ground);
    });
  });
}
