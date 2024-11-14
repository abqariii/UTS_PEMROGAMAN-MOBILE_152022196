import 'package:flutter/material.dart';
import 'dart:async'; // Untuk menggunakan Timer
import 'calculator_screen.dart';
import 'bmi_screen.dart';
import 'temperature_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Variabel untuk menyimpan waktu saat ini
  String currentTime = '';
  String username = 'Daffa Faris Abqari Ramdhani'; // Username yang ditampilkan

  @override
  void initState() {
    super.initState();
    _startClock();
  }

  // Memulai timer untuk update waktu setiap detik
  void _startClock() {
    Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
  }

  // Mengupdate waktu setiap detik
  void _updateTime() {
    final DateTime now = DateTime.now();
    final String formattedTime =
        '${_getWeekday(now.weekday)}, ${now.day} ${_getMonth(now.month)} ${now.year}, ${_formatTime(now.hour)}:${_formatTime(now.minute)}:${_formatTime(now.second)}';
    setState(() {
      currentTime = formattedTime;
    });
  }

  // Mendapatkan nama hari dalam bahasa Indonesia
  String _getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return 'Senin';
      case 2:
        return 'Selasa';
      case 3:
        return 'Rabu';
      case 4:
        return 'Kamis';
      case 5:
        return 'Jumat';
      case 6:
        return 'Sabtu';
      case 7:
        return 'Minggu';
      default:
        return '';
    }
  }

  // Mendapatkan nama bulan dalam bahasa Indonesia
  String _getMonth(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }

  // Memformat jam, menit, atau detik untuk dua digit
  String _formatTime(int time) {
    return time < 10 ? '0$time' : time.toString();
  }

  // Dialog konfirmasi logout
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Column(
            children: [
              Icon(
                Icons.exit_to_app, // Ikon logout
                color: Colors.blue.shade800,
                size: 60,
              ),
              SizedBox(height: 10),
              Text(
                'Konfirmasi Logout',
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Apakah Anda yakin ingin keluar?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          actions: [
            TextButton(
              child: Text(
                'Tidak',
                style: TextStyle(color: Colors.blue.shade800),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Ya'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()), // Navigasi ke halaman login
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800, // Warna konsisten dengan login
        elevation: 10,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade300, Colors.blue.shade800], // Warna konsisten dengan login
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan salam dan nama pengguna
            Text(
              'Selamat Datang,',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            Text(
              username, // Menampilkan username
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            // Menampilkan waktu saat ini secara real-time
            Text(
              currentTime,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _buildMenuCard(
                    context,
                    'Profile',
                    Icons.person,
                    ProfileScreen(),
                  ),
                  _buildMenuCard(
                    context,
                    'Kalkulator',
                    Icons.calculate,
                    CalculatorScreen(),
                  ),
                  _buildMenuCard(
                    context,
                    'BMI Calculator',
                    Icons.monitor_weight,
                    BMIScreen(),
                  ),
                  _buildMenuCard(
                    context,
                    'Konversi Suhu',
                    Icons.thermostat,
                    TemperatureScreen(),
                  ),
                ],
              ),
            ),
            // Tombol logout
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.logout, color: Colors.white), // Warna ikon menjadi putih
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white), // Warna teks menjadi putih
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800, // Warna konsisten dengan appbar
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadowColor: Colors.black.withOpacity(0.3),
                  elevation: 5,
                ),
                onPressed: () => _showLogoutDialog(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Membuat menu card untuk GridView
  Widget _buildMenuCard(
      BuildContext context, String title, IconData icon, Widget screen) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: Colors.blue.shade800, // Warna konsisten dengan tema
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
