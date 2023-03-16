import 'package:flutter/material.dart';
import 'package:todo/core/constants/constants.dart';
import 'package:todo/presentation/additem/add_list.dart';
import 'package:todo/presentation/additem/add_task.dart';
import 'package:todo/presentation/homepage/widgets/tab.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final tabController;
  @override
  void initState() {
    tabController = TabController(length: 8, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => AddTask(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            toolbarHeight: 50,
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 100.0,
            collapsedHeight: 50,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TabBar(
                      controller: tabController,
                      tabs: [
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                      ],
                      isScrollable: true,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          size: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddList(),
                            ));
                          },
                          child: Text(
                            'New list',
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              background: Column(
                children: [
                  kheight30,
                  Text(
                    'ToDos',
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              centerTitle: true,
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: tabController,
              children: [
                TabWidget(),
                TabWidget(),
                TabWidget(),
                TabWidget(),
                TabWidget(),
                TabWidget(),
                TabWidget(),
                TabWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
