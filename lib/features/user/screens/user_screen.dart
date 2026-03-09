import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  DESIGN TOKENS (shared)
// ─────────────────────────────────────────────
class AppColors {
  static const bg = Color(0xFFF4F6FB);
  static const surface = Colors.white;
  static const border = Color(0xFFE8ECF4);
  static const indigo = Color(0xFF4F46E5);
  static const indigoLight = Color(0xFFEEF2FF);
  static const indigoDark = Color(0xFF3730A3);
  static const emerald = Color(0xFF10B981);
  static const emeraldLight = Color(0xFFD1FAE5);
  static const rose = Color(0xFFF43F5E);
  static const roseLight = Color(0xFFFFE4E6);
  static const amber = Color(0xFFF59E0B);
  static const amberLight = Color(0xFFFEF3C7);
  static const violet = Color(0xFF8B5CF6);
  static const violetLight = Color(0xFFEDE9FE);
  static const sky = Color(0xFF0EA5E9);
  static const skyLight = Color(0xFFE0F2FE);
  static const textPrimary = Color(0xFF0F172A);
  static const textSecondary = Color(0xFF64748B);
  static const textMuted = Color(0xFF94A3B8);
}

// ─────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────
enum UserTier { standard, premium, enterprise }

class PrintRequest {
  final String id;
  final String fileName;
  final String material;
  final String color;
  final String status; // 'Approved' | 'Pending' | 'Rejected' | 'Printing' | 'Completed'
  final DateTime submittedAt;
  final String? assignedStaff;
  final double? estimatedCost;

  const PrintRequest({
    required this.id,
    required this.fileName,
    required this.material,
    required this.color,
    required this.status,
    required this.submittedAt,
    this.assignedStaff,
    this.estimatedCost,
  });
}

class AppUser {
  final String id;
  final String name;
  final String email;
  final String department;
  final UserTier tier;
  final bool isActive;
  final DateTime joinedAt;
  final int totalRequests;
  final int completedPrints;
  final int pendingRequests;
  final double totalSpent;
  final List<PrintRequest> recentRequests;
  final Color avatarColor;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.tier,
    required this.isActive,
    required this.joinedAt,
    required this.totalRequests,
    required this.completedPrints,
    required this.pendingRequests,
    required this.totalSpent,
    required this.recentRequests,
    required this.avatarColor,
  });

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}';
    return name[0];
  }
}

