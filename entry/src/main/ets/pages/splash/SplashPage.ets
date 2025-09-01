import { router } from '@kit.ArkUI';
import { basketballColor, footballColor, volleyballColor } from '../../common/Constants';

@Entry
@Component
struct SplashPage {
  imagesSources: Array<string> = ['football.png', 'basketball.png', 'volleyball.png'];
  backgroundColors: Array<ResourceColor> = [footballColor, basketballColor, volleyballColor];
  @State animationIndex: number = 0;
  @State rotateAnimation: number = 0;

  aboutToAppear(): void {
    const intervalId = setInterval(() => {
      this.animationIndex++;
      if (this.animationIndex == 3) {
        this.onAnimationFinish(intervalId);
      }
    }, 1000);
  }

  onAnimationFinish(intervalId: number) {
    clearInterval(intervalId);
    setTimeout(() => {
      router.replaceUrl({
        url: 'pages/Index'
      })
    }, 1000)
    this.animationIndex = 2;
  }

  build() {
    Row() {
      Stack() {
        Image($rawfile(this.imagesSources[this.animationIndex]))
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
    .backgroundColor(this.backgroundColors[this.animationIndex])
    .alignItems(VerticalAlign.Center)
    .height('100%')
    .width('100%')
  }
}