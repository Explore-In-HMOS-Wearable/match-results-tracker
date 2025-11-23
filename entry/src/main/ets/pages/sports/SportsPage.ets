import { Sport } from '../../models/Sport';
import { sportsViewModel } from '../../viewmodels/SportsViewModel';

@Entry
@Component
struct SportsPage {
  onBackPress(): boolean | void {
    this.getUIContext().getRouter().back()
  }

  build() {
    Swiper() {
      ForEach(sportsViewModel, (item: Sport) => {
        Column() {
          Blank().height('10%')

          Image(item.image)
            .aspectRatio(1)
            .height('50%')
            .clipShape(
              new Circle({ height: '100%', width: '100%' })
            )

          Blank().height('3%')

          Text(item.name)
            .fontColor(Color.White)
            .fontWeight(800)
            .fontSize(20)

          Blank().height('3%')

          Button() {
            Text('Show Matches')
              .fontWeight(900)
              .fontColor(Color.White)
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Black)
          .borderRadius(5)
          .padding(5)
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({
              url: 'pages/matches/MatchesPage',
              params: { sportType: item.type }
            }
            )
          })
        }
        .linearGradient({
          direction: GradientDirection.Right,
          repeating: false,
          colors: [[0x000000, 0], [item.gradientColor, 0.5], [0x000000, 1]]
        })
        .width('100%')
        .height('100%')
      }, (item: string) => item)
    }
    .indicator(
      new DotIndicator()
        .selectedColor(Color.Black)
    )
    .height('100%')
    .width('100%')
  }
}