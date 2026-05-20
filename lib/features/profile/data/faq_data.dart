/// Static FAQ data for the MRT Jakarta app.
library;

/// Each [FaqCategory] has a display [label] and a list of [FaqItem]s.


class FaqItem {
  final String question;
  final String answer;
  const FaqItem({required this.question, required this.answer});
}

class FaqCategory {
  final String label;
  final List<FaqItem> items;
  const FaqCategory({required this.label, required this.items});
}

const List<FaqCategory> faqCategories = [
  FaqCategory(
    label: 'Umum',
    items: [
      FaqItem(
        question: 'Bagaimana apabila saya masih ada pertanyaan dan atau kendala yang terjadi?',
        answer: 'Anda dapat menghubungi tim MRT Jakarta melalui menu Contact Us atau mengirim email ke info@jakartamrt.co.id.',
      ),
      FaqItem(
        question: 'Bagaimana cara mengisi saldo di setiap penyedia jasa sistem pembayaran terdaftar?',
        answer: 'Anda dapat mengisi saldo melalui aplikasi masing-masing penyedia pembayaran yang sudah terdaftar, seperti GoPay, OVO, dan lainnya.',
      ),
    ],
  ),
  FaqCategory(
    label: 'Pembelian Tiket Elektronik',
    items: [
      FaqItem(
        question: 'Kenapa transaksi gagal walaupun saldo cukup setelah melakukan pembelian berulang kali?',
        answer: '"Transaksi yg berulang dan mencurigakan dapat menyebabkan pemblokiran transaksi dan kegagalan pembayaran pada mitra QR silakan melakukan pengecekan dengan mitra pembayaran"',
      ),
      FaqItem(
        question: 'Apa yang harus Saya lakukan ketika Tiket tidak berhasil dibayar?',
        answer: 'Pastikan saldo Anda mencukupi dan koneksi internet stabil. Jika masalah berlanjut, hubungi customer service kami.',
      ),
      FaqItem(
        question: 'Berapa lama waktu kadaluarsa Tiket?',
        answer: 'Tiket elektronik berlaku selama 24 jam sejak pembelian. Pastikan Anda menggunakannya sebelum kadaluarsa.',
      ),
      FaqItem(
        question: 'Bagaimana cara mengajukan refund?',
        answer: 'Refund dapat diajukan melalui menu Bantuan > Contact Us dalam aplikasi MyMRTJ dengan melampirkan bukti transaksi.',
      ),
      FaqItem(
        question: 'Bagaimana cara mengganti Stasiun Tujuan?',
        answer: 'Perubahan stasiun tujuan tidak dapat dilakukan setelah tiket diterbitkan. Anda perlu membeli tiket baru.',
      ),
      FaqItem(
        question: 'Apa arti status pada tiket?',
        answer: 'Status "Active" berarti tiket siap digunakan. "Used" berarti tiket sudah dipakai. "Expired" berarti tiket sudah kadaluarsa.',
      ),
      FaqItem(
        question: 'Bagaimana cara melihat tiket yang sudah dibeli?',
        answer: 'Tiket yang sudah dibeli dapat dilihat di tab Tiket pada halaman utama aplikasi MyMRTJ.',
      ),
      FaqItem(
        question: 'Bagaimana cara pembelian Tiket Elektronik Ratangga?',
        answer: 'Buka aplikasi MyMRTJ, pilih menu Beli Tiket, pilih stasiun asal dan tujuan, pilih metode pembayaran, lalu konfirmasi pembelian.',
      ),
    ],
  ),
  FaqCategory(
    label: 'Payment Method',
    items: [
      FaqItem(
        question: 'Metode pembayaran apa saja yang tersedia?',
        answer: 'MyMRTJ mendukung berbagai metode pembayaran seperti GoPay, AstraPay, i.saku, Kredivo, Yup, serta Virtual Account bank.',
      ),
      FaqItem(
        question: 'Bagaimana cara menghubungkan dompet digital saya?',
        answer: 'Buka menu Profile > Payment, lalu aktifkan toggle pada dompet digital yang ingin dihubungkan dan ikuti instruksi selanjutnya.',
      ),
    ],
  ),
];
