import 'package:flutter/material.dart';

void main() => runApp(const DigitalizApp());
class DigitalizApp extends StatelessWidget {
  const DigitalizApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}

// PAGE LOGIN PAR CODE
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final codeCtrl = TextEditingController();
  String error = "";
  void login() {
    String c = codeCtrl.text.trim().toUpperCase();
    if (c.startsWith("PROV")) Navigator.push(context, MaterialPageRoute(builder: (_) => Dashboard(role: "PROVISEUR", nom: "M. le Proviseur")));
    else if (c.startsWith("GEST")) Navigator.push(context, MaterialPageRoute(builder: (_) => Dashboard(role: "GESTIONNAIRE", nom: "Mme la Gestionnaire")));
    else if (c.startsWith("PROF")) Navigator.push(context, MaterialPageRoute(builder: (_) => Dashboard(role: "PROFESSEUR", nom: "Prof. Koumba")));
    else if (c.startsWith("PARENT")) Navigator.push(context, MaterialPageRoute(builder: (_) => ParentDashboard(enfant: "Aminata Diallo - 5e A", solde: 15000)));
    else setState(()=> error = "Code invalide. Essaie: PROV-2026, GEST-2026, PROF-2026, PARENT-EL420");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFF1447C1),
      body: Padding(padding: EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.school, size: 60, color: Colors.white),
        Text("DIGITALIZ SCHOOL", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
        SizedBox(height: 8),
        Text("Pour écoles francophones - Pointe-Noire", style: TextStyle(color: Colors.white70)),
        SizedBox(height: 30),
        Container(padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            Text("Entrez votre code d'accès", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(controller: codeCtrl, decoration: InputDecoration(hintText: "Ex: PROV-2026", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            SizedBox(height: 10),
            if(error.isNotEmpty) Text(error, style: TextStyle(color: Colors.red, fontSize: 12)),
            SizedBox(height: 10),
            ElevatedButton(onPressed: login, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1447C1), minimumSize: Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Text("ENTRER", style: TextStyle(color: Colors.white))),
            SizedBox(height: 10),
            Text("Codes test:\nPROV-2026 = Proviseur\nGEST-2026 = Gestionnaire\nPROF-2026 = Prof\nPARENT-EL420 = Parent", style: TextStyle(fontSize: 11, color: Colors.grey)),
          ]),
        )
      ])),
    );
  }
}

// DASHBOARD PROVISEUR / GEST / PROF
class Dashboard extends StatelessWidget {
  final String role; final String nom;
  Dashboard({required this.role, required this.nom});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F3F8),
      appBar: AppBar(title: Text("$role - $nom"), backgroundColor: Color(0xFF1447C1), foregroundColor: Colors.white),
      body: ListView(padding: EdgeInsets.all(16), children: [
        if(role=="PROVISEUR") Text("💰 Recette totale: 1,24M FCFA | 420 élèves", style: TextStyle(fontWeight: FontWeight.bold)),
        if(role=="GESTIONNAIRE") Text("💰 Paiements du jour: 125.000 FCFA", style: TextStyle(fontWeight: FontWeight.bold)),
        if(role=="PROFESSEUR") Text("📚 Mes classes: 5e A (32 élèves) - Présence à faire", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        // Paiement partiel exemple
        Container(padding: EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Aminata Diallo - 5e A", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Scolarité Mars: 25.000 FCFA", style: TextStyle(fontSize: 12)),
            SizedBox(height: 8),
            LinearProgressIndicator(value: 0.6, backgroundColor: Colors.grey[200], color: Colors.green),
            SizedBox(height: 4),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Payé: 15.000 FCFA", style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
              Text("Reste: 10.000 FCFA", style: TextStyle(color: Colors.red, fontSize: 12)),
            ]),
            SizedBox(height: 8),
            Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
              child: Row(children: [Icon(Icons.receipt, size: 16), SizedBox(width: 6), Text("Reçu partiel N°001 - Cachet École Lumière", style: TextStyle(fontSize: 11))]),
            )
          ]),
        ),
        SizedBox(height: 12),
        ElevatedButton.icon(onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Notification envoyée au parent: Reste 10.000 FCFA"))); }, icon: Icon(Icons.message), label: Text("Envoyer rappel au parent")),
      ]),
      bottomNavigationBar: BottomNavigationBar(type: BottomNavigationBarType.fixed, items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Messages"),
        BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Reçus"),
      ]),
    );
  }
}

// DASHBOARD PARENT - LE PLUS IMPORTANT
class ParentDashboard extends StatefulWidget {
  final String enfant; final int solde;
  ParentDashboard({required this.enfant, required this.solde});
  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}
class _ParentDashboardState extends State<ParentDashboard> {
  int reste = 10000;
  void payerPartiel() {
    setState(()=> reste = reste - 5000);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ Paiement 5.000 FCFA réussi via MoMo! Reçu envoyé. Notif envoyée à l'école. Reste: $reste FCFA")));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Parent - ${widget.enfant}"), backgroundColor: Color(0xFF1447C1), foregroundColor: Colors.white),
      body: ListView(padding: EdgeInsets.all(16), children: [
        Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Solde Scolarité Mars 2024", style: TextStyle(color: Colors.grey)),
            Text("$reste FCFA restant", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: reste>0? Colors.red : Colors.green)),
            SizedBox(height: 10),
            LinearProgressIndicator(value: (25000-reste)/25000, color: Colors.green),
            SizedBox(height: 10),
            Text("Payé: ${25000-reste} / 25.000 FCFA", style: TextStyle(fontSize: 12)),
          ]),
        ),
        SizedBox(height: 16),
        ElevatedButton.icon(onPressed: payerPartiel, icon: Icon(Icons.phone_android), label: Text("PAYER 5.000 FCFA VIA MOMO"), style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50))),
        SizedBox(height: 12),
        ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.receipt_long), label: Text("Voir mes reçus partiels avec cachet de l'école"), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1447C1), foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50))),
        SizedBox(height: 16),
        Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(12)),
          child: Row(children: [Icon(Icons.message, color: Colors.orange), SizedBox(width: 8), Expanded(child: Text("Message de l'école: 'Bonjour, rappel solde 10.000 FCFA avant le 30 oct.'", style: TextStyle(fontSize: 12)))]),
        ),
        SizedBox(height: 12),
        TextField(decoration: InputDecoration(hintText: "Écrire à l'école...", suffixIcon: Icon(Icons.send), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
      ]),
    );
  }
}