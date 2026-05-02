import { HomePage } from './home/HomePage';
import { MatchesPage } from './matches/MatchesPage';
import { SplashPage } from './splash/SplashPage';
import { SportsPage } from './sports/SportsPage';

@Entry
@Component
struct Index {
  @Provide('pageStack') pageStack: NavPathStack = new NavPathStack();

  @Builder
  Pages(name: string) {
    if (name === 'HomePage') {
      HomePage();
    } else if (name === 'MatchesPage') {
      MatchesPage()
    } else if (name === 'SplashPage') {
      SplashPage()
    } else if (name === 'SportsPage') {
      SportsPage()
    }
  }

  build() {
    Navigation(this.pageStack)
      .mode(NavigationMode.Stack)
      .navDestination(this.Pages)
      .hideNavBar(true)
      .onAppear(() => {
        if (this.pageStack.getAllPathName().length === 0) {
          this.pageStack.pushPathByName('SplashPage', null);
        }
      })
  }
}
