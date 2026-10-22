import 'package:flutter/material.dart';

import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

/// UI states required by Activity 9.
/// idle    = form ready / report list shown
/// loading = async submit in progress
/// success = report submitted (SIMULATED)
/// empty   = no reports yet
/// error   = submit failed (SIMULATED)
enum ReportUiState { idle, loading, success, empty, error }

class _Report {
  const _Report({
    required this.title,
    required this.category,
    required this.location,
    required this.submittedAt,
  });

  final String title;
  final String category;
  final String location;
  final String submittedAt;
}

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  static const _categories = <String>[
    'Equipment problem',
    'Inventory issue',
    'Order problem',
    'Customer feedback',
    'Other',
  ];

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleFocus = FocusNode();

  final List<_Report> _reports = [];
  String? _category;
  bool _simulateFailure = false;
  ReportUiState _uiState = ReportUiState.empty; // no reports yet

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _titleFocus.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------- logic

  Future<void> _submitReport() async {
    if (_uiState == ReportUiState.loading) return; // block duplicate submits
    if (!_formKey.currentState!.validate()) return; // field-level validation

    setState(() => _uiState = ReportUiState.loading);

    try {
      // SIMULATED request. Replace with a REST API call in services/ later.
      await Future<void>.delayed(const Duration(seconds: 3));
      if (_simulateFailure) throw Exception('Simulated failure');
      if (!mounted) return;

      _reports.insert(
        0,
        _Report(
          title: _titleController.text.trim(),
          category: _category!,
          location: _locationController.text.trim(),
          submittedAt: TimeOfDay.now().format(context),
        ),
      );
      setState(() => _uiState = ReportUiState.success);
    } catch (_) {
      if (!mounted) return;
      setState(() => _uiState = ReportUiState.error);
    }
  }

  /// Retry: switches the simulated failure off, then resubmits.
  void _retry() {
    setState(() => _simulateFailure = false);
    _submitReport();
  }

  void _resetForm() {
    _titleController.clear();
    _locationController.clear();
    _descriptionController.clear();
    _formKey.currentState?.reset();
    setState(() {
      _category = null;
      _uiState = _reports.isEmpty ? ReportUiState.empty : ReportUiState.idle;
    });
  }

  // ------------------------------------------------------------------ UI

  @override
  Widget build(BuildContext context) {
    final isLoading = _uiState == ReportUiState.loading;

    return Scaffold(
      appBar: AppBar(title: const Text('BrewHaven - Report an Issue')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildForm(isLoading),
                const SizedBox(height: 24),
                _buildStatePanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(bool isLoading) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: _titleController,
            label: 'Report title',
            validator: (v) {
              final value = v?.trim() ?? '';
              if (value.isEmpty) return 'Report title is required.';
              if (value.length < 5) return 'Use at least 5 characters.';
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _category,
            decoration: const InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
            items: _categories
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: isLoading ? null : (v) => setState(() => _category = v),
            validator: (v) => v == null ? 'Please choose a category.' : null,
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: _locationController,
            label: 'Location / Station (e.g., Counter 2, Storage)',
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'Location is required.'
                : null,
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: _descriptionController,
            label: 'Description',
            maxLines: 4,
            validator: (v) {
              final value = v?.trim() ?? '';
              if (value.isEmpty) return 'Description is required.';
              if (value.length < 10) {
                return 'Please describe the issue in at least 10 characters.';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Simulate server failure (demo only)'),
            subtitle: const Text('Turn on to demonstrate the Error state.'),
            value: _simulateFailure,
            onChanged: isLoading
                ? null
                : (v) => setState(() => _simulateFailure = v),
          ),
          const SizedBox(height: 8),
          AppButton(
            label: isLoading ? 'Submitting...' : 'Submit Report',
            onPressed: isLoading ? null : _submitReport, // disabled while loading
          ),
        ],
      ),
    );
  }

  Widget _buildStatePanel() {
    switch (_uiState) {
      case ReportUiState.loading:
        return _StatusCard(
          icon: const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
          title: 'Submitting your report...',
          message: 'Please wait. The submit button is disabled until this '
              'finishes (simulated 3-second request).',
        );

      case ReportUiState.success:
        return _StatusCard(
          icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
          title: 'Report submitted successfully',
          message: 'Your report was recorded (simulated - no database record '
              'was saved).',
          actions: [
            AppButton(label: 'Submit Another Report', onPressed: _resetForm),
          ],
        );

      case ReportUiState.error:
        return _StatusCard(
          icon: const Icon(Icons.error, color: Colors.red, size: 48),
          title: 'Submission failed',
          message: 'We could not send your report (simulated failure). '
              'Check your details and try again.',
          actions: [
            AppButton(label: 'Retry', onPressed: _retry),
            TextButton(
              onPressed: () => setState(() => _uiState = ReportUiState.idle),
              child: const Text('Edit details'),
            ),
          ],
        );

      case ReportUiState.empty:
        return _StatusCard(
          icon: const Icon(Icons.inbox_outlined, size: 48),
          title: 'No reports yet',
          message: 'There are no submitted reports to show. Fill out the '
              'form above to create your first one.',
          actions: [
            TextButton(
              onPressed: _titleFocus.requestFocus,
              child: const Text('Start a report'),
            ),
          ],
        );

      case ReportUiState.idle:
        if (_reports.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Submitted reports (${_reports.length})',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            for (final r in _reports)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: Text(r.title),
                  subtitle: Text('${r.category} - ${r.location}'),
                  trailing: Text(r.submittedAt),
                ),
              ),
          ],
        );
    }
  }
}

/// Reusable card used by every state response.
class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.icon,
    required this.title,
    required this.message,
    this.actions = const [],
  });

  final Widget icon;
  final String title;
  final String message;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            icon,
            const SizedBox(height: 16),
            Text(title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
            if (actions.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: actions,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
