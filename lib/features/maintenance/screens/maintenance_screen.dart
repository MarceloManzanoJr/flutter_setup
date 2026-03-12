import 'package:flutter/material.dart';
import 'package:innolab_application/features/App_schedule_store.dart';

// ─────────────────────────────────────────────
//  DESIGN TOKENS
// ─────────────────────────────────────────────
class _C {
  static const bg = Color(0xFFF4F6FB);
  static const surface = Colors.white;
  static const border = Color(0xFFE8ECF4);
  static const indigo = Color(0xFF4F46E5);
  static const indigoLight = Color(0xFFEEF2FF);
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
  static const slate = Color(0xFF64748B);
  static const slateLight = Color(0xFFF1F5F9);
  static const textPrimary = Color(0xFF0F172A);
  static const textSecondary = Color(0xFF64748B);
  static const textMuted = Color(0xFF94A3B8);
}

// ─────────────────────────────────────────────
//  ENUMS & MODELS
// ─────────────────────────────────────────────
enum MachineStatus { operational, idle, underMaintenance, broken }
enum MachineType { printer3D, laserCutter, cnc, resinPrinter, slsPrinter, postProcessing }
enum IssuePriority { critical, high, medium, low }
enum IssueStatus { pending, inProgress, fixed }
enum ScheduleStatus { upcoming, inProgress, completed, overdue }

class Machine {
  final String id, name, model, location;
  final MachineType type;
  final MachineStatus status;
  final DateTime lastMaintenance;
  final DateTime nextMaintenance;
  final String assignedTech;
  final double uptimePercent;
  final int totalJobs;
  final String? currentJob;
  const Machine({
    required this.id, required this.name, required this.model,
    required this.location, required this.type, required this.status,
    required this.lastMaintenance, required this.nextMaintenance,
    required this.assignedTech, required this.uptimePercent,
    required this.totalJobs, this.currentJob,
  });
}

class MaintenanceLog {
  final String id, machineId, machineName, issue, workDone, technician;
  final DateTime date;
  final List<String> partsUsed;
  final Duration downtime;
  final double cost;
  const MaintenanceLog({
    required this.id, required this.machineId, required this.machineName,
    required this.issue, required this.workDone, required this.technician,
    required this.date, required this.partsUsed,
    required this.downtime, required this.cost,
  });
}

class ScheduledTask {
  final String id, machineId, machineName, taskName, assignedTo, notes;
  final DateTime scheduledDate;
  final ScheduleStatus status;
  final Duration estimatedDuration;
  const ScheduledTask({
    required this.id, required this.machineId, required this.machineName,
    required this.taskName, required this.assignedTo,
    required this.scheduledDate, required this.status,
    required this.estimatedDuration, required this.notes,
  });
}

class ReportedIssue {
  final String id, machineId, machineName, description, reportedBy;
  final IssuePriority priority;
  final IssueStatus status;
  final DateTime reportedAt;
  final String? assignedTo;
  const ReportedIssue({
    required this.id, required this.machineId, required this.machineName,
    required this.description, required this.reportedBy,
    required this.priority, required this.status,
    required this.reportedAt, this.assignedTo,
  });
}

// ─────────────────────────────────────────────
//  SAMPLE DATA
// ─────────────────────────────────────────────
final List<Machine> _machines = [
  Machine(id: 'MCH-001', name: 'Bambu X1 Carbon', model: 'Bambu Lab X1C', location: 'Bay A1', type: MachineType.printer3D, status: MachineStatus.operational, lastMaintenance: DateTime.now().subtract(const Duration(days: 14)), nextMaintenance: DateTime.now().add(const Duration(days: 16)), assignedTech: 'Mike Johnson', uptimePercent: 96.2, totalJobs: 312, currentJob: 'JOB-895'),
  Machine(id: 'MCH-002', name: 'Prusa MK4', model: 'Prusa Research MK4', location: 'Bay A2', type: MachineType.printer3D, status: MachineStatus.idle, lastMaintenance: DateTime.now().subtract(const Duration(days: 7)), nextMaintenance: DateTime.now().add(const Duration(days: 23)), assignedTech: 'Sarah Wilson', uptimePercent: 91.5, totalJobs: 248),
  Machine(id: 'MCH-003', name: 'Creality K1 Max', model: 'Creality K1 Max', location: 'Bay A3', type: MachineType.printer3D, status: MachineStatus.underMaintenance, lastMaintenance: DateTime.now().subtract(const Duration(days: 1)), nextMaintenance: DateTime.now().add(const Duration(days: 29)), assignedTech: 'David Chen', uptimePercent: 78.4, totalJobs: 189),
  Machine(id: 'MCH-004', name: 'Voron 2.4 R2', model: 'Voron Design 2.4', location: 'Bay B1', type: MachineType.printer3D, status: MachineStatus.operational, lastMaintenance: DateTime.now().subtract(const Duration(days: 21)), nextMaintenance: DateTime.now().add(const Duration(days: 9)), assignedTech: 'Nina Patel', uptimePercent: 94.1, totalJobs: 276, currentJob: 'JOB-891'),
  Machine(id: 'MCH-005', name: 'Elegoo Saturn 4', model: 'Elegoo Saturn 4 Ultra', location: 'Bay C1', type: MachineType.resinPrinter, status: MachineStatus.idle, lastMaintenance: DateTime.now().subtract(const Duration(days: 5)), nextMaintenance: DateTime.now().add(const Duration(days: 25)), assignedTech: 'Lisa Garcia', uptimePercent: 88.7, totalJobs: 145),
  Machine(id: 'MCH-006', name: 'Sinterit Lisa Pro', model: 'Sinterit Lisa Pro SLS', location: 'Vault C2', type: MachineType.slsPrinter, status: MachineStatus.broken, lastMaintenance: DateTime.now().subtract(const Duration(days: 3)), nextMaintenance: DateTime.now().subtract(const Duration(days: 1)), assignedTech: 'David Chen', uptimePercent: 62.0, totalJobs: 88),
  Machine(id: 'MCH-007', name: 'xTool D1 Pro', model: 'xTool D1 Pro 20W', location: 'Bay D1', type: MachineType.laserCutter, status: MachineStatus.operational, lastMaintenance: DateTime.now().subtract(const Duration(days: 10)), nextMaintenance: DateTime.now().add(const Duration(days: 20)), assignedTech: 'Mike Johnson', uptimePercent: 97.3, totalJobs: 203),
  Machine(id: 'MCH-008', name: 'Bambu P1S', model: 'Bambu Lab P1S', location: 'Bay A4', type: MachineType.printer3D, status: MachineStatus.operational, lastMaintenance: DateTime.now().subtract(const Duration(days: 18)), nextMaintenance: DateTime.now().add(const Duration(days: 12)), assignedTech: 'Sarah Wilson', uptimePercent: 93.8, totalJobs: 198, currentJob: 'JOB-884'),
];

