import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './movie.dart';
import '../movie_flow_controller.dart';

class SimilarMovies extends ConsumerWidget {
  const SimilarMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(movieFlowControllerProvider).similarMovies.when(
          data: (similarMovies) {
            return ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: similarMovies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 150,
                          child: Image.network(
                            similarMovies[index].posterPath ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(similarMovies[index].title),
                      ],
                    ),
                  );
                },
              ),
            );
          },
          error: (e, s) => const Text('Something went wrong!'),
          loading: () => const CircularProgressIndicator(),
        );
  }
}
