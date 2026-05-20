import 'package:flutter/material.dart';
import '../../../../shared/widget/policy_sheet_content.dart';

/// Terms and Conditions static content (reuses same structure as Privacy Policy).
const List<PolicySection> _termsSections = [
  PolicySection(heading: 'KETENTUAN PENGGUNAAN', body: 'berlaku mulai dari 31 Agustus 2024'),
  PolicySection(
    heading: 'PENGANTAR',
    body:
        'Pemberitahuan Privasi ini mulai berlaku sejak tanggal 31 Agustus 2024.\n\n'
        'Pemberitahuan Privasi berikut ini menjelaskan bagaimana kami, PT MRT Jakarta (Perseroda) '
        '("Kami" atau "PT MRT Jakarta") memperoleh, mengumpulkan, menyimpan, menguasai, '
        'menggunakan, memproses, mengolah, menganalisis, memperbaiki, melakukan pembaruan, '
        'menampilkan, mengumumkan, mentransfer, mengungkapkan dan melindungi Data Pribadi Anda '
        '("Memproses Data Pribadi" atau "Pemrosesan Data Pribadi") untuk satu atau lebih tujuan '
        'yang disebutkan dalam Pemberitahuan Privasi ini.',
  ),
  PolicySection(
    heading: 'LINGKUP KETENTUAN',
    body:
        'Ketentuan ini berlaku untuk semua pengguna dan/atau penyedia layanan ("Pengguna" '
        'atau "Anda") pada aplikasi seluler Kami (termasuk aplikasi MyMRTJ, aplikasi TVM QR MyMRTJ Lite), '
        'situs web (termasuk www.jakartamrt.co.id dan situs turunannya), fitur, layanan, dan produk.\n\n'
        'Harap baca Ketentuan ini secara menyeluruh sebelum menggunakan Aplikasi Kami.',
  ),
  PolicySection(
    heading: 'HAK DAN KEWAJIBAN PENGGUNA',
    body:
        'Pengguna wajib mematuhi semua peraturan yang berlaku di Indonesia dan ketentuan penggunaan '
        'aplikasi MyMRTJ. Pelanggaran terhadap ketentuan ini dapat mengakibatkan penangguhan atau '
        'penghapusan akun.',
  ),
  PolicySection(
    heading: 'BATASAN TANGGUNG JAWAB',
    body:
        'PT MRT Jakarta tidak bertanggung jawab atas kerugian yang timbul akibat penggunaan '
        'aplikasi di luar ketentuan yang telah ditetapkan.',
  ),
];

/// Terms and Conditions — presented as a modal bottom sheet.
class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.92,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => PolicySheetContent(
        title: 'Terms and Conditions',
        sections: _termsSections,
      ),
    );
  }
}