final List<MaintenanceLog> _logs = [
  MaintenanceLog(id: 'LOG-001', machineId: 'MCH-003', machineName: 'Creality K1 Max', issue: 'Extruder clogging — repeated under-extrusion at layer 40+', workDone: 'Replaced brass nozzle 0.4mm, cold-pull cleaning, re-calibrated e-steps', technician: 'David Chen', date: DateTime.now().subtract(const Duration(days: 1)), partsUsed: ['Brass Nozzle 0.4mm', 'PTFE Tube 300mm'], downtime: const Duration(hours: 3), cost: 285),
  MaintenanceLog(id: 'LOG-002', machineId: 'MCH-001', machineName: 'Bambu X1 Carbon', issue: 'AMS filament feed error — sensor trigger false positives', workDone: 'Cleaned filament sensors, updated firmware to v1.8.2, recalibrated AMS hub', technician: 'Mike Johnson', date: DateTime.now().subtract(const Duration(days: 14)), partsUsed: [], downtime: const Duration(minutes: 90), cost: 0),
  MaintenanceLog(id: 'LOG-003', machineId: 'MCH-006', machineName: 'Sinterit Lisa Pro', issue: 'Laser module temperature sensor fault — print aborted mid-job', workDone: 'Replaced temperature sensor unit, ran diagnostic cycle, thermal recalibration', technician: 'David Chen', date: DateTime.now().subtract(const Duration(days: 3)), partsUsed: ['Temp Sensor Module (SLS)', 'Thermal Paste'], downtime: const Duration(hours: 8), cost: 3400),
  MaintenanceLog(id: 'LOG-004', machineId: 'MCH-004', machineName: 'Voron 2.4 R2', issue: 'Z-axis skipping steps intermittently on tall prints', workDone: 'Tightened Z-axis coupler, lubricated lead screw, tuned motor current via Klipper', technician: 'Nina Patel', date: DateTime.now().subtract(const Duration(days: 21)), partsUsed: ['Lubricant (PTFE)'], downtime: const Duration(hours: 2), cost: 120),
  MaintenanceLog(id: 'LOG-005', machineId: 'MCH-002', machineName: 'Prusa MK4', issue: 'Bed adhesion failures — PEI surface worn out', workDone: 'Replaced PEI build plate, full first-layer calibration', technician: 'Sarah Wilson', date: DateTime.now().subtract(const Duration(days: 7)), partsUsed: ['Build Plate PEI Sheet'], downtime: const Duration(minutes: 45), cost: 890),
  MaintenanceLog(id: 'LOG-006', machineId: 'MCH-005', machineName: 'Elegoo Saturn 4', issue: 'FEP film scratched — print releasing from FEP instead of plate', workDone: 'Replaced FEP film, resin vat cleaning with IPA, exposure recalibration', technician: 'Lisa Garcia', date: DateTime.now().subtract(const Duration(days: 5)), partsUsed: ['FEP Film 200x280mm', 'Isopropyl Alcohol 99%'], downtime: const Duration(hours: 1, minutes: 30), cost: 560),
];

final List<ScheduledTask> _schedule = [
  ScheduledTask(id: 'SCH-001', machineId: 'MCH-004', machineName: 'Voron 2.4 R2', taskName: 'Preventive — Full lubrication & belt tension check', assignedTo: 'Nina Patel', scheduledDate: DateTime.now().add(const Duration(days: 9)), status: ScheduleStatus.upcoming, estimatedDuration: const Duration(hours: 2), notes: 'Check all axis belts, lubricate lead screws, inspect hotend'),
  ScheduledTask(id: 'SCH-002', machineId: 'MCH-001', machineName: 'Bambu X1 Carbon', taskName: 'Preventive — AMS cleaning & nozzle inspection', assignedTo: 'Mike Johnson', scheduledDate: DateTime.now().add(const Duration(days: 16)), status: ScheduleStatus.upcoming, estimatedDuration: const Duration(hours: 1), notes: 'Deep clean AMS hub, inspect hardened nozzle wear'),
  ScheduledTask(id: 'SCH-003', machineId: 'MCH-006', machineName: 'Sinterit Lisa Pro', taskName: 'Corrective — Laser module replacement & full recal', assignedTo: 'David Chen', scheduledDate: DateTime.now().add(const Duration(days: 2)), status: ScheduleStatus.inProgress, estimatedDuration: const Duration(hours: 6), notes: 'Awaiting laser module part delivery from Sinterit. ETA 2 days'),
  ScheduledTask(id: 'SCH-004', machineId: 'MCH-008', machineName: 'Bambu P1S', taskName: 'Preventive — Hotend & extruder gear inspection', assignedTo: 'Sarah Wilson', scheduledDate: DateTime.now().add(const Duration(days: 12)), status: ScheduleStatus.upcoming, estimatedDuration: const Duration(minutes: 90), notes: 'Inspect extruder gear wear, clean hotend heatsink'),
  ScheduledTask(id: 'SCH-005', machineId: 'MCH-006', machineName: 'Sinterit Lisa Pro', taskName: 'Preventive — Powder chamber seal & filter replacement', assignedTo: 'David Chen', scheduledDate: DateTime.now().subtract(const Duration(days: 1)), status: ScheduleStatus.overdue, estimatedDuration: const Duration(hours: 3), notes: 'OVERDUE — machine is currently broken, reschedule after repair'),
  ScheduledTask(id: 'SCH-006', machineId: 'MCH-007', machineName: 'xTool D1 Pro', taskName: 'Preventive — Lens cleaning & rail alignment', assignedTo: 'Mike Johnson', scheduledDate: DateTime.now().add(const Duration(days: 20)), status: ScheduleStatus.upcoming, estimatedDuration: const Duration(minutes: 60), notes: 'Clean laser lens, check gantry squareness'),
];

