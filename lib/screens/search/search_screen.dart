import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_edit_app/bloc/bloc_status.dart';
import 'package:photo_edit_app/bloc/search/search_cubit.dart';
import 'package:photo_edit_app/repository/search/search_repo.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../config/config.dart';
import '../../widgets/widgets.dart';
import 'components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(
        repo: GetIt.I.get<SearchRepo>(),
      ),
      child: const SearchLayout(),
    );
  }
}

class SearchLayout extends StatefulWidget {
  const SearchLayout({super.key});

  @override
  State<SearchLayout> createState() => _SearchLayoutState();
}

class _SearchLayoutState extends State<SearchLayout> {
  final RefreshController refreshController = RefreshController();
  final TextEditingController keywordController = TextEditingController();

  String? initialKeyword;

  @override
  void didChangeDependencies() {
    initialKeyword = ModalRoute.of(context)?.settings.arguments as String?;

    if (initialKeyword == null) return;
    if (initialKeyword?.isNotEmpty ?? false) {
      keywordController.text = initialKeyword ?? '';
      context.read<SearchCubit>().onKeywordChanged(keywordController.text);
      context.read<SearchCubit>().searchPhotos();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          iconSize: 20,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).textTheme.headlineLarge?.color,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        title: TextField(
          controller: keywordController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'e.g: Winter, Nature, etc.',
            hintStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          style: Theme.of(context).textTheme.bodyLarge,
          autocorrect: initialKeyword != null ? false : true,
          textInputAction: TextInputAction.search,
          onChanged: context.read<SearchCubit>().onKeywordChanged,
          onSubmitted: (_) {
            context.read<SearchCubit>().searchPhotos();
          },
        ),
        actions: [
          BlocBuilder<SearchCubit, SearchState>(
            buildWhen: (p, c) => p.keyword != c.keyword,
            builder: (context, state) {
              if (state.keyword.isEmpty) {
                return const SizedBox();
              }
              return IconButton(
                onPressed: () {
                  keywordController.clear();
                  context.read<SearchCubit>().clearKeyword();
                },
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).textTheme.headlineLarge?.color,
                ),
              );
            },
          )
        ],
        elevation: 1,
      ),
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state.status == BlocStatus.success) {
            if (refreshController.isRefresh) {
              refreshController.refreshCompleted();
            }
            if (refreshController.isLoading) {
              refreshController.loadComplete();
            }
          }

          if (state.status == BlocStatus.error) {
            if (refreshController.isRefresh) {
              refreshController.refreshCompleted();
            }
            if (refreshController.isLoading) {
              refreshController.loadComplete();
            }

            showInfoSnackBar(
              context,
              'Something went wrong, please try again later!',
            );
          }
        },
        builder: (context, state) {
          if (state.status == BlocStatus.initial) {
            return const SizedBox();
          }
          if (state.status != BlocStatus.success && state.photos.isEmpty) {
            return const PhotoSearchLoading();
          }

          return SmartRefresher(
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
            enablePullDown: true,
            onRefresh: context.read<SearchCubit>().searchPhotos,
            onLoading: context.read<SearchCubit>().fetchNextPhotos,
            child: GridView.custom(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: const [
                  QuiltedGridTile(2, 1),
                  QuiltedGridTile(1, 1),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) {
                  final photo = state.photos[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.detailPhoto,
                        arguments: photo,
                      );
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image(
                          image: NetworkImage(
                            photo.src.portrait,
                          ),
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return Center(
                              child: Icon(
                                Icons.broken_image_rounded,
                                color: AppColor.primaryColor,
                              ),
                            );
                          },
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black,
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 16,
                          child: Text(
                            photo.photographer,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: state.photos.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
