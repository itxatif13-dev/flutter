import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/cv_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeTab extends StatelessWidget {
  final CVEntity cvData;

  const HomeTab({super.key, required this.cvData});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(cvData.personalInfo.fullName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                )),
            background: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: cvData.personalInfo.profileImage,
                  fit: BoxFit.cover,
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cvData.personalInfo.jobTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 5),
                    Text(cvData.personalInfo.location),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'About Me',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  cvData.personalInfo.bio,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 30),
                Text(
                  'Connect with me',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _SocialButton(
                      icon: FontAwesomeIcons.linkedin,
                      url: cvData.personalInfo.socialLinks['linkedin'] ?? '',
                      color: const Color(0xFF0077B5),
                    ),
                    _SocialButton(
                      icon: FontAwesomeIcons.github,
                      url: cvData.personalInfo.socialLinks['github'] ?? '',
                      color: const Color(0xFF333333),
                    ),
                    _SocialButton(
                      icon: FontAwesomeIcons.twitter,
                      url: cvData.personalInfo.socialLinks['twitter'] ?? '',
                      color: const Color(0xFF1DA1F2),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: Text(cvData.personalInfo.email),
                          onTap: () => launchUrl(Uri.parse('mailto:${cvData.personalInfo.email}')),
                        ),
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: Text(cvData.personalInfo.phone),
                          onTap: () => launchUrl(Uri.parse('tel:${cvData.personalInfo.phone}')),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String url;
  final Color color;

  const _SocialButton({required this.icon, required this.url, required this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(icon, color: color, size: 30),
      onPressed: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        }
      },
    );
  }
}
