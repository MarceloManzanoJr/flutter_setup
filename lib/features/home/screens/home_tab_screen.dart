import 'package:flutter/material.dart';
import 'dart:math' as math;

//part na ito ay design token
class AppColors {
  // Base
  static const bg = Color(0xFFF4F6FB);
  static const surface = Colors.white;
  static const border = Color(0xFFE8ECF4);

  // Brand
  static const indigo = Color(0xFF4F46E5);
  static const indigoLight = Color(0xFFEEF2FF);
  static const indigoDark = Color(0xFF3730A3);

  // Status
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

  // Text
  static const textPrimary = Color(0xFF0F172A);
  static const textSecondary = Color(0xFF64748B);
  static const textMuted = Color(0xFF94A3B8);
}

class AppText {
  static const displayLg = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
    color: AppColors.textPrimary,
    height: 1.2,
  );
  static const titleMd = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    color: AppColors.textPrimary,
  );
  static const labelSm = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    color: AppColors.textSecondary,
  );
  static const mono = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
}

//data model to sya
class RequestSummary {
  final String id;
  final String user;
  final String staff;
  final String status;
  final DateTime submittedDate;

  const RequestSummary({
    required this.id,
    required this.user,
    required this.staff,
    required this.status,
    required this.submittedDate,
  });
}

class StaffPerformance {
  final String name;
  final int approved;
  final int rejected;
  final int pending;

  const StaffPerformance({
    required this.name,
    required this.approved,
    required this.rejected,
    required this.pending,
  });
}

// main dashboard screen
class AdminHomeDashboard extends StatefulWidget {
  const AdminHomeDashboard({super.key});

  @override
  State<AdminHomeDashboard> createState() => _AdminHomeDashboardState();
}

class _AdminHomeDashboardState extends State<AdminHomeDashboard> {
  final List<RequestSummary> _recentRequests = [
    RequestSummary(id: 'REQ-001', user: 'John Doe', staff: 'Mike Johnson', status: 'Pending', submittedDate: DateTime.now().subtract(const Duration(hours: 2))),
    RequestSummary(id: 'REQ-002', user: 'Jane Smith', staff: 'Sarah Wilson', status: 'Approved', submittedDate: DateTime.now().subtract(const Duration(hours: 5))),
    RequestSummary(id: 'REQ-003', user: 'Robert Brown', staff: 'Mike Johnson', status: 'Rejected', submittedDate: DateTime.now().subtract(const Duration(hours: 8))),
    RequestSummary(id: 'REQ-004', user: 'Emily Davis', staff: 'Unassigned', status: 'Pending', submittedDate: DateTime.now().subtract(const Duration(hours: 12))),
    RequestSummary(id: 'REQ-005', user: 'Michael Lee', staff: 'Sarah Wilson', status: 'Approved', submittedDate: DateTime.now().subtract(const Duration(hours: 24))),
  ];

  final List<StaffPerformance> _staffPerformance = [
    const StaffPerformance(name: 'Mike Johnson', approved: 45, rejected: 8, pending: 12),
    const StaffPerformance(name: 'Sarah Wilson', approved: 52, rejected: 5, pending: 8),
    const StaffPerformance(name: 'David Chen', approved: 38, rejected: 10, pending: 15),
    const StaffPerformance(name: 'Lisa Garcia', approved: 41, rejected: 6, pending: 9),
  ];

