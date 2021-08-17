import 'package:get/get.dart';
import 'package:motion_mis/feature/home/repository/member_sources.dart';

class MemberRepository {
  final GetHttpClient client;

  MemberRepository(this.client);

  Future<List<String>> getFileList() async {
    final response = await client.get(MemberSources.CONFIG);
    print(response);
    print(response.body);
    return [];
  }
}
