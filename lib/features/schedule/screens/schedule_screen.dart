import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  DESIGN TOKENS
// ─────────────────────────────────────────────
class _C {
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
  static const slate = Color(0xFF64748B);
  static const slateLight = Color(0xFFF1F5F9);
  static const textPrimary = Color(0xFF0F172A);
  static const textSecondary = Color(0xFF64748B);
  static const textMuted = Color(0xFF94A3B8);
}

// ─────────────────────────────────────────────
//  ENUMS & MODELS
// ─────────────────────────────────────────────
enum EventType { requestApproval, maintenance, meeting, machineUsage, adminTask }
enum EventStatus { pending, inProgress, completed, canceled, approved, rejected }

class ScheduleEvent {
  final String id;
  final String title;
  final String description;
  final EventType type;
  EventStatus status;
  final DateTime startTime;
  final DateTime endTime;
  final String? assignedStaff;
  final String? relatedUser;
  final String? machine;
  final String? location;
  final String? linkedId; // REQ-xxx or MCH-xxx
  bool isAdminTask;
  final bool isEditable;

  ScheduleEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.startTime,
    required this.endTime,
    this.assignedStaff,
    this.relatedUser,
    this.machine,
    this.location,
    this.linkedId,
    this.isAdminTask = false,
    this.isEditable = true,
  });

  ScheduleEvent copyWith({
    String? title,
    String? description,
    EventType? type,
    EventStatus? status,
    DateTime? startTime,
    DateTime? endTime,
    String? assignedStaff,
    String? relatedUser,
    String? machine,
    String? location,
  }) {
    return ScheduleEvent(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      status: status ?? this.status,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      assignedStaff: assignedStaff ?? this.assignedStaff,
      relatedUser: relatedUser ?? this.relatedUser,
      machine: machine ?? this.machine,
      location: location ?? this.location,
      linkedId: linkedId,
      isAdminTask: isAdminTask,
      isEditable: isEditable,
    );
  }
}

// ─────────────────────────────────────────────
//  SAMPLE DATA
// ─────────────────────────────────────────────
final _now = DateTime.now();

List<ScheduleEvent> _buildSampleEvents() => [
  // ── TODAY ──
  ScheduleEvent(
    id: 'EVT-001', title: 'Approve REQ-001 — Mounting Bracket',
    description: 'John Doe submitted a PLA black bracket print request. File verified. Awaiting admin approval.',
    type: EventType.requestApproval, status: EventStatus.pending,
    startTime: DateTime(_now.year, _now.month, _now.day, 9, 0),
    endTime: DateTime(_now.year, _now.month, _now.day, 9, 30),
    relatedUser: 'John Doe', machine: 'Bambu X1 Carbon', location: 'Bay A1',
    linkedId: 'REQ-001', isAdminTask: true,
  ),
  ScheduleEvent(
    id: 'EVT-002', title: 'Weekly Staff Meeting',
    description: 'Weekly sync with all lab staff. Review print queue, machine status, and pending requests.',
    type: EventType.meeting, status: EventStatus.pending,
    startTime: DateTime(_now.year, _now.month, _now.day, 10, 0),
    endTime: DateTime(_now.year, _now.month, _now.day, 11, 0),
    assignedStaff: 'All Staff', location: 'Conference Room 1', isAdminTask: true,
  ),
  ScheduleEvent(
    id: 'EVT-003', title: 'Creality K1 Max Maintenance',
    description: 'Scheduled corrective maintenance — extruder nozzle replacement and calibration.',
    type: EventType.maintenance, status: EventStatus.inProgress,
    startTime: DateTime(_now.year, _now.month, _now.day, 11, 0),
    endTime: DateTime(_now.year, _now.month, _now.day, 14, 0),
    assignedStaff: 'David Chen', machine: 'Creality K1 Max', location: 'Bay A3',
    linkedId: 'MCH-003',
  ),
  ScheduleEvent(
    id: 'EVT-004', title: 'Approve REQ-004 — Display Stand',
    description: 'Emily Davis request for a PLA white display stand with logo. Marketing dept.',
    type: EventType.requestApproval, status: EventStatus.pending,
    startTime: DateTime(_now.year, _now.month, _now.day, 14, 0),
    endTime: DateTime(_now.year, _now.month, _now.day, 14, 30),
    relatedUser: 'Emily Davis', machine: 'Bambu P1S', location: 'Bay A4',
    linkedId: 'REQ-004', isAdminTask: true,
  ),
  ScheduleEvent(
    id: 'EVT-005', title: 'Voron 2.4 R2 — Print Run JOB-891',
    description: 'Extended print session for phone stand batch. Sarah Wilson operating.',
    type: EventType.machineUsage, status: EventStatus.inProgress,
    startTime: DateTime(_now.year, _now.month, _now.day, 9, 0),
    endTime: DateTime(_now.year, _now.month, _now.day, 17, 0),
    assignedStaff: 'Sarah Wilson', machine: 'Voron 2.4 R2', location: 'Bay B1',
    linkedId: 'JOB-891',
  ),
  ScheduleEvent(
    id: 'EVT-006', title: 'Sign Completion Report — REQ-009',
    description: 'PETG enclosure lid completed for Jane Smith. Admin to sign completion confirmation.',
    type: EventType.adminTask, status: EventStatus.pending,
    startTime: DateTime(_now.year, _now.month, _now.day, 16, 0),
    endTime: DateTime(_now.year, _now.month, _now.day, 16, 30),
    relatedUser: 'Jane Smith', linkedId: 'REQ-009', isAdminTask: true,
  ),

  // ── TOMORROW ──
  ScheduleEvent(
    id: 'EVT-007', title: 'Sinterit Lisa Pro — Laser Module Repair',
    description: 'Parts arrived. Full laser module replacement scheduled with David Chen.',
    type: EventType.maintenance, status: EventStatus.pending,
    startTime: DateTime(_now.year, _now.month, _now.day + 1, 8, 0),
    endTime: DateTime(_now.year, _now.month, _now.day + 1, 14, 0),
    assignedStaff: 'David Chen', machine: 'Sinterit Lisa Pro', location: 'Vault C2',
    linkedId: 'MCH-006',
  ),
  ScheduleEvent(
    id: 'EVT-008', title: 'Approve REQ-002 — Phone Case Prototype',
    description: 'Jane Smith TPU blue phone case prototype. Enterprise user — high priority.',
    type: EventType.requestApproval, status: EventStatus.pending,
    startTime: DateTime(_now.year, _now.month, _now.day + 1, 9, 30),
    endTime: DateTime(_now.year, _now.month, _now.day + 1, 10, 0),
    relatedUser: 'Jane Smith', machine: 'Bambu X1 Carbon', location: 'Bay A1',
    linkedId: 'REQ-002', isAdminTask: true,
  ),
  ScheduleEvent(
    id: 'EVT-009', title: 'Inventory Restock Check',
    description: 'Monthly inventory audit. Check low stock items: PLA Black, PETG Clear, TPU Blue.',
    type: EventType.adminTask, status: EventStatus.pending,
    startTime: DateTime(_now.year, _now.month, _now.day + 1, 14, 0),
    endTime: DateTime(_now.year, _now.month, _now.day + 1, 15, 0),
    location: 'Storage Room', isAdminTask: true,
  ),
  ScheduleEvent(
    id: 'EVT-010', title: 'Bambu X1 Carbon — Nozzle Inspection',
    description: 'Preventive maintenance: AMS cleaning and hardened nozzle wear check.',
    type: EventType.maintenance, status: EventStatus.pending,
    startTime: DateTime(_now.year, _now.month, _now.day + 9, 10, 0),
    endTime: DateTime(_now.year, _now.month, _now.day + 9, 11, 0),
    assignedStaff: 'Mike Johnson', machine: 'Bambu X1 Carbon', location: 'Bay A1',
    linkedId: 'MCH-001',
  ),
  ScheduleEvent(
    id: 'EVT-011', title: 'Vendor Meeting — Bambu Lab PH',
    description: 'Quarterly review with Bambu Lab Philippines. Discuss filament pricing and new X1E model.',
    type: EventType.meeting, status: EventStatus.pending,
    startTime: DateTime(_now.year, _now.month, _now.day + 3, 14, 0),
    endTime: DateTime(_now.year, _now.month, _now.day + 3, 16, 0),
    location: 'Conference Room 1', isAdminTask: true,
  ),
  ScheduleEvent(
    id: 'EVT-012', title: 'Monthly Performance Review',
    description: 'Review all staff KPIs, machine utilization rates, and request turnaround times.',
    type: EventType.adminTask, status: EventStatus.pending,
    startTime: DateTime(_now.year, _now.month, _now.day + 5, 9, 0),
    endTime: DateTime(_now.year, _now.month, _now.day + 5, 11, 0),
    assignedStaff: 'All Staff', location: 'Conference Room 1', isAdminTask: true,
  ),
  ScheduleEvent(
    id: 'EVT-013', title: 'REQ-005 Approved — Drone Frame Print',
    description: 'Michael Lee\'s Carbon PLA drone frame approved. Scheduled for Voron 2.4.',
    type: EventType.machineUsage, status: EventStatus.completed,
    startTime: DateTime(_now.year, _now.month, _now.day - 1, 9, 0),
    endTime: DateTime(_now.year, _now.month, _now.day - 1, 17, 0),
    assignedStaff: 'Sarah Wilson', machine: 'Voron 2.4 R2', location: 'Bay B1',
    linkedId: 'REQ-005',
  ),
];

