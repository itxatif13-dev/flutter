import 'package:equatable/equatable.dart';

class CVEntity extends Equatable {
  final PersonalInfoEntity personalInfo;
  final SkillsEntity skills;
  final List<ExperienceEntity> experience;
  final List<EducationEntity> education;
  final List<HobbyEntity> hobbies;
  final List<ProjectEntity> projects;

  const CVEntity({
    required this.personalInfo,
    required this.skills,
    required this.experience,
    required this.education,
    required this.hobbies,
    required this.projects,
  });

  @override
  List<Object?> get props => [personalInfo, skills, experience, education, hobbies, projects];
}

class PersonalInfoEntity extends Equatable {
  final String fullName;
  final String jobTitle;
  final String email;
  final String phone;
  final String location;
  final String bio;
  final String profileImage;
  final Map<String, String> socialLinks;

  const PersonalInfoEntity({
    required this.fullName,
    required this.jobTitle,
    required this.email,
    required this.phone,
    required this.location,
    required this.bio,
    required this.profileImage,
    required this.socialLinks,
  });

  @override
  List<Object?> get props => [fullName, jobTitle, email, phone, location, bio, profileImage, socialLinks];
}

class SkillsEntity extends Equatable {
  final List<SkillItemEntity> technical;
  final List<SkillItemEntity> softSkills;
  final List<SkillItemEntity> languages;

  const SkillsEntity({
    required this.technical,
    required this.softSkills,
    required this.languages,
  });

  @override
  List<Object?> get props => [technical, softSkills, languages];
}

class SkillItemEntity extends Equatable {
  final String name;
  final double level;

  const SkillItemEntity({required this.name, required this.level});

  @override
  List<Object?> get props => [name, level];
}

class ExperienceEntity extends Equatable {
  final String company;
  final String position;
  final String period;
  final String description;
  final List<String> technologies;

  const ExperienceEntity({
    required this.company,
    required this.position,
    required this.period,
    required this.description,
    required this.technologies,
  });

  @override
  List<Object?> get props => [company, position, period, description, technologies];
}

class ProjectEntity extends Equatable {
  final String title;
  final String description;
  final String image;
  final String link;

  const ProjectEntity({
    required this.title,
    required this.description,
    required this.image,
    required this.link,
  });

  @override
  List<Object?> get props => [title, description, image, link];
}

class EducationEntity extends Equatable {
  final String institution;
  final String degree;
  final String period;
  final String gpa;

  const EducationEntity({
    required this.institution,
    required this.degree,
    required this.period,
    required this.gpa,
  });

  @override
  List<Object?> get props => [institution, degree, period, gpa];
}

class HobbyEntity extends Equatable {
  final String name;
  final String description;
  final String icon;

  const HobbyEntity({
    required this.name,
    required this.description,
    required this.icon,
  });

  @override
  List<Object?> get props => [name, description, icon];
}
