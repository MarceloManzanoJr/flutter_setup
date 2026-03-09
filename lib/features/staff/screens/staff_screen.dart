import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  RE-USING DESIGN TOKENS (same as dashboard)
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
enum StaffStatus { online, busy, offline, onBreak }

class PrintJob {
  final String jobId;
  final String fileName;
  final double progressPercent; // 0–100
  final String material;
  final String estimatedEnd; // e.g. "~1h 20m"

  const PrintJob({
    required this.jobId,
    required this.fileName,
    required this.progressPercent,
    required this.material,
    required this.estimatedEnd,
  });
}

class StaffMember {
  final String id;
  final String name;
  final String role;
  final StaffStatus status;
  final String assignedPrinter;
  final PrintJob? activeJob;
  final int jobsToday;
  final int jobsApproved;
  final int jobsRejected;
  final String lastActivity;
  final String avatarInitials;
  final Color avatarColor;
  final List<String> recentActivityLog;

  const StaffMember({
    required this.id,
    required this.name,
    required this.role,
    required this.status,
    required this.assignedPrinter,
    this.activeJob,
    required this.jobsToday,
    required this.jobsApproved,
    required this.jobsRejected,
    required this.lastActivity,
    required this.avatarInitials,
    required this.avatarColor,
    required this.recentActivityLog,
  });
}

class ActivityEvent {
  final String staffName;
  final String action;
  final String time;
  final IconData icon;
  final Color color;

  const ActivityEvent({
    required this.staffName,
    required this.action,
    required this.time,
    required this.icon,
    required this.color,
  });
}

// ─────────────────────────────────────────────
//  SAMPLE DATA
// ─────────────────────────────────────────────
final List<StaffMember> _sampleStaff = [
  StaffMember(
    id: 'STF-001',
    name: 'Mike Johnson',
    role: 'Senior Operator',
    status: StaffStatus.busy,
    assignedPrinter: 'Printer A3 · Bambu X1',
    activeJob: const PrintJob(
      jobId: 'JOB-884',
      fileName: 'bracket_v3_final.stl',
      progressPercent: 67,
      material: 'PLA · Black',
      estimatedEnd: '~1h 20m',
    ),
    jobsToday: 8,
    jobsApproved: 7,
    jobsRejected: 1,
    lastActivity: '3 min ago',
    avatarInitials: 'MJ',
    avatarColor: AppColors.indigo,
    recentActivityLog: [
      'Approved JOB-883 · PLA enclosure print',
      'Started print on Printer A3',
      'Rejected JOB-879 · file corrupted',
    ],
  ),
  StaffMember(
    id: 'STF-002',
    name: 'Sarah Wilson',
    role: 'Print Technician',
    status: StaffStatus.online,
    assignedPrinter: 'Printer B1 · Prusa MK4',
    activeJob: const PrintJob(
      jobId: 'JOB-891',
      fileName: 'phone_stand_v2.stl',
      progressPercent: 22,
      material: 'PETG · Clear',
      estimatedEnd: '~3h 05m',
    ),
    jobsToday: 6,
    jobsApproved: 6,
    jobsRejected: 0,
    lastActivity: '1 min ago',
    avatarInitials: 'SW',
    avatarColor: AppColors.violet,
    recentActivityLog: [
      'Approved JOB-891 · phone stand print',
      'Loaded PETG filament on B1',
      'Completed JOB-887 · drone arm',
    ],
  ),
  StaffMember(
    id: 'STF-003',
    name: 'David Chen',
    role: 'Quality Inspector',
    status: StaffStatus.online,
    assignedPrinter: 'Printer C2 · Creality K1',
    activeJob: null,
    jobsToday: 5,
    jobsApproved: 4,
    jobsRejected: 1,
    lastActivity: '12 min ago',
    avatarInitials: 'DC',
    avatarColor: AppColors.sky,
    recentActivityLog: [
      'Flagged JOB-880 for re-print · warping',
      'Approved JOB-878 · passed QC',
      'Idle — waiting for next job',
    ],
  ),
  StaffMember(
    id: 'STF-004',
    name: 'Lisa Garcia',
    role: 'Print Technician',
    status: StaffStatus.onBreak,
    assignedPrinter: 'Printer D4 · Bambu P1S',
    activeJob: null,
    jobsToday: 4,
    jobsApproved: 4,
    jobsRejected: 0,
    lastActivity: '28 min ago',
    avatarInitials: 'LG',
    avatarColor: AppColors.emerald,
    recentActivityLog: [
      'On break',
      'Completed JOB-872 · cosplay helmet part',
      'Swapped filament on D4 · PLA White',
    ],
  ),
  StaffMember(
    id: 'STF-005',
    name: 'Alex Turner',
    role: 'Junior Operator',
    status: StaffStatus.offline,
    assignedPrinter: 'Unassigned',
    activeJob: null,
    jobsToday: 0,
    jobsApproved: 0,
    jobsRejected: 0,
    lastActivity: '4 hrs ago',
    avatarInitials: 'AT',
    avatarColor: AppColors.amber,
    recentActivityLog: [
      'Logged out',
      'Completed shift',
    ],
  ),
  StaffMember(
    id: 'STF-006',
    name: 'Nina Patel',
    role: 'Senior Operator',
    status: StaffStatus.busy,
    assignedPrinter: 'Printer E1 · Voron 2.4',
    activeJob: const PrintJob(
      jobId: 'JOB-895',
      fileName: 'industrial_clamp.stl',
      progressPercent: 89,
      material: 'ABS · Grey',
      estimatedEnd: '~18m',
    ),
    jobsToday: 9,
    jobsApproved: 8,
    jobsRejected: 1,
    lastActivity: 'Just now',
    avatarInitials: 'NP',
    avatarColor: AppColors.rose,
    recentActivityLog: [
      'Print at 89% on Printer E1',
      'Approved JOB-894 · ABS enclosure',
      'Approved JOB-892 · custom bracket',
    ],
  ),
];