const _staffList = ['Mike Johnson', 'Sarah Wilson', 'David Chen', 'Lisa Garcia', 'Nina Patel', 'Alex Turner'];
const _machineList = ['Bambu X1 Carbon', 'Prusa MK4', 'Creality K1 Max', 'Voron 2.4 R2', 'Elegoo Saturn 4', 'Sinterit Lisa Pro', 'xTool D1 Pro', 'Bambu P1S'];
const _locationList = ['Bay A1', 'Bay A2', 'Bay A3', 'Bay A4', 'Bay B1', 'Bay C1', 'Bay D1', 'Vault C2', 'Conference Room 1', 'Storage Room', 'Remote'];

// ─────────────────────────────────────────────
//  SCREEN
// ─────────────────────────────────────────────
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _viewTab;
  late List<ScheduleEvent> _events;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  ScheduleEvent? _selectedEvent;

  // Filters
  EventType? _typeFilter;
  EventStatus? _statusFilter;
  String? _staffFilter;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _viewTab = TabController(length: 3, vsync: this);
    _viewTab.addListener(() {
      if (!mounted) return;
      if (_viewTab.indexIsChanging) setState(() {});
    });
    _events = _buildSampleEvents();
  }

  @override
  void dispose() {
    _viewTab.dispose();
    super.dispose();
  }

  List<ScheduleEvent> get _filteredEvents {
    return _events.where((e) {
      final matchType = _typeFilter == null || e.type == _typeFilter;
      final matchStatus = _statusFilter == null || e.status == _statusFilter;
      final matchStaff = _staffFilter == null || e.assignedStaff == _staffFilter || e.relatedUser == _staffFilter;
      final matchSearch = _searchQuery.isEmpty ||
          e.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (e.machine?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
          (e.assignedStaff?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
          (e.linkedId?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      return matchType && matchStatus && matchStaff && matchSearch;
    }).toList()..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  List<ScheduleEvent> _eventsForDay(DateTime day) {
    return _filteredEvents.where((e) =>
      e.startTime.year == day.year &&
      e.startTime.month == day.month &&
      e.startTime.day == day.day).toList();
  }

  List<ScheduleEvent> _eventsForWeek(DateTime weekStart) {
    return _filteredEvents.where((e) {
      final d = e.startTime;
      return d.isAfter(weekStart.subtract(const Duration(days: 1))) &&
             d.isBefore(weekStart.add(const Duration(days: 7)));
    }).toList();
  }

  int get _pendingAdminTasks => _events.where((e) => e.isAdminTask && e.status == EventStatus.pending).length;
  int get _pendingApprovals => _events.where((e) => e.type == EventType.requestApproval && e.status == EventStatus.pending).length;
  int get _todayEvents => _eventsForDay(_now).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── MAIN CONTENT ──
          Expanded(
            child: Column(
              children: [
                // Header + tabs bar
                Container(
                  color: _C.surface,
                  padding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 16),
                      _buildTopStats(),
                      const SizedBox(height: 16),
                      _buildFilters(),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          // View switcher
                          SizedBox(
                            width: 248,
                            child: Container(
                              decoration: BoxDecoration(color: _C.bg, borderRadius: BorderRadius.circular(10), border: Border.all(color: _C.border)),
                              child: TabBar(
                                controller: _viewTab,
                                isScrollable: false,
                                labelColor: Colors.white,
                                unselectedLabelColor: _C.textSecondary,
                                labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                                indicator: BoxDecoration(color: _C.indigo, borderRadius: BorderRadius.circular(8)),
                                indicatorSize: TabBarIndicatorSize.tab,
                                dividerColor: Colors.transparent,
                                padding: const EdgeInsets.all(4),
                                tabs: const [
                                  Tab(text: 'Daily'),
                                  Tab(text: 'Weekly'),
                                  Tab(text: 'Monthly'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Day navigator
                          _buildDayNav(),
                          const Spacer(),
                          // Create event button
                          ElevatedButton.icon(
                            onPressed: () => _showEventDialog(context),
                            icon: const Icon(Icons.add_rounded, size: 16),
                            label: const Text('New Event'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _C.indigo,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                // Tab content
                Expanded(
                  child: TabBarView(
                    controller: _viewTab,
                    children: [
                      _DailyView(
                        selectedDay: _selectedDay,
                        events: _eventsForDay(_selectedDay),
                        onEventTap: (e) => setState(() => _selectedEvent = _selectedEvent?.id == e.id ? null : e),
                        selectedEvent: _selectedEvent,
                        onQuickAction: _handleQuickAction,
                      ),
                      _WeeklyView(
                        focusedDay: _focusedDay,
                        events: _filteredEvents,
                        selectedDay: _selectedDay,
                        onDayTap: (d) {
                          setState(() { _selectedDay = d; _focusedDay = d; });
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) _viewTab.animateTo(0);
                          });
                        },
                        onEventTap: (e) => setState(() => _selectedEvent = _selectedEvent?.id == e.id ? null : e),
                        selectedEvent: _selectedEvent,
                      ),
                      _MonthlyView(
                        focusedDay: _focusedDay,
                        events: _filteredEvents,
                        selectedDay: _selectedDay,
                        onDayTap: (d) {
                          setState(() { _selectedDay = d; _focusedDay = d; });
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) _viewTab.animateTo(0);
                          });
                        },
                        onMonthChanged: (d) => setState(() => _focusedDay = d),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ── EVENT DETAIL PANEL ──
          if (_selectedEvent != null)
            _EventDetailPanel(
              event: _selectedEvent!,
              onClose: () => setState(() => _selectedEvent = null),
              onEdit: () => _showEventDialog(context, event: _selectedEvent),
              onStatusChange: (status) {
                setState(() {
                  final idx = _events.indexWhere((e) => e.id == _selectedEvent!.id);
                  if (idx != -1) _events[idx].status = status;
                  _selectedEvent = _events[idx];
                });
              },
              onDelete: () {
                setState(() {
                  _events.removeWhere((e) => e.id == _selectedEvent!.id);
                  _selectedEvent = null;
                });
              },
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
                  Text('Schedule', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: -0.6, color: _C.textPrimary)),
                  Text('Manage events, approvals and machine reservations', style: TextStyle(fontSize: 13, color: _C.textSecondary)),
                ],
              ),
            ],
          ),
        ),
        if (_pendingApprovals > 0)
          _PillBadge(label: '$_pendingApprovals Pending Approvals', color: _C.rose, light: _C.roseLight, icon: Icons.pending_actions_rounded),
      ],
    );
  }

  // ── TOP STATS ────────────────────────────────
  Widget _buildTopStats() {
    return Row(
      children: [
        _StatChip(label: "Today's Events", value: _todayEvents.toString(), color: _C.indigo, icon: Icons.today_rounded),
        const SizedBox(width: 10),
        _StatChip(label: 'Admin Tasks', value: _pendingAdminTasks.toString(), color: _C.amber, icon: Icons.assignment_rounded),
        const SizedBox(width: 10),
        _StatChip(label: 'Approvals Due', value: _pendingApprovals.toString(), color: _C.rose, icon: Icons.pending_actions_rounded),
        const SizedBox(width: 10),
        _StatChip(label: 'In Progress', value: _events.where((e) => e.status == EventStatus.inProgress).length.toString(), color: _C.emerald, icon: Icons.timelapse_rounded),
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
            height: 40,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(9), border: Border.all(color: _C.border)),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              style: const TextStyle(fontSize: 13, color: _C.textPrimary),
              decoration: const InputDecoration(
                hintText: 'Search events, machines, staff, IDs…',
                hintStyle: TextStyle(fontSize: 12, color: _C.textMuted),
                prefixIcon: Icon(Icons.search_rounded, size: 16, color: _C.textMuted),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Type filter
        _FilterDropdown(
          label: _typeFilter == null ? 'All Types' : _typeMeta(_typeFilter!).label,
          color: _typeFilter == null ? _C.textSecondary : _typeMeta(_typeFilter!).color,
          onTap: () => _showTypePicker(),
        ),
        const SizedBox(width: 6),
        // Status filter
        _FilterDropdown(
          label: _statusFilter == null ? 'All Status' : _statusLabel(_statusFilter!),
          color: _statusFilter == null ? _C.textSecondary : _statusColor(_statusFilter!),
          onTap: () => _showStatusPicker(),
        ),
        const SizedBox(width: 6),
        // Staff filter
        _FilterDropdown(
          label: _staffFilter ?? 'All Staff',
          color: _staffFilter == null ? _C.textSecondary : _C.indigo,
          onTap: () => _showStaffPicker(),
        ),
        if (_typeFilter != null || _statusFilter != null || _staffFilter != null)
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: GestureDetector(
              onTap: () => setState(() { _typeFilter = null; _statusFilter = null; _staffFilter = null; }),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: _C.border)),
                child: const Icon(Icons.close_rounded, size: 15, color: _C.textMuted),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDayNav() {
    return Row(
      children: [
        _NavBtn(icon: Icons.chevron_left_rounded, onTap: () {
          setState(() {
            _selectedDay = _selectedDay.subtract(const Duration(days: 1));
            _focusedDay = _selectedDay;
          });
        }),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () => setState(() { _selectedDay = DateTime.now(); _focusedDay = DateTime.now(); }),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: _isSameDay(_selectedDay, DateTime.now()) ? _C.indigoLight : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _isSameDay(_selectedDay, DateTime.now()) ? _C.indigo.withOpacity(0.3) : _C.border),
            ),
            child: Text(
              _isSameDay(_selectedDay, DateTime.now()) ? 'Today' : _fmtDateShort(_selectedDay),
              style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w700,
                color: _isSameDay(_selectedDay, DateTime.now()) ? _C.indigo : _C.textPrimary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        _NavBtn(icon: Icons.chevron_right_rounded, onTap: () {
          setState(() {
            _selectedDay = _selectedDay.add(const Duration(days: 1));
            _focusedDay = _selectedDay;
          });
        }),
      ],
    );
  }

  // ── QUICK ACTIONS ────────────────────────────
  void _handleQuickAction(ScheduleEvent event, String action) {
    setState(() {
      final idx = _events.indexWhere((e) => e.id == event.id);
      if (idx == -1) return;
      if (action == 'approve') _events[idx].status = EventStatus.approved;
      if (action == 'reject') _events[idx].status = EventStatus.rejected;
      if (action == 'complete') _events[idx].status = EventStatus.completed;
      if (_selectedEvent?.id == event.id) _selectedEvent = _events[idx];
    });
  }

  // ── DIALOGS ──────────────────────────────────
  void _showEventDialog(BuildContext context, {ScheduleEvent? event}) {
    showDialog(
      context: context,
      builder: (_) => _EventFormDialog(
        existing: event,
        onSave: (newEvent) {
          setState(() {
            if (event != null) {
              final idx = _events.indexWhere((e) => e.id == event.id);
              if (idx != -1) _events[idx] = newEvent;
              _selectedEvent = newEvent;
            } else {
              _events.add(newEvent);
            }
          });
        },
      ),
    );
  }

  void _showTypePicker() => showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (_) => _PickerSheet(title: 'Filter by Type', options: [
      _PickerOption(label: 'All Types', onTap: () { setState(() => _typeFilter = null); Navigator.pop(context); }),
      ...EventType.values.map((t) => _PickerOption(label: _typeMeta(t).label, onTap: () { setState(() => _typeFilter = t); Navigator.pop(context); })),
    ]),
  );

  void _showStatusPicker() => showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (_) => _PickerSheet(title: 'Filter by Status', options: [
      _PickerOption(label: 'All Status', onTap: () { setState(() => _statusFilter = null); Navigator.pop(context); }),
      ...EventStatus.values.map((s) => _PickerOption(label: _statusLabel(s), onTap: () { setState(() => _statusFilter = s); Navigator.pop(context); })),
    ]),
  );

  void _showStaffPicker() => showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (_) => _PickerSheet(title: 'Filter by Staff', options: [
      _PickerOption(label: 'All Staff', onTap: () { setState(() => _staffFilter = null); Navigator.pop(context); }),
      ..._staffList.map((s) => _PickerOption(label: s, onTap: () { setState(() => _staffFilter = s); Navigator.pop(context); })),
    ]),
  );
}

// ─────────────────────────────────────────────
//  DAILY VIEW
// ─────────────────────────────────────────────
class _DailyView extends StatelessWidget {
  final DateTime selectedDay;
  final List<ScheduleEvent> events;
  final ValueChanged<ScheduleEvent> onEventTap;
  final ScheduleEvent? selectedEvent;
  final Function(ScheduleEvent, String) onQuickAction;

  const _DailyView({required this.selectedDay, required this.events, required this.onEventTap, required this.selectedEvent, required this.onQuickAction});

  @override
  Widget build(BuildContext context) {
    final hours = List.generate(13, (i) => i + 7); // 7am–7pm

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 16, 28, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _isSameDay(selectedDay, DateTime.now()) ? 'Today — ${_fmtDateLong(selectedDay)}' : _fmtDateLong(selectedDay),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _C.textPrimary),
              ),
              const SizedBox(width: 10),
              if (events.isEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: _C.slateLight, borderRadius: BorderRadius.circular(6)),
                  child: const Text('No events', style: TextStyle(fontSize: 11, color: _C.textMuted)),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: _C.indigoLight, borderRadius: BorderRadius.circular(6)),
                  child: Text('${events.length} events', style: const TextStyle(fontSize: 11, color: _C.indigo, fontWeight: FontWeight.w600)),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Hour-by-hour timeline
          ...hours.map((hour) {
            final hourEvents = events.where((e) => e.startTime.hour == hour).toList();
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hour label
                  SizedBox(
                    width: 52,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        '${hour.toString().padLeft(2, '0')}:00',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: hour == DateTime.now().hour && _isSameDay(selectedDay, DateTime.now()) ? _C.indigo : _C.textMuted),
                      ),
                    ),
                  ),
                  // Hour line + events
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 1,
                          color: hour == DateTime.now().hour && _isSameDay(selectedDay, DateTime.now())
                              ? _C.indigo.withOpacity(0.3)
                              : _C.border,
                        ),
                        if (hourEvents.isEmpty)
                          const SizedBox(height: 48)
                        else
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Column(
                              children: hourEvents.map((e) => _EventTile(
                                event: e,
                                isSelected: selectedEvent?.id == e.id,
                                onTap: () => onEventTap(e),
                                onQuickAction: (action) => onQuickAction(e, action),
                              )).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  WEEKLY VIEW
// ─────────────────────────────────────────────
class _WeeklyView extends StatelessWidget {
  final DateTime focusedDay;
  final List<ScheduleEvent> events;
  final DateTime selectedDay;
  final ValueChanged<DateTime> onDayTap;
  final ValueChanged<ScheduleEvent> onEventTap;
  final ScheduleEvent? selectedEvent;

  const _WeeklyView({required this.focusedDay, required this.events, required this.selectedDay, required this.onDayTap, required this.onEventTap, required this.selectedEvent});

  @override
  Widget build(BuildContext context) {
    final weekStart = focusedDay.subtract(Duration(days: focusedDay.weekday - 1));
    final days = List.generate(7, (i) => weekStart.add(Duration(days: i)));

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 16, 28, 40),
      child: Column(
        children: [
          // Day headers
          Row(
            children: [
              const SizedBox(width: 52),
              ...days.map((day) {
                final isToday = _isSameDay(day, DateTime.now());
                final isSelected = _isSameDay(day, selectedDay);
                final dayEvents = events.where((e) =>
                  e.startTime.year == day.year &&
                  e.startTime.month == day.month &&
                  e.startTime.day == day.day).toList();

                return Expanded(
                  child: GestureDetector(
                    onTap: () => onDayTap(day),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? _C.indigo : isToday ? _C.indigoLight : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: isSelected ? _C.indigo : isToday ? _C.indigo.withOpacity(0.3) : _C.border),
                      ),
                      child: Column(
                        children: [
                          Text(_weekdayShort(day.weekday), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: isSelected ? Colors.white.withOpacity(0.8) : _C.textMuted)),
                          const SizedBox(height: 2),
                          Text('${day.day}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: isSelected ? Colors.white : isToday ? _C.indigo : _C.textPrimary)),
                          const SizedBox(height: 4),
                          if (dayEvents.isNotEmpty)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: dayEvents.take(3).map((e) => Container(
                                width: 5, height: 5,
                                margin: const EdgeInsets.symmetric(horizontal: 1),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.white.withOpacity(0.7) : _typeMeta(e.type).color,
                                  shape: BoxShape.circle,
                                ),
                              )).toList(),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 16),
          // Events grid
          ...days.map((day) {
            final dayEvents = events.where((e) =>
              e.startTime.year == day.year &&
              e.startTime.month == day.month &&
              e.startTime.day == day.day).toList();
            if (dayEvents.isEmpty) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 52,
                    child: Text(
                      '${_weekdayShort(day.weekday)}\n${day.day}',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _isSameDay(day, DateTime.now()) ? _C.indigo : _C.textMuted),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: dayEvents.map((e) => _EventTile(
                        event: e,
                        isSelected: selectedEvent?.id == e.id,
                        onTap: () => onEventTap(e),
                        onQuickAction: (_) {},
                        compact: true,
                      )).toList(),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  MONTHLY VIEW
// ─────────────────────────────────────────────
class _MonthlyView extends StatelessWidget {
  final DateTime focusedDay;
  final List<ScheduleEvent> events;
  final DateTime selectedDay;
  final ValueChanged<DateTime> onDayTap;
  final ValueChanged<DateTime> onMonthChanged;

  const _MonthlyView({required this.focusedDay, required this.events, required this.selectedDay, required this.onDayTap, required this.onMonthChanged});

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(focusedDay.year, focusedDay.month, 1);
    final lastDay = DateTime(focusedDay.year, focusedDay.month + 1, 0);
    final startOffset = firstDay.weekday - 1;
    final totalCells = startOffset + lastDay.day;
    final rows = (totalCells / 7).ceil();

    const dayHeaders = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 16, 28, 40),
      child: Column(
        children: [
          // Month navigation
          Row(
            children: [
              _NavBtn(icon: Icons.chevron_left_rounded, onTap: () => onMonthChanged(DateTime(focusedDay.year, focusedDay.month - 1))),
              const SizedBox(width: 12),
              Text(
                '${_monthName(focusedDay.month)} ${focusedDay.year}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _C.textPrimary, letterSpacing: -0.4),
              ),
              const SizedBox(width: 12),
              _NavBtn(icon: Icons.chevron_right_rounded, onTap: () => onMonthChanged(DateTime(focusedDay.year, focusedDay.month + 1))),
            ],
          ),
          const SizedBox(height: 16),
          // Grid
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: _C.border)),
            child: Column(
              children: [
                // Day headers
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  child: Row(
                    children: dayHeaders.map((h) => Expanded(
                      child: Text(h, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _C.textMuted)),
                    )).toList(),
                  ),
                ),
                const Divider(height: 1, color: _C.border),
                // Weeks
                ...List.generate(rows, (row) {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(7, (col) {
                          final cellIndex = row * 7 + col;
                          final dayNum = cellIndex - startOffset + 1;
                          if (dayNum < 1 || dayNum > lastDay.day) {
                            return Expanded(child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFAFBFD),
                                border: Border.all(color: _C.border.withOpacity(0.5), width: 0.5),
                              ),
                            ));
                          }
                          final day = DateTime(focusedDay.year, focusedDay.month, dayNum);
                          final dayEvents = events.where((e) =>
                            e.startTime.year == day.year &&
                            e.startTime.month == day.month &&
                            e.startTime.day == day.day).toList();
                          final isToday = _isSameDay(day, DateTime.now());
                          final isSelected = _isSameDay(day, selectedDay);

                          return Expanded(
                            child: GestureDetector(
                              onTap: () => onDayTap(day),
                              child: Container(
                                height: 80,
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: isSelected ? _C.indigoLight : isToday ? const Color(0xFFFAFBFD) : Colors.white,
                                  border: Border.all(color: _C.border.withOpacity(0.5), width: 0.5),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 24, height: 24,
                                      decoration: BoxDecoration(
                                        color: isToday ? _C.indigo : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$dayNum',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: isToday || isSelected ? FontWeight.w800 : FontWeight.w500,
                                            color: isToday ? Colors.white : isSelected ? _C.indigo : _C.textPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    ...dayEvents.take(2).map((e) {
                                      final tm = _typeMeta(e.type);
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 2),
                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                        decoration: BoxDecoration(color: tm.light, borderRadius: BorderRadius.circular(3)),
                                        child: Text(e.title, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: tm.color), overflow: TextOverflow.ellipsis),
                                      );
                                    }),
                                    if (dayEvents.length > 2)
                                      Text('+${dayEvents.length - 2} more', style: const TextStyle(fontSize: 9, color: _C.textMuted)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      if (row < rows - 1) const Divider(height: 1, color: _C.border),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  EVENT TILE
// ─────────────────────────────────────────────
class _EventTile extends StatelessWidget {
  final ScheduleEvent event;
  final bool isSelected;
  final VoidCallback onTap;
  final Function(String) onQuickAction;
  final bool compact;

  const _EventTile({required this.event, required this.isSelected, required this.onTap, required this.onQuickAction, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final tm = _typeMeta(event.type);
    final sm = _statusMeta(event.status);
    final isPending = event.status == EventStatus.pending;
    final isApprovalTask = event.type == EventType.requestApproval && isPending;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        margin: const EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(compact ? 10 : 14),
        decoration: BoxDecoration(
          color: isSelected ? tm.color.withOpacity(0.08) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? tm.color.withOpacity(0.4) : _C.border),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Type indicator bar
                Container(width: 3, height: compact ? 28 : 40, decoration: BoxDecoration(color: tm.color, borderRadius: BorderRadius.circular(4))),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: tm.light, borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(tm.icon, size: 10, color: tm.color),
                                const SizedBox(width: 3),
                                Text(tm.label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: tm.color)),
                              ],
                            ),
                          ),
                          if (event.isAdminTask) ...[
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(color: _C.amberLight, borderRadius: BorderRadius.circular(5)),
                              child: const Text('Admin', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: _C.amber)),
                            ),
                          ],
                          const Spacer(),
                          Text(
                            '${_fmtTime(event.startTime)} – ${_fmtTime(event.endTime)}',
                            style: const TextStyle(fontSize: 11, color: _C.textMuted),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(event.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.textPrimary), overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  decoration: BoxDecoration(color: sm.light, borderRadius: BorderRadius.circular(7)),
                  child: Text(sm.label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: sm.color)),
                ),
              ],
            ),
            if (!compact) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  if (event.machine != null) ...[
                    const Icon(Icons.precision_manufacturing_rounded, size: 11, color: _C.textMuted),
                    const SizedBox(width: 4),
                    Text(event.machine!, style: const TextStyle(fontSize: 11, color: _C.textSecondary)),
                    const SizedBox(width: 10),
                  ],
                  if (event.assignedStaff != null) ...[
                    const Icon(Icons.person_rounded, size: 11, color: _C.textMuted),
                    const SizedBox(width: 4),
                    Text(event.assignedStaff!, style: const TextStyle(fontSize: 11, color: _C.textSecondary)),
                    const SizedBox(width: 10),
                  ],
                  if (event.location != null) ...[
                    const Icon(Icons.place_rounded, size: 11, color: _C.textMuted),
                    const SizedBox(width: 4),
                    Text(event.location!, style: const TextStyle(fontSize: 11, color: _C.textSecondary)),
                  ],
                  if (event.linkedId != null) ...[
                    const Spacer(),
                    Text(event.linkedId!, style: const TextStyle(fontSize: 10, color: _C.textMuted, fontFamily: 'monospace')),
                  ],
                ],
              ),
              // Quick actions for admin-pending items
              if (isApprovalTask) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onQuickAction('approve'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          decoration: BoxDecoration(color: _C.emeraldLight, borderRadius: BorderRadius.circular(8)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_rounded, size: 13, color: _C.emerald),
                              SizedBox(width: 4),
                              Text('Approve', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _C.emerald)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onQuickAction('reject'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          decoration: BoxDecoration(color: _C.roseLight, borderRadius: BorderRadius.circular(8)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.close_rounded, size: 13, color: _C.rose),
                              SizedBox(width: 4),
                              Text('Reject', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _C.rose)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              if (isPending && event.type != EventType.requestApproval && event.isAdminTask) ...[
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => onQuickAction('complete'),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(color: _C.indigoLight, borderRadius: BorderRadius.circular(8)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.task_alt_rounded, size: 13, color: _C.indigo),
                        SizedBox(width: 4),
                        Text('Mark Complete', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _C.indigo)),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  EVENT DETAIL PANEL
// ─────────────────────────────────────────────
class _EventDetailPanel extends StatelessWidget {
  final ScheduleEvent event;
  final VoidCallback onClose;
  final VoidCallback onEdit;
  final ValueChanged<EventStatus> onStatusChange;
  final VoidCallback onDelete;

  const _EventDetailPanel({required this.event, required this.onClose, required this.onEdit, required this.onStatusChange, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final tm = _typeMeta(event.type);
    final sm = _statusMeta(event.status);

    return Container(
      width: 320,
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      decoration: const BoxDecoration(color: _C.surface, border: Border(left: BorderSide(color: _C.border))),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Panel header
            Row(
              children: [
                const Text('Event Detail', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _C.textPrimary)),
                const Spacer(),
                if (event.isEditable) ...[
                  _IconBtn(icon: Icons.edit_rounded, color: _C.indigo, light: _C.indigoLight, onTap: onEdit),
                  const SizedBox(width: 6),
                  _IconBtn(icon: Icons.delete_rounded, color: _C.rose, light: _C.roseLight, onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Delete Event'),
                        content: const Text('Are you sure you want to delete this event? This cannot be undone.'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                          TextButton(onPressed: () { Navigator.pop(context); onDelete(); }, child: const Text('Delete', style: TextStyle(color: _C.rose))),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(width: 6),
                ],
                _IconBtn(icon: Icons.close_rounded, color: _C.textSecondary, light: _C.bg, onTap: onClose),
              ],
            ),

            const SizedBox(height: 20),

            // Type + status badges
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  decoration: BoxDecoration(color: tm.light, borderRadius: BorderRadius.circular(8)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(tm.icon, size: 12, color: tm.color),
                    const SizedBox(width: 5),
                    Text(tm.label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: tm.color)),
                  ]),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  decoration: BoxDecoration(color: sm.light, borderRadius: BorderRadius.circular(8)),
                  child: Text(sm.label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: sm.color)),
                ),
                if (event.isAdminTask) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                    decoration: BoxDecoration(color: _C.amberLight, borderRadius: BorderRadius.circular(8)),
                    child: const Text('Admin Task', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _C.amber)),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 14),

            // Title
            Text(event.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _C.textPrimary, letterSpacing: -0.3)),
            if (event.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(event.description, style: const TextStyle(fontSize: 13, color: _C.textSecondary, height: 1.5)),
            ],

            const SizedBox(height: 16),
            const Divider(height: 1, color: _C.border),
            const SizedBox(height: 14),

            // Details
            _DetailRow(icon: Icons.calendar_today_rounded, label: 'Date', value: _fmtDateLong(event.startTime)),
            _DetailRow(icon: Icons.access_time_rounded, label: 'Time', value: '${_fmtTime(event.startTime)} – ${_fmtTime(event.endTime)}'),
            _DetailRow(icon: Icons.timelapse_rounded, label: 'Duration', value: _fmtDuration(event.endTime.difference(event.startTime))),
            if (event.location != null) _DetailRow(icon: Icons.place_rounded, label: 'Location', value: event.location!),
            if (event.machine != null) _DetailRow(icon: Icons.precision_manufacturing_rounded, label: 'Machine', value: event.machine!),
            if (event.assignedStaff != null) _DetailRow(icon: Icons.engineering_rounded, label: 'Assigned To', value: event.assignedStaff!),
            if (event.relatedUser != null) _DetailRow(icon: Icons.person_rounded, label: 'User', value: event.relatedUser!),
            if (event.linkedId != null) _DetailRow(icon: Icons.link_rounded, label: 'Linked ID', value: event.linkedId!, mono: true, valueColor: _C.indigo),

            const SizedBox(height: 16),
            const Divider(height: 1, color: _C.border),
            const SizedBox(height: 14),

            // Change status
            const Text('Update Status', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.textPrimary)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6, runSpacing: 6,
              children: EventStatus.values.map((s) {
                final meta = _statusMeta(s);
                final isActive = event.status == s;
                return GestureDetector(
                  onTap: () => onStatusChange(s),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive ? meta.color : meta.light,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: isActive ? meta.color : meta.color.withOpacity(0.2)),
                    ),
                    child: Text(meta.label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: isActive ? Colors.white : meta.color)),
                  ),
                );
              }).toList(),
            ),

            // Quick approve/reject
            if (event.type == EventType.requestApproval && event.status == EventStatus.pending) ...[
              const SizedBox(height: 16),
              const Divider(height: 1, color: _C.border),
              const SizedBox(height: 14),
              const Text('Quick Action', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.textPrimary)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => onStatusChange(EventStatus.approved),
                      icon: const Icon(Icons.check_rounded, size: 15),
                      label: const Text('Approve'),
                      style: ElevatedButton.styleFrom(backgroundColor: _C.emerald, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => onStatusChange(EventStatus.rejected),
                      icon: const Icon(Icons.close_rounded, size: 15),
                      label: const Text('Reject'),
                      style: ElevatedButton.styleFrom(backgroundColor: _C.rose, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  EVENT FORM DIALOG (Create / Edit)
// ─────────────────────────────────────────────
class _EventFormDialog extends StatefulWidget {
  final ScheduleEvent? existing;
  final ValueChanged<ScheduleEvent> onSave;

  const _EventFormDialog({this.existing, required this.onSave});

  @override
  State<_EventFormDialog> createState() => _EventFormDialogState();
}

class _EventFormDialogState extends State<_EventFormDialog> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  late EventType _type;
  late EventStatus _status;
  late DateTime _startTime;
  late DateTime _endTime;
  String? _staff;
  String? _machine;
  String? _location;
  bool _isAdminTask = false;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _titleCtrl.text = e?.title ?? '';
    _descCtrl.text = e?.description ?? '';
    _type = e?.type ?? EventType.meeting;
    _status = e?.status ?? EventStatus.pending;
    _startTime = e?.startTime ?? DateTime(_now.year, _now.month, _now.day, 9, 0);
    _endTime = e?.endTime ?? DateTime(_now.year, _now.month, _now.day, 10, 0);
    _staff = e?.assignedStaff;
    _machine = e?.machine;
    _location = e?.location;
    _isAdminTask = e?.isAdminTask ?? false;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  String _generateId() => 'EVT-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

  void _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startTime : _endTime,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      builder: (ctx, child) => Theme(data: Theme.of(ctx).copyWith(colorScheme: const ColorScheme.light(primary: _C.indigo)), child: child!),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _startTime = DateTime(picked.year, picked.month, picked.day, _startTime.hour, _startTime.minute);
        if (_endTime.isBefore(_startTime)) _endTime = _startTime.add(const Duration(hours: 1));
      } else {
        _endTime = DateTime(picked.year, picked.month, picked.day, _endTime.hour, _endTime.minute);
      }
    });
  }

  void _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(isStart ? _startTime : _endTime),
      builder: (ctx, child) => Theme(data: Theme.of(ctx).copyWith(colorScheme: const ColorScheme.light(primary: _C.indigo)), child: child!),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _startTime = DateTime(_startTime.year, _startTime.month, _startTime.day, picked.hour, picked.minute);
      } else {
        _endTime = DateTime(_endTime.year, _endTime.month, _endTime.day, picked.hour, picked.minute);
      }
    });
  }

  void _save() {
    if (_titleCtrl.text.trim().isEmpty) return;
    final event = ScheduleEvent(
      id: widget.existing?.id ?? _generateId(),
      title: _titleCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      type: _type,
      status: _status,
      startTime: _startTime,
      endTime: _endTime,
      assignedStaff: _staff,
      machine: _machine,
      location: _location,
      isAdminTask: _isAdminTask,
    );
    widget.onSave(event);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 560,
        constraints: const BoxConstraints(maxHeight: 640),
        child: Column(
          children: [
            // Dialog header
            Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 20, 16),
              decoration: const BoxDecoration(
                color: _C.bg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                border: Border(bottom: BorderSide(color: _C.border)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: _C.indigoLight, borderRadius: BorderRadius.circular(8)),
                    child: Icon(isEdit ? Icons.edit_calendar_rounded : Icons.add_circle_rounded, color: _C.indigo, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Text(isEdit ? 'Edit Event' : 'Create New Event', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _C.textPrimary)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: _C.border)),
                      child: const Icon(Icons.close_rounded, size: 16, color: _C.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
            // Form body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    _FormLabel('Event Title *'),
                    const SizedBox(height: 6),
                    _TextField(controller: _titleCtrl, hint: 'e.g. Weekly Team Meeting'),
                    const SizedBox(height: 16),

                    // Description
                    _FormLabel('Description'),
                    const SizedBox(height: 6),
                    _TextField(controller: _descCtrl, hint: 'Optional notes or details…', maxLines: 3),
                    const SizedBox(height: 16),

                    // Type + Status row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FormLabel('Event Type'),
                              const SizedBox(height: 6),
                              _DropdownField<EventType>(
                                value: _type,
                                items: EventType.values,
                                labelBuilder: (t) => _typeMeta(t).label,
                                onChanged: (t) => setState(() => _type = t!),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FormLabel('Status'),
                              const SizedBox(height: 6),
                              _DropdownField<EventStatus>(
                                value: _status,
                                items: EventStatus.values,
                                labelBuilder: (s) => _statusLabel(s),
                                onChanged: (s) => setState(() => _status = s!),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Start date/time
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FormLabel('Start Date'),
                              const SizedBox(height: 6),
                              _DateTimeBtn(label: _fmtDateShort(_startTime), icon: Icons.calendar_today_rounded, onTap: () => _pickDate(true)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FormLabel('Start Time'),
                              const SizedBox(height: 6),
                              _DateTimeBtn(label: _fmtTime(_startTime), icon: Icons.access_time_rounded, onTap: () => _pickTime(true)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FormLabel('End Date'),
                              const SizedBox(height: 6),
                              _DateTimeBtn(label: _fmtDateShort(_endTime), icon: Icons.calendar_today_rounded, onTap: () => _pickDate(false)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FormLabel('End Time'),
                              const SizedBox(height: 6),
                              _DateTimeBtn(label: _fmtTime(_endTime), icon: Icons.access_time_rounded, onTap: () => _pickTime(false)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Staff + Machine row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FormLabel('Assigned Staff'),
                              const SizedBox(height: 6),
                              _DropdownField<String?>(
                                value: _staff,
                                items: [null, ..._staffList],
                                labelBuilder: (s) => s ?? 'None',
                                onChanged: (s) => setState(() => _staff = s),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FormLabel('Machine'),
                              const SizedBox(height: 6),
                              _DropdownField<String?>(
                                value: _machine,
                                items: [null, ..._machineList],
                                labelBuilder: (m) => m ?? 'None',
                                onChanged: (m) => setState(() => _machine = m),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Location
                    _FormLabel('Location'),
                    const SizedBox(height: 6),
                    _DropdownField<String?>(
                      value: _location,
                      items: [null, ..._locationList],
                      labelBuilder: (l) => l ?? 'None',
                      onChanged: (l) => setState(() => _location = l),
                    ),
                    const SizedBox(height: 16),

                    // Admin task toggle
                    GestureDetector(
                      onTap: () => setState(() => _isAdminTask = !_isAdminTask),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _isAdminTask ? _C.amberLight : _C.bg,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: _isAdminTask ? _C.amber.withOpacity(0.4) : _C.border),
                        ),
                        child: Row(
                          children: [
                            Icon(_isAdminTask ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded, color: _isAdminTask ? _C.amber : _C.textMuted, size: 20),
                            const SizedBox(width: 10),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mark as Admin Task', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.textPrimary)),
                                Text('Appears in admin task reminders and badges', style: TextStyle(fontSize: 11, color: _C.textMuted)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Footer actions
            Container(
              padding: const EdgeInsets.fromLTRB(24, 14, 24, 20),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: _C.border)),
                color: _C.bg,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel', style: TextStyle(color: _C.textSecondary)),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: _save,
                    icon: Icon(isEdit ? Icons.save_rounded : Icons.add_rounded, size: 16),
                    label: Text(isEdit ? 'Save Changes' : 'Create Event'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _C.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
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
//  FORM FIELD HELPERS
// ─────────────────────────────────────────────
class _FormLabel extends StatelessWidget {
  final String text;
  const _FormLabel(this.text);
  @override
  Widget build(BuildContext context) => Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _C.textSecondary));
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  const _TextField({required this.controller, required this.hint, this.maxLines = 1});
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(9), border: Border.all(color: _C.border)),
    child: TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 13, color: _C.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: _C.textMuted),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    ),
  );
}

class _DropdownField<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final String Function(T) labelBuilder;
  final ValueChanged<T?> onChanged;
  const _DropdownField({required this.value, required this.items, required this.labelBuilder, required this.onChanged});
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(9), border: Border.all(color: _C.border)),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: value,
        isExpanded: true,
        style: const TextStyle(fontSize: 13, color: _C.textPrimary),
        icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: _C.textMuted),
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(labelBuilder(item)))).toList(),
        onChanged: onChanged,
      ),
    ),
  );
}

