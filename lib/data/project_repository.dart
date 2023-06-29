import 'package:portfolio_website/models/project.dart';

class ProjectRepository {
  List<Project> getProjects() {
    // Replace this with your actual implementation to fetch project data
    return [
      Project(
        title: 'Bringit',
        image: 'assets/images/bringit.jpeg',
        description: 'This is the first project.',
      ),
      Project(
        title: 'Bringer',
        image: 'assets/images/bringer.PNG',
        description: 'This is the second project.',
      ),
      Project(
        title: 'RestyleMe',
        image: 'assets/images/restyleme.jpeg',
        description: 'This is the third project.',
      ),
      // Add more projects as needed
    ];
  }
}
