import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildSection(String title, List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: items,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logo_cepsten.png',
              height: 80,
              width: 80,
            ),
            Row(
              children: [
                TextButton(onPressed: () {}, child: const Text('Home')),
                TextButton(onPressed: () {}, child: const Text('Outfit')),
                TextButton(onPressed: () {}, child: const Text('Camera')),
                TextButton(onPressed: () {}, child: const Text('Chat')),
                TextButton(onPressed: () {}, child: const Text('Profile')),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Outfit Warna hitam',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ],
              ),
            ),
            Image.asset('assets/images/banner.png'),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Skintone Styles adalah pendekatan fashion yang menyesuaikan pilihan warna dan gaya berdasarkan karakteristik warna kulit individu.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Learn More'),
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Featured Outfits',
              [
                Container(
                  width: 150,
                  color: Colors.red,
                  child: const Center(child: Text('Outfit 1')),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 150,
                  color: Colors.green,
                  child: const Center(child: Text('Outfit 2')),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 150,
                  color: Colors.blue,
                  child: const Center(child: Text('Outfit 3')),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Latest Trends',
              [
                Container(
                  width: 150,
                  color: Colors.orange,
                  child: const Center(child: Text('Trend 1')),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 150,
                  color: Colors.purple,
                  child: const Center(child: Text('Trend 2')),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 150,
                  color: Colors.yellow,
                  child: const Center(child: Text('Trend 3')),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Popular Categories',
              [
                Container(
                  width: 150,
                  color: Colors.teal,
                  child: const Center(child: Text('Category 1')),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 150,
                  color: Colors.cyan,
                  child: const Center(child: Text('Category 2')),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 150,
                  color: Colors.indigo,
                  child: const Center(child: Text('Category 3')),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Customer Reviews',
              [
                Container(
                  width: 150,
                  color: Colors.lightBlue,
                  child: const Center(child: Text('Review 1')),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 150,
                  color: Colors.lightGreen,
                  child: const Center(child: Text('Review 2')),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 150,
                  color: Colors.lightGreen,
                  child: const Center(child: Text('Review 3')),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Upcoming Events',
              [
                Container(
                  width: 150,
                  color: Colors.brown,
                  child: const Center(child: Text('Event 1')),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 150,
                  color: Colors.grey,
                  child: const Center(child: Text('Event 2')),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 150,
                  color: Colors.amber,
                  child: const Center(child: Text('Event 3')),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Featured Brands',
              [
                Container(
                  width: 150,
                  color: Colors.redAccent,
                  child: const Center(child: Text('Brand 1')),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 150,
                  color: Colors.greenAccent,
                  child: const Center(child: Text('Brand 2')),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 150,
                  color: Colors.blueAccent,
                  child: const Center(child: Text('Brand 3')),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Latest Offers',
              [
                Container(
                  width: 150,
                  color: Colors.pink,
                  child: const Center(child: Text('Offer 1')),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 150,
                  color: Colors.orangeAccent,
                  child: const Center(child: Text('Offer 2')),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 150,
                  color: Colors.lightBlueAccent,
                  child: const Center(child: Text('Offer 3')),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Social Media Links',
              [
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.verified_user),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.verified_user),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'For inquiries, please reach out to us at support@example.com',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Send Message'),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Feedback',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Leave your feedback here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                maxLines: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
