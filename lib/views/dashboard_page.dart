import 'package:flutter/material.dart';
import 'package:flutter_mvvm/view_models/movie_list_view_model.dart';
import 'package:provider/provider.dart';

import '../view_models/movie_view_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    // you can uncomment this to get all batman movies when the page is loaded
    //Provider.of<MovieListViewModel>(context, listen: false).fetchMovies("batman");
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MoviesListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    vm.fetchMovies(value);
                    // _controller.clear();
                  }
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none),
              ),
            ),
          ),
          // SizedBox(height: 10),
          Expanded(
              child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              MovieListWidget(
                movies: vm.movieList,
              ),
              vm.isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox()
            ],
          ))
        ],
      ),
    );
  }
}

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({Key? key, required this.movies}) : super(key: key);
  final List<MovieViewModel> movies;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: movie.poster == "N/A"
              ? const SizedBox()
              : Image.network(movie.poster!),
          title: Text(movie.title!),
        );
      },
    );
  }
}