// ─────────────────────────────────────────────
//  SAMPLE DATA
// ─────────────────────────────────────────────
final List<AppUser> _sampleUsers = [
  AppUser(
    id: 'USR-001',
    name: 'John Doe',
    email: 'john.doe@company.com',
    department: 'Engineering',
    tier: UserTier.premium,
    isActive: true,
    joinedAt: DateTime(2023, 3, 14),
    totalRequests: 38,
    completedPrints: 34,
    pendingRequests: 2,
    totalSpent: 420.50,
    avatarColor: AppColors.indigo,
    recentRequests: [
      PrintRequest(id: 'REQ-001', fileName: 'mounting_bracket_v4.stl', material: 'PLA', color: 'Black', status: 'Pending', submittedAt: DateTime.now().subtract(const Duration(hours: 2)), assignedStaff: 'Mike Johnson', estimatedCost: 14.50),
      PrintRequest(id: 'REQ-009', fileName: 'enclosure_lid.stl', material: 'PETG', color: 'Clear', status: 'Completed', submittedAt: DateTime.now().subtract(const Duration(days: 2)), assignedStaff: 'Sarah Wilson', estimatedCost: 22.00),
      PrintRequest(id: 'REQ-017', fileName: 'gear_prototype.stl', material: 'ABS', color: 'Grey', status: 'Completed', submittedAt: DateTime.now().subtract(const Duration(days: 5)), assignedStaff: 'Mike Johnson', estimatedCost: 18.75),
    ],
  ),
  AppUser(
    id: 'USR-002',
    name: 'Jane Smith',
    email: 'jane.smith@company.com',
    department: 'Product Design',
    tier: UserTier.enterprise,
    isActive: true,
    joinedAt: DateTime(2022, 11, 2),
    totalRequests: 72,
    completedPrints: 69,
    pendingRequests: 1,
    totalSpent: 1240.00,
    avatarColor: AppColors.violet,
    recentRequests: [
      PrintRequest(id: 'REQ-002', fileName: 'phone_case_prototype.stl', material: 'TPU', color: 'Blue', status: 'Printing', submittedAt: DateTime.now().subtract(const Duration(hours: 5)), assignedStaff: 'Sarah Wilson', estimatedCost: 9.90),
      PrintRequest(id: 'REQ-011', fileName: 'product_mockup_v2.stl', material: 'PLA', color: 'White', status: 'Completed', submittedAt: DateTime.now().subtract(const Duration(days: 1)), assignedStaff: 'Nina Patel', estimatedCost: 31.00),
      PrintRequest(id: 'REQ-021', fileName: 'handle_ergonomic.stl', material: 'PETG', color: 'Black', status: 'Completed', submittedAt: DateTime.now().subtract(const Duration(days: 3)), assignedStaff: 'Mike Johnson', estimatedCost: 16.25),
    ],
  ),
  AppUser(
    id: 'USR-003',
    name: 'Robert Brown',
    email: 'r.brown@company.com',
    department: 'R&D',
    tier: UserTier.standard,
    isActive: true,
    joinedAt: DateTime(2024, 1, 20),
    totalRequests: 14,
    completedPrints: 11,
    pendingRequests: 0,
    totalSpent: 175.25,
    avatarColor: AppColors.sky,
    recentRequests: [
      PrintRequest(id: 'REQ-003', fileName: 'sensor_housing.stl', material: 'ABS', color: 'Grey', status: 'Rejected', submittedAt: DateTime.now().subtract(const Duration(hours: 8)), assignedStaff: 'Mike Johnson', estimatedCost: null),
      PrintRequest(id: 'REQ-014', fileName: 'test_rig_base.stl', material: 'PLA', color: 'Red', status: 'Completed', submittedAt: DateTime.now().subtract(const Duration(days: 4)), assignedStaff: 'David Chen', estimatedCost: 27.50),
    ],
  ),
  AppUser(
    id: 'USR-004',
    name: 'Emily Davis',
    email: 'emily.d@company.com',
    department: 'Marketing',
    tier: UserTier.standard,
    isActive: true,
    joinedAt: DateTime(2023, 7, 8),
    totalRequests: 9,
    completedPrints: 7,
    pendingRequests: 1,
    totalSpent: 98.00,
    avatarColor: AppColors.emerald,
    recentRequests: [
      PrintRequest(id: 'REQ-004', fileName: 'display_stand_logo.stl', material: 'PLA', color: 'White', status: 'Pending', submittedAt: DateTime.now().subtract(const Duration(hours: 12)), assignedStaff: 'Unassigned', estimatedCost: 11.00),
      PrintRequest(id: 'REQ-019', fileName: 'promo_figurine.stl', material: 'PLA', color: 'Blue', status: 'Completed', submittedAt: DateTime.now().subtract(const Duration(days: 6)), assignedStaff: 'Lisa Garcia', estimatedCost: 19.50),
    ],
  ),
  AppUser(
    id: 'USR-005',
    name: 'Michael Lee',
    email: 'mlee@company.com',
    department: 'Engineering',
    tier: UserTier.premium,
    isActive: true,
    joinedAt: DateTime(2022, 5, 30),
    totalRequests: 55,
    completedPrints: 52,
    pendingRequests: 0,
    totalSpent: 860.75,
    avatarColor: AppColors.amber,
    recentRequests: [
      PrintRequest(id: 'REQ-005', fileName: 'drone_frame_v7.stl', material: 'Carbon PLA', color: 'Black', status: 'Completed', submittedAt: DateTime.now().subtract(const Duration(days: 1)), assignedStaff: 'Sarah Wilson', estimatedCost: 48.00),
      PrintRequest(id: 'REQ-023', fileName: 'motor_mount.stl', material: 'ABS', color: 'Grey', status: 'Completed', submittedAt: DateTime.now().subtract(const Duration(days: 3)), assignedStaff: 'Nina Patel', estimatedCost: 22.50),
    ],
  ),
  AppUser(
    id: 'USR-006',
    name: 'Clara Nguyen',
    email: 'clara.n@company.com',
    department: 'Architecture',
    tier: UserTier.enterprise,
    isActive: false,
    joinedAt: DateTime(2023, 2, 11),
    totalRequests: 41,
    completedPrints: 40,
    pendingRequests: 0,
    totalSpent: 990.00,
    avatarColor: AppColors.rose,
    recentRequests: [
      PrintRequest(id: 'REQ-033', fileName: 'scale_model_wing_A.stl', material: 'PLA', color: 'White', status: 'Completed', submittedAt: DateTime.now().subtract(const Duration(days: 14)), assignedStaff: 'Mike Johnson', estimatedCost: 56.00),
    ],
  ),
];