final List<ActivityEvent> _activityFeed = [
  ActivityEvent(staffName: 'Nina Patel', action: 'Print JOB-895 at 89% — almost done', time: 'just now', icon: Icons.print_rounded, color: AppColors.indigo),
  ActivityEvent(staffName: 'Sarah Wilson', action: 'Loaded PETG filament on Printer B1', time: '1m ago', icon: Icons.cable_rounded, color: AppColors.sky),
  ActivityEvent(staffName: 'Mike Johnson', action: 'Approved request REQ-884', time: '3m ago', icon: Icons.check_circle_rounded, color: AppColors.emerald),
  ActivityEvent(staffName: 'David Chen', action: 'Flagged JOB-880 — warping detected', time: '12m ago', icon: Icons.flag_rounded, color: AppColors.amber),
  ActivityEvent(staffName: 'Lisa Garcia', action: 'Went on break', time: '28m ago', icon: Icons.coffee_rounded, color: AppColors.textMuted),
  ActivityEvent(staffName: 'Mike Johnson', action: 'Rejected REQ-879 — corrupted file', time: '34m ago', icon: Icons.cancel_rounded, color: AppColors.rose),
  ActivityEvent(staffName: 'Sarah Wilson', action: 'Completed JOB-887 — drone arm', time: '41m ago', icon: Icons.task_alt_rounded, color: AppColors.emerald),
  ActivityEvent(staffName: 'Nina Patel', action: 'Approved JOB-892 — custom bracket', time: '55m ago', icon: Icons.check_circle_rounded, color: AppColors.emerald),
];