final List<ReportedIssue> _issues = [
  ReportedIssue(id: 'ISS-001', machineId: 'MCH-006', machineName: 'Sinterit Lisa Pro', description: 'Machine stopped mid-print. Display shows TEMP_SENSOR_ERR. Print bed not heating.', reportedBy: 'Nina Patel', priority: IssuePriority.critical, status: IssueStatus.inProgress, reportedAt: DateTime.now().subtract(const Duration(days: 3)), assignedTo: 'David Chen'),
  ReportedIssue(id: 'ISS-002', machineId: 'MCH-003', machineName: 'Creality K1 Max', description: 'Extruder makes clicking noise and filament grinds. Print quality poor after layer 30.', reportedBy: 'John Doe', priority: IssuePriority.high, status: IssueStatus.inProgress, reportedAt: DateTime.now().subtract(const Duration(days: 1)), assignedTo: 'David Chen'),
  ReportedIssue(id: 'ISS-003', machineId: 'MCH-002', machineName: 'Prusa MK4', description: 'First layer not sticking. Tried re-leveling but issue persists. Wasted 3 prints.', reportedBy: 'Emily Davis', priority: IssuePriority.medium, status: IssueStatus.fixed, reportedAt: DateTime.now().subtract(const Duration(days: 7)), assignedTo: 'Sarah Wilson'),
  ReportedIssue(id: 'ISS-004', machineId: 'MCH-001', machineName: 'Bambu X1 Carbon', description: 'AMS showing filament run-out error even with full spool. Print pauses unexpectedly.', reportedBy: 'Michael Lee', priority: IssuePriority.medium, status: IssueStatus.fixed, reportedAt: DateTime.now().subtract(const Duration(days: 14)), assignedTo: 'Mike Johnson'),
  ReportedIssue(id: 'ISS-005', machineId: 'MCH-005', machineName: 'Elegoo Saturn 4', description: 'Prints releasing from FEP film rather than build plate. FEP may be cloudy.', reportedBy: 'Jane Smith', priority: IssuePriority.high, status: IssueStatus.fixed, reportedAt: DateTime.now().subtract(const Duration(days: 5)), assignedTo: 'Lisa Garcia'),
  ReportedIssue(id: 'ISS-006', machineId: 'MCH-007', machineName: 'xTool D1 Pro', description: 'Laser power seems weaker than usual. Cuts not going through 3mm acrylic cleanly.', reportedBy: 'Robert Brown', priority: IssuePriority.low, status: IssueStatus.pending, reportedAt: DateTime.now().subtract(const Duration(hours: 4)), assignedTo: null),
];

