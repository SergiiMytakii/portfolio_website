import 'package:flutter/material.dart';
import 'package:portfolio_website/data/project_repository.dart';
import 'package:portfolio_website/models/project.dart';
import 'package:portfolio_website/ui/widgets/project_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:portfolio_website/ui/widgets/title_card.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key, this.initialProject = 0});
  final int initialProject;
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  ProjectRepository repo = ProjectRepository();
  List<Project> projects = [];
  late final CarouselController imageCaruselController;
  late final CarouselController titleCaruselController;
  late Project currentProject;
  bool _visible = false;
  int? currentPage;
  @override
  void initState() {
    projects = repo.getProjects();
    imageCaruselController = CarouselController();
    titleCaruselController = CarouselController();
    currentProject = projects[0];
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _visible = true;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double horisontalPositionOfCenter = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left: horisontalPositionOfCenter - 100,
                    width: 400,
                    child: CarouselSlider(
                      carouselController: imageCaruselController,
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height,
                        enlargeFactor: 0.3,
                        autoPlay: true,
                        initialPage: widget.initialProject,
                        enlargeCenterPage: true,
                        autoPlayInterval: const Duration(seconds: 6),
                        viewportFraction: 0.7,
                        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1200),
                        scrollDirection: Axis.vertical,
                        onPageChanged: (index, reason) {
                          titleCaruselController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 1200),
                          );
                          currentPage = index;
                          setState(() {
                            currentProject = projects[index];

                            _visible = !_visible;
                          });
                        },
                      ),
                      items: projects
                          .map((project) => ProjectCard(
                                project: project,
                                initialProject: currentPage ?? 0,
                              ))
                          .toList(),
                    ),
                  ),
                  Positioned(
                    left: horisontalPositionOfCenter - 197,
                    width: 350,
                    child: CarouselSlider(
                        carouselController: titleCaruselController,
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.height,
                            viewportFraction: 1,
                            enableInfiniteScroll: true,
                            scrollDirection: Axis.vertical,
                            onPageChanged: (index, reason) {
                              imageCaruselController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 1200),
                              );
                              setState(() {
                                currentProject = projects[index];
                                _visible = !_visible;
                              });
                            }),
                        items: projects.map(
                          (project) {
                            return TitleCard(project);
                          },
                        ).toList()),
                  ),
                  Positioned(
                    left: horisontalPositionOfCenter + 300,
                    bottom: 150,
                    width: 100,
                    child: AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration:
                          _visible ? const Duration(seconds: 2) : Duration.zero,
                      child: Text(
                        currentProject.description,
                        style: const TextStyle(fontFamily: 'MartianMono'),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 50,
                    left: 50,
                    child: Text(
                      'Contact me...',
                      style: TextStyle(fontFamily: 'MartianMono'),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: horisontalPositionOfCenter > 610 ? 50 : null,
                    left: horisontalPositionOfCenter < 610
                        ? horisontalPositionOfCenter + 300
                        : null,
                    child: const Text(
                      'Sergii Mytakii \nSoftware developer',
                      style: TextStyle(fontFamily: 'MartianMono'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