class _DateTimeBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _DateTimeBtn({required this.label, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(9), border: Border.all(color: _C.border)),
      child: Row(
        children: [
          Icon(icon, size: 14, color: _C.indigo),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _C.textPrimary)),
        ],
      ),
    ),
  );
}

// ─────────────────────────────────────────────
//  SMALL HELPERS
// ─────────────────────────────────────────────
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

class _StatChip extends StatelessWidget {
  final String label, value;
  final Color color;
  final IconData icon;
  const _StatChip({required this.label, required this.value, required this.color, required this.icon});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withOpacity(0.15))),
    child: Row(children: [
      Icon(icon, size: 13, color: color),
      const SizedBox(width: 6),
      Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: color)),
      const SizedBox(width: 5),
      Text(label, style: TextStyle(fontSize: 11, color: color.withOpacity(0.8))),
    ]),
  );
}

class _FilterDropdown extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _FilterDropdown({required this.label, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: _C.border)),
      child: Row(children: [
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
        const SizedBox(width: 4),
        const Icon(Icons.keyboard_arrow_down_rounded, size: 14, color: _C.textMuted),
      ]),
    ),
  );
}

class _NavBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _NavBtn({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: _C.border)),
      child: Icon(icon, size: 16, color: _C.textSecondary),
    ),
  );
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final Color color, light;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.color, required this.light, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(color: light, borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withOpacity(0.2))),
      child: Icon(icon, size: 15, color: color),
    ),
  );
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

