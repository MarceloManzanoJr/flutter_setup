import 'package:flutter/material.dart';
import 'package:innolab_application/features/home/screens/admin_home_screen.dart';

const _adminEmail = 'admin@gmail.com';
const _adminPassword = 'admin12345678';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                  child: Row(
                    children: [
                      Text(
                      'ADVANCED MANUFACTURING Center MIMAROPA',
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
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 1000,
                          minHeight: 420,
                        ),
                        child: Material(
                          color: Colors.white,
                          shape: BeveledRectangleBorder(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(64),
                            ),
                            side: BorderSide(
                              color: Colors.grey.shade500,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: isWide
                              ? Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: _LeftPanel(theme: theme),
                                    ),
                                    SizedBox(
                                      height: 320,
                                      child: VerticalDivider(
                                        width: 64,
                                        thickness: 1,
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 3,
                                      child: _RightPanel(),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _LeftPanel(theme: theme),
                                    const SizedBox(height: 32),
                                    const Divider(),
                                    const SizedBox(height: 32),
                                    const _RightPanel(),
                                  ],
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LeftPanel extends StatelessWidget {
  const _LeftPanel({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 96,
          height: 96,
          child: Image.asset(
            'assets/logos/admin_logo.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Sign in',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'sign in using google account',
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey.shade500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Or',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialButton(
              icon: Icons.g_mobiledata,
              label: 'G',
            ),
            const SizedBox(width: 24),
            _SocialButton(
              icon: Icons.facebook,
              label: 'f',
            ),
          ],
        ),
      ],
    );
  }
}

class _RightPanel extends StatefulWidget {
  const _RightPanel();

  @override
  State<_RightPanel> createState() => _RightPanelState();
}

class _RightPanelState extends State<_RightPanel> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final isValid =
        email.toLowerCase() == _adminEmail.toLowerCase() && password == _adminPassword;

    final messenger = ScaffoldMessenger.of(context);

    if (isValid) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Admin login successful'),
          backgroundColor: Colors.green,
        ),
      );
      // TODO: Navigate to admin dashboard screen here.
    } else {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Invalid admin credentials'),
          backgroundColor: Colors.red,
        ),
      );
    }
     Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const AdminHomeScreen(),
    ),
  ); 
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            style: const TextStyle(color: Colors.black),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              labelText: 'Email or phone',
              labelStyle: TextStyle(color: Colors.grey.shade700),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Colors.blue, width: 1.5),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email or phone';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _passwordController,
            style: const TextStyle(color: Colors.black),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              labelText: 'password',
              labelStyle: TextStyle(color: Colors.grey.shade700),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Colors.blue, width: 1.5),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey.shade700,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Forgot password flow.
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Forgot password?',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: _onLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Log in'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(
        side: BorderSide(
          color: Colors.black54,
          width: 1,
        ),
      ),
      elevation: 0,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {},
        child: SizedBox(
          width: 52,
          height: 52,
          child: Center(
            child: Icon(
              icon,
              size: 28,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

