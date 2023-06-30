import 'package:flutter/material.dart';
import 'package:portfolio_website/data/project_repository.dart';
import 'package:portfolio_website/models/project.dart';
import 'package:portfolio_website/ui/widgets/project_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:widget_mask/widget_mask.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  ProjectRepository repo = ProjectRepository();
  List<Project> projects = [];
  int page = 0;
  CarouselController controller = CarouselController();
  @override
  void initState() {
    projects = repo.getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double horisontalPositionOfCenter = MediaQuery.of(context).size.width / 2;
    double verticalPositionOfCenter = MediaQuery.of(context).size.height / 2;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: WidgetMask(
              blendMode: BlendMode.colorBurn,
              mask: Container(
                width: 300,
                height: 200,
                color: Colors.transparent,
                child: CarouselSlider(
                    carouselController: controller,
                    options: CarouselOptions(
                      viewportFraction: 1,
                      enableInfiniteScroll: true,
                      scrollDirection: Axis.vertical,
                    ),
                    items: projects.map(
                      (project) {
                        return Text(
                          project.title,
                          style: TextStyle(fontSize: 85),
                          textAlign: TextAlign.center,
                        );
                      },
                    ).toList()),
              ),
              child: SizedBox(
                width: 500,
                height: 500,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 200,
                    ),
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height,
                        enlargeFactor: 0.3,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.7,
                        reverse: false,
                        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        enableInfiniteScroll: true,
                        scrollDirection: Axis.vertical,
                        onPageChanged: (index, reason) {
                          setState(() {
                            page = index;
                            controller.nextPage();
                            // controller.animateTo(30,
                            //     duration: const Duration(milliseconds: 500),
                            //     curve: Curves.easeInOut);
                          });
                        },
                      ),
                      itemCount: projects.length,
                      carouselController: controller,
                      itemBuilder: (context, index, pageViewIndex) {
                        final project = projects[index];
                        return ProjectCard(
                          project: project,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// child: ListView(
//                         controller: controller,
//                         children: projects.map(
//                           (project) {
//                             return Text(
//                               project.title,
//                               style: TextStyle(fontSize: 55),
//                             );
//                           },
//                         ).toList()),