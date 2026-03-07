import '../../domain/entities/cv_entity.dart';

class CVModel extends CVEntity {
  const CVModel({
    required PersonalInfoModel personalInfo,
    required SkillsModel skills,
    required List<ExperienceModel> experience,
    required List<EducationModel> education,
    required List<HobbyModel> hobbies,
    required List<ProjectModel> projects,
  }) : super(
          personalInfo: personalInfo,
          skills: skills,
          experience: experience,
          education: education,
          hobbies: hobbies,
          projects: projects,
        );

  factory CVModel.fromJson(Map<String, dynamic> json) {
    return CVModel(
      personalInfo: PersonalInfoModel.fromJson(json['personal_info']),
      skills: SkillsModel.fromJson(json['skills']),
      experience: (json['experience'] as List).map((e) => ExperienceModel.fromJson(e)).toList(),
      education: (json['education'] as List).map((e) => EducationModel.fromJson(e)).toList(),
      hobbies: (json['hobbies'] as List).map((e) => HobbyModel.fromJson(e)).toList(),
      projects: (json['projects'] as List).map((e) => ProjectModel.fromJson(e)).toList(),
    );
  }
}

class PersonalInfoModel extends PersonalInfoEntity {
  const PersonalInfoModel({
    required String fullName,
    required String jobTitle,
    required String email,
    required String phone,
    required String location,
    required String bio,
    required String profileImage,
    required Map<String, String> socialLinks,
  }) : super(
          fullName: fullName,
          jobTitle: jobTitle,
          email: email,
          phone: phone,
          location: location,
          bio: bio,
          profileImage: profileImage,
          socialLinks: socialLinks,
        );

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    return PersonalInfoModel(
      fullName: json['full_name'],
      jobTitle: json['job_title'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      bio: json['bio'],
      profileImage: json['profile_image'],
      socialLinks: Map<String, String>.from(json['social_links']),
    );
  }
}

class SkillsModel extends SkillsEntity {
  const SkillsModel({
    required List<SkillItemModel> technical,
    required List<SkillItemModel> softSkills,
    required List<SkillItemModel> languages,
  }) : super(
          technical: technical,
          softSkills: softSkills,
          languages: languages,
        );

  factory SkillsModel.fromJson(Map<String, dynamic> json) {
    return SkillsModel(
      technical: (json['technical'] as List).map((e) => SkillItemModel.fromJson(e)).toList(),
      softSkills: (json['soft_skills'] as List).map((e) => SkillItemModel.fromJson(e)).toList(),
      languages: (json['languages'] as List).map((e) => SkillItemModel.fromJson(e)).toList(),
    );
  }
}

class SkillItemModel extends SkillItemEntity {
  const SkillItemModel({required String name, required double level}) : super(name: name, level: level);

  factory SkillItemModel.fromJson(Map<String, dynamic> json) {
    return SkillItemModel(
      name: json['name'],
      level: (json['level'] as num).toDouble(),
    );
  }
}

class ExperienceModel extends ExperienceEntity {
  const ExperienceModel({
    required String company,
    required String position,
    required String period,
    required String description,
    required List<String> technologies,
  }) : super(
          company: company,
          position: position,
          period: period,
          description: description,
          technologies: technologies,
        );

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      company: json['company'],
      position: json['position'],
      period: json['period'],
      description: json['description'],
      technologies: List<String>.from(json['technologies']),
    );
  }
}

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required String title,
    required String description,
    required String image,
    required String link,
  }) : super(
          title: title,
          description: description,
          image: image,
          link: link,
        );

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      link: json['link'],
    );
  }
}

class EducationModel extends EducationEntity {
  const EducationModel({
    required String institution,
    required String degree,
    required String period,
    required String gpa,
  }) : super(
          institution: institution,
          degree: degree,
          period: period,
          gpa: gpa,
        );

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      institution: json['institution'],
      degree: json['degree'],
      period: json['period'],
      gpa: json['gpa'],
    );
  }
}

class HobbyModel extends HobbyEntity {
  const HobbyModel({
    required String name,
    required String description,
    required String icon,
  }) : super(
          name: name,
          description: description,
          icon: icon,
        );

  factory HobbyModel.fromJson(Map<String, dynamic> json) {
    return HobbyModel(
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}
