/// Model representing an MRT Jakarta station.
class MrtStation {
  final String id;
  final String name;
  final int basePriceRp; // price from the northernmost station (Lebak Bulus)

  const MrtStation({required this.id, required this.name, required this.basePriceRp});
}

/// All 16 active MRT Jakarta stations (Phase 1) — north → south.
const List<MrtStation> kMrtStations = [
  MrtStation(id: 'STN-LB', name: 'Lebak Bulus Grab', basePriceRp: 3000),
  MrtStation(id: 'STN-FM', name: 'Fatmawati Indomaret', basePriceRp: 3000),
  MrtStation(id: 'STN-CP', name: 'Cipete Raya', basePriceRp: 3000),
  MrtStation(id: 'STN-HJ', name: 'Haji Nawi', basePriceRp: 3000),
  MrtStation(id: 'STN-BA', name: 'Blok A', basePriceRp: 3000),
  MrtStation(id: 'STN-BL', name: 'Blok M BCA', basePriceRp: 3000),
  MrtStation(id: 'STN-AS', name: 'ASEAN', basePriceRp: 3000),
  MrtStation(id: 'STN-SN', name: 'Senayan Mastercard', basePriceRp: 3000),
  MrtStation(id: 'STN-IS', name: 'Istora Mandiri', basePriceRp: 3000),
  MrtStation(id: 'STN-BN', name: 'Bendungan Hilir', basePriceRp: 3000),
  MrtStation(id: 'STN-ST', name: 'Setiabudi Astra', basePriceRp: 3000),
  MrtStation(id: 'STN-DK', name: 'Dukuh Atas BNI', basePriceRp: 3000),
  MrtStation(id: 'STN-HI', name: 'Bundaran HI Bank Jakarta', basePriceRp: 3000),
  MrtStation(id: 'STN-SR', name: 'Sarinah', basePriceRp: 3000),
  MrtStation(id: 'STN-MN', name: 'Monas', basePriceRp: 3000),
  MrtStation(id: 'STN-HM', name: 'Harmoni', basePriceRp: 3000),
];

/// Compute ticket price between two stations (Rp 1.000 per station hop, min Rp 3.000).
int computePrice(MrtStation from, MrtStation to) {
  final fromIdx = kMrtStations.indexOf(from);
  final toIdx = kMrtStations.indexOf(to);
  final hops = (fromIdx - toIdx).abs();
  return hops <= 1 ? 3000 : hops * 1000;
}

/// Format an int as "Rp X.000"
String formatRp(int amount) {
  final s = amount.toString();
  final buf = StringBuffer('Rp ');
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return buf.toString();
}