  List<RequestSummary> get _delayedRequests {
    final now = DateTime.now();
    return _recentRequests.where((r) {
      if (r.status == 'Pending') {
        return now.difference(r.submittedDate).inHours >= 24;
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(28, 32, 28, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 28),
            _buildSummaryCards(),
            const SizedBox(height: 28),
            _buildStaffPerformanceTable(),
            const SizedBox(height: 28),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildRecentRequests()),
                const SizedBox(width: 20),
                Expanded(flex: 2, child: _buildDelayedRequests()),
              ],
            ),
            const SizedBox(height: 28),
            _buildAnalyticsSection(),
          ],
        ),
      ),
    );
  }

  // header ito
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
                  const Text('Dashboard Overview', style: AppText.displayLg),
                ],
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Monitor system activity and staff performance in real-time',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildHeaderAction(),
      ],
    );
  }

  Widget _buildHeaderAction() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.indigo, AppColors.indigoDark]),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.indigo.withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: const [
          Icon(Icons.download_rounded, color: Colors.white, size: 16),
          SizedBox(width: 8),
          Text('Export Report', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
        ],
      ),
    );
  }

  // ito yong summary cards baka makalimutan ko
  Widget _buildSummaryCards() {
    final cards = [
      _CardData('Total Requests', '1,284', Icons.assignment_rounded, AppColors.indigo, AppColors.indigoLight, '+12% from last week', true),
      _CardData('Pending', '48', Icons.hourglass_top_rounded, AppColors.amber, AppColors.amberLight, '12 need attention', false),
      _CardData('Approved', '1,024', Icons.check_circle_rounded, AppColors.emerald, AppColors.emeraldLight, '82% approval rate', true),
      _CardData('Rejected', '212', Icons.cancel_rounded, AppColors.rose, AppColors.roseLight, '18% rejection rate', false),
      _CardData('Active Staff', '12', Icons.people_alt_rounded, AppColors.violet, AppColors.violetLight, '4 currently offline', false),
    ];

    return Row(
      children: cards.map((card) {
        final isLast = card == cards.last;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : 16),
            child: _SummaryCard(data: card),
          ),
        );
      }).toList(),
    );
  }

  // ito yong staff performance table baka makalimutan ko
  Widget _buildStaffPerformanceTable() {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Staff Performance', style: AppText.titleMd),
              _Chip(label: 'Last 7 days', color: AppColors.indigo),
            ],
          ),
          const SizedBox(height: 20),
          // yong header row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Expanded(flex: 3, child: _TableHeader('Staff Member')),
                Expanded(flex: 2, child: _TableHeader('Approved')),
                Expanded(flex: 2, child: _TableHeader('Rejected')),
                Expanded(flex: 2, child: _TableHeader('Pending')),
                Expanded(flex: 2, child: _TableHeader('Total')),
                Expanded(flex: 3, child: _TableHeader('Performance')),
              ],
            ),
          ),
          const SizedBox(height: 4),
          ..._staffPerformance.asMap().entries.map((e) => _StaffRow(staff: e.value, index: e.key)),
        ],
      ),
    );
  }

  // ito yong recent requests baka makalimutan ko
  Widget _buildRecentRequests() {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent Requests', style: AppText.titleMd),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.indigo,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  backgroundColor: AppColors.indigoLight,
                ),
                child: const Text('View All', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._recentRequests.take(5).map((r) => _RequestRow(request: r)),
        ],
      ),
    );
  }

  // ito yong delayed requests baka makalimutan ko
  Widget _buildDelayedRequests() {
    final delayed = _delayedRequests;
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.amberLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.warning_amber_rounded, color: AppColors.amber, size: 18),
              ),
              const SizedBox(width: 10),
              const Text('Delayed Requests', style: AppText.titleMd),
              const SizedBox(width: 8),
              if (delayed.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.rose, borderRadius: BorderRadius.circular(20)),
                  child: Text(delayed.length.toString(), style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (delayed.isEmpty)
            _EmptyState(icon: Icons.check_circle_rounded, color: AppColors.emerald, label: 'All caught up!')
          else
            ...delayed.map((r) {
              final hours = DateTime.now().difference(r.submittedDate).inHours;
              return _DelayedRow(request: r, hoursDelayed: hours);
            }),
        ],
      ),
    );
  }

  // ito yong analytics baka makalimutan ko
  Widget _buildAnalyticsSection() {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Request Analytics', style: AppText.titleMd),
              _Chip(label: 'This week', color: AppColors.sky),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _AnalyticStat(label: 'Daily Avg', value: '24', color: AppColors.indigo, icon: Icons.bar_chart_rounded)),
              const SizedBox(width: 12),
              Expanded(child: _AnalyticStat(label: 'Approval Rate', value: '78%', color: AppColors.emerald, icon: Icons.thumb_up_rounded)),
              const SizedBox(width: 12),
              Expanded(child: _AnalyticStat(label: 'Rejection Rate', value: '12%', color: AppColors.rose, icon: Icons.thumb_down_rounded)),
              const SizedBox(width: 12),
              Expanded(child: _AnalyticStat(label: 'Avg Response', value: '3.5h', color: AppColors.amber, icon: Icons.timer_rounded)),
            ],
          ),
          const SizedBox(height: 28),
          const Text('Daily Volume', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          _WeeklyBarChart(),
        ],
      ),
    );
  }
}


class _CardData {
  final String title, value, subtitle;
  final IconData icon;
  final Color color, lightColor;
  final bool positive;

  const _CardData(this.title, this.value, this.icon, this.color, this.lightColor, this.subtitle, this.positive);
}

