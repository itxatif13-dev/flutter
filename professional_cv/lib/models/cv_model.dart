class CVData {
  final PersonalInfo personalInfo;
  final List<Experience> experience;
  final List<Education> education;
  final List<Skill> skills;
  final List<Project> projects;
  final List<String> hobbies;

  CVData({
    required this.personalInfo,
    required this.experience,
    required this.education,
    required this.skills,
    required this.projects,
    required this.hobbies,
  });

  factory CVData.fromJson(Map<String, dynamic> json) {
    return CVData(
      personalInfo: PersonalInfo.fromJson(json['personal_info']),
      experience: (json['experience'] as List).map((e) => Experience.fromJson(e)).toList(),
      education: (json['education'] as List).map((e) => Education.fromJson(e)).toList(),
      skills: (json['skills']['technical'] as List).map((e) => Skill.fromJson(e)).toList(),
      projects: (json['projects'] as List).map((e) => Project.fromJson(e)).toList(),
      hobbies: (json['hobbies'] as List).map((e) => e['name'] as String).toList(),
    );
  }
}

class PersonalInfo {
  final String fullName;
  final String jobTitle;
  final String email;
  final String phone;
  final String location;
  final String bio;
  final String profileImage;

  PersonalInfo({
    required this.fullName,
    required this.jobTitle,
    required this.email,
    required this.phone,
    required this.location,
    required this.bio,
    required this.profileImage,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      fullName: json['full_name'],
      jobTitle: json['job_title'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      bio: json['bio'],
      profileImage: json['profile_image'],
    );
  }
}

class Experience {
  final String company;
  final String position;
  final String period;
  final String description;

  Experience({required this.company, required this.position, required this.period, required this.description});

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      company: json['company'],
      position: json['position'],
      period: json['period'],
      description: json['description'],
    );
  }
}

class Education {
  final String institution;
  final String degree;
  final String period;
  final String gpa;

  Education({required this.institution, required this.degree, required this.period, required this.gpa});

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      institution: json['institution'],
      degree: json['degree'],
      period: json['period'],
      gpa: json['gpa'],
    );
  }
}

class Skill {
  final String name;
  final double level;

  Skill({required this.name, required this.level});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'],
      level: (json['level'] as num).toDouble(),
    );
  }
}

class Project {
  final String title;
  final String description;
  final String image;
  final String link;

  Project({required this.title, required this.description, required this.image, required this.link});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      link: json['link'],
    );
  }
}
