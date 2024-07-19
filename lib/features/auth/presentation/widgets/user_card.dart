import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_fridge/features/auth/domain/entities/user.dart';

class UserCard extends StatefulWidget {
  final User? currentUser;
  const UserCard({super.key, required this.currentUser});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 12),
          )
        ],
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Stack(
            children: [
              CircleAvatar(
                radius: 50.w,
                backgroundImage: const CachedNetworkImageProvider(
                  'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=826&t=st=1721237500~exp=1721238100~hmac=43d94e13fa49ce48c9d21d0156c3beeddb78238322d055c7b270d37fc2217f99',
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  size: 24,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            widget.currentUser!.name,
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
          ),
          Text(
            widget.currentUser!.email,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}
