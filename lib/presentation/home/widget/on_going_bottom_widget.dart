import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unsplash/presentation/home/pagination/page_provider.dart';

class OnGoingBottomWidget extends StatelessWidget {
  const OnGoingBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(40),
      sliver: SliverToBoxAdapter(
        child: Consumer(builder: (context, ref, child) {
          final state = ref.watch(itemsProvider);
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            onGoingLoading: (items) =>
                const Center(child: CircularProgressIndicator()),
            onGoingError: (items, e, stk) => Center(
              child: Column(
                children: const [
                  Icon(Icons.info),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Something Went Wrong!",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
