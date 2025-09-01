import { footballColor } from '../../common/Constants';
import { SportType } from '../../common/Enums';
import { Match } from '../../models/Match';
import { footballMatchesData, MatchesViewModel } from '../../viewmodels/MatchesViewModel';

@Entry
@Component
struct MatchesPage {
  @State sportType: SportType = SportType.football;
  @State matches: Array<Match> = footballMatchesData;
  @State color: ResourceColor = footballColor;
  matchesViewModel = new MatchesViewModel();

  aboutToAppear() {
    const data: object = this.getUIContext().getRouter().getParams()
    this.sportType = data['sportType'];
    this.matches = this.matchesViewModel.getMatches(this.sportType)
    this.color = this.matchesViewModel.getBackgroundColor(this.sportType)
  }

  build() {
    Swiper() {
      ForEach(this.matches, (item: Match) => {
        Row() {
          Column() {
            Text(item.date.toLocaleDateString())
              .fontColor(Color.White)
            Blank().height('1%')
            Text('Full Time')
              .fontSize(12)
            Blank().height('3%')
            Column() {
              Text(item.teamName1)
                .fontSize(16)
                .fontWeight(700)
                .fontColor($r('sys.color.white'))
                .textAlign(TextAlign.Center)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
              Row() {
                Text(item.team1Point.toString())
                  .fontSize(36)
                  .fontWeight(700)
                  .fontColor($r('sys.color.white'))
                Text('-')
                  .fontSize(36)
                  .fontWeight(700)
                  .fontColor($r('sys.color.white'))
                  .margin({ left: 8, right: 8 })
                Text(item.team2Point.toString())
                  .fontSize(36)
                  .fontWeight(700)
                  .fontColor($r('sys.color.white'))
              }
              .justifyContent(FlexAlign.Center)
              .margin({ top: 8, bottom: 8 })

              // Team 2
              Text(item.teamName2)
                .fontSize(16)
                .fontWeight(700)
                .fontColor($r('sys.color.white'))
                .textAlign(TextAlign.Center)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .alignItems(HorizontalAlign.Center)
          }
          .width('100%')
        }
        .backgroundColor(this.color)
      }, (item: string) => item)
    }
    .indicator(
      new DotIndicator()
        .selectedColor(Color.White)
    )
    .height('100%')
  }
}