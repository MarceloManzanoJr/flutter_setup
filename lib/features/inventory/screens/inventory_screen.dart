import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  DESIGN TOKENS
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
  static const orange = Color(0xFFEA580C);
  static const orangeLight = Color(0xFFFFEDD5);
  static const textPrimary = Color(0xFF0F172A);
  static const textSecondary = Color(0xFF64748B);
  static const textMuted = Color(0xFF94A3B8);
}

// ─────────────────────────────────────────────
//  MODELS
// ─────────────────────────────────────────────
enum MaterialCategory { filament, resin, powder, sparePart, consumable }

enum StockLevel { critical, low, adequate, overstocked }

class UsageEntry {
  final String projectId;
  final String projectName;
  final double amountUsed;
  final String unit;
  final DateTime usedAt;

  const UsageEntry({
    required this.projectId,
    required this.projectName,
    required this.amountUsed,
    required this.unit,
    required this.usedAt,
  });
}

class ReorderHistory {
  final DateTime orderedAt;
  final double quantity;
  final String unit;
  final double cost;
  final String supplier;
  final String status; // 'Delivered' | 'In Transit' | 'Pending'

  const ReorderHistory({
    required this.orderedAt,
    required this.quantity,
    required this.unit,
    required this.cost,
    required this.supplier,
    required this.status,
  });
}

class InventoryItem {
  final String id;
  final String name;
  final String brand;
  final MaterialCategory category;
  final String unit; // 'rolls', 'bottles', 'kg', 'pcs', etc.
  final double currentStock;
  final double minStock; // triggers low alert
  final double criticalStock; // triggers critical alert
  final double maxStock;
  final double reorderQty;
  final double costPerUnit;
  final String sku;
  final String location; // shelf/bin location
  final DateTime lastRestocked;
  final DateTime? expiryDate;
  final Color itemColor; // for filament color
  final bool autoReorder;
  final String supplier;
  final List<UsageEntry> recentUsage;
  final List<ReorderHistory> reorderHistory;
  final String? compatiblePrinters;

  const InventoryItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.unit,
    required this.currentStock,
    required this.minStock,
    required this.criticalStock,
    required this.maxStock,
    required this.reorderQty,
    required this.costPerUnit,
    required this.sku,
    required this.location,
    required this.lastRestocked,
    this.expiryDate,
    required this.itemColor,
    required this.autoReorder,
    required this.supplier,
    required this.recentUsage,
    required this.reorderHistory,
    this.compatiblePrinters,
  });

  StockLevel get stockLevel {
    if (currentStock <= criticalStock) return StockLevel.critical;
    if (currentStock <= minStock) return StockLevel.low;
    if (currentStock >= maxStock * 0.9) return StockLevel.overstocked;
    return StockLevel.adequate;
  }

  double get stockPercent => (currentStock / maxStock).clamp(0.0, 1.0);

  double get weeklyUsage {
    final cutoff = DateTime.now().subtract(const Duration(days: 7));
    return recentUsage
        .where((u) => u.usedAt.isAfter(cutoff))
        .fold(0.0, (sum, u) => sum + u.amountUsed);
  }

  double get totalUsageValue => recentUsage.fold(0.0, (s, u) => s + u.amountUsed * costPerUnit);
}

