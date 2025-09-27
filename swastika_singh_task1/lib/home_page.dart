import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Sample categories and books with 7-8 books each
  final Map<String, List<Map<String, String>>> categories = {
    "Fiction": [
      {
        "title": "To Kill a Mockingbird",
        "price": "₹499",
        "image": "https://m.media-amazon.com/images/I/81r81MTfTuL.jpg",
      },
      {
        "title": "The Alchemist",
        "price": "₹399",
        "image":
            "https://images-na.ssl-images-amazon.com/images/I/71aFt4%2BOTOL.jpg",
      },
      {
        "title": "1984",
        "price": "₹599",
        "image":
            "https://i.pinimg.com/originals/c5/94/49/c59449aaffccfdcba684cee512339cd0.jpg",
      },
      {
        "title": "The Great Gatsby",
        "price": "₹299",
        "image":
            "https://d28hgpri8am2if.cloudfront.net/book_images/onix/cvr9781645173519/the-great-gatsby-and-other-works-9781645173519_hr.jpg",
      },
    ],
    "True Crime": [
      {
        "title": "The Mussoorie Murders",
        "price": "₹399",
        "image":
            "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1696662567i/199303531.jpg",
      },
      {
        "title": "In Cold Blood",
        "price": "₹599",
        "image":
            "https://d3525k1ryd2155.cloudfront.net/h/055/099/539099055.0.x.jpg",
      },
      {
        "title": "The Stranger Beside Me",
        "price": "₹499",
        "image":
            "https://media1.popsugar-assets.com/files/thumbor/-V9fclPOi06CnZ2jThbbAUNVodU/fit-in/728xorig/filters:format_auto-!!-:strip_icc-!!-/2019/01/30/826/n/44498184/c9490535d521d37c_3b57fd9a-6781-4712-9776-e9db7760dea7-1614932356/i/Stranger-Beside-Me-Ann-Rule.jpg",
      },
      {
        "title": "Helter Skelter",
        "price": "₹699",
        "image": "https://m.media-amazon.com/images/I/51atngIHkvL.jpg",
      },
    ],
    "Romantic": [
      {
        "title": "It Ends with Us",
        "price": "₹599",
        "image":
            "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1670795825i/62627512.jpg",
      },
      {
        "title": "The Notebook",
        "price": "₹399",
        "image":
            "https://tse3.mm.bing.net/th/id/OIP.XOtt9QqJ4DfMXQcpyZ0iBwAAAA?w=283&h=475&rs=1&pid=ImgDetMain&o=7&rm=3",
      },
      {
        "title": "Pride and Prejudice",
        "price": "₹299",
        "image":
            "https://tse3.mm.bing.net/th/id/OIP.Lfp5RYL8FWEFT3EbVX3elgHaMK?rs=1&pid=ImgDetMain&o=7&rm=3",
      },
      {
        "title": "Me Before You",
        "price": "₹499",
        "image":
            "https://cdn2.penguin.com.au/covers/original/9780141969183.jpg",
      },
    ],

    "Fantasy": [
      {
        "title": "House of Crimson hearts",
        "price": "₹850",
        "image":
            "https://cdn.waterstones.com/bookjackets/large/9781/9132/9781913236823.jpg",
      },
      {
        "title": "Twisted series",
        "price": "₹799",
        "image":
            "https://i5.walmartimages.com/seo/Twisted-Series-4-Books-Collection-Set-by-Ana-Huang-Twisted-Love-Twisted-Games-Twisted-Hate-and-Twisted-Lies_5640ff50-7596-4965-8f5d-1c9f561f989d.396b6aaabbd395eecfdbe3a33e4157b2.jpeg",
      },
      {
        "title": "Mistborn: The Final Empire",
        "price": "₹699",
        "image":
            "https://i.pinimg.com/originals/ed/03/08/ed03089134262590a10eda3775441a5d.jpg",
      },
      {
        "title": "The Way of Kings",
        "price": "₹999",
        "image":
            "https://tse3.mm.bing.net/th/id/OIP.r2VO8tI2bOcCJasoFnbaLwHaKx?w=550&h=800&rs=1&pid=ImgDetMain&o=7&rm=3",
      },
    ],
    "Horror": [
      {
        "title": "The Exorcist",
        "price": "₹499",
        "image": "https://m.media-amazon.com/images/I/71Aa9Pgz0sL._SL1500_.jpg",
      },
      {
        "title": "Ghost of The Silent Hills",
        "price": "₹399",
        "image":
            "https://www.indiacafe24.com/wp-content/uploads/2020/03/Ghosts-of-the-Silent-Hills-front-cover.jpg",
      },
      {
        "title": "I'll be gone in the dark",
        "price": "₹599",
        "image":
            "https://legendary-digital-network-assets.s3.amazonaws.com/wp-content/uploads/2020/05/13042041/Ill-Be-Gone-in-the-Dark-cover.jpg",
      },
      {
        "title": "The devil in the white city",
        "price": "₹299",
        "image":
            "https://cdn.images.express.co.uk/img/dynamic/20/590x/secondary/devil-in-the-white-city-plot-1746451.jpg?r=1550603296139",
      },
    ],
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50, // light purple background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end, // icons right align
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite),
                      color: Colors.purpleAccent, // wishlist purple
                      onPressed: () {
                        // wishlist action
                      },
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: Colors.deepPurple, // cart icon
                      onPressed: () {
                        // cart action
                      },
                    ),
                  ],
                ),
              ),
              // ------------------- TWILIGHT TITLE -------------------
              Center(
                child: Text(
                  "Twilight",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.deepPurple.shade900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // ------------------- SEARCH BAR -------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search your next read...",
                    prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
                    filled: true,
                    fillColor: Colors.white, // white search bar
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 25),

              // ------------------- CATEGORIES + BOOKS -------------------
              Column(
                children: categories.keys.map((category) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category star-shaped box
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white, // category box white
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.shade100,
                                blurRadius: 6,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.deepPurple),
                              SizedBox(width: 8),
                              Text(
                                category,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.deepPurple.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      // Horizontal scrollable books for this category (7-8 books)
                      Container(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          itemCount: categories[category]!.length,
                          itemBuilder: (context, index) {
                            final book = categories[category]![index];
                            return bookCard(
                              book["title"]!,
                              book["price"]!,
                              book["image"]!,
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 20),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------- BOOK CARD -------------------
  Widget bookCard(String title, String price, String imageUrl) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.white, // book card background white
              child: Image.network(
                imageUrl,
                height: 180,
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade900,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