class _PickerOption {
  final String label;
  final VoidCallback onTap;
  const _PickerOption({required this.label, required this.onTap});
}

class _PickerSheet extends StatelessWidget {
  final String title;
  final List<_PickerOption> options;
  const _PickerSheet({required this.title, required this.options});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _C.textPrimary)),
        const SizedBox(height: 14),
        ...options.map((o) => ListTile(title: Text(o.label, style: const TextStyle(fontSize: 14, color: _C.textPrimary)), onTap: o.onTap, contentPadding: EdgeInsets.zero, dense: true)),
      ],
    ),
  );
}

// ─────────────────────────────────────────────
//  META HELPERS
// ─────────────────────────────────────────────
({Color color, Color light, String label, IconData icon}) _typeMeta(EventType t) => switch (t) {
  EventType.requestApproval => (color: _C.rose, light: _C.roseLight, label: 'Approval', icon: Icons.pending_actions_rounded),
  EventType.maintenance => (color: _C.amber, light: _C.amberLight, label: 'Maintenance', icon: Icons.build_rounded),
  EventType.meeting => (color: _C.indigo, light: _C.indigoLight, label: 'Meeting', icon: Icons.groups_rounded),
  EventType.machineUsage => (color: _C.emerald, light: _C.emeraldLight, label: 'Machine Use', icon: Icons.precision_manufacturing_rounded),
  EventType.adminTask => (color: _C.violet, light: _C.violetLight, label: 'Admin Task', icon: Icons.assignment_rounded),
};

