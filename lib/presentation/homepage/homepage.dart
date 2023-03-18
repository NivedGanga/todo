import 'package:flutter/material.dart';

import 'package:todo/infrastructure/list/list_repo.dart';
import 'package:todo/presentation/additem/add_list.dart';
import 'package:todo/presentation/additem/add_task.dart';
import 'package:todo/presentation/homepage/widgets/myappbar.dart';
import 'package:todo/presentation/homepage/widgets/tab.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    tabController = TabController(
        length: ListRepo.instance.todoListTitles.length, vsync: this)
      ..addListener(() {});
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
            builder: (context) => AddTask(index: tabController.index),
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
            expandedHeight: 120.0,
            collapsedHeight: 65,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 40,
                          child: TabBar(
                            controller: tabController,
                            tabs: List.generate(
                                ListRepo.instance.todoListTitles.length,
                                (index) => GestureDetector(
                                      onLongPress: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                  onPressed: () async {
                                                    await ListRepo.instance
                                                        .deletelist(
                                                      list: ListRepo.instance
                                                              .todoListTitles[
                                                          index],
                                                    );
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      HomePage(),
                                                            ),
                                                            (route) => false);
                                                  },
                                                  child: Text(
                                                    'I confirm to delete the List',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.red),
                                                  )),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(ListRepo.instance
                                          .todoListTitles[index].title),
                                    )),
                            isScrollable: true,
                          ),
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
                ),
              ),
              background: MyAppBar(context: context),
              centerTitle: true,
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: tabController,
              children: List.generate(
                  ListRepo.instance.todoListTitles.length,
                  (index) => TabWidget(
                        index: index,
                      )),
            ),
          )
        ],
      ),
    );
  }
}