// ─────────────────────────────────────────────
//  MAIN SCREEN
// ─────────────────────────────────────────────
class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});
  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  Machine? _selectedMachine;

  final _tabs = const [
    Tab(text: 'Machines'),
    Tab(text: 'Schedule'),
    Tab(text: 'History'),
    Tab(text: 'Issues'),
    Tab(text: 'Analytics'),
  ];

  // Merge the hardcoded list with any tasks pushed from ScheduleScreen
  List<ScheduledTask> get _mergedSchedule {
    final storeItems = AppScheduleStore.instance.tasks.map((t) {
      final s = switch (t.status) {
        SharedTaskStatus.upcoming  => ScheduleStatus.upcoming,
        SharedTaskStatus.inProgress => ScheduleStatus.inProgress,
        SharedTaskStatus.completed => ScheduleStatus.completed,
        SharedTaskStatus.canceled  => ScheduleStatus.completed,
        SharedTaskStatus.overdue   => ScheduleStatus.overdue,
      };
      return ScheduledTask(
        id: t.id,
        machineId: t.machineId,
        machineName: t.machineName,
        taskName: t.title,
        assignedTo: t.assignedTo,
        scheduledDate: t.scheduledDate,
        status: s,
        estimatedDuration: t.estimatedDuration,
        notes: t.notes,
      );
    }).toList();

    // Deduplicate: store items override hardcoded items with same ID
    final hardcoded = _schedule.where(
      (h) => !storeItems.any((s) => s.id == h.id),
    ).toList();

    return [...hardcoded, ...storeItems];
  }

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 5, vsync: this);
    _tab.addListener(() => setState(() {}));
    // Rebuild whenever a maintenance event is added/changed from ScheduleScreen
    AppScheduleStore.instance.addListener(_onStoreChanged);
  }

  void _onStoreChanged() => setState(() {});

  @override
  void dispose() {
    _tab.dispose();
    AppScheduleStore.instance.removeListener(_onStoreChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final schedule = _mergedSchedule;
    return Scaffold(
      backgroundColor: _C.bg,
      body: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── TOP HEADER ──
                Container(
                  color: _C.surface,
                  padding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 20),
                      _buildTopStats(),
                      const SizedBox(height: 20),
                      TabBar(
                        controller: _tab,
                        isScrollable: true,
                        labelColor: _C.indigo,
                        unselectedLabelColor: _C.textMuted,
                        labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                        indicatorColor: _C.indigo,
                        indicatorWeight: 2.5,
                        indicatorSize: TabBarIndicatorSize.label,
                        dividerColor: _C.border,
                        tabs: [
                          _TabItem(label: 'Machines', count: _machines.length, tab: _tabs[0]),
                          _TabItem(label: 'Schedule', count: schedule.where((s) => s.status != ScheduleStatus.completed).length, tab: _tabs[1]),
                          _TabItem(label: 'History', count: _logs.length, tab: _tabs[2]),
                          _TabItem(label: 'Issues', count: _issues.where((i) => i.status != IssueStatus.fixed).length, tab: _tabs[3], alertCount: _issues.where((i) => i.priority == IssuePriority.critical && i.status != IssueStatus.fixed).length),
                          _tabs[4],
                        ],
                      ),
                    ],
                  ),
                ),
                // ── TAB BODY ──
                Expanded(
                  child: TabBarView(
                    controller: _tab,
                    children: [
                      _MachinesTab(
                        machines: _machines,
                        selectedMachine: _selectedMachine,
                        onSelect: (m) => setState(() => _selectedMachine = _selectedMachine?.id == m.id ? null : m),
                      ),
                      _ScheduleTab(tasks: schedule),
                      _HistoryTab(logs: _logs),
                      _IssuesTab(issues: _issues),
                      _AnalyticsTab(machines: _machines, logs: _logs, issues: _issues),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ── MACHINE DETAIL PANEL ──
          if (_selectedMachine != null && _tab.index == 0)
            _MachineDetailPanel(
              machine: _selectedMachine!,
              logs: _logs.where((l) => l.machineId == _selectedMachine!.id).toList(),
              issues: _issues.where((i) => i.machineId == _selectedMachine!.id).toList(),
              schedule: _schedule.where((s) => s.machineId == _selectedMachine!.id).toList(),
              onClose: () => setState(() => _selectedMachine = null),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: 6, height: 32,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [_C.indigo, _C.violet],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 14),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Maintenance', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: -0.6, color: _C.textPrimary)),
                  Text('Equipment health, schedules and reported faults', style: TextStyle(fontSize: 13, color: _C.textSecondary)),
                ],
              ),
            ],
          ),
        ),
        if (_issues.any((i) => i.priority == IssuePriority.critical && i.status != IssueStatus.fixed))
          _PillBadge(label: '${_issues.where((i) => i.priority == IssuePriority.critical && i.status != IssueStatus.fixed).length} Critical Issues', color: _C.rose, light: _C.roseLight, icon: Icons.error_rounded),
        const SizedBox(width: 8),
        if (_schedule.any((s) => s.status == ScheduleStatus.overdue))
          _PillBadge(label: 'Overdue Tasks', color: _C.amber, light: _C.amberLight, icon: Icons.schedule_rounded),
      ],
    );
  }

  Widget _buildTopStats() {
    final operational = _machines.where((m) => m.status == MachineStatus.operational).length;
    final idle = _machines.where((m) => m.status == MachineStatus.idle).length;
    final maint = _machines.where((m) => m.status == MachineStatus.underMaintenance).length;
    final broken = _machines.where((m) => m.status == MachineStatus.broken).length;
    final openIssues = _issues.where((i) => i.status != IssueStatus.fixed).length;
    final overdueTasks = _schedule.where((s) => s.status == ScheduleStatus.overdue).length;

    return Row(
      children: [
        _StatChip(label: 'Operational', value: operational.toString(), color: _C.emerald, icon: Icons.check_circle_rounded),
        const SizedBox(width: 10),
        _StatChip(label: 'Idle', value: idle.toString(), color: _C.slate, icon: Icons.pause_circle_rounded),
        const SizedBox(width: 10),
        _StatChip(label: 'Under Maint.', value: maint.toString(), color: _C.amber, icon: Icons.build_rounded),
        const SizedBox(width: 10),
        _StatChip(label: 'Broken', value: broken.toString(), color: _C.rose, icon: Icons.error_rounded),
        const SizedBox(width: 10),
        _StatChip(label: 'Open Issues', value: openIssues.toString(), color: _C.violet, icon: Icons.report_rounded),
        const SizedBox(width: 10),
        _StatChip(label: 'Overdue', value: overdueTasks.toString(), color: _C.amber, icon: Icons.warning_rounded),
        const Spacer(),
        Text('${_machines.length} total machines', style: const TextStyle(fontSize: 12, color: _C.textMuted, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 1 — MACHINES
// ─────────────────────────────────────────────
class _MachinesTab extends StatelessWidget {
  final List<Machine> machines;
  final Machine? selectedMachine;
  final ValueChanged<Machine> onSelect;

  const _MachinesTab({required this.machines, required this.selectedMachine, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 40),
      child: Column(
        children: [
          // Table header
          _TableBox(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: const BoxDecoration(color: _C.bg, borderRadius: BorderRadius.vertical(top: Radius.circular(14))),
                  child: Row(children: const [
                    Expanded(flex: 3, child: _TH('Machine')),
                    Expanded(flex: 2, child: _TH('Type')),
                    Expanded(flex: 2, child: _TH('Location')),
                    Expanded(flex: 2, child: _TH('Status')),
                    Expanded(flex: 2, child: _TH('Last Maintenance')),
                    Expanded(flex: 2, child: _TH('Next Maintenance')),
                    Expanded(flex: 2, child: _TH('Technician')),
                    Expanded(flex: 2, child: _TH('Uptime')),
                  ]),
                ),
                const Divider(height: 1, color: _C.border),
                ...machines.asMap().entries.map((e) => _MachineRow(
                  machine: e.value,
                  isEven: e.key.isEven,
                  isSelected: selectedMachine?.id == e.value.id,
                  onTap: () => onSelect(e.value),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MachineRow extends StatelessWidget {
  final Machine machine;
  final bool isEven, isSelected;
  final VoidCallback onTap;
  const _MachineRow({required this.machine, required this.isEven, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final sm = _statusMeta(machine.status);
    final nextIsOverdue = machine.nextMaintenance.isBefore(DateTime.now());
    final nextDays = machine.nextMaintenance.difference(DateTime.now()).inDays;
    final nextColor = nextIsOverdue ? _C.rose : nextDays <= 7 ? _C.amber : _C.textSecondary;

    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? _C.indigoLight : isEven ? Colors.white : const Color(0xFFFAFBFD),
          border: Border(left: BorderSide(color: isSelected ? _C.indigo : Colors.transparent, width: 3)),
        ),
        child: Row(
          children: [
            // Machine name
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(machine.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.textPrimary)),
                  Text('${machine.id}  ·  ${machine.model}', style: const TextStyle(fontSize: 11, color: _C.textMuted)),
                  if (machine.currentJob != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Row(
                        children: [
                          Container(width: 5, height: 5, margin: const EdgeInsets.only(right: 4), decoration: const BoxDecoration(color: _C.emerald, shape: BoxShape.circle)),
                          Text(machine.currentJob!, style: const TextStyle(fontSize: 10, color: _C.emerald, fontFamily: 'monospace', fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            // Type
            Expanded(flex: 2, child: _TypeBadge(type: machine.type)),
            // Location
            Expanded(
              flex: 2,
              child: Row(children: [
                const Icon(Icons.place_rounded, size: 12, color: _C.textMuted),
                const SizedBox(width: 4),
                Text(machine.location, style: const TextStyle(fontSize: 12, color: _C.textSecondary)),
              ]),
            ),
            // Status
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(color: sm.light, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 6, height: 6, margin: const EdgeInsets.only(right: 5), decoration: BoxDecoration(color: sm.color, shape: BoxShape.circle)),
                    Text(sm.label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: sm.color)),
                  ],
                ),
              ),
            ),
            // Last maint
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_daysAgo(machine.lastMaintenance), style: const TextStyle(fontSize: 12, color: _C.textSecondary)),
                  Text(_fmtDate(machine.lastMaintenance), style: const TextStyle(fontSize: 10, color: _C.textMuted)),
                ],
              ),
            ),
            // Next maint
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nextIsOverdue ? 'Overdue!' : 'In ${nextDays}d', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: nextColor)),
                  Text(_fmtDate(machine.nextMaintenance), style: const TextStyle(fontSize: 10, color: _C.textMuted)),
                ],
              ),
            ),
            // Technician
            Expanded(
              flex: 2,
              child: Row(children: [
                _Avatar(name: machine.assignedTech, size: 22, color: _C.indigo),
                const SizedBox(width: 7),
                Expanded(child: Text(machine.assignedTech, style: const TextStyle(fontSize: 12, color: _C.textSecondary), overflow: TextOverflow.ellipsis)),
              ]),
            ),
            // Uptime
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${machine.uptimePercent}%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: machine.uptimePercent >= 90 ? _C.emerald : machine.uptimePercent >= 75 ? _C.amber : _C.rose)),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: machine.uptimePercent / 100,
                      backgroundColor: _C.border,
                      valueColor: AlwaysStoppedAnimation(machine.uptimePercent >= 90 ? _C.emerald : machine.uptimePercent >= 75 ? _C.amber : _C.rose),
                      minHeight: 4,
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

// ─────────────────────────────────────────────
//  TAB 2 — SCHEDULE
// ─────────────────────────────────────────────
class _ScheduleTab extends StatelessWidget {
  final List<ScheduledTask> tasks;
  const _ScheduleTab({required this.tasks});

  @override
  Widget build(BuildContext context) {
    final overdue = tasks.where((t) => t.status == ScheduleStatus.overdue).toList();
    final upcoming = tasks.where((t) => t.status == ScheduleStatus.upcoming).toList();
    final inProgress = tasks.where((t) => t.status == ScheduleStatus.inProgress).toList();
    final completed = tasks.where((t) => t.status == ScheduleStatus.completed).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (overdue.isNotEmpty) ...[
            _SectionLabel(label: 'Overdue', icon: Icons.warning_rounded, color: _C.rose),
            const SizedBox(height: 8),
            ...overdue.map((t) => _ScheduleCard(task: t)),
            const SizedBox(height: 20),
          ],
          if (inProgress.isNotEmpty) ...[
            _SectionLabel(label: 'In Progress', icon: Icons.build_rounded, color: _C.amber),
            const SizedBox(height: 8),
            ...inProgress.map((t) => _ScheduleCard(task: t)),
            const SizedBox(height: 20),
          ],
          _SectionLabel(label: 'Upcoming', icon: Icons.calendar_today_rounded, color: _C.indigo),
          const SizedBox(height: 8),
          ...upcoming.map((t) => _ScheduleCard(task: t)),
          if (completed.isNotEmpty) ...[
            const SizedBox(height: 20),
            _SectionLabel(label: 'Completed', icon: Icons.check_circle_rounded, color: _C.emerald),
            const SizedBox(height: 8),
            ...completed.map((t) => _ScheduleCard(task: t)),
          ],
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  final ScheduledTask task;
  const _ScheduleCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final sm = _scheduleMeta(task.status);
    final daysUntil = task.scheduledDate.difference(DateTime.now()).inDays;
    final isOverdue = task.status == ScheduleStatus.overdue;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isOverdue ? _C.rose.withOpacity(0.3) : _C.border),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          // Date block
          Container(
            width: 56, padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: sm.light, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Text(_monthShort(task.scheduledDate), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: sm.color, letterSpacing: 0.5)),
                Text('${task.scheduledDate.day}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: sm.color, letterSpacing: -0.5)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(task.taskName, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.textPrimary))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: sm.light, borderRadius: BorderRadius.circular(7)),
                      child: Text(sm.label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: sm.color)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.precision_manufacturing_rounded, size: 12, color: _C.textMuted),
                    const SizedBox(width: 4),
                    Text(task.machineName, style: const TextStyle(fontSize: 12, color: _C.textSecondary)),
                    const SizedBox(width: 12),
                    const Icon(Icons.person_rounded, size: 12, color: _C.textMuted),
                    const SizedBox(width: 4),
                    Text(task.assignedTo, style: const TextStyle(fontSize: 12, color: _C.textSecondary)),
                    const SizedBox(width: 12),
                    const Icon(Icons.timer_rounded, size: 12, color: _C.textMuted),
                    const SizedBox(width: 4),
                    Text(_formatDuration(task.estimatedDuration), style: const TextStyle(fontSize: 12, color: _C.textSecondary)),
                  ],
                ),
                if (task.notes.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(task.notes, style: const TextStyle(fontSize: 11, color: _C.textMuted, fontStyle: FontStyle.italic)),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            isOverdue ? 'Overdue!' : daysUntil == 0 ? 'Today' : 'In ${daysUntil}d',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: sm.color),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 3 — HISTORY
// ─────────────────────────────────────────────
class _HistoryTab extends StatelessWidget {
  final List<MaintenanceLog> logs;
  const _HistoryTab({required this.logs});

  @override
  Widget build(BuildContext context) {
    final sorted = [...logs]..sort((a, b) => b.date.compareTo(a.date));
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sorted.map((log) => _LogCard(log: log)).toList(),
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  final MaintenanceLog log;
  const _LogCard({required this.log});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _C.border),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          // Card header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: _C.indigoLight, borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.build_circle_rounded, color: _C.indigo, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(log.machineName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _C.textPrimary)),
                          const SizedBox(width: 8),
                          Text(log.machineId, style: const TextStyle(fontSize: 11, color: _C.textMuted, fontFamily: 'monospace')),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(log.issue, style: const TextStyle(fontSize: 13, color: _C.textSecondary)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(_fmtDate(log.date), style: const TextStyle(fontSize: 12, color: _C.textMuted)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.person_rounded, size: 12, color: _C.textMuted),
                        const SizedBox(width: 4),
                        Text(log.technician, style: const TextStyle(fontSize: 12, color: _C.textSecondary, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Work done + meta
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: BoxDecoration(
              color: _C.bg,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              border: const Border(top: BorderSide(color: _C.border)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Work Done', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _C.textMuted, letterSpacing: 0.4)),
                const SizedBox(height: 4),
                Text(log.workDone, style: const TextStyle(fontSize: 12, color: _C.textPrimary, height: 1.5)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _LogMeta(icon: Icons.timer_rounded, label: 'Downtime', value: _formatDuration(log.downtime)),
                    const SizedBox(width: 20),
                    _LogMeta(icon: Icons.payments_rounded, label: 'Cost', value: '₱${log.cost.toStringAsFixed(0)}', valueColor: _C.violet),
                    if (log.partsUsed.isNotEmpty) ...[
                      const SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.inventory_2_rounded, size: 12, color: _C.textMuted),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                log.partsUsed.join(', '),
                                style: const TextStyle(fontSize: 11, color: _C.textSecondary),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 4 — ISSUES
// ─────────────────────────────────────────────
class _IssuesTab extends StatelessWidget {
  final List<ReportedIssue> issues;
  const _IssuesTab({required this.issues});

  @override
  Widget build(BuildContext context) {
    final sorted = [...issues]..sort((a, b) {
      const order = [IssueStatus.inProgress, IssueStatus.pending, IssueStatus.fixed];
      final si = order.indexOf(a.status);
      final sb = order.indexOf(b.status);
      if (si != sb) return si.compareTo(sb);
      const po = [IssuePriority.critical, IssuePriority.high, IssuePriority.medium, IssuePriority.low];
      return po.indexOf(a.priority).compareTo(po.indexOf(b.priority));
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 40),
      child: Column(
        children: sorted.map((i) => _IssueCard(issue: i)).toList(),
      ),
    );
  }
}

class _IssueCard extends StatelessWidget {
  final ReportedIssue issue;
  const _IssueCard({required this.issue});

  @override
  Widget build(BuildContext context) {
    final pm = _priorityMeta(issue.priority);
    final sm = _issueStatusMeta(issue.status);
    final isFixed = issue.status == IssueStatus.fixed;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isFixed ? _C.border : pm.color.withOpacity(0.25)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Priority indicator
          Container(
            width: 4, height: 60,
            decoration: BoxDecoration(color: isFixed ? _C.border : pm.color, borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(color: pm.light, borderRadius: BorderRadius.circular(6)),
                      child: Text(pm.label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: pm.color)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(color: sm.light, borderRadius: BorderRadius.circular(6)),
                      child: Text(sm.label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: sm.color)),
                    ),
                    const Spacer(),
                    Text(_timeAgo(issue.reportedAt), style: const TextStyle(fontSize: 11, color: _C.textMuted)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(issue.machineName, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.textPrimary)),
                    const SizedBox(width: 6),
                    Text(issue.machineId, style: const TextStyle(fontSize: 11, color: _C.textMuted, fontFamily: 'monospace')),
                  ],
                ),
                const SizedBox(height: 4),
                Text(issue.description, style: const TextStyle(fontSize: 12, color: _C.textSecondary, height: 1.5)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.person_outline_rounded, size: 12, color: _C.textMuted),
                    const SizedBox(width: 4),
                    Text('Reported by ${issue.reportedBy}', style: const TextStyle(fontSize: 11, color: _C.textMuted)),
                    if (issue.assignedTo != null) ...[
                      const SizedBox(width: 12),
                      const Icon(Icons.engineering_rounded, size: 12, color: _C.indigo),
                      const SizedBox(width: 4),
                      Text('Assigned: ${issue.assignedTo}', style: const TextStyle(fontSize: 11, color: _C.indigo, fontWeight: FontWeight.w600)),
                    ] else ...[
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: _C.amberLight, borderRadius: BorderRadius.circular(5)),
                        child: const Text('Unassigned', style: TextStyle(fontSize: 10, color: _C.amber, fontWeight: FontWeight.w600)),
                      ),
                    ],
                    const Spacer(),
                    Text(issue.id, style: const TextStyle(fontSize: 11, color: _C.textMuted, fontFamily: 'monospace')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 5 — ANALYTICS
// ─────────────────────────────────────────────
class _AnalyticsTab extends StatelessWidget {
  final List<Machine> machines;
  final List<MaintenanceLog> logs;
  final List<ReportedIssue> issues;
  const _AnalyticsTab({required this.machines, required this.logs, required this.issues});

  @override
  Widget build(BuildContext context) {
    final totalCost = logs.fold(0.0, (s, l) => s + l.cost);
    final totalDowntime = logs.fold(Duration.zero, (s, l) => s + l.downtime);
    final avgUptime = machines.fold(0.0, (s, m) => s + m.uptimePercent) / machines.length;
    final fixedIssues = issues.where((i) => i.status == IssueStatus.fixed).length;

    // Issues per machine count
    final issueCount = <String, int>{};
    for (final i in issues) issueCount[i.machineName] = (issueCount[i.machineName] ?? 0) + 1;
    final sorted = issueCount.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KPI row
          Row(
            children: [
              _AnalyticKPI(label: 'Total Maint. Cost', value: '₱${totalCost.toStringAsFixed(0)}', color: _C.violet, icon: Icons.payments_rounded),
              const SizedBox(width: 14),
              _AnalyticKPI(label: 'Total Downtime', value: '${totalDowntime.inHours}h ${totalDowntime.inMinutes % 60}m', color: _C.rose, icon: Icons.timer_off_rounded),
              const SizedBox(width: 14),
              _AnalyticKPI(label: 'Avg Fleet Uptime', value: '${avgUptime.toStringAsFixed(1)}%', color: _C.emerald, icon: Icons.trending_up_rounded),
              const SizedBox(width: 14),
              _AnalyticKPI(label: 'Issues Resolved', value: '$fixedIssues / ${issues.length}', color: _C.sky, icon: Icons.task_alt_rounded),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Uptime per machine
              Expanded(
                flex: 3,
                child: _Panel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _PanelTitle(title: 'Machine Uptime', subtitle: 'All time'),
                      const SizedBox(height: 16),
                      ...machines.map((m) {
                        final color = m.uptimePercent >= 90 ? _C.emerald : m.uptimePercent >= 75 ? _C.amber : _C.rose;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  _StatusDot(color: _statusMeta(m.status).color),
                                  const SizedBox(width: 6),
                                  Expanded(child: Text(m.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _C.textPrimary))),
                                  Text('${m.uptimePercent}%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: m.uptimePercent / 100,
                                  backgroundColor: color.withOpacity(0.1),
                                  valueColor: AlwaysStoppedAnimation(color),
                                  minHeight: 6,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Most issues per machine
              Expanded(
                flex: 2,
                child: _Panel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _PanelTitle(title: 'Issues by Machine', subtitle: 'All reported'),
                      const SizedBox(height: 16),
                      ...sorted.map((e) {
                        final maxV = sorted.first.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(e.key, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _C.textPrimary), overflow: TextOverflow.ellipsis)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(color: e.value >= 2 ? _C.roseLight : _C.amberLight, borderRadius: BorderRadius.circular(6)),
                                    child: Text('${e.value}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: e.value >= 2 ? _C.rose : _C.amber)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: e.value / maxV,
                                  backgroundColor: _C.roseLight,
                                  valueColor: const AlwaysStoppedAnimation(_C.rose),
                                  minHeight: 6,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Maintenance cost breakdown
              Expanded(
                flex: 2,
                child: _Panel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _PanelTitle(title: 'Maintenance Cost', subtitle: 'Per activity'),
                      const SizedBox(height: 16),
                      ...logs.map((l) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(l.machineName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _C.textPrimary)),
                                  Text(_fmtDate(l.date), style: const TextStyle(fontSize: 10, color: _C.textMuted)),
                                ],
                              ),
                            ),
                            Text('₱${l.cost.toStringAsFixed(0)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.violet, fontFamily: 'monospace')),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Status distribution
              Expanded(
                flex: 3,
                child: _Panel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _PanelTitle(title: 'Fleet Status Distribution', subtitle: 'Right now'),
                      const SizedBox(height: 16),
                      ...[MachineStatus.operational, MachineStatus.idle, MachineStatus.underMaintenance, MachineStatus.broken].map((s) {
                        final count = machines.where((m) => m.status == s).length;
                        final pct = count / machines.length;
                        final sm = _statusMeta(s);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(color: sm.light, borderRadius: BorderRadius.circular(7)),
                                child: Text(sm.label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: sm.color)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: pct,
                                    backgroundColor: sm.color.withOpacity(0.1),
                                    valueColor: AlwaysStoppedAnimation(sm.color),
                                    minHeight: 10,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text('$count', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: sm.color)),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  MACHINE DETAIL PANEL
// ─────────────────────────────────────────────
class _MachineDetailPanel extends StatelessWidget {
  final Machine machine;
  final List<MaintenanceLog> logs;
  final List<ReportedIssue> issues;
  final List<ScheduledTask> schedule;
  final VoidCallback onClose;

  const _MachineDetailPanel({
    required this.machine, required this.logs,
    required this.issues, required this.schedule, required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final sm = _statusMeta(machine.status);
    return Container(
      width: 340,
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      decoration: const BoxDecoration(
        color: _C.surface,
        border: Border(left: BorderSide(color: _C.border)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Machine Detail', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _C.textPrimary)),
                const Spacer(),
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: _C.bg, borderRadius: BorderRadius.circular(8), border: Border.all(color: _C.border)),
                    child: const Icon(Icons.close_rounded, size: 16, color: _C.textSecondary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Machine header block
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: _C.bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: _C.border)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: sm.light, borderRadius: BorderRadius.circular(10)),
                        child: Icon(_typeIcon(machine.type), color: sm.color, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(machine.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _C.textPrimary)),
                            Text(machine.model, style: const TextStyle(fontSize: 11, color: _C.textMuted)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: sm.light, borderRadius: BorderRadius.circular(7)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _StatusDot(color: sm.color),
                            const SizedBox(width: 5),
                            Text(sm.label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: sm.color)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      _TypeBadge(type: machine.type),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Info rows
            _DetailRow(icon: Icons.place_rounded, label: 'Location', value: machine.location),
            _DetailRow(icon: Icons.badge_rounded, label: 'Machine ID', value: machine.id, mono: true),
            _DetailRow(icon: Icons.person_rounded, label: 'Technician', value: machine.assignedTech),
            _DetailRow(icon: Icons.layers_rounded, label: 'Total Jobs', value: machine.totalJobs.toString()),
            if (machine.currentJob != null)
              _DetailRow(icon: Icons.print_rounded, label: 'Active Job', value: machine.currentJob!, mono: true, valueColor: _C.emerald),
            const SizedBox(height: 4),
            // Uptime
            Row(
              children: [
                const Icon(Icons.speed_rounded, size: 13, color: _C.textMuted),
                const SizedBox(width: 8),
                const Text('Uptime', style: TextStyle(fontSize: 12, color: _C.textSecondary)),
                const Spacer(),
                Text('${machine.uptimePercent}%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: machine.uptimePercent >= 90 ? _C.emerald : _C.amber)),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: machine.uptimePercent / 100,
                backgroundColor: _C.border,
                valueColor: AlwaysStoppedAnimation(machine.uptimePercent >= 90 ? _C.emerald : _C.amber),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: _C.border),
            const SizedBox(height: 14),
            // Maintenance dates
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: _C.bg, borderRadius: BorderRadius.circular(10), border: Border.all(color: _C.border)),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.history_rounded, size: 13, color: _C.textMuted),
                      const SizedBox(width: 6),
                      const Text('Last Maintenance', style: TextStyle(fontSize: 12, color: _C.textSecondary)),
                      const Spacer(),
                      Text(_daysAgo(machine.lastMaintenance), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _C.textPrimary)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.event_rounded, size: 13, color: _C.textMuted),
                      const SizedBox(width: 6),
                      const Text('Next Maintenance', style: TextStyle(fontSize: 12, color: _C.textSecondary)),
                      const Spacer(),
                      Text(
                        machine.nextMaintenance.isBefore(DateTime.now()) ? 'OVERDUE' : 'In ${machine.nextMaintenance.difference(DateTime.now()).inDays}d',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
                          color: machine.nextMaintenance.isBefore(DateTime.now()) ? _C.rose :
                            machine.nextMaintenance.difference(DateTime.now()).inDays <= 7 ? _C.amber : _C.emerald),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (logs.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(height: 1, color: _C.border),
              const SizedBox(height: 14),
              const Text('Maintenance History', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.textPrimary)),
              const SizedBox(height: 10),
              ...logs.map((l) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: _C.bg, borderRadius: BorderRadius.circular(10), border: Border.all(color: _C.border)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(l.issue, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _C.textPrimary), overflow: TextOverflow.ellipsis),
                        const Spacer(),
                        Text(_fmtDate(l.date), style: const TextStyle(fontSize: 10, color: _C.textMuted)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(l.workDone, style: const TextStyle(fontSize: 11, color: _C.textSecondary, height: 1.4)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _MiniMeta(icon: Icons.timer_rounded, value: _formatDuration(l.downtime)),
                        const SizedBox(width: 10),
                        _MiniMeta(icon: Icons.payments_rounded, value: '₱${l.cost.toStringAsFixed(0)}', color: _C.violet),
                      ],
                    ),
                  ],
                ),
              )),
            ],
            if (issues.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(height: 1, color: _C.border),
              const SizedBox(height: 14),
              const Text('Reported Issues', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.textPrimary)),
              const SizedBox(height: 10),
              ...issues.map((i) {
                final pm = _priorityMeta(i.priority);
                final sm2 = _issueStatusMeta(i.status);
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: _C.bg, borderRadius: BorderRadius.circular(10), border: Border.all(color: pm.color.withOpacity(0.2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: pm.light, borderRadius: BorderRadius.circular(5)),
                            child: Text(pm.label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: pm.color)),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: sm2.light, borderRadius: BorderRadius.circular(5)),
                            child: Text(sm2.label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: sm2.color)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(i.description, style: const TextStyle(fontSize: 11, color: _C.textSecondary, height: 1.4)),
                    ],
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  HELPER WIDGETS
// ─────────────────────────────────────────────
class _TableBox extends StatelessWidget {
  final Widget child;
  const _TableBox({required this.child});
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: _C.border),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 14, offset: const Offset(0, 4))]),
    child: child,
  );
}

class _Panel extends StatelessWidget {
  final Widget child;
  const _Panel({required this.child});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: _C.border),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 3))]),
    child: child,
  );
}

class _PanelTitle extends StatelessWidget {
  final String title, subtitle;
  const _PanelTitle({required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _C.textPrimary)),
      Text(subtitle, style: const TextStyle(fontSize: 11, color: _C.textMuted)),
    ],
  );
}

class _TH extends StatelessWidget {
  final String label;
  const _TH(this.label);
  @override
  Widget build(BuildContext context) => Text(label,
    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _C.textMuted, letterSpacing: 0.4));
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _SectionLabel({required this.label, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, size: 14, color: color),
      const SizedBox(width: 6),
      Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
    ],
  );
}

class _StatChip extends StatelessWidget {
  final String label, value;
  final Color color;
  final IconData icon;
  const _StatChip({required this.label, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withOpacity(0.15))),
    child: Row(
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 6),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: color)),
        const SizedBox(width: 5),
        Text(label, style: TextStyle(fontSize: 11, color: color.withOpacity(0.8))),
      ],
    ),
  );
}