// ─────────────────────────────────────────────
//  SCREEN
// ─────────────────────────────────────────────
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String _searchQuery = '';
  String _tierFilter = 'All';
  String _statusFilter = 'All';
  AppUser? _selectedUser;

  static const _tierFilters = ['All', 'Standard', 'Premium', 'Enterprise'];
  static const _statusFilters = ['All', 'Active', 'Inactive'];

  List<AppUser> get _filtered {
    return _sampleUsers.where((u) {
      final matchSearch = _searchQuery.isEmpty ||
          u.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          u.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          u.department.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchTier = _tierFilter == 'All' ||
          (_tierFilter == 'Standard' && u.tier == UserTier.standard) ||
          (_tierFilter == 'Premium' && u.tier == UserTier.premium) ||
          (_tierFilter == 'Enterprise' && u.tier == UserTier.enterprise);
      final matchStatus = _statusFilter == 'All' ||
          (_statusFilter == 'Active' && u.isActive) ||
          (_statusFilter == 'Inactive' && !u.isActive);
      return matchSearch && matchTier && matchStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main list
          Expanded(
            flex: _selectedUser != null ? 5 : 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 32, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildSummaryRow(),
                  const SizedBox(height: 20),
                  _buildFilters(),
                  const SizedBox(height: 16),
                  _buildUserTable(),
                ],
              ),
            ),
          ),
          // Detail panel
          if (_selectedUser != null)
            Container(
              width: 340,
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(left: BorderSide(color: AppColors.border)),
              ),
              child: _UserDetailPanel(
                user: _selectedUser!,
                onClose: () => setState(() => _selectedUser = null),
              ),
            ),
        ],
      ),
    );
  }

  // ── HEADER ───────────────────────────────────
  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColors.indigo, AppColors.violet],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Text(
                    'Users',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.7,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Manage and monitor all user print requests',
                  style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: AppColors.indigoLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.indigo.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              const Icon(Icons.people_alt_rounded, size: 15, color: AppColors.indigo),
              const SizedBox(width: 8),
              Text(
                '${_sampleUsers.length} Total Users',
                style: const TextStyle(color: AppColors.indigo, fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── SUMMARY ROW ──────────────────────────────
  Widget _buildSummaryRow() {
    final active = _sampleUsers.where((u) => u.isActive).length;
    final totalReqs = _sampleUsers.fold(0, (s, u) => s + u.totalRequests);
    final totalPending = _sampleUsers.fold(0, (s, u) => s + u.pendingRequests);
    final totalRevenue = _sampleUsers.fold(0.0, (s, u) => s + u.totalSpent);
    final enterprise = _sampleUsers.where((u) => u.tier == UserTier.enterprise).length;

    return Row(
      children: [
        _SummaryTile(label: 'Active Users', value: active.toString(), color: AppColors.emerald, icon: Icons.person_rounded),
        const SizedBox(width: 12),
        _SummaryTile(label: 'Total Requests', value: totalReqs.toString(), color: AppColors.indigo, icon: Icons.layers_rounded),
        const SizedBox(width: 12),
        _SummaryTile(label: 'Pending', value: totalPending.toString(), color: AppColors.amber, icon: Icons.hourglass_top_rounded),
        const SizedBox(width: 12),
        _SummaryTile(label: 'Revenue', value: '₱${totalRevenue.toStringAsFixed(0)}', color: AppColors.violet, icon: Icons.payments_rounded),
        const SizedBox(width: 12),
        _SummaryTile(label: 'Enterprise', value: enterprise.toString(), color: AppColors.sky, icon: Icons.business_rounded),
      ],
    );
  }

  // ── FILTERS ──────────────────────────────────
  Widget _buildFilters() {
    return Row(
      children: [
        // Search
        Expanded(
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
              decoration: const InputDecoration(
                hintText: 'Search by name, email or department…',
                hintStyle: TextStyle(fontSize: 13, color: AppColors.textMuted),
                prefixIcon: Icon(Icons.search_rounded, size: 18, color: AppColors.textMuted),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        _FilterGroup(
          label: 'Tier:',
          options: _tierFilters,
          selected: _tierFilter,
          onChanged: (v) => setState(() => _tierFilter = v),
        ),
        const SizedBox(width: 12),
        _FilterGroup(
          label: 'Status:',
          options: _statusFilters,
          selected: _statusFilter,
          onChanged: (v) => setState(() => _statusFilter = v),
        ),
      ],
    );
  }

  // ── USER TABLE ───────────────────────────────
  Widget _buildUserTable() {
    final users = _filtered;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: const [
                Expanded(flex: 3, child: _TH('User')),
                Expanded(flex: 2, child: _TH('Department')),
                Expanded(flex: 2, child: _TH('Tier')),
                Expanded(flex: 1, child: _TH('Requests')),
                Expanded(flex: 1, child: _TH('Pending')),
                Expanded(flex: 2, child: _TH('Spent')),
                Expanded(flex: 2, child: _TH('Status')),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          if (users.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Text('No users match your filters', style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
              ),
            )
          else
            ...users.asMap().entries.map((e) => _UserRow(
              user: e.value,
              isEven: e.key.isEven,
              isSelected: _selectedUser?.id == e.value.id,
              onTap: () => setState(() {
                _selectedUser = _selectedUser?.id == e.value.id ? null : e.value;
              }),
            )),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  USER ROW
// ─────────────────────────────────────────────
class _UserRow extends StatelessWidget {
  final AppUser user;
  final bool isEven, isSelected;
  final VoidCallback onTap;

  const _UserRow({required this.user, required this.isEven, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.indigoLight
              : isEven
                  ? Colors.white
                  : AppColors.bg.withOpacity(0.5),
          border: Border(
            left: BorderSide(
              color: isSelected ? AppColors.indigo : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Row(
          children: [
            // User info
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 19,
                        backgroundColor: user.isActive
                            ? user.avatarColor.withOpacity(0.15)
                            : const Color(0xFFF1F5F9),
                        child: Text(
                          user.initials,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: user.isActive ? user.avatarColor : AppColors.textMuted,
                          ),
                        ),
                      ),
                      if (!user.isActive)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: AppColors.textMuted,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1.5),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        Text(user.email, style: const TextStyle(fontSize: 11, color: AppColors.textMuted), overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Department
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Icon(Icons.business_center_rounded, size: 12, color: AppColors.textMuted),
                  const SizedBox(width: 5),
                  Text(user.department, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            // Tier
            Expanded(
              flex: 2,
              child: _TierBadge(tier: user.tier),
            ),
            // Total requests
            Expanded(
              flex: 1,
              child: Text(
                user.totalRequests.toString(),
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
            ),
            // Pending
            Expanded(
              flex: 1,
              child: user.pendingRequests > 0
                  ? Container(
                      width: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: AppColors.amberLight, borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        user.pendingRequests.toString(),
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.amber),
                      ),
                    )
                  : Text('—', style: TextStyle(fontSize: 13, color: AppColors.textMuted.withOpacity(0.5))),
            ),
            // Spent
            Expanded(
              flex: 2,
              child: Text(
                '₱${user.totalSpent.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontFamily: 'monospace'),
              ),
            ),
            // Status
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: user.isActive ? AppColors.emeraldLight : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: user.isActive ? AppColors.emerald : AppColors.textMuted,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          user.isActive ? 'Active' : 'Inactive',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: user.isActive ? AppColors.emerald : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.textMuted),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  USER DETAIL PANEL
// ─────────────────────────────────────────────
class _UserDetailPanel extends StatelessWidget {
  final AppUser user;
  final VoidCallback onClose;

  const _UserDetailPanel({required this.user, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Close + title
          Row(
            children: [
              const Text('User Detail', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const Spacer(),
              GestureDetector(
                onTap: onClose,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
                  child: const Icon(Icons.close_rounded, size: 16, color: AppColors.textSecondary),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Avatar + name block
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: user.isActive ? user.avatarColor.withOpacity(0.15) : const Color(0xFFF1F5F9),
                  child: Text(
                    user.initials,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: user.isActive ? user.avatarColor : AppColors.textMuted,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(user.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text(user.email, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _TierBadge(tier: user.tier),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: user.isActive ? AppColors.emeraldLight : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 6, height: 6,
                            decoration: BoxDecoration(
                              color: user.isActive ? AppColors.emerald : AppColors.textMuted,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            user.isActive ? 'Active' : 'Inactive',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: user.isActive ? AppColors.emerald : AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const _Divider(),
          const SizedBox(height: 16),

          // Info rows
          _InfoRow(icon: Icons.business_center_rounded, label: 'Department', value: user.department),
          _InfoRow(icon: Icons.badge_rounded, label: 'User ID', value: user.id, mono: true),
          _InfoRow(icon: Icons.calendar_today_rounded, label: 'Member since', value: _formatDate(user.joinedAt)),

          const SizedBox(height: 20),
          const _Divider(),
          const SizedBox(height: 16),

          // Stats grid
          const Text('Print Statistics', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _StatBox(label: 'Total', value: user.totalRequests.toString(), color: AppColors.indigo)),
              const SizedBox(width: 10),
              Expanded(child: _StatBox(label: 'Completed', value: user.completedPrints.toString(), color: AppColors.emerald)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _StatBox(label: 'Pending', value: user.pendingRequests.toString(), color: AppColors.amber)),
              const SizedBox(width: 10),
              Expanded(child: _StatBox(label: 'Total Spent', value: '₱${user.totalSpent.toStringAsFixed(0)}', color: AppColors.violet)),
            ],
          ),

          const SizedBox(height: 20),
          const _Divider(),
          const SizedBox(height: 16),

          // Recent requests
          const Text('Recent Requests', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          ...user.recentRequests.map((r) => _RequestCard(request: r)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  REQUEST CARD (in detail panel)
// ─────────────────────────────────────────────
class _RequestCard extends StatelessWidget {
  final PrintRequest request;
  const _RequestCard({required this.request});

  static ({Color color, Color light, IconData icon}) _meta(String status) {
    switch (status) {
      case 'Approved': return (color: AppColors.emerald, light: AppColors.emeraldLight, icon: Icons.check_circle_rounded);
      case 'Rejected': return (color: AppColors.rose, light: AppColors.roseLight, icon: Icons.cancel_rounded);
      case 'Pending': return (color: AppColors.amber, light: AppColors.amberLight, icon: Icons.hourglass_top_rounded);
      case 'Printing': return (color: AppColors.indigo, light: AppColors.indigoLight, icon: Icons.print_rounded);
      case 'Completed': return (color: AppColors.sky, light: AppColors.skyLight, icon: Icons.task_alt_rounded);
      default: return (color: AppColors.textMuted, light: AppColors.bg, icon: Icons.help_rounded);
    }
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    final m = _meta(request.status);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: m.light, borderRadius: BorderRadius.circular(6)),
                child: Icon(m.icon, size: 13, color: m.color),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  request.fileName,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontFamily: 'monospace'),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(color: m.light, borderRadius: BorderRadius.circular(6)),
                child: Text(request.status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: m.color)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _MiniTag(label: request.material, icon: Icons.layers_rounded),
              const SizedBox(width: 6),
              _MiniTag(label: request.color, icon: Icons.circle, iconColor: _colorFromName(request.color)),
              const Spacer(),
              if (request.estimatedCost != null)
                Text('₱${request.estimatedCost!.toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.violet, fontFamily: 'monospace')),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.access_time_rounded, size: 10, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Text(_timeAgo(request.submittedAt), style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
              if (request.assignedStaff != null && request.assignedStaff != 'Unassigned') ...[
                const SizedBox(width: 8),
                Icon(Icons.person_outline_rounded, size: 10, color: AppColors.textMuted),
                const SizedBox(width: 3),
                Text(request.assignedStaff!, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Color _colorFromName(String name) {
    switch (name.toLowerCase()) {
      case 'black': return Colors.black87;
      case 'white': return Colors.grey.shade300;
      case 'red': return Colors.red;
      case 'blue': return Colors.blue;
      case 'grey': return Colors.grey;
      case 'clear': return Colors.cyan.shade200;
      default: return AppColors.textMuted;
    }
  }
}

// ─────────────────────────────────────────────
//  REUSABLE COMPONENTS
// ─────────────────────────────────────────────
class _SummaryTile extends StatelessWidget {
  final String label, value;
  final Color color;
  final IconData icon;
  const _SummaryTile({required this.label, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, size: 15, color: color),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: color, letterSpacing: -0.4)),
                Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TierBadge extends StatelessWidget {
  final UserTier tier;
  const _TierBadge({required this.tier});

  @override
  Widget build(BuildContext context) {
    final data = switch (tier) {
      UserTier.standard => (label: 'Standard', color: AppColors.textSecondary, light: AppColors.bg, icon: Icons.person_rounded),
      UserTier.premium => (label: 'Premium', color: AppColors.amber, light: AppColors.amberLight, icon: Icons.star_rounded),
      UserTier.enterprise => (label: 'Enterprise', color: AppColors.violet, light: AppColors.violetLight, icon: Icons.business_rounded),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(color: data.light, borderRadius: BorderRadius.circular(8), border: Border.all(color: data.color.withOpacity(0.2))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(data.icon, size: 11, color: data.color),
          const SizedBox(width: 4),
          Text(data.label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: data.color)),
        ],
      ),
    );
  }
}

class _FilterGroup extends StatelessWidget {
  final String label;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onChanged;
  const _FilterGroup({required this.label, required this.options, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
        const SizedBox(width: 6),
        ...options.map((o) => GestureDetector(
          onTap: () => onChanged(o),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            margin: const EdgeInsets.only(left: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: selected == o ? AppColors.indigo : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: selected == o ? AppColors.indigo : AppColors.border),
            ),
            child: Text(o, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: selected == o ? Colors.white : AppColors.textSecondary)),
          ),
        )),
      ],
    );
  }
}

class _TH extends StatelessWidget {
  final String label;
  const _TH(this.label);
  @override
  Widget build(BuildContext context) {
    return Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.4));
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final bool mono;
  const _InfoRow({required this.icon, required this.label, required this.value, this.mono = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.textMuted),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontFamily: mono ? 'monospace' : null)),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label, value;
  final Color color;
  const _StatBox({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withOpacity(0.15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: color, letterSpacing: -0.5)),
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

class _MiniTag extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? iconColor;
  const _MiniTag({required this.label, required this.icon, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 10, color: iconColor ?? AppColors.textMuted),
        const SizedBox(width: 3),
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) => const Divider(height: 1, color: AppColors.border);
}

String _formatDate(DateTime dt) {
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
}