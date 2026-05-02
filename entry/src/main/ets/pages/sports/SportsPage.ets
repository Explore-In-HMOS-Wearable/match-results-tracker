import { ArcList, ArcListItem } from '@ohos.arkui.ArcList';
import { Sport } from '../../models/Sport';
import { sportsViewModel } from '../../viewmodels/SportsViewModel';

@Component
export struct SportsPage {
  @Consume('pageStack') pageStack: NavPathStack;
  @State selectedSportName: ResourceStr = sportsViewModel[0].name;

  onBackPress(): boolean | void {
    this.pageStack.pop()
  }

  @Builder
  sportListItem(item: Sport) {
    Column() {
      Row({ space: 10 }) {
        Image(item.image)
          .width(44)
          .height(44)
          .borderRadius(22)

        Column({ space: 2 }) {
          Text(item.name)
            .fontColor(Color.White)
            .fontWeight(800)
            .fontSize(17)

          Text($r('app.string.sports_latest_matches'))
            .fontColor($r('app.color.ui_text_secondary'))
            .fontSize(10)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Button($r('app.string.sports_open'))
          .type(ButtonType.Capsule)
          .fontColor(Color.Black)
          .fontSize(10)
          .backgroundColor(Color.White)
          .height(28)
          .onClick(() => {
            this.selectedSportName = item.name;
            this.pageStack.pushPathByName('MatchesPage', item.type);
          })
      }
      .width('88%')
      .height(86)
      .padding({ left: 12, right: 8 })
      .borderRadius(44)
      .linearGradient({
        direction: GradientDirection.Right,
        repeating: false,
        colors: [[$r('app.color.sports_gradient_edge'), 0], [item.gradientColor, 0.5], [$r('app.color.sports_gradient_edge'), 1]]
      })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .padding({ top: 4, bottom: 4 })
  }

  build() {
    NavDestination() {
      Stack() {
        ArcList({ initialIndex: 0 }) {
          ArcListItem() {
            Column({ space: 6 }) {
              Row({ space: 6 }) {
                Text($r('app.string.sports_choose_sport'))
                  .fontSize(18)
                  .fontColor(Color.White)
                  .fontWeight(800)

                LoadingProgress()
                  .width(16)
                  .height(16)
                  .color(Color.White)
              }
              .alignItems(VerticalAlign.Center)

              Divider()
                .strokeWidth(1)
                .color($r('app.color.matches_divider'))
                .width('78%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Center)
            .padding({ top: 4, bottom: 6 })
          }

          ForEach(sportsViewModel, (item: Sport) => {
            ArcListItem() {
              this.sportListItem(item)
            }
          }, (item: Sport) => item.type.toString())

          ArcListItem() {
            Column({ space: 6 }) {
              Row({ space: 4 }) {
                Text($r('app.string.sports_focused'))
                  .fontSize(11)
                  .fontColor($r('app.color.ui_text_secondary'))

                Text(this.selectedSportName)
                  .fontSize(11)
                  .fontColor($r('app.color.ui_text_secondary'))
              }
              Progress({ value: sportsViewModel.length, total: sportsViewModel.length, type: ProgressType.Capsule })
                .width('72%')
                .height(14)
                .color(Color.White)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .padding({ top: 4, bottom: 8 })
          }
        }
      }
      .linearGradient({
        direction: GradientDirection.Bottom,
        repeating: false,
        colors: [[$r('app.color.sports_background_top'), 0], [$r('app.color.sports_background_bottom'), 1]]
      })
      .width('100%')
      .height('100%')
    }.onReady((ctx: NavDestinationContext) => {
      this.pageStack = ctx.pathStack;
      this.selectedSportName = sportsViewModel[0].name;
    })
    .hideBackButton(true)
  }
}