class _PillBadge extends StatelessWidget {
  final String label;
  final Color color, light;
  final IconData icon;
  const _PillBadge({required this.label, required this.color, required this.light, required this.icon});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(color: light, borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withOpacity(0.25))),
    child: Row(children: [
      Icon(icon, size: 13, color: color),
      const SizedBox(width: 6),
      Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
    ]),
  );
}

class _TypeBadge extends StatelessWidget {
  final MachineType type;
  const _TypeBadge({required this.type});
  @override
  Widget build(BuildContext context) {
    final data = switch (type) {
      MachineType.printer3D => (label: 'FDM Printer', color: _C.indigo, light: _C.indigoLight),
      MachineType.resinPrinter => (label: 'Resin/MSLA', color: _C.violet, light: _C.violetLight),
      MachineType.slsPrinter => (label: 'SLS Printer', color: _C.amber, light: _C.amberLight),
      MachineType.laserCutter => (label: 'Laser Cutter', color: _C.rose, light: _C.roseLight),
      MachineType.cnc => (label: 'CNC Machine', color: _C.sky, light: _C.skyLight),
      MachineType.postProcessing => (label: 'Post-Process', color: _C.slate, light: _C.slateLight),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: data.light, borderRadius: BorderRadius.circular(7)),
      child: Text(data.label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: data.color)),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String name;
  final double size;
  final Color color;
  const _Avatar({required this.name, required this.size, required this.color});
  @override
  Widget build(BuildContext context) {
    final initials = name.split(' ').take(2).map((p) => p.isNotEmpty ? p[0] : '').join();
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: color.withOpacity(0.15),
      child: Text(initials, style: TextStyle(fontSize: size * 0.35, fontWeight: FontWeight.w800, color: color)),
    );
  }
}

