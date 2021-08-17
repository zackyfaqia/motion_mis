import 'package:flutter/services.dart';
import 'package:motion_mis/feature/home/model/generation_data.dart';
import 'package:motion_mis/feature/home/model/member_data.dart';
import 'package:motion_mis/feature/home/repository/member_sources.dart';
import 'package:yaml/yaml.dart';

class MemberRepository {
  Future<List<String>> getFileList() async {
    final rawString = await rootBundle.loadString(MemberSources.CONFIG);
    final yamlData = loadYaml(rawString);
    final data = (yamlData['files'] as YamlList)
        .map<String>((element) => element)
        .toList();

    return data;
  }

  Future<GenerationData> getGenerationData(String generationPath) async {
    final path = MemberSources.BASE + '/' + generationPath;
    final rawString = await rootBundle.loadString(path);
    var yamlData = loadYaml(rawString);

    final name = yamlData['name'];
    final data = (yamlData['members'] as YamlList).map<Member>((element) {
      final map = (element as YamlMap).map<String, dynamic>(
        (key, value) => MapEntry(key, value),
      );
      return Member(name, map);
    }).toList();

    return GenerationData(name, data);
  }
}