// ─────────────────────────────────────────────
//  SAMPLE DATA
// ─────────────────────────────────────────────
final List<InventoryItem> _inventory = [
  // ── FILAMENTS ──
  InventoryItem(
    id: 'INV-001', name: 'PLA Filament — Black', brand: 'Bambu Lab',
    category: MaterialCategory.filament, unit: 'rolls',
    currentStock: 3, minStock: 5, criticalStock: 2, maxStock: 20,
    reorderQty: 10, costPerUnit: 320.00, sku: 'BL-PLA-BLK-1KG',
    location: 'Shelf A1', lastRestocked: DateTime.now().subtract(const Duration(days: 12)),
    itemColor: Colors.black87, autoReorder: true, supplier: 'Bambu Lab PH',
    compatiblePrinters: 'Bambu X1, Bambu P1S',
    recentUsage: [
      UsageEntry(projectId: 'JOB-884', projectName: 'bracket_v3_final', amountUsed: 0.8, unit: 'rolls', usedAt: DateTime.now().subtract(const Duration(hours: 3))),
      UsageEntry(projectId: 'JOB-877', projectName: 'enclosure_base', amountUsed: 1.2, unit: 'rolls', usedAt: DateTime.now().subtract(const Duration(days: 2))),
      UsageEntry(projectId: 'JOB-861', projectName: 'gear_prototype', amountUsed: 0.5, unit: 'rolls', usedAt: DateTime.now().subtract(const Duration(days: 4))),
    ],
    reorderHistory: [
      ReorderHistory(orderedAt: DateTime.now().subtract(const Duration(days: 30)), quantity: 10, unit: 'rolls', cost: 3200, supplier: 'Bambu Lab PH', status: 'Delivered'),
    ],
  ),
  InventoryItem(
    id: 'INV-002', name: 'PLA Filament — White', brand: 'Bambu Lab',
    category: MaterialCategory.filament, unit: 'rolls',
    currentStock: 10, minStock: 5, criticalStock: 2, maxStock: 20,
    reorderQty: 10, costPerUnit: 320.00, sku: 'BL-PLA-WHT-1KG',
    location: 'Shelf A2', lastRestocked: DateTime.now().subtract(const Duration(days: 5)),
    itemColor: Colors.white, autoReorder: true, supplier: 'Bambu Lab PH',
    compatiblePrinters: 'Bambu X1, Bambu P1S, Prusa MK4',
    recentUsage: [
      UsageEntry(projectId: 'JOB-891', projectName: 'phone_stand_v2', amountUsed: 0.3, unit: 'rolls', usedAt: DateTime.now().subtract(const Duration(hours: 1))),
      UsageEntry(projectId: 'JOB-880', projectName: 'product_mockup', amountUsed: 1.1, unit: 'rolls', usedAt: DateTime.now().subtract(const Duration(days: 1))),
    ],
    reorderHistory: [],
  ),
  InventoryItem(
    id: 'INV-003', name: 'PETG Filament — Clear', brand: 'Prusa',
    category: MaterialCategory.filament, unit: 'rolls',
    currentStock: 2, minStock: 4, criticalStock: 1, maxStock: 15,
    reorderQty: 8, costPerUnit: 380.00, sku: 'PR-PETG-CLR-1KG',
    location: 'Shelf A3', lastRestocked: DateTime.now().subtract(const Duration(days: 18)),
    itemColor: Colors.cyan.shade200, autoReorder: false, supplier: 'Prusa Research',
    compatiblePrinters: 'Prusa MK4, Creality K1',
    recentUsage: [
      UsageEntry(projectId: 'JOB-891', projectName: 'phone_stand_v2', amountUsed: 0.9, unit: 'rolls', usedAt: DateTime.now().subtract(const Duration(hours: 5))),
      UsageEntry(projectId: 'JOB-872', projectName: 'enclosure_lid', amountUsed: 0.7, unit: 'rolls', usedAt: DateTime.now().subtract(const Duration(days: 3))),
    ],
    reorderHistory: [],
  ),
  InventoryItem(
    id: 'INV-004', name: 'ABS Filament — Grey', brand: 'eSUN',
    category: MaterialCategory.filament, unit: 'rolls',
    currentStock: 7, minStock: 4, criticalStock: 2, maxStock: 16,
    reorderQty: 8, costPerUnit: 295.00, sku: 'ES-ABS-GRY-1KG',
    location: 'Shelf A4', lastRestocked: DateTime.now().subtract(const Duration(days: 8)),
    itemColor: Colors.grey.shade500, autoReorder: true, supplier: 'eSUN Philippines',
    compatiblePrinters: 'Voron 2.4, Bambu X1 (AMS)',
    recentUsage: [
      UsageEntry(projectId: 'JOB-895', projectName: 'industrial_clamp', amountUsed: 1.5, unit: 'rolls', usedAt: DateTime.now().subtract(const Duration(hours: 1))),
    ],
    reorderHistory: [],
  ),
  InventoryItem(
    id: 'INV-005', name: 'TPU Filament — Blue', brand: 'Bambu Lab',
    category: MaterialCategory.filament, unit: 'rolls',
    currentStock: 1, minStock: 3, criticalStock: 1, maxStock: 10,
    reorderQty: 5, costPerUnit: 490.00, sku: 'BL-TPU-BLU-1KG',
    location: 'Shelf A5', lastRestocked: DateTime.now().subtract(const Duration(days: 22)),
    itemColor: Colors.blue.shade400, autoReorder: false, supplier: 'Bambu Lab PH',
    compatiblePrinters: 'Bambu X1, Prusa MK4',
    recentUsage: [
      UsageEntry(projectId: 'JOB-888', projectName: 'phone_case_prototype', amountUsed: 0.6, unit: 'rolls', usedAt: DateTime.now().subtract(const Duration(days: 1))),
    ],
    reorderHistory: [],
  ),
  InventoryItem(
    id: 'INV-006', name: 'Carbon Fibre PLA — Black', brand: 'Bambu Lab',
    category: MaterialCategory.filament, unit: 'rolls',
    currentStock: 4, minStock: 3, criticalStock: 1, maxStock: 12,
    reorderQty: 6, costPerUnit: 780.00, sku: 'BL-CFPLA-BLK-1KG',
    location: 'Shelf A6', lastRestocked: DateTime.now().subtract(const Duration(days: 3)),
    itemColor: const Color(0xFF2D2D2D), autoReorder: true, supplier: 'Bambu Lab PH',
    compatiblePrinters: 'Bambu X1 only (hardened nozzle)',
    recentUsage: [
      UsageEntry(projectId: 'JOB-885', projectName: 'drone_frame_v7', amountUsed: 1.0, unit: 'rolls', usedAt: DateTime.now().subtract(const Duration(days: 1))),
    ],
    reorderHistory: [],
  ),

  // ── RESIN ──
  InventoryItem(
    id: 'INV-007', name: 'Standard Resin — Grey', brand: 'Elegoo',
    category: MaterialCategory.resin, unit: 'bottles',
    currentStock: 2, minStock: 4, criticalStock: 1, maxStock: 12,
    reorderQty: 6, costPerUnit: 650.00, sku: 'EL-STD-GRY-500ML',
    location: 'Cabinet B1', lastRestocked: DateTime.now().subtract(const Duration(days: 14)),
    expiryDate: DateTime.now().add(const Duration(days: 90)),
    itemColor: Colors.grey.shade400, autoReorder: false, supplier: 'Elegoo Official PH',
    compatiblePrinters: 'Elegoo Saturn 4 Ultra',
    recentUsage: [
      UsageEntry(projectId: 'JOB-870', projectName: 'miniature_figurine', amountUsed: 0.8, unit: 'bottles', usedAt: DateTime.now().subtract(const Duration(days: 3))),
    ],
    reorderHistory: [],
  ),
  InventoryItem(
    id: 'INV-008', name: 'ABS-Like Resin — Clear', brand: 'Anycubic',
    category: MaterialCategory.resin, unit: 'bottles',
    currentStock: 6, minStock: 3, criticalStock: 1, maxStock: 10,
    reorderQty: 4, costPerUnit: 720.00, sku: 'AC-ABS-CLR-500ML',
    location: 'Cabinet B2', lastRestocked: DateTime.now().subtract(const Duration(days: 7)),
    expiryDate: DateTime.now().add(const Duration(days: 120)),
    itemColor: Colors.cyan.shade100, autoReorder: true, supplier: 'Anycubic PH Reseller',
    compatiblePrinters: 'Elegoo Saturn 4 Ultra, Anycubic Photon',
    recentUsage: [],
    reorderHistory: [],
  ),

  // ── POWDER ──
  InventoryItem(
    id: 'INV-009', name: 'Nylon PA12 Powder', brand: 'Sinterit',
    category: MaterialCategory.powder, unit: 'kg',
    currentStock: 1.5, minStock: 5, criticalStock: 2, maxStock: 20,
    reorderQty: 10, costPerUnit: 4200.00, sku: 'ST-PA12-PWD-1KG',
    location: 'Vault C1', lastRestocked: DateTime.now().subtract(const Duration(days: 25)),
    itemColor: Colors.grey.shade300, autoReorder: false, supplier: 'Sinterit Global',
    compatiblePrinters: 'Sinterit Lisa Pro (SLS)',
    recentUsage: [
      UsageEntry(projectId: 'JOB-860', projectName: 'industrial_bracket_sls', amountUsed: 2.0, unit: 'kg', usedAt: DateTime.now().subtract(const Duration(days: 5))),
      UsageEntry(projectId: 'JOB-845', projectName: 'functional_hinge', amountUsed: 1.5, unit: 'kg', usedAt: DateTime.now().subtract(const Duration(days: 10))),
    ],
    reorderHistory: [
      ReorderHistory(orderedAt: DateTime.now().subtract(const Duration(days: 25)), quantity: 10, unit: 'kg', cost: 42000, supplier: 'Sinterit Global', status: 'Delivered'),
    ],
  ),

  // ── SPARE PARTS ──
  InventoryItem(
    id: 'INV-010', name: 'Brass Nozzle 0.4mm', brand: 'E3D',
    category: MaterialCategory.sparePart, unit: 'pcs',
    currentStock: 8, minStock: 5, criticalStock: 2, maxStock: 20,
    reorderQty: 10, costPerUnit: 150.00, sku: 'E3D-NOZ-BRS-04',
    location: 'Drawer D1', lastRestocked: DateTime.now().subtract(const Duration(days: 10)),
    itemColor: const Color(0xFFD4A853), autoReorder: true, supplier: 'E3D Online',
    recentUsage: [
      UsageEntry(projectId: 'MAINT-014', projectName: 'Prusa MK4 nozzle swap', amountUsed: 1, unit: 'pcs', usedAt: DateTime.now().subtract(const Duration(days: 4))),
    ],
    reorderHistory: [],
  ),
  InventoryItem(
    id: 'INV-011', name: 'Hardened Steel Nozzle 0.4mm', brand: 'E3D',
    category: MaterialCategory.sparePart, unit: 'pcs',
    currentStock: 2, minStock: 4, criticalStock: 1, maxStock: 10,
    reorderQty: 5, costPerUnit: 480.00, sku: 'E3D-NOZ-HST-04',
    location: 'Drawer D1', lastRestocked: DateTime.now().subtract(const Duration(days: 20)),
    itemColor: const Color(0xFF6B7280), autoReorder: false, supplier: 'E3D Online',
    recentUsage: [
      UsageEntry(projectId: 'MAINT-012', projectName: 'Bambu X1 nozzle swap', amountUsed: 1, unit: 'pcs', usedAt: DateTime.now().subtract(const Duration(days: 7))),
    ],
    reorderHistory: [],
  ),
  InventoryItem(
    id: 'INV-012', name: 'Build Plate PEI Sheet', brand: 'Bambu Lab',
    category: MaterialCategory.sparePart, unit: 'pcs',
    currentStock: 5, minStock: 3, criticalStock: 1, maxStock: 12,
    reorderQty: 6, costPerUnit: 890.00, sku: 'BL-PEI-256MM',
    location: 'Drawer D3', lastRestocked: DateTime.now().subtract(const Duration(days: 6)),
    itemColor: AppColors.amber, autoReorder: true, supplier: 'Bambu Lab PH',
    recentUsage: [],
    reorderHistory: [],
  ),

  // ── CONSUMABLES ──
  InventoryItem(
    id: 'INV-013', name: 'Isopropyl Alcohol 99%', brand: 'Generic',
    category: MaterialCategory.consumable, unit: 'bottles',
    currentStock: 3, minStock: 5, criticalStock: 2, maxStock: 15,
    reorderQty: 8, costPerUnit: 110.00, sku: 'GEN-IPA-99-500ML',
    location: 'Cabinet E1', lastRestocked: DateTime.now().subtract(const Duration(days: 9)),
    itemColor: Colors.blue.shade100, autoReorder: true, supplier: 'Local Supplier',
    recentUsage: [
      UsageEntry(projectId: 'MAINT-015', projectName: 'Resin plate cleaning', amountUsed: 1, unit: 'bottles', usedAt: DateTime.now().subtract(const Duration(days: 2))),
    ],
    reorderHistory: [],
  ),
  InventoryItem(
    id: 'INV-014', name: 'Glue Stick (Bed Adhesion)', brand: 'Pritt',
    category: MaterialCategory.consumable, unit: 'pcs',
    currentStock: 12, minStock: 5, criticalStock: 2, maxStock: 20,
    reorderQty: 10, costPerUnit: 45.00, sku: 'PRT-GLUE-40G',
    location: 'Shelf F1', lastRestocked: DateTime.now().subtract(const Duration(days: 2)),
    itemColor: Colors.yellow.shade600, autoReorder: false, supplier: 'Local Supplier',
    recentUsage: [],
    reorderHistory: [],
  ),
];

