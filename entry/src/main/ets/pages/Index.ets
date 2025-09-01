import { AnimatedText } from '../views/index/AnimatedText';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Flex({ justifyContent: FlexAlign.Center }) {
          Text('Track ')
            .fontColor(Color.White)
            .fontWeight(800)
            .fontSize(30)
          AnimatedText({ message: 'Latest' })
        }

        Text('Matches')
          .fontColor(Color.White)
          .fontWeight(800)
          .fontSize(30)
        Blank().height('5%')
        Button() {
          Text('Discover')
            .fontWeight(900)
            .fontColor(Color.Black)
        }
        .onClick(() => {
          router.pushUrl(
            { url: 'pages/sports/SportsPage' }
          )
        })
        .backgroundColor('#ff36ff00')
        .padding(10)
        .type(ButtonType.Normal)
        .borderRadius(10)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .alignItems(VerticalAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      repeating: false,
      colors: [[0xff00470b, 0.5], [0x000000, 1]]
    })
    .height('100%')
    .width('100%')
  }
}