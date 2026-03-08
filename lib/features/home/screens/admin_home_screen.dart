import 'package:flutter/material.dart';

enum AdminSection {
  home,
  maintenance,
  request,
  message,
  staff,
  user,
}

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  AdminSection _selectedSection = AdminSection.home;

  void _onSectionSelected(AdminSection section) {
    setState(() {
      _selectedSection = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TopBar(theme: theme),
            const SizedBox(height: 8),
            Expanded(
              child: Row(
                children: [
                  _Sidebar(
                    selected: _selectedSection,
                    onSelect: _onSectionSelected,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      child: Material(
                        color: Colors.white,
                        shape: BeveledRectangleBorder(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(64),
                          ),
                          side: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1,
                          ),
                        ),
                        child: _SectionContent(section: _selectedSection),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          Text(
            'ADVANCED MANUFACTURING Center  MIMAROPA',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              letterSpacing: 4,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 2,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.star, color: Colors.redAccent, size: 14),
          const SizedBox(width: 16),
          const Icon(Icons.notifications_none, size: 20),
          const SizedBox(width: 12),
          const Icon(Icons.settings_outlined, size: 20),
          const SizedBox(width: 12),
          const Icon(Icons.wb_sunny_outlined, size: 20),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.selected,
    required this.onSelect,
  });

  final AdminSection selected;
  final ValueChanged<AdminSection> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 220,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.menu,
                    size: 20,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    'assets/logos/admin_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  'AMCent',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'General',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.grey.shade600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _SidebarItem(
            icon: Icons.home_filled,
            label: 'Home',
            selected: selected == AdminSection.home,
            onTap: () => onSelect(AdminSection.home),
          ),
          _SidebarItem(
            icon: Icons.build_outlined,
            label: 'Maintenance',
            selected: selected == AdminSection.maintenance,
            onTap: () => onSelect(AdminSection.maintenance),
          ),
          _SidebarItem(
            icon: Icons.assignment_outlined,
            label: 'Request',
            selected: selected == AdminSection.request,
            onTap: () => onSelect(AdminSection.request),
          ),
          _SidebarItem(
            icon: Icons.mail_outline,
            label: 'Message',
            selected: selected == AdminSection.message,
            onTap: () => onSelect(AdminSection.message),
          ),
          _SidebarItem(
            icon: Icons.people_outline,
            label: 'Staff',
            selected: selected == AdminSection.staff,
            onTap: () => onSelect(AdminSection.staff),
          ),
          _SidebarItem(
            icon: Icons.person_outline,
            label: 'User',
            selected: selected == AdminSection.user,
            onTap: () => onSelect(AdminSection.user),
          ),
          const Spacer(),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFF6C5CE7),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Marcelo',
                        style: theme.textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Profile',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.logout,
                    size: 18,
                    color: Colors.black87,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Logout',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE7EBFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: selected ? Colors.indigo : Colors.grey.shade700,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: selected ? Colors.indigo : Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionContent extends StatelessWidget {
  const _SectionContent({required this.section});

  final AdminSection section;

  String get _title {
    switch (section) {
      case AdminSection.home:
        return 'Home';
      case AdminSection.maintenance:
        return 'Maintenance';
      case AdminSection.request:
        return 'Request';
      case AdminSection.message:
        return 'Message';
      case AdminSection.staff:
        return 'Staff';
      case AdminSection.user:
        return 'User';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          _title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}