// ─────────────────────────────────────────────
//  SCREEN
// ─────────────────────────────────────────────
class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String _searchQuery = '';
  MaterialCategory? _categoryFilter;
  StockLevel? _stockFilter;
  InventoryItem? _selectedItem;
  String _sortBy = 'name'; // 'name' | 'stock' | 'cost'

  List<InventoryItem> get _filtered {
    var list = List<InventoryItem>.from(_inventory);
    if (_searchQuery.isNotEmpty) {
      list = list.where((i) =>
          i.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          i.brand.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          i.sku.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
    if (_categoryFilter != null) {
      list = list.where((i) => i.category == _categoryFilter).toList();
    }
    if (_stockFilter != null) {
      list = list.where((i) => i.stockLevel == _stockFilter).toList();
    }
    list.sort((a, b) {
      if (_sortBy == 'stock') return a.stockPercent.compareTo(b.stockPercent);
      if (_sortBy == 'cost') return b.costPerUnit.compareTo(a.costPerUnit);
      return a.name.compareTo(b.name);
    });
    return list;
  }

  int get _criticalCount => _inventory.where((i) => i.stockLevel == StockLevel.critical).length;
  int get _lowCount => _inventory.where((i) => i.stockLevel == StockLevel.low).length;
  int get _alertCount => _criticalCount + _lowCount;
  double get _totalInventoryValue => _inventory.fold(0, (s, i) => s + i.currentStock * i.costPerUnit);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 32, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  if (_alertCount > 0) ...[
                    const SizedBox(height: 16),
                    _buildAlertBanner(),
                  ],
                  const SizedBox(height: 20),
                  _buildSummaryRow(),
                  const SizedBox(height: 20),
                  _buildFiltersBar(),
                  const SizedBox(height: 16),
                  _buildInventoryTable(),
                ],
              ),
            ),
          ),
          if (_selectedItem != null)
            Container(
              width: 360,
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(left: BorderSide(color: AppColors.border)),
              ),
              child: _ItemDetailPanel(
                item: _selectedItem!,
                onClose: () => setState(() => _selectedItem = null),
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
                    width: 6, height: 32,
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
                  const Text('Inventory',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.7, color: AppColors.textPrimary)),
                ],
              ),
              const SizedBox(height: 4),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text('Track materials, stock levels and reorder supplies',
                  style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
              ),
            ],
          ),
        ),
        if (_alertCount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: AppColors.roseLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.rose.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_rounded, size: 15, color: AppColors.rose),
                const SizedBox(width: 7),
                Text('$_alertCount items need attention',
                  style: const TextStyle(color: AppColors.rose, fontWeight: FontWeight.w700, fontSize: 13)),
              ],
            ),
          ),
      ],
    );
  }

  // ── ALERT BANNER ─────────────────────────────
  Widget _buildAlertBanner() {
    final criticalItems = _inventory.where((i) => i.stockLevel == StockLevel.critical).toList();
    final lowItems = _inventory.where((i) => i.stockLevel == StockLevel.low).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.08), Colors.grey.withOpacity(0.06)],
          begin: Alignment.centerLeft, end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Colors.black,
                width: 1.5,
            ),
        ),
            child: const Icon(
            Icons.inventory_2_rounded,
            color: Colors.black,
            size: 20,
            ),
        ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Stock Alert', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6, runSpacing: 4,
                  children: [
                    ...criticalItems.map((i) => _AlertChip(name: i.name, level: StockLevel.critical)),
                    ...lowItems.map((i) => _AlertChip(name: i.name, level: StockLevel.low)),
                  ],
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: () => setState(() => _stockFilter = StockLevel.critical),
            icon: const Icon(Icons.filter_list_rounded, size: 14),
            label: const Text('Show Critical'),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.rose,
              backgroundColor: AppColors.roseLight,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  // ── SUMMARY ROW ──────────────────────────────
  Widget _buildSummaryRow() {
    final filamentCount = _inventory.where((i) => i.category == MaterialCategory.filament).length;
    final totalItems = _inventory.length;

    return Row(
      children: [
        _SummaryTile(label: 'Total SKUs', value: totalItems.toString(), color: AppColors.indigo, icon: Icons.inventory_2_rounded),
        const SizedBox(width: 12),
        _SummaryTile(label: 'Critical Stock', value: _criticalCount.toString(), color: AppColors.rose, icon: Icons.warning_rounded),
        const SizedBox(width: 12),
        _SummaryTile(label: 'Low Stock', value: _lowCount.toString(), color: AppColors.amber, icon: Icons.trending_down_rounded),
        const SizedBox(width: 12),
        _SummaryTile(label: 'Filament Rolls', value: '${_inventory.where((i) => i.category == MaterialCategory.filament).fold(0.0, (s, i) => s + i.currentStock).toInt()} left', color: AppColors.violet, icon: Icons.rotate_right_rounded),
        const SizedBox(width: 12),
        _SummaryTile(label: 'Inventory Value', value: '₱${(_totalInventoryValue / 1000).toStringAsFixed(1)}k', color: AppColors.emerald, icon: Icons.payments_rounded),
        const SizedBox(width: 12),
        _SummaryTile(label: 'Auto-Reorder On', value: _inventory.where((i) => i.autoReorder).length.toString(), color: AppColors.sky, icon: Icons.autorenew_rounded),
      ],
    );
  }

  // ── FILTERS BAR ──────────────────────────────
  Widget _buildFiltersBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 42,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
              decoration: const InputDecoration(
                hintText: 'Search by name, brand or SKU…',
                hintStyle: TextStyle(fontSize: 13, color: AppColors.textMuted),
                prefixIcon: Icon(Icons.search_rounded, size: 18, color: AppColors.textMuted),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Category filter
        _DropdownFilter(
          label: _categoryFilter == null ? 'All Categories' : _categoryLabel(_categoryFilter!),
          icon: Icons.category_rounded,
          color: AppColors.indigo,
          onTap: () => _showCategoryPicker(),
        ),
        const SizedBox(width: 8),
        // Stock filter
        _DropdownFilter(
          label: _stockFilter == null ? 'All Stock' : _stockLabel(_stockFilter!),
          icon: Icons.bar_chart_rounded,
          color: _stockFilter == null ? AppColors.textSecondary : _stockColor(_stockFilter!),
          onTap: () => _showStockPicker(),
        ),
        const SizedBox(width: 8),
        // Sort
        _DropdownFilter(
          label: 'Sort: ${_sortBy[0].toUpperCase()}${_sortBy.substring(1)}',
          icon: Icons.sort_rounded,
          color: AppColors.textSecondary,
          onTap: () => _showSortPicker(),
        ),
        if (_categoryFilter != null || _stockFilter != null)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: GestureDetector(
              onTap: () => setState(() { _categoryFilter = null; _stockFilter = null; }),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
                child: const Icon(Icons.close_rounded, size: 16, color: AppColors.textMuted),
              ),
            ),
          ),
      ],
    );
  }

  // ── INVENTORY TABLE ───────────────────────────
  Widget _buildInventoryTable() {
    final items = _filtered;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Row(
              children: const [
                Expanded(flex: 4, child: _TH('Material')),
                Expanded(flex: 2, child: _TH('Category')),
                Expanded(flex: 2, child: _TH('Stock Level')),
                Expanded(flex: 3, child: _TH('Quantity')),
                Expanded(flex: 2, child: _TH('Cost/Unit')),
                Expanded(flex: 2, child: _TH('Location')),
                Expanded(flex: 2, child: _TH('Auto-Reorder')),
                Expanded(flex: 2, child: _TH('Last Restocked')),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(child: Text('No items match your filters', style: TextStyle(color: AppColors.textMuted, fontSize: 14))),
            )
          else
            ...items.asMap().entries.map((e) => _InventoryRow(
              item: e.value,
              isEven: e.key.isEven,
              isSelected: _selectedItem?.id == e.value.id,
              onTap: () => setState(() {
                _selectedItem = _selectedItem?.id == e.value.id ? null : e.value;
              }),
            )),
        ],
      ),
    );
  }

  // ── PICKERS ─────────────────────────────────
  void _showCategoryPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => _PickerSheet(
        title: 'Filter by Category',
        options: [
          _PickerOption(label: 'All Categories', onTap: () { setState(() => _categoryFilter = null); Navigator.pop(context); }),
          ...[MaterialCategory.filament, MaterialCategory.resin, MaterialCategory.powder, MaterialCategory.sparePart, MaterialCategory.consumable]
              .map((c) => _PickerOption(label: _categoryLabel(c), onTap: () { setState(() => _categoryFilter = c); Navigator.pop(context); })),
        ],
      ),
    );
  }

  void _showStockPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => _PickerSheet(
        title: 'Filter by Stock',
        options: [
          _PickerOption(label: 'All Stock', onTap: () { setState(() => _stockFilter = null); Navigator.pop(context); }),
          ...[StockLevel.critical, StockLevel.low, StockLevel.adequate, StockLevel.overstocked]
              .map((s) => _PickerOption(label: _stockLabel(s), onTap: () { setState(() => _stockFilter = s); Navigator.pop(context); })),
        ],
      ),
    );
  }

  void _showSortPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => _PickerSheet(
        title: 'Sort By',
        options: [
          _PickerOption(label: 'Name (A–Z)', onTap: () { setState(() => _sortBy = 'name'); Navigator.pop(context); }),
          _PickerOption(label: 'Stock Level (lowest first)', onTap: () { setState(() => _sortBy = 'stock'); Navigator.pop(context); }),
          _PickerOption(label: 'Cost Per Unit (highest first)', onTap: () { setState(() => _sortBy = 'cost'); Navigator.pop(context); }),
        ],
      ),
    );
  }

  String _categoryLabel(MaterialCategory c) {
    switch (c) {
      case MaterialCategory.filament: return 'Filament';
      case MaterialCategory.resin: return 'Resin';
      case MaterialCategory.powder: return 'Powder';
      case MaterialCategory.sparePart: return 'Spare Parts';
      case MaterialCategory.consumable: return 'Consumables';
    }
  }

  String _stockLabel(StockLevel s) {
    switch (s) {
      case StockLevel.critical: return 'Critical';
      case StockLevel.low: return 'Low';
      case StockLevel.adequate: return 'Adequate';
      case StockLevel.overstocked: return 'Overstocked';
    }
  }

  Color _stockColor(StockLevel s) {
    switch (s) {
      case StockLevel.critical: return AppColors.rose;
      case StockLevel.low: return AppColors.amber;
      case StockLevel.adequate: return AppColors.emerald;
      case StockLevel.overstocked: return AppColors.sky;
    }
  }
}

