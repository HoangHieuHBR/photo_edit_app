import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_edit_app/bloc/home/home_cubit.dart';
import 'package:photo_edit_app/config/config.dart';
import 'package:photo_edit_app/screens/home/components/components.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../bloc/bloc_status.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        repo: GetIt.I.get(),
      )
        ..fetchCollection()
        ..fetchPhotos(),
      child: const HomeLayout(),
    );
  }
}

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.collectionStatus == BlocStatus.success &&
            state.photoStatus == BlocStatus.success) {
          if (refreshController.isRefresh) {
            refreshController.refreshCompleted();
          }
          if (refreshController.isLoading) {
            refreshController.loadComplete();
          }
        }

        if (state.collectionStatus == BlocStatus.error ||
            state.photoStatus == BlocStatus.error) {
          if (refreshController.isRefresh) {
            refreshController.refreshFailed();
          }
          if (refreshController.isLoading) {
            refreshController.loadFailed();
          }

          showInfoSnackBar(
            context,
            'Something went wrong, please try again later!',
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SmartRefresher(
            controller: refreshController,
            header: CustomHeader(
              builder: (context, mode) {
                if (mode == RefreshStatus.idle) {
                  return const SizedBox();
                }
                return Center(
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
            ),
            footer: CustomFooter(
              builder: (context, mode) {
                if (mode == LoadStatus.idle) {
                  return const SizedBox();
                }
                return Center(
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
            ),
            enablePullUp: true,
            onRefresh: () {
              context.read<HomeCubit>().fetchCollection(showLoading: false);
              context.read<HomeCubit>().fetchPhotos(showLoading: false);
            },
            enablePullDown: true,
            onLoading: () => context.read<HomeCubit>().fetchNextPhotos(),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: true,
                  centerTitle: false,
                  title: Text(
                    'Discover',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.background,
                  elevation: 0,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(76),
                    child: Container(
                      height: 76,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.search,
                        ),
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              const Icon(
                                CupertinoIcons.search,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Search keyword, nature',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CollectionWidget(),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'Popular Images',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  sliver: PhotoWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