class _StatusDot extends StatelessWidget {
  final Color color;
  const _StatusDot({required this.color});
  @override
  Widget build(BuildContext context) => Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
}

class _LogMeta extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color? valueColor;
  const _LogMeta({required this.icon, required this.label, required this.value, this.valueColor});
  @override
  Widget build(BuildContext context) => Row(children: [
    Icon(icon, size: 12, color: _C.textMuted),
    const SizedBox(width: 4),
    Text('$label: ', style: const TextStyle(fontSize: 11, color: _C.textMuted)),
    Text(value, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: valueColor ?? _C.textPrimary)),
  ]);
}

class _MiniMeta extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color? color;
  const _MiniMeta({required this.icon, required this.value, this.color});
  @override
  Widget build(BuildContext context) => Row(children: [
    Icon(icon, size: 11, color: color ?? _C.textMuted),
    const SizedBox(width: 3),
    Text(value, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color ?? _C.textSecondary)),
  ]);
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final bool mono;
  final Color? valueColor;
  const _DetailRow({required this.icon, required this.label, required this.value, this.mono = false, this.valueColor});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 9),
    child: Row(children: [
      Icon(icon, size: 13, color: _C.textMuted),
      const SizedBox(width: 8),
      Text(label, style: const TextStyle(fontSize: 12, color: _C.textSecondary)),
      const Spacer(),
      Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: valueColor ?? _C.textPrimary, fontFamily: mono ? 'monospace' : null)),
    ]),
  );
}

