import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:professional_cv/core/services/pdf_service.dart';
import 'package:professional_cv/features/cv/presentation/bloc/cv_bloc.dart';
import '../bloc/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
            children: [
              ListTile(
                title: const Text('Theme Mode'),
                subtitle: Text(state.themeMode.name.toUpperCase()),
                trailing: DropdownButton<ThemeMode>(
                  value: state.themeMode,
                  onChanged: (ThemeMode? newValue) {
                    if (newValue != null) {
                      context.read<SettingsBloc>().add(ChangeThemeEvent(newValue));
                    }
                  },
                  items: ThemeMode.values.map((mode) {
                    return DropdownMenuItem(
                      value: mode,
                      child: Text(mode.name.toUpperCase()),
                    );
                  }).toList(),
                ),
              ),
              ListTile(
                title: const Text('Language'),
                subtitle: Text(state.locale.languageCode == 'en' ? 'English' : 'Spanish'),
                trailing: DropdownButton<String>(
                  value: state.locale.languageCode,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      context.read<SettingsBloc>().add(ChangeLocaleEvent(Locale(newValue)));
                    }
                  },
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'es', child: Text('Spanish')),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Export CV as PDF'),
                subtitle: const Text('Generate a printable version of your CV'),
                leading: const Icon(Icons.picture_as_pdf),
                onTap: () {
                  final cvState = context.read<CVBloc>().state;
                  if (cvState is CVLoaded) {
                    PdfService.generateAndPrintCV(cvState.cvData);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('CV data not loaded yet.')),
                    );
                  }
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('About App'),
                subtitle: const Text('Professional CV v1.0.0'),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Professional CV',
                    applicationVersion: '1.0.0',
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