({Color color, Color light, String label}) _statusMeta(EventStatus s) => switch (s) {
  EventStatus.pending => (color: _C.amber, light: _C.amberLight, label: 'Pending'),
  EventStatus.inProgress => (color: _C.indigo, light: _C.indigoLight, label: 'In Progress'),
  EventStatus.completed => (color: _C.emerald, light: _C.emeraldLight, label: 'Completed'),
  EventStatus.canceled => (color: _C.slate, light: _C.slateLight, label: 'Canceled'),
  EventStatus.approved => (color: _C.emerald, light: _C.emeraldLight, label: 'Approved'),
  EventStatus.rejected => (color: _C.rose, light: _C.roseLight, label: 'Rejected'),
};

String _statusLabel(EventStatus s) => _statusMeta(s).label;
Color _statusColor(EventStatus s) => _statusMeta(s).color;

// ─────────────────────────────────────────────
//  STRING HELPERS
// ─────────────────────────────────────────────
bool _isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

String _fmtTime(DateTime dt) {
  final h = dt.hour.toString().padLeft(2, '0');
  final m = dt.minute.toString().padLeft(2, '0');
  return '$h:$m';
}

String _fmtDateShort(DateTime dt) {
  const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  return '${months[dt.month - 1]} ${dt.day}';
}

String _fmtDateLong(DateTime dt) {
  const months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
  const days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
  return '${days[dt.weekday - 1]}, ${months[dt.month - 1]} ${dt.day}, ${dt.year}';
}

String _fmtDuration(Duration d) {
  if (d.inHours == 0) return '${d.inMinutes}min';
  final m = d.inMinutes % 60;
  return m == 0 ? '${d.inHours}h' : '${d.inHours}h ${m}m';
}

String _weekdayShort(int wd) => ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'][wd - 1];
String _monthName(int m) => ['January','February','March','April','May','June','July','August','September','October','November','December'][m - 1];