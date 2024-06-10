class ApiResponse {
  final String status;
  final int code;
  final String message;
  final Result result;

  ApiResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.result,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      result: Result.fromJson(json['result']),
    );
  }
}

class Result {
  final List<Rank> editorRank;
  final List<Rank> langRank;
  final List<Rank> frameworkRank;
  final JobCodeHours jobCodeHours;
  final LearnTime learnTime;
  final List<ProductiveToJob> productiveToJob;
  final SleepHours sleepHours;
  final List<Lecture> recommendLectures;

  Result({
    required this.editorRank,
    required this.langRank,
    required this.frameworkRank,
    required this.jobCodeHours,
    required this.learnTime,
    required this.productiveToJob,
    required this.sleepHours,
    required this.recommendLectures,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      editorRank:
          (json['editorRank'] as List).map((i) => Rank.fromJson(i)).toList(),
      langRank:
          (json['langRank'] as List).map((i) => Rank.fromJson(i)).toList(),
      frameworkRank:
          (json['frameworkRank'] as List).map((i) => Rank.fromJson(i)).toList(),
      jobCodeHours: JobCodeHours.fromJson(json['jobCodeHours']),
      learnTime: LearnTime.fromJson(json['learnTime']),
      productiveToJob: (json['productiveToJob'] as List)
          .map((i) => ProductiveToJob.fromJson(i))
          .toList(),
      sleepHours: SleepHours.fromJson(json['sleepHours']),
      recommendLectures: (json['recommendLectures'] as List)
          .map((i) => Lecture.fromJson(i))
          .toList(),
    );
  }
}

class Rank {
  final int rank;
  final String name;
  final int count;

  Rank({
    required this.rank,
    required this.name,
    required this.count,
  });

  factory Rank.fromJson(Map<String, dynamic> json) {
    return Rank(
      rank: json['rank'],
      name: json.containsKey('editor')
          ? json['editor']
          : json.containsKey('language')
              ? json['language']
              : json['framework'],
      count: json['count'],
    );
  }
}

class JobCodeHours {
  final String percent;

  JobCodeHours({
    required this.percent,
  });

  factory JobCodeHours.fromJson(Map<String, dynamic> json) {
    return JobCodeHours(
      percent: json['percent'],
    );
  }
}

class LearnTime {
  final String hours;

  LearnTime({
    required this.hours,
  });

  factory LearnTime.fromJson(Map<String, dynamic> json) {
    return LearnTime(
      hours: json['hours'],
    );
  }
}

class ProductiveToJob {
  final String product;

  ProductiveToJob({
    required this.product,
  });

  factory ProductiveToJob.fromJson(Map<String, dynamic> json) {
    return ProductiveToJob(
      product: json['product'],
    );
  }
}

class SleepHours {
  final String hours;

  SleepHours({
    required this.hours,
  });

  factory SleepHours.fromJson(Map<String, dynamic> json) {
    return SleepHours(
      hours: json['hours'],
    );
  }
}

class Lecture {
  final int lectureId;
  final String imageUrl;
  final String title;
  final String linkUrl;
  final String category;
  final String skill;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Lecture({
    required this.lectureId,
    required this.imageUrl,
    required this.title,
    required this.linkUrl,
    required this.category,
    required this.skill,
    required this.createdAt,
    this.updatedAt,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      lectureId: json['lecture_id'],
      imageUrl: json['image_url'],
      title: json['title'],
      linkUrl: json['link_url'],
      category: json['category'],
      skill: json['skill'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}
