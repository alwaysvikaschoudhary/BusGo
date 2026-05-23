import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar & Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        child: const Icon(
                          Icons.person_rounded,
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primary, width: 2),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Vikas Choudhary',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'vikas@email.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Account Section
            _buildSection(
              context,
              title: 'Account',
              items: [
                _SettingsItem(Icons.person_outline_rounded, 'Edit Profile'),
                _SettingsItem(Icons.lock_outline_rounded, 'Change Password'),
                _SettingsItem(Icons.notifications_outlined, 'Notifications'),
                _SettingsItem(Icons.payment_rounded, 'Saved Payments'),
              ],
            ),
            const SizedBox(height: 16),

            // Preferences Section
            _buildSection(
              context,
              title: 'Preferences',
              items: [
                _SettingsItem(Icons.language_rounded, 'Language', trailing: 'English'),
              ],
              customChildren: [
                // Dark mode toggle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.dark_mode_rounded,
                            size: 20, color: theme.colorScheme.primary),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text('Dark Mode', style: theme.textTheme.bodyMedium),
                      ),
                      Switch(
                        value: appProvider.isDarkMode,
                        onChanged: (v) => appProvider.toggleDarkMode(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Support Section
            _buildSection(
              context,
              title: 'Support',
              items: [
                _SettingsItem(Icons.help_outline_rounded, 'Help Center'),
                _SettingsItem(Icons.info_outline_rounded, 'About'),
                _SettingsItem(Icons.star_outline_rounded, 'Rate App'),
                _SettingsItem(Icons.description_outlined, 'Terms & Privacy'),
              ],
            ),
            const SizedBox(height: 24),

            // Logout
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout_rounded, color: AppColors.error),
                label: const Text('Logout', style: TextStyle(color: AppColors.error)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.error),
                  minimumSize: const Size(double.infinity, 52),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Version 1.0.0',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<_SettingsItem> items,
    List<Widget>? customChildren,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.dividerTheme.color?.withValues(alpha: 0.3) ?? Colors.transparent,
            ),
          ),
          child: Column(
            children: [
              ...items.asMap().entries.map((entry) {
                final i = entry.key;
                final item = entry.value;
                return Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(item.icon, size: 20, color: theme.colorScheme.primary),
                      ),
                      title: Text(item.label, style: theme.textTheme.bodyMedium),
                      trailing: item.trailing != null
                          ? Text(item.trailing!, style: theme.textTheme.bodySmall)
                          : Icon(Icons.chevron_right,
                              color: theme.textTheme.bodySmall?.color),
                      onTap: () {},
                    ),
                    if (i < items.length - 1 || (customChildren?.isNotEmpty ?? false))
                      Divider(
                        height: 1,
                        indent: 68,
                        color: theme.dividerTheme.color?.withValues(alpha: 0.3),
                      ),
                  ],
                );
              }),
              if (customChildren != null) ...customChildren,
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsItem {
  final IconData icon;
  final String label;
  final String? trailing;

  _SettingsItem(this.icon, this.label, {this.trailing});
}
