import 'package:flutter/material.dart';
import '../../data/models/place.dart';

import '../../constants/colors.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({super.key, required this.suggestion});

  final Place suggestion;

  @override
  Widget build(BuildContext context) {
    final subTitle = suggestion.description.split(',').skip(1).join(',').trim();

    return Card(
      elevation: 3, // Ajoute une ombre légère
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Coins arrondis
      ),
      color: AppColors.thirdColor.withAlpha(200), // Fond léger
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.mainColor.withAlpha(160),
          ),
          child: const Icon(
            Icons.place,
            color: AppColors.thirdColor,
            size: 24,
          ),
        ),
        title: Text(
          suggestion.description
              .split(',')[0], // Première partie du texte en gras
          maxLines: 1,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.darkColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          subTitle.isNotEmpty ? subTitle : "Aucune information supplémentaire",
          maxLines: 1,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.headerColor.withAlpha(180),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: AppColors.mainColor.withAlpha(160),
          size: 16,
        ),
        onTap: () {
          // Ajoutez ici une action lorsqu'on clique sur un élément de la liste
        },
      ),
    );
  }
}
