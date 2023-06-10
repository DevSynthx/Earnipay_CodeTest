import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unsplash/domain/model/photos.dart';
import 'package:unsplash/presentation/home/pagination/page_provider.dart';
import 'package:unsplash/presentation/home/pagination/pagination-state/pagination_state.dart';
import 'package:unsplash/presentation/home/widget/no_more_item_widget.dart';
import 'package:unsplash/presentation/home/widget/on_going_bottom_widget.dart';
import 'package:unsplash/presentation/home/widget/photo_list.dart';
import 'package:unsplash/presentation/home/widget/scroll_to_bottom_button.dart';
import 'package:unsplash/presentation/util/components/alert_dialog/alert_screen_util.dart';

class HomePageView extends StatefulHookConsumerWidget {
  const HomePageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageViewState();
}

class _HomePageViewState extends ConsumerState<HomePageView> {
  ScrollController? _scrollController;
  void _scrollcontroll() {
    double maxScroll = _scrollController!.position.maxScrollExtent;
    double currentScroll = _scrollController!.position.pixels;
    double delta = MediaQuery.of(context).size.width * 0.10;
    if (maxScroll - currentScroll <= delta) {
      ref.read(itemsProvider.notifier).fetchNextBatch();
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollcontroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<PaginationState<Photos>>(itemsProvider, (previous, next) {
      if (next is OnGoingError<Photos>) {
        ScreenAlertView.showErrorDialog(
            context: context, errorText: next.e.toString());
      }

      if (next is Error<Photos>) {
        ScreenAlertView.showErrorDialog(
            context: context, errorText: next.e.toString());
      }
    });
    return Scaffold(
      floatingActionButton: ScrollToTopButton(
        scrollController: _scrollController!,
      ),
      body: CustomScrollView(
        controller: _scrollController,
        restorationId: "items List",
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        slivers: const [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            title: Text('Task one'),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          PhotosList(),
          NoMoreItems(),
          OnGoingBottomWidget(),
        ],
      ),
    );
  }
}