class _AnalyticKPI extends StatelessWidget {
  final String label, value;
  final Color color;
  final IconData icon;
  const _AnalyticKPI({required this.label, required this.value, required this.color, required this.icon});
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: _C.border),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))]),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(9)),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: color, letterSpacing: -0.4)),
              Text(label, style: const TextStyle(fontSize: 11, color: _C.textMuted)),
            ],
          ),
        ],
      ),
    ),
  );
}

class _TabItem extends StatelessWidget {
  final String label;
  final int count;
  final Tab tab;
  final int alertCount;
  const _TabItem({required this.label, required this.count, required this.tab, this.alertCount = 0});
  @override
  Widget build(BuildContext context) => Tab(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: alertCount > 0 ? _C.rose : _C.indigoLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text('$count', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: alertCount > 0 ? Colors.white : _C.indigo)),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────
//  META HELPERS
// ─────────────────────────────────────────────
({Color color, Color light, String label}) _statusMeta(MachineStatus s) => switch (s) {
  MachineStatus.operational => (color: _C.emerald, light: _C.emeraldLight, label: 'Operational'),
  MachineStatus.idle => (color: _C.slate, light: _C.slateLight, label: 'Idle'),
  MachineStatus.underMaintenance => (color: _C.amber, light: _C.amberLight, label: 'Under Maint.'),
  MachineStatus.broken => (color: _C.rose, light: _C.roseLight, label: 'Broken'),
};

({Color color, Color light, String label}) _scheduleMeta(ScheduleStatus s) => switch (s) {
  ScheduleStatus.upcoming => (color: _C.indigo, light: _C.indigoLight, label: 'Upcoming'),
  ScheduleStatus.inProgress => (color: _C.amber, light: _C.amberLight, label: 'In Progress'),
  ScheduleStatus.completed => (color: _C.emerald, light: _C.emeraldLight, label: 'Completed'),
  ScheduleStatus.overdue => (color: _C.rose, light: _C.roseLight, label: 'Overdue'),
};

({Color color, Color light, String label}) _priorityMeta(IssuePriority p) => switch (p) {
  IssuePriority.critical => (color: _C.rose, light: _C.roseLight, label: '🔴 Critical'),
  IssuePriority.high => (color: _C.amber, light: _C.amberLight, label: '🟠 High'),
  IssuePriority.medium => (color: _C.violet, light: _C.violetLight, label: '🟡 Medium'),
  IssuePriority.low => (color: _C.slate, light: _C.slateLight, label: '🟢 Low'),
};

({Color color, Color light, String label}) _issueStatusMeta(IssueStatus s) => switch (s) {
  IssueStatus.pending => (color: _C.amber, light: _C.amberLight, label: 'Pending'),
  IssueStatus.inProgress => (color: _C.indigo, light: _C.indigoLight, label: 'In Progress'),
  IssueStatus.fixed => (color: _C.emerald, light: _C.emeraldLight, label: 'Fixed'),
};

IconData _typeIcon(MachineType t) => switch (t) {
  MachineType.printer3D => Icons.precision_manufacturing_rounded,
  MachineType.resinPrinter => Icons.water_drop_rounded,
  MachineType.slsPrinter => Icons.grain_rounded,
  MachineType.laserCutter => Icons.highlight_rounded,
  MachineType.cnc => Icons.settings_rounded,
  MachineType.postProcessing => Icons.cleaning_services_rounded,
};

// ─────────────────────────────────────────────
//  STRING HELPERS
// ─────────────────────────────────────────────
String _fmtDate(DateTime dt) {
  const m = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  return '${m[dt.month - 1]} ${dt.day}, ${dt.year}';
}

String _monthShort(DateTime dt) {
  const m = ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];
  return m[dt.month - 1];
}

String _daysAgo(DateTime dt) {
  final d = DateTime.now().difference(dt).inDays;
  if (d == 0) return 'Today';
  if (d == 1) return 'Yesterday';
  return '${d}d ago';
}

String _timeAgo(DateTime dt) {
  final diff = DateTime.now().difference(dt);
  if (diff.inHours < 1) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  return '${diff.inDays}d ago';
}

String _formatDuration(Duration d) {
  if (d.inHours == 0) return '${d.inMinutes}min';
  final m = d.inMinutes % 60;
  return m == 0 ? '${d.inHours}h' : '${d.inHours}h ${m}m';
}