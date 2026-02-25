import 'package:flutter/material.dart';
import '../../../app/routes.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/local_storage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  
  DateTime? _dateOfBirth;
  String _userType = 'PATIENT';
  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (_dateOfBirth == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Date de naissance requise')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await ApiClient().register({
        'phone_number': _phoneController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'password2': _password2Controller.text,
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'date_of_birth': '${_dateOfBirth!.year}-${_dateOfBirth!.month.toString().padLeft(2, '0')}-${_dateOfBirth!.day.toString().padLeft(2, '0')}',
        'country': 'Cameroun',
        'city': 'Yaounde',
        'neighborhood': 'Centre',
        'user_type': _userType,
      });

      if (response.statusCode == 201) {
        await LocalStorage.saveToken(response.data['tokens']['access']);
        await LocalStorage.saveUserId(response.data['user']['id'].toString());
        
        if (!mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✓ Inscription réussie !'), backgroundColor: Colors.green),
        );

        String route = _userType == 'MEDECIN' 
            ? AppRoutes.doctorDashboard 
            : _userType == 'HOPITAL' 
                ? AppRoutes.hospitalDashboard 
                : AppRoutes.home;
        
        Navigator.pushReplacementNamed(context, route);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Type de compte', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _userType,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: const [
                  DropdownMenuItem(value: 'PATIENT', child: Text('Patient')),
                  DropdownMenuItem(value: 'MEDECIN', child: Text('Médecin')),
                  DropdownMenuItem(value: 'HOPITAL', child: Text('Hôpital')),
                ],
                onChanged: (val) => setState(() => _userType = val!),
              ),
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _firstNameController,
                validator: (v) => v?.isEmpty == true ? 'Requis' : null,
                decoration: InputDecoration(
                  labelText: 'Prénom *',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                validator: (v) => v?.isEmpty == true ? 'Requis' : null,
                decoration: InputDecoration(
                  labelText: 'Nom *',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) setState(() => _dateOfBirth = date);
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Date de naissance *',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  child: Text(
                    _dateOfBirth != null 
                        ? '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}'
                        : 'Sélectionner',
                    style: TextStyle(color: _dateOfBirth != null ? Colors.black : Colors.grey),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                validator: (v) => v?.isEmpty == true ? 'Requis' : null,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Téléphone *',
                  hintText: '+237 6XX XXX XXX',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email (optionnel)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                validator: (v) => v == null || v.length < 6 ? 'Min 6 caractères' : null,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe *',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _password2Controller,
                validator: (v) => v != _passwordController.text ? 'Mots de passe différents' : null,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmer mot de passe *',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('S\'inscrire', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
