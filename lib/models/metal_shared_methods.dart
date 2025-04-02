

class MetalSharedMethods{

  static List<Map<String, String>> listOfMetals = [
    {
      'category': 'Gold XAU',
      'image': 'assets/images/Category_Gold.jpg',
      'shortCut': 'XAU',
    },
    {
      'category': 'Silver XAG',
      'image': 'assets/images/Category_Silver.jpg',
      'shortCut': 'XAG',
    },
    {
      'category': 'Platinum XPT',
      'image': 'assets/images/Category_Platinum.jpg',
      'shortCut': 'XPT',
    },
    {
      'category': 'Palladium XPD',
      'image': 'assets/images/Category_Palladium.jpg',
      'shortCut': 'XPD',
    },
  ];

  static String selectedMetalTypeByShortcut(String metalShortCut) {
    switch (metalShortCut.toLowerCase()) {
      case 'xag':
        return 'Silver';
      case 'xpd':
        return 'Palladium';
      case 'xpt':
        return 'Platinum';
      default:
        return 'Gold';
    }
  }

}