// ─────────────────────────────────────────────
//  INVENTORY ROW
// ─────────────────────────────────────────────
class _InventoryRow extends StatelessWidget {
  final InventoryItem item;
  final bool isEven, isSelected;
  final VoidCallback onTap;

  const _InventoryRow({required this.item, required this.isEven, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final sl = item.stockLevel;
    final stockColor = _slColor(sl);
    final stockLight = _slLight(sl);

    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.indigoLight : isEven ? Colors.white : AppColors.bg.withOpacity(0.5),
          border: Border(left: BorderSide(color: isSelected ? AppColors.indigo : Colors.transparent, width: 3)),
        ),
        child: Row(
          children: [
            // Material name + brand
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Container(
                    width: 10, height: 10,
                    decoration: BoxDecoration(
                      color: item.itemColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black12),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        Text('${item.brand}  ·  ${item.sku}', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Category
            Expanded(
              flex: 2,
              child: _CategoryBadge(category: item.category),
            ),
            // Stock level
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: stockLight, borderRadius: BorderRadius.circular(7)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (sl == StockLevel.critical)
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(Icons.error_rounded, size: 11, color: stockColor),
                      ),
                    Text(_slLabel(sl), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: stockColor)),
                  ],
                ),
              ),
            ),
            // Quantity + bar
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${item.currentStock % 1 == 0 ? item.currentStock.toInt() : item.currentStock} / ${item.maxStock.toInt()} ${item.unit}',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: item.stockPercent,
                      backgroundColor: stockColor.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(stockColor),
                      minHeight: 4,
                    ),
                  ),
                ],
              ),
            ),
            // Cost/unit
            Expanded(
              flex: 2,
              child: Text(
                '₱${item.costPerUnit.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontFamily: 'monospace'),
              ),
            ),
            // Location
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  const Icon(Icons.location_on_rounded, size: 12, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Text(item.location, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            // Auto-reorder
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: item.autoReorder ? AppColors.emeraldLight : AppColors.bg,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(item.autoReorder ? Icons.autorenew_rounded : Icons.block_rounded,
                          size: 11, color: item.autoReorder ? AppColors.emerald : AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(item.autoReorder ? 'ON' : 'OFF',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                            color: item.autoReorder ? AppColors.emerald : AppColors.textMuted)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Last restocked
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_daysAgo(item.lastRestocked), style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  Text(_formatDate(item.lastRestocked), style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _slColor(StockLevel s) {
    switch (s) {
      case StockLevel.critical: return AppColors.rose;
      case StockLevel.low: return AppColors.amber;
      case StockLevel.adequate: return AppColors.emerald;
      case StockLevel.overstocked: return AppColors.sky;
    }
  }

  Color _slLight(StockLevel s) {
    switch (s) {
      case StockLevel.critical: return AppColors.roseLight;
      case StockLevel.low: return AppColors.amberLight;
      case StockLevel.adequate: return AppColors.emeraldLight;
      case StockLevel.overstocked: return AppColors.skyLight;
    }
  }

  String _slLabel(StockLevel s) {
    switch (s) {
      case StockLevel.critical: return 'Critical';
      case StockLevel.low: return 'Low Stock';
      case StockLevel.adequate: return 'Adequate';
      case StockLevel.overstocked: return 'Overstocked';
    }
  }

  String _daysAgo(DateTime dt) {
    final d = DateTime.now().difference(dt).inDays;
    if (d == 0) return 'Today';
    if (d == 1) return 'Yesterday';
    return '${d}d ago';
  }
}

// ─────────────────────────────────────────────
//  ITEM DETAIL PANEL
// ─────────────────────────────────────────────
class _ItemDetailPanel extends StatelessWidget {
  final InventoryItem item;
  final VoidCallback onClose;

  const _ItemDetailPanel({required this.item, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final stockColor = _stockColor(item.stockLevel);
    final stockLight = _stockLight(item.stockLevel);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Text('Item Detail', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
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

          const SizedBox(height: 20),

          // Item name block
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 16, height: 16,
                      decoration: BoxDecoration(color: item.itemColor, shape: BoxShape.circle, border: Border.all(color: Colors.black12)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(item.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textPrimary))),
                  ],
                ),
                const SizedBox(height: 6),
                Text('${item.brand}  ·  ${item.sku}', style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _CategoryBadge(category: item.category),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: stockLight, borderRadius: BorderRadius.circular(7)),
                      child: Text(_stockLabel(item.stockLevel), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: stockColor)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Stock Gauge
          const Text('Stock Status', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          _StockGauge(item: item, stockColor: stockColor),

          const SizedBox(height: 20),
          const _HDivider(),
          const SizedBox(height: 16),

          // Info details
          const Text('Details', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 10),
          _InfoRow(icon: Icons.location_on_rounded, label: 'Location', value: item.location),
          _InfoRow(icon: Icons.attach_money_rounded, label: 'Cost Per Unit', value: '₱${item.costPerUnit.toStringAsFixed(2)}', mono: true),
          _InfoRow(icon: Icons.payments_rounded, label: 'Total Value', value: '₱${(item.currentStock * item.costPerUnit).toStringAsFixed(2)}', mono: true),
          _InfoRow(icon: Icons.local_shipping_rounded, label: 'Supplier', value: item.supplier),
          _InfoRow(icon: Icons.autorenew_rounded, label: 'Reorder Qty', value: '${item.reorderQty} ${item.unit}'),
          _InfoRow(icon: Icons.autorenew_rounded, label: 'Auto-Reorder', value: item.autoReorder ? '✅ Enabled' : '❌ Disabled'),
          if (item.expiryDate != null)
            _InfoRow(icon: Icons.event_busy_rounded, label: 'Expiry Date', value: _formatDate(item.expiryDate!), valueColor: _expiryColor(item.expiryDate!)),
          if (item.compatiblePrinters != null)
            _InfoRow(icon: Icons.precision_manufacturing_rounded, label: 'Compatible With', value: item.compatiblePrinters!),

          const SizedBox(height: 20),
          const _HDivider(),
          const SizedBox(height: 16),

          // Weekly usage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Usage This Week', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              Text('${item.weeklyUsage % 1 == 0 ? item.weeklyUsage.toInt() : item.weeklyUsage} ${item.unit}',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.indigo)),
            ],
          ),
          const SizedBox(height: 10),
          if (item.recentUsage.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('No usage recorded', style: TextStyle(fontSize: 13, color: AppColors.textMuted)),
            )
          else
            ...item.recentUsage.map((u) => _UsageCard(entry: u, unit: item.unit, costPerUnit: item.costPerUnit)),

          if (item.reorderHistory.isNotEmpty) ...[
            const SizedBox(height: 20),
            const _HDivider(),
            const SizedBox(height: 16),
            const Text('Reorder History', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 10),
            ...item.reorderHistory.map((r) => _ReorderCard(record: r)),
          ],

          const SizedBox(height: 24),

          // Reorder button
          if (item.stockLevel == StockLevel.critical || item.stockLevel == StockLevel.low)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart_rounded, size: 16),
                label: Text('Reorder ${item.reorderQty} ${item.unit} Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _stockColor(StockLevel s) {
    switch (s) {
      case StockLevel.critical: return AppColors.rose;
      case StockLevel.low: return AppColors.amber;
      case StockLevel.adequate: return AppColors.emerald;
      case StockLevel.overstocked: return AppColors.sky;
    }
  }

  Color _stockLight(StockLevel s) {
    switch (s) {
      case StockLevel.critical: return AppColors.roseLight;
      case StockLevel.low: return AppColors.amberLight;
      case StockLevel.adequate: return AppColors.emeraldLight;
      case StockLevel.overstocked: return AppColors.skyLight;
    }
  }

  String _stockLabel(StockLevel s) {
    switch (s) {
      case StockLevel.critical: return 'Critical';
      case StockLevel.low: return 'Low Stock';
      case StockLevel.adequate: return 'Adequate';
      case StockLevel.overstocked: return 'Overstocked';
    }
  }

  Color _expiryColor(DateTime expiry) {
    final daysLeft = expiry.difference(DateTime.now()).inDays;
    if (daysLeft < 30) return AppColors.rose;
    if (daysLeft < 60) return AppColors.amber;
    return AppColors.emerald;
  }
}

// ─────────────────────────────────────────────
//  STOCK GAUGE WIDGET
// ─────────────────────────────────────────────
class _StockGauge extends StatelessWidget {
  final InventoryItem item;
  final Color stockColor;

  const _StockGauge({required this.item, required this.stockColor});

  @override
  Widget build(BuildContext context) {
    final pct = item.stockPercent;
    final critPct = item.criticalStock / item.maxStock;
    final minPct = item.minStock / item.maxStock;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.currentStock % 1 == 0 ? item.currentStock.toInt() : item.currentStock}',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: stockColor, letterSpacing: -1),
                  ),
                  Text('${item.unit} remaining', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Max: ${item.maxStock.toInt()} ${item.unit}', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  const SizedBox(height: 2),
                  Text('Reorder at: ${item.minStock.toInt()} ${item.unit}', style: const TextStyle(fontSize: 11, color: AppColors.amber)),
                  const SizedBox(height: 2),
                  Text('Critical: ${item.criticalStock.toInt()} ${item.unit}', style: const TextStyle(fontSize: 11, color: AppColors.rose)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Gauge bar with markers
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: pct,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(stockColor),
                  minHeight: 14,
                ),
              ),
              // Critical marker
              Positioned(
                left: critPct * (MediaQuery.of(context).size.width * 0.25),
                top: 0, bottom: 0,
                child: Container(width: 2, color: AppColors.rose.withOpacity(0.6)),
              ),
              // Min marker
              Positioned(
                left: minPct * (MediaQuery.of(context).size.width * 0.25),
                top: 0, bottom: 0,
                child: Container(width: 2, color: AppColors.amber.withOpacity(0.6)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _GaugeLegend(color: AppColors.rose, label: 'Critical'),
              const SizedBox(width: 12),
              _GaugeLegend(color: AppColors.amber, label: 'Reorder Point'),
              const Spacer(),
              Text('${(pct * 100).toInt()}% full', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: stockColor)),
            ],
          ),
        ],
      ),
    );
  }
}

