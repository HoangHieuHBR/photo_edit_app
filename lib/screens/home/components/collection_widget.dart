import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_edit_app/bloc/bloc_status.dart';
import 'package:shimmer/shimmer.dart';

import '../../../bloc/home/home_cubit.dart';
import '../../../config/config.dart';

class CollectionWidget extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          if (shrinkOffset == 80)
            const BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset.zero,
            ),
        ],
      ),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.collectionStatus != BlocStatus.success) {
            return const CollectionLoading();
          }

          final collections = state.collections;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            scrollDirection: Axis.horizontal,
            itemCount: collections.length,
            itemBuilder: (context, index) {
              final collection = collections[index];
              return InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.search,
                  arguments: collection.title,
                ),
                child: Container(
                  margin: EdgeInsets.only(left: index == 0 ? 0 : 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    collection.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                        ),
                    maxLines: 1,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CollectionLoading extends StatelessWidget {
  const CollectionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            margin: EdgeInsets.only(left: index == 0 ? 0 : 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
          );
        },
      ),
    );
  }
}
