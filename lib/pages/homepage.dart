import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sankalp/component/bottomnavbar.dart';
import 'package:sankalp/component/homesearchbar.dart';
import 'package:sankalp/component/ngocard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../backend/models/ngo.dart';
import '../backend/repositories/ngo_repository.dart';
import '../backend/services/auth_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _authService = AuthService();
  final _ngoRepository = NGORepository();
  bool _isLoading = true;
  List<NGO> _ngos = [];
  String? _username;
  bool _isLoggedIn = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadNgos();
  }

  Future<void> _loadUserInfo() async {
    final isLoggedIn = await _authService.isLoggedIn();

    if (isLoggedIn) {
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username');

      if (mounted) {
        setState(() {
          _isLoggedIn = true;
          _username = username;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _isLoggedIn = false;
          _username = null;
        });
      }
    }
  }

  Future<void> _loadNgos() async {
    try {
      final ngos = await _ngoRepository.getAllNgos();
      if (mounted) {
        setState(() {
          _ngos = ngos;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading NGOs: $e');
      }
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _searchNgos(String query) async {
    if (query.isEmpty) {
      _loadNgos();
      return;
    }

    setState(() {
      _isLoading = true;
      _searchQuery = query;
    });

    try {
      final results = await _ngoRepository.getNearbyNgos(query);

      if (mounted) {
        setState(() {
          _ngos = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error searching NGOs: $e');
      }
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _logout() async {
    await _authService.logout();

    if (mounted) {
      setState(() {
        _isLoggedIn = false;
        _username = null;
      });

      // Optionally navigate to login page
      // Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top colored section
          Container(
            color: const Color(0xFF39AC9E),
            width: double.infinity,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // App header with title and profile icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sankalp',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        _isLoggedIn
                            ? PopupMenuButton(
                              child: CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.9),
                                radius: 20,
                                child: const Icon(
                                  Icons.person,
                                  color: Color(0xFF39AC9E),
                                ),
                              ),
                              itemBuilder:
                                  (BuildContext context) => [
                                    PopupMenuItem(
                                      value: 'profile',
                                      child: Text(
                                        'Profile${_username != null ? ' ($_username)' : ''}',
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'logout',
                                      child: Text('Logout'),
                                    ),
                                  ],
                              onSelected: (value) {
                                if (value == 'profile') {
                                  // Navigate to profile page (implement this later)
                                } else if (value == 'logout') {
                                  _logout();
                                }
                              },
                            )
                            : InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.9),
                                radius: 20,
                                child: const Icon(
                                  Icons.login,
                                  color: Color(0xFF39AC9E),
                                ),
                              ),
                            ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    HomeSearchBar(onSearch: _searchNgos),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          // Rest of the content
          Expanded(
            child:
                _isLoading
                    ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF39AC9E),
                      ),
                    )
                    : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          // NGOs title with search results if applicable
                          Text(
                            _searchQuery.isNotEmpty
                                ? "Search results for '$_searchQuery'"
                                : "NGO's near you",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF4A4A4A),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Search result count if applicable
                          if (_searchQuery.isNotEmpty)
                            Text(
                              "${_ngos.length} result${_ngos.length != 1 ? 's' : ''} found",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          const SizedBox(height: 16),
                          // NGO listing (scrollable)
                          Expanded(
                            child:
                                _ngos.isEmpty
                                    ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.search_off,
                                            size: 64,
                                            color: Color(0xFFCCCCCC),
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            _searchQuery.isNotEmpty
                                                ? 'No NGOs found for "$_searchQuery"'
                                                : 'No NGOs available',
                                            style: const TextStyle(
                                              color: Color(0xFF757575),
                                              fontSize: 16,
                                            ),
                                          ),
                                          if (_searchQuery.isNotEmpty) ...[
                                            const SizedBox(height: 24),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _searchQuery = '';
                                                });
                                                _loadNgos();
                                              },
                                              child: const Text(
                                                'Show all NGOs',
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    )
                                    : ListView.builder(
                                      itemCount: _ngos.length,
                                      itemBuilder: (context, index) {
                                        final ngo = _ngos[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 16.0,
                                          ),
                                          child: NGOCard(
                                            name: ngo.ngoName,
                                            location:
                                                ngo.location ??
                                                'Location not specified',
                                          ),
                                        );
                                      },
                                    ),
                          ),
                          // Show login button at bottom if not logged in
                          if (!_isLoggedIn) ...[
                            const SizedBox(height: 16),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF39AC9E),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Login / Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ],
                      ),
                    ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
