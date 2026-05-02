import { ArcButton, ArcButtonOptions, ArcButtonPosition, ArcButtonStatus, ArcButtonStyleMode } from '@ohos.arkui.advanced.ArcButton';
import { ColorMetrics } from '@ohos.arkui.node';
import { AnimatedText } from '../../views/index/AnimatedText';

@Component
export struct HomePage {
  @State favoriteTeam: string = '';
  @State onboardingReadiness: number = 72;
  @Consume('pageStack') pageStack: NavPathStack;

  build() {
    NavDestination() {
      Stack() {
        Column() {
          ArcButton({
            options: new ArcButtonOptions({
              label: $r('app.string.home_discover'),
              position: ArcButtonPosition.BOTTOM_EDGE,
              styleMode: ArcButtonStyleMode.CUSTOM,
              status: ArcButtonStatus.NORMAL,
              backgroundColor: ColorMetrics.resourceColor($r('app.color.arc_button_bg')),
              fontColor: ColorMetrics.resourceColor($r('app.color.arc_button_text')),
              pressedFontColor: ColorMetrics.resourceColor($r('app.color.arc_button_text_pressed')),
              shadowEnabled: false,
              onClick: () => {
                this.pageStack.pushPathByName('SportsPage', null);
              }
            })
          })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.End)

        Column({ space: 4 }) {
          Flex({ justifyContent: FlexAlign.Center }) {
            Text($r('app.string.home_track'))
              .fontColor(Color.White)
              .fontWeight(800)
              .fontSize(22)
            AnimatedText({ message: $r('app.string.home_latest'), fontSize: 22 })
          }

          Text($r('app.string.home_matches'))
            .fontColor(Color.White)
            .fontWeight(800)
            .fontSize(22)

          Divider()
            .strokeWidth(1)
            .color($r('app.color.ui_divider_soft'))
            .width('66%')

          TextInput({ placeholder: $r('app.string.home_favorite_team_placeholder'), text: this.favoriteTeam })
            .placeholderColor($r('app.color.ui_input_placeholder'))
            .placeholderFont({ size: 8 })
            .fontColor(Color.White)
            .fontSize(8)
            .width('68%')
            .height(30)
            .backgroundColor($r('app.color.ui_panel_background'))
            .borderRadius(15)
            .padding({ left: 12, right: 12 })
            .maxLength(12)
            .onChange((value: string) => {
              this.favoriteTeam = value.length > 12 ? value.slice(0, 12) : value;
              this.onboardingReadiness = this.favoriteTeam.trim().length > 0 ? 100 : 72;
            })

          Row({ space: 8 }) {
            Progress({ value: this.onboardingReadiness, total: 100, type: ProgressType.Ring })
              .width(28)
              .color($r('app.color.ui_accent_green'))
              .style({ strokeWidth: 3 })

            Row({ space: 2 }) {
              Text(`${Math.round(this.onboardingReadiness)}%`)
                .fontSize(10)
                .fontColor($r('app.color.ui_text_secondary'))
              Text($r('app.string.home_ready_suffix'))
                .fontSize(10)
                .fontColor($r('app.color.ui_text_secondary'))
            }
            .alignItems(VerticalAlign.Center)
          }
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: 10 })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
        .height('56%')
        .margin({ top: 6 })
      }
      .linearGradient({
        direction: GradientDirection.Bottom,
        repeating: false,
        colors: [[$r('app.color.home_gradient_top'), 0.5], [$r('app.color.home_gradient_bottom'), 1]]
      })
      .height('100%')
      .width('100%')
    }.onReady((ctx: NavDestinationContext) => {
      this.pageStack = ctx.pathStack;
    })
    .hideBackButton(true)
  }
}
