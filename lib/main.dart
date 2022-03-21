import 'package:anim_pizza/bloc/pizza_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/pizza_models.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PizzaBloc()..add(LoadPizzaCounter()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocBuilder<PizzaBloc, PizzaState>(builder: (context, state) {
          if (state is PizzaInitial) {
            return const CircularProgressIndicator(color: Colors.deepPurple);
          }
          if (state is PizzaLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${state.pizzas.length}',
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      for (int i = 0; i < state.pizzas.length; i++)
                        Positioned(
                          left: Random()
                              .nextInt(
                                  (MediaQuery.of(context).size.width - 100) ~/
                                      1.2)
                              .toDouble(),
                          top: Random()
                              .nextInt(
                                  (MediaQuery.of(context).size.height - 100) ~/
                                      1.6)
                              .toDouble(),
                          right: Random()
                              .nextInt(
                                  (MediaQuery.of(context).size.width - 100) ~/
                                      1.2)
                              .toDouble(),
                          bottom: Random()
                              .nextInt(
                                  (MediaQuery.of(context).size.height - 100) ~/
                                      1.6)
                              .toDouble(),
                          child: SizedBox(
                            height: 150,
                            width: 500,
                            child: state.pizzas[i].image,
                          ),
                        )
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Text('Zut... c\'est la sauce...');
          }
        }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.local_pizza_outlined),
            backgroundColor: Colors.lightGreen,
            onPressed: () {
              context.read<PizzaBloc>().add(AddPizza(Pizza.pizzas[0]));
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            backgroundColor: Colors.lightGreen,
            onPressed: () {
              context.read<PizzaBloc>().add(RemovePizza(Pizza.pizzas[0]));
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            child: const Icon(Icons.local_pizza_outlined),
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              context.read<PizzaBloc>().add(AddPizza(Pizza.pizzas[1]));
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              context.read<PizzaBloc>().add(RemovePizza(Pizza.pizzas[1]));
            },
          ),
        ],
      ),
    );
  }
}
