import { basketballColor, footballColor, volleyballColor } from '../../common/Constants';

@Component
export struct SplashPage {
  imagesSources: Array<string> = ['football.png', 'basketball.png', 'volleyball.png'];
  backgroundColors: Array<ResourceColor> = [footballColor, basketballColor, volleyballColor];
  @State animationIndex: number = 0;
  @State rotateAnimation: number = 0;
  @Consume('pageStack') pageStack: NavPathStack;
  intervalId: number = -1;

  aboutToAppear(): void {
    this.intervalId = setInterval(() => {
      if (this.animationIndex >= this.imagesSources.length - 1) {
        this.onAnimationFinish();
      } else {
        this.animationIndex++;
      }
    }, 1000);
  }

  aboutToDisappear(): void {
    if (this.intervalId !== -1) {
      clearInterval(this.intervalId);
      this.intervalId = -1;
    }
  }

  onAnimationFinish() {
    if (this.intervalId !== -1) {
      clearInterval(this.intervalId);
      this.intervalId = -1;
    }
    setTimeout(() => {
      this.pageStack.replacePathByName('HomePage', {});
    }, 1000)
  }

  build() {
    NavDestination() {
      Row() {
        Stack() {
          Image($rawfile(this.imagesSources[Math.min(this.animationIndex, this.imagesSources.length - 1)]))
            .width('50%')
            .rotate({
              angle: this.rotateAnimation
            })
            .animation({
              duration: 3000,
              playMode: PlayMode.Normal,
              curve: Curve.Smooth,
              iterations: 1
            })
            .onAppear(() => {
              this.rotateAnimation = 3000;
            })
        }
        .width('100%')
      }
      .backgroundColor(this.backgroundColors[Math.min(this.animationIndex, this.backgroundColors.length - 1)])
      .alignItems(VerticalAlign.Center)
      .height('100%')
      .width('100%')
    }.onReady((ctx: NavDestinationContext) => {
      this.pageStack = ctx.pathStack;
    })
    .hideBackButton(true)
  }
}