// ─────────────────────────────────────────────
//  SCREEN
// ─────────────────────────────────────────────
class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  String _filter = 'All';
  String _searchQuery = '';
  StaffMember? _selectedStaff;

  static const _filters = ['All', 'Online', 'Busy', 'On Break', 'Offline'];

  List<StaffMember> get _filtered {
    return _sampleStaff.where((s) {
      final matchesFilter = _filter == 'All' ||
          (_filter == 'Online' && s.status == StaffStatus.online) ||
          (_filter == 'Busy' && s.status == StaffStatus.busy) ||
          (_filter == 'On Break' && s.status == StaffStatus.onBreak) ||
          (_filter == 'Offline' && s.status == StaffStatus.offline);
      final matchesSearch = _searchQuery.isEmpty ||
          s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          s.role.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main content
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 32, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildStatusSummaryRow(),
                  const SizedBox(height: 20),
                  _buildSearchAndFilter(),
                  const SizedBox(height: 20),
                  _buildStaffGrid(),
                ],
              ),
            ),
          ),
          // Activity sidebar
          Container(
            width: 300,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(left: BorderSide(color: AppColors.border)),
            ),
            child: _buildActivityFeed(),
          ),
        ],
      ),
    );
  }

  // ── HEADER ──────────────────────────────────
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
                    'Staff Monitor',
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
                  'Real-time staff activity across all 3D printers',
                  style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
        _buildHeaderBadge(
          icon: Icons.circle,
          label: '${_sampleStaff.where((s) => s.status != StaffStatus.offline).length} Active',
          color: AppColors.emerald,
        ),
      ],
    );
  }

  Widget _buildHeaderBadge({required IconData icon, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 10),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 13)),
        ],
      ),
    );
  }

  // ── STATUS SUMMARY ───────────────────────────
  Widget _buildStatusSummaryRow() {
    final counts = {
      StaffStatus.online: _sampleStaff.where((s) => s.status == StaffStatus.online).length,
      StaffStatus.busy: _sampleStaff.where((s) => s.status == StaffStatus.busy).length,
      StaffStatus.onBreak: _sampleStaff.where((s) => s.status == StaffStatus.onBreak).length,
      StaffStatus.offline: _sampleStaff.where((s) => s.status == StaffStatus.offline).length,
    };
    final totalJobs = _sampleStaff.fold(0, (sum, s) => sum + s.jobsToday);
    final totalApproved = _sampleStaff.fold(0, (sum, s) => sum + s.jobsApproved);

    return Row(
      children: [
        _MiniStat(label: 'Online', value: counts[StaffStatus.online].toString(), color: AppColors.emerald, icon: Icons.wifi_rounded),
        const SizedBox(width: 12),
        _MiniStat(label: 'Printing', value: counts[StaffStatus.busy].toString(), color: AppColors.indigo, icon: Icons.print_rounded),
        const SizedBox(width: 12),
        _MiniStat(label: 'On Break', value: counts[StaffStatus.onBreak].toString(), color: AppColors.amber, icon: Icons.coffee_rounded),
        const SizedBox(width: 12),
        _MiniStat(label: 'Offline', value: counts[StaffStatus.offline].toString(), color: AppColors.textMuted, icon: Icons.wifi_off_rounded),
        const SizedBox(width: 12),
        _MiniStat(label: "Jobs Today", value: totalJobs.toString(), color: AppColors.violet, icon: Icons.layers_rounded),
        const SizedBox(width: 12),
        _MiniStat(label: "Approval Rate", value: totalJobs > 0 ? '${(totalApproved / totalJobs * 100).toStringAsFixed(0)}%' : '—', color: AppColors.sky, icon: Icons.thumb_up_rounded),
      ],
    );
  }

  // ── SEARCH & FILTER ──────────────────────────
  Widget _buildSearchAndFilter() {
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
                hintText: 'Search staff by name or role…',
                hintStyle: TextStyle(fontSize: 13, color: AppColors.textMuted),
                prefixIcon: Icon(Icons.search_rounded, size: 18, color: AppColors.textMuted),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Filter chips
        ...(_filters.map((f) => Padding(
          padding: const EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () => setState(() => _filter = f),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: _filter == f ? AppColors.indigo : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _filter == f ? AppColors.indigo : AppColors.border,
                ),
              ),
              child: Text(
                f,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _filter == f ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ))),
      ],
    );
  }

  // ── STAFF GRID ───────────────────────────────
  Widget _buildStaffGrid() {
    final staff = _filtered;
    if (staff.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            children: [
              Icon(Icons.people_outline_rounded, size: 48, color: AppColors.textMuted.withOpacity(0.5)),
              const SizedBox(height: 12),
              const Text('No staff match your filter', style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
            ],
          ),
        ),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.35,
      ),
      itemCount: staff.length,
      itemBuilder: (_, i) => _StaffCard(
        member: staff[i],
        isSelected: _selectedStaff?.id == staff[i].id,
        onTap: () => setState(() {
          _selectedStaff = _selectedStaff?.id == staff[i].id ? null : staff[i];
        }),
      ),
    );
  }

  // ── ACTIVITY FEED ────────────────────────────
  Widget _buildActivityFeed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 16),
          child: Row(
            children: [
              const Text('Live Activity', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: AppColors.emerald, shape: BoxShape.circle),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: AppColors.border),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: _activityFeed.length,
            separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.border, indent: 20, endIndent: 20),
            itemBuilder: (_, i) {
              final event = _activityFeed[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: event.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(event.icon, size: 14, color: event.color),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.staffName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                          const SizedBox(height: 2),
                          Text(event.action, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
                          const SizedBox(height: 4),
                          Text(event.time, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  STAFF CARD
// ─────────────────────────────────────────────
class _StaffCard extends StatelessWidget {
  final StaffMember member;
  final bool isSelected;
  final VoidCallback onTap;

  const _StaffCard({required this.member, required this.isSelected, required this.onTap});

  static ({Color color, Color light, String label, IconData icon}) _statusMeta(StaffStatus s) {
    switch (s) {
      case StaffStatus.online:
        return (color: AppColors.emerald, light: AppColors.emeraldLight, label: 'Online', icon: Icons.wifi_rounded);
      case StaffStatus.busy:
        return (color: AppColors.indigo, light: AppColors.indigoLight, label: 'Printing', icon: Icons.print_rounded);
      case StaffStatus.onBreak:
        return (color: AppColors.amber, light: AppColors.amberLight, label: 'On Break', icon: Icons.coffee_rounded);
      case StaffStatus.offline:
        return (color: AppColors.textMuted, light: const Color(0xFFF1F5F9), label: 'Offline', icon: Icons.wifi_off_rounded);
    }
  }

  @override
  Widget build(BuildContext context) {
    final meta = _statusMeta(member.status);
    final isOffline = member.status == StaffStatus.offline;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.indigo : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.indigo.withOpacity(0.1)
                  : Colors.black.withOpacity(0.04),
              blurRadius: isSelected ? 20 : 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: avatar + status
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: isOffline
                          ? const Color(0xFFF1F5F9)
                          : member.avatarColor.withOpacity(0.15),
                      child: Text(
                        member.avatarInitials,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: isOffline ? AppColors.textMuted : member.avatarColor,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: meta.color,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
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
                      Text(
                        member.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        member.role,
                        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: meta.light,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Icon(meta.icon, size: 11, color: meta.color),
                      const SizedBox(width: 4),
                      Text(meta.label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: meta.color)),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Printer assignment
            Row(
              children: [
                Icon(Icons.precision_manufacturing_rounded, size: 13, color: AppColors.textMuted),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    member.assignedPrinter,
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Active job or idle state
            if (member.activeJob != null)
              _ActiveJobWidget(job: member.activeJob!)
            else
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.bg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      isOffline ? Icons.power_off_rounded : Icons.hourglass_empty_rounded,
                      size: 13,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isOffline ? 'Not available' : 'Idle — no active job',
                      style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),

            const Spacer(),

            // Footer stats
            Row(
              children: [
                _MicroStat(value: member.jobsToday.toString(), label: 'today', color: AppColors.indigo),
                const SizedBox(width: 10),
                _MicroStat(value: member.jobsApproved.toString(), label: 'approved', color: AppColors.emerald),
                const SizedBox(width: 10),
                _MicroStat(value: member.jobsRejected.toString(), label: 'rejected', color: AppColors.rose),
                const Spacer(),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded, size: 11, color: AppColors.textMuted),
                    const SizedBox(width: 3),
                    Text(member.lastActivity, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  ACTIVE JOB WIDGET (print progress)
// ─────────────────────────────────────────────
class _ActiveJobWidget extends StatelessWidget {
  final PrintJob job;
  const _ActiveJobWidget({required this.job});

  @override
  Widget build(BuildContext context) {
    final pct = job.progressPercent / 100;
    final color = pct < 0.4 ? AppColors.sky : pct < 0.75 ? AppColors.indigo : AppColors.emerald;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(4)),
                child: Icon(Icons.print_rounded, size: 11, color: color),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  job.fileName,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontFamily: 'monospace'),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${job.progressPercent.toInt()}%',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: color),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: color.withOpacity(0.12),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 5,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              _JobTag(label: job.material, icon: Icons.layers_rounded, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              _JobTag(label: job.estimatedEnd, icon: Icons.timer_rounded, color: color),
            ],
          ),
        ],
      ),
    );
  }
}

class _JobTag extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _JobTag({required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 10, color: color),
        const SizedBox(width: 3),
        Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  MICRO COMPONENTS
// ─────────────────────────────────────────────
class _MiniStat extends StatelessWidget {
  final String label, value;
  final Color color;
  final IconData icon;
  const _MiniStat({required this.label, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(7)),
              child: Icon(icon, size: 14, color: color),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color, letterSpacing: -0.4)),
                Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MicroStat extends StatelessWidget {
  final String value, label;
  final Color color;
  const _MicroStat({required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: color)),
        const SizedBox(width: 3),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
      ],
    );
  }
}