class _SummaryCard extends StatelessWidget {
  final _CardData data;
  const _SummaryCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: data.lightColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(data.icon, color: data.color, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: data.positive ? AppColors.emeraldLight : AppColors.roseLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  data.positive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                  size: 14,
                  color: data.positive ? AppColors.emerald : AppColors.rose,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            data.value,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: -0.8),
          ),
          const SizedBox(height: 2),
          Text(data.title, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: data.lightColor, borderRadius: BorderRadius.circular(6)),
            child: Text(data.subtitle, style: TextStyle(fontSize: 11, color: data.color, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  final Widget child;
  const _Panel({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  const _Chip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}

class _TableHeader extends StatelessWidget {
  final String label;
  const _TableHeader(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(label, style: AppText.labelSm.copyWith(color: AppColors.textMuted, letterSpacing: 0.5));
  }
}

class _StaffRow extends StatelessWidget {
  final StaffPerformance staff;
  final int index;
  const _StaffRow({required this.staff, required this.index});

  @override
  Widget build(BuildContext context) {
    final total = staff.approved + staff.rejected;
    final perf = total > 0 ? (staff.approved / total * 100) : 0.0;
    final perfColor = perf >= 80 ? AppColors.emerald : perf >= 50 ? AppColors.amber : AppColors.rose;

    const avatarColors = [AppColors.indigo, AppColors.violet, AppColors.sky, AppColors.emerald];
    final avatarColor = avatarColors[index % avatarColors.length];

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: index.isEven ? Colors.white : AppColors.bg.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: avatarColor.withOpacity(0.15),
                  child: Text(
                    staff.name[0],
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: avatarColor),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(staff.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textPrimary)),
                    Text('${staff.approved + staff.rejected + staff.pending} assigned', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(flex: 2, child: _StatBadge(value: staff.approved, color: AppColors.emerald, light: AppColors.emeraldLight)),
          Expanded(flex: 2, child: _StatBadge(value: staff.rejected, color: AppColors.rose, light: AppColors.roseLight)),
          Expanded(flex: 2, child: _StatBadge(value: staff.pending, color: AppColors.amber, light: AppColors.amberLight)),
          Expanded(
            flex: 2,
            child: Text(total.toString(), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textPrimary)),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${perf.toStringAsFixed(1)}%',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: perfColor),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      perf >= 80 ? Icons.trending_up_rounded : perf >= 50 ? Icons.trending_flat_rounded : Icons.trending_down_rounded,
                      color: perfColor,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: perf / 100,
                    backgroundColor: perfColor.withOpacity(0.12),
                    valueColor: AlwaysStoppedAnimation<Color>(perfColor),
                    minHeight: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final int value;
  final Color color, light;
  const _StatBadge({required this.value, required this.color, required this.light});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: light, borderRadius: BorderRadius.circular(8)),
      child: Text(value.toString(), style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 13)),
    );
  }
}

class _RequestRow extends StatelessWidget {
  final RequestSummary request;
  const _RequestRow({required this.request});

  static Color _statusColor(String s) {
    switch (s.toLowerCase()) {
      case 'approved': return AppColors.emerald;
      case 'rejected': return AppColors.rose;
      default: return AppColors.amber;
    }
  }

  static Color _statusLight(String s) {
    switch (s.toLowerCase()) {
      case 'approved': return AppColors.emeraldLight;
      case 'rejected': return AppColors.roseLight;
      default: return AppColors.amberLight;
    }
  }

  static IconData _statusIcon(String s) {
    switch (s.toLowerCase()) {
      case 'approved': return Icons.check_circle_rounded;
      case 'rejected': return Icons.cancel_rounded;
      default: return Icons.hourglass_top_rounded;
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
    final color = _statusColor(request.status);
    final light = _statusLight(request.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: light, borderRadius: BorderRadius.circular(10)),
            child: Icon(_statusIcon(request.status), color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(request.id, style: AppText.mono.copyWith(color: AppColors.textPrimary)),
                    const SizedBox(width: 8),
                    Text(_timeAgo(request.submittedDate), style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  ],
                ),
                const SizedBox(height: 3),
                Text('${request.user}  ·  ${request.staff}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: light, borderRadius: BorderRadius.circular(8)),
            child: Text(request.status, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _DelayedRow extends StatelessWidget {
  final RequestSummary request;
  final int hoursDelayed;
  const _DelayedRow({required this.request, required this.hoursDelayed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.amberLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.amber.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: AppColors.amber.withOpacity(0.2), shape: BoxShape.circle),
            child: Center(
              child: Text(
                '${hoursDelayed}h',
                style: const TextStyle(color: AppColors.amber, fontSize: 11, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(request.id, style: AppText.mono.copyWith(color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Text(request.user, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  const _EmptyState({required this.icon, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _AnalyticStat extends StatelessWidget {
  final String label, value;
  final Color color;
  final IconData icon;
  const _AnalyticStat({required this.label, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: color, letterSpacing: -0.5)),
              Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeeklyBarChart extends StatelessWidget {
  final List<({String day, double value})> data = const [
    (day: 'Mon', value: 45),
    (day: 'Tue', value: 52),
    (day: 'Wed', value: 38),
    (day: 'Thu', value: 65),
    (day: 'Fri', value: 42),
    (day: 'Sat', value: 28),
    (day: 'Sun', value: 20),
  ];

  @override
  Widget build(BuildContext context) {
    final maxValue = data.map((e) => e.value).reduce(math.max);
    final today = DateTime.now().weekday; // full isang bwan to

    return SizedBox(
      height: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: data.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          final isToday = (i + 1) == today;
          final height = math.max(8.0, (item.value / maxValue) * 90);

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isToday)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: AppColors.indigo,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(item.value.toInt().toString(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                ),
              Container(
                width: 32,
                height: height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: isToday
                        ? [AppColors.indigo, AppColors.violet]
                        : [AppColors.indigo.withOpacity(0.3), AppColors.indigo.withOpacity(0.5)],
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.day,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                  color: isToday ? AppColors.indigo : AppColors.textMuted,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}