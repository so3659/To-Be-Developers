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
  final List<Salary> salary;
  final List<Rank> editorRank;
  final List<Rank> langRank;
  final List<Rank> frameworkRank;
  final JobCodeHours? jobCodeHours; // Updated to allow null
  final LearnTime? learnTime; // Updated to allow null
  final List<ProductiveToJob> productiveToJob;
  final SleepHours? sleepHours; // Updated to allow null
  final List<Lecture> recommendLectures;

  Result({
    required this.salary,
    required this.editorRank,
    required this.langRank,
    required this.frameworkRank,
    this.jobCodeHours, // Updated to allow null
    this.learnTime, // Updated to allow null
    required this.productiveToJob,
    this.sleepHours, // Updated to allow null
    required this.recommendLectures,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      salary: (json['salary'] as List).map((i) => Salary.fromJson(i)).toList(),
      editorRank:
          (json['editorRank'] as List).map((i) => Rank.fromJson(i)).toList(),
      langRank:
          (json['langRank'] as List).map((i) => Rank.fromJson(i)).toList(),
      frameworkRank:
          (json['frameworkRank'] as List).map((i) => Rank.fromJson(i)).toList(),
      jobCodeHours: json['jobCodeHours'] != null
          ? JobCodeHours.fromJson(json['jobCodeHours'])
          : null, // Updated to handle null
      learnTime: json['learnTime'] != null
          ? LearnTime.fromJson(json['learnTime'])
          : null, // Updated to handle null
      productiveToJob: (json['productiveToJob'] as List)
          .map((i) => ProductiveToJob.fromJson(i))
          .toList(),
      sleepHours: json['sleepHours'] != null
          ? SleepHours.fromJson(json['sleepHours'])
          : null, // Updated to handle null
      recommendLectures: (json['recommendLectures'] as List)
          .map((i) => Lecture.fromJson(i))
          .toList(),
    );
  }
}

class Salary {
  final int salary;

  Salary({
    required this.salary,
  });

  factory Salary.fromJson(Map<String, dynamic> json) {
    return Salary(
      salary: json['salary'],
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