class _GaugeLegend extends StatelessWidget {
  final Color color;
  final String label;
  const _GaugeLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 10, height: 3, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  USAGE & REORDER CARDS
// ─────────────────────────────────────────────
class _UsageCard extends StatelessWidget {
  final UsageEntry entry;
  final String unit;
  final double costPerUnit;

  const _UsageCard({required this.entry, required this.unit, required this.costPerUnit});

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: AppColors.indigoLight, borderRadius: BorderRadius.circular(7)),
            child: const Icon(Icons.print_rounded, size: 13, color: AppColors.indigo),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.projectName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontFamily: 'monospace')),
                Text('${entry.projectId}  ·  ${_timeAgo(entry.usedAt)}', style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${entry.amountUsed} $unit', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              Text('₱${(entry.amountUsed * costPerUnit).toStringAsFixed(0)}', style: const TextStyle(fontSize: 10, color: AppColors.violet, fontFamily: 'monospace')),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReorderCard extends StatelessWidget {
  final ReorderHistory record;
  const _ReorderCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final isDelivered = record.status == 'Delivered';
    final isTransit = record.status == 'In Transit';
    final color = isDelivered ? AppColors.emerald : isTransit ? AppColors.sky : AppColors.amber;
    final light = isDelivered ? AppColors.emeraldLight : isTransit ? AppColors.skyLight : AppColors.amberLight;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: light, borderRadius: BorderRadius.circular(7)),
            child: Icon(Icons.local_shipping_rounded, size: 13, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${record.quantity.toInt()} ${record.unit} from ${record.supplier}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                Text(_formatDate(record.orderedAt), style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(color: light, borderRadius: BorderRadius.circular(6)),
                child: Text(record.status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
              ),
              const SizedBox(height: 2),
              Text('₱${record.cost.toStringAsFixed(0)}', style: const TextStyle(fontSize: 10, color: AppColors.violet, fontFamily: 'monospace')),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  SMALL COMPONENTS
// ─────────────────────────────────────────────
class _AlertChip extends StatelessWidget {
  final String name;
  final StockLevel level;
  const _AlertChip({required this.name, required this.level});

  @override
  Widget build(BuildContext context) {
    final color = level == StockLevel.critical ? AppColors.rose : AppColors.amber;
    final light = level == StockLevel.critical ? AppColors.roseLight : AppColors.amberLight;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: light, borderRadius: BorderRadius.circular(6), border: Border.all(color: color.withOpacity(0.25))),
      child: Text(name, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final MaterialCategory category;
  const _CategoryBadge({required this.category});

  @override
  Widget build(BuildContext context) {
    final data = switch (category) {
      MaterialCategory.filament => (label: 'Filament', color: AppColors.indigo, light: AppColors.indigoLight, icon: Icons.rotate_right_rounded),
      MaterialCategory.resin => (label: 'Resin', color: AppColors.violet, light: AppColors.violetLight, icon: Icons.water_drop_rounded),
      MaterialCategory.powder => (label: 'Powder', color: AppColors.amber, light: AppColors.amberLight, icon: Icons.grain_rounded),
      MaterialCategory.sparePart => (label: 'Spare Part', color: AppColors.sky, light: AppColors.skyLight, icon: Icons.build_rounded),
      MaterialCategory.consumable => (label: 'Consumable', color: AppColors.emerald, light: AppColors.emeraldLight, icon: Icons.cleaning_services_rounded),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: data.light, borderRadius: BorderRadius.circular(7)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(data.icon, size: 10, color: data.color),
          const SizedBox(width: 4),
          Text(data.label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: data.color)),
        ],
      ),
    );
  }
}

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
          color: Colors.white, borderRadius: BorderRadius.circular(12),
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
                Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DropdownFilter extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _DropdownFilter({required this.label, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
        child: Row(
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down_rounded, size: 14, color: color),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final bool mono;
  final Color? valueColor;
  const _InfoRow({required this.icon, required this.label, required this.value, this.mono = false, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          Icon(icon, size: 13, color: AppColors.textMuted),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const Spacer(),
          Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: valueColor ?? AppColors.textPrimary, fontFamily: mono ? 'monospace' : null)),
        ],
      ),
    );
  }
}

class _TH extends StatelessWidget {
  final String label;
  const _TH(this.label);
  @override
  Widget build(BuildContext context) =>
      Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.4));
}

class _HDivider extends StatelessWidget {
  const _HDivider();
  @override
  Widget build(BuildContext context) => const Divider(height: 1, color: AppColors.border);
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 16),
          ...options.map((o) => ListTile(
            title: Text(o.label, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
            onTap: o.onTap,
            contentPadding: EdgeInsets.zero,
            dense: true,
          )),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  HELPERS
// ─────────────────────────────────────────────
String _formatDate(DateTime dt) {
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
}