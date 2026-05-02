import { footballColor } from '../../common/Constants';
import { SportType } from '../../common/Enums';
import { Match } from '../../models/Match';
import { footballMatchesData, MatchesViewModel } from '../../viewmodels/MatchesViewModel';

interface MatchesTheme {
  backgroundTop: ResourceColor;
  backgroundBottom: ResourceColor;
  accent: ResourceColor;
  accentStrong: ResourceColor;
  panel: ResourceColor;
  card: ResourceColor;
  divider: ResourceColor;
  sliderTrack: ResourceColor;
  swiperDot: ResourceColor;
  textPrimary: ResourceColor;
  textSecondary: ResourceColor;
  textMuted: ResourceColor;
  inputPlaceholder: ResourceColor;
}

const footballTheme: MatchesTheme = {
  backgroundTop: $r('app.color.sport_football_bg_top'),
  backgroundBottom: $r('app.color.sport_football_bg_bottom'),
  accent: $r('app.color.sport_football_accent'),
  accentStrong: $r('app.color.sport_football_accent_strong'),
  panel: $r('app.color.sport_football_panel'),
  card: $r('app.color.sport_football_card'),
  divider: $r('app.color.sport_football_divider'),
  sliderTrack: $r('app.color.sport_football_slider_track'),
  swiperDot: $r('app.color.sport_football_swiper_dot'),
  textPrimary: $r('sys.color.white'),
  textSecondary: $r('app.color.sport_football_text_secondary'),
  textMuted: $r('app.color.sport_football_text_muted'),
  inputPlaceholder: $r('app.color.sport_football_placeholder')
};

const basketballTheme: MatchesTheme = {
  backgroundTop: $r('app.color.sport_basketball_bg_top'),
  backgroundBottom: $r('app.color.sport_basketball_bg_bottom'),
  accent: $r('app.color.sport_basketball_accent'),
  accentStrong: $r('app.color.sport_basketball_accent_strong'),
  panel: $r('app.color.sport_basketball_panel'),
  card: $r('app.color.sport_basketball_card'),
  divider: $r('app.color.sport_basketball_divider'),
  sliderTrack: $r('app.color.sport_basketball_slider_track'),
  swiperDot: $r('app.color.sport_basketball_swiper_dot'),
  textPrimary: $r('sys.color.white'),
  textSecondary: $r('app.color.sport_basketball_text_secondary'),
  textMuted: $r('app.color.sport_basketball_text_muted'),
  inputPlaceholder: $r('app.color.sport_basketball_placeholder')
};

const volleyballTheme: MatchesTheme = {
  backgroundTop: $r('app.color.sport_volleyball_bg_top'),
  backgroundBottom: $r('app.color.sport_volleyball_bg_bottom'),
  accent: $r('app.color.sport_volleyball_accent'),
  accentStrong: $r('app.color.sport_volleyball_accent_strong'),
  panel: $r('app.color.sport_volleyball_panel'),
  card: $r('app.color.sport_volleyball_card'),
  divider: $r('app.color.sport_volleyball_divider'),
  sliderTrack: $r('app.color.sport_volleyball_slider_track'),
  swiperDot: $r('app.color.sport_volleyball_swiper_dot'),
  textPrimary: $r('sys.color.white'),
  textSecondary: $r('app.color.sport_volleyball_text_secondary'),
  textMuted: $r('app.color.sport_volleyball_text_muted'),
  inputPlaceholder: $r('app.color.sport_volleyball_placeholder')
};

@Component
export struct MatchesPage {
  @State sportType: SportType = SportType.football;
  @State matches: Array<Match> = footballMatchesData;
  @State color: ResourceColor = footballColor;
  @State showListMode: boolean = false;
  @State visibleMatchCount: number = 2;
  @State filterText: string = '';
  @State activeCardIndex: number = 0;
  matchesViewModel = new MatchesViewModel();
  @Consume('pageStack') pageStack: NavPathStack;

  private getSportTitle(): ResourceStr {
    switch (this.sportType) {
      case SportType.football:
        return $r('app.string.sport_football');
      case SportType.basketball:
        return $r('app.string.sport_basketball');
      case SportType.volleyball:
        return $r('app.string.sport_volleyball');
      default:
        return $r('app.string.sport_generic');
    }
  }

  private getTheme(): MatchesTheme {
    switch (this.sportType) {
      case SportType.football:
        return footballTheme;
      case SportType.basketball:
        return basketballTheme;
      case SportType.volleyball:
        return volleyballTheme;
      default:
        return footballTheme;
    }
  }

  private getFilteredMatches(): Match[] {
    const normalizedText = this.filterText.trim().toLowerCase();
    if (normalizedText.length === 0) {
      return this.matches;
    }
    return this.matches.filter((item: Match) => {
      return item.teamName1.toLowerCase().includes(normalizedText) ||
        item.teamName2.toLowerCase().includes(normalizedText);
    });
  }

  private getSliderMax(): number {
    const count = this.getFilteredMatches().length;
    return count > 0 ? count : 1;
  }

  private getVisibleMatches(): Match[] {
    const filteredMatches = this.getFilteredMatches();
    if (filteredMatches.length === 0) {
      return [];
    }
    const limit = Math.min(Math.max(1, Math.round(this.visibleMatchCount)), filteredMatches.length);
    return filteredMatches.slice(0, limit);
  }

  private syncVisibleMatchCount(): void {
    const max = this.getSliderMax();
    if (this.visibleMatchCount > max) {
      this.visibleMatchCount = max;
    }
    if (this.visibleMatchCount < 1) {
      this.visibleMatchCount = 1;
    }
  }

  private isDraw(item: Match): boolean {
    return item.team1Point === item.team2Point;
  }

  private getWinnerName(item: Match): string {
    return item.team1Point > item.team2Point ? item.teamName1 : item.teamName2;
  }

  private getMatchKey(item: Match): string {
    return `${item.type}-${item.teamName1}-${item.teamName2}-${item.date.getTime()}-${item.team1Point}-${item.team2Point}`;
  }

  @Builder
  resultStatusText(item: Match, textSize: number, isCenter: boolean = false) {
    if (this.isDraw(item)) {
      Text($r('app.string.match_draw'))
        .fontSize(textSize)
        .fontColor(this.getTheme().accentStrong)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(isCenter ? TextAlign.Center : TextAlign.End)
    } else {
      Row({ space: 4 }) {
        Text(this.getWinnerName(item))
          .fontSize(textSize)
          .fontColor(this.getTheme().accentStrong)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .textAlign(isCenter ? TextAlign.Center : TextAlign.End)

        Text($r('app.string.match_won'))
          .fontSize(textSize)
          .fontColor(this.getTheme().accentStrong)
      }
      .justifyContent(isCenter ? FlexAlign.Center : FlexAlign.End)
    }
  }

  @Builder
  scoreRow(item: Match) {
    Row() {
      Text(item.team1Point.toString())
        .fontSize(28)
        .fontWeight(700)
        .fontColor(this.getTheme().textPrimary)
      Text('-')
        .fontSize(28)
        .fontWeight(700)
        .fontColor(this.getTheme().textPrimary)
        .margin({ left: 6, right: 6 })
      Text(item.team2Point.toString())
        .fontSize(28)
        .fontWeight(700)
        .fontColor(this.getTheme().textPrimary)
    }
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  swiperCard(item: Match) {
    Column({ space: 6 }) {
      Text(item.date.toLocaleDateString())
        .fontColor(this.getTheme().textMuted)
        .fontSize(12)

      Text($r('app.string.matches_full_time'))
        .fontSize(11)
        .fontColor(this.getTheme().accent)

      Text(item.teamName1)
        .fontSize(15)
        .fontWeight(700)
        .fontColor(this.getTheme().textPrimary)
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      this.scoreRow(item)

      Text(item.teamName2)
        .fontSize(15)
        .fontWeight(700)
        .fontColor(this.getTheme().textPrimary)
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Column() {
        this.resultStatusText(item, 10, true)
      }
      .width('80%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.Transparent)
  }

  @Builder
  compactRow(item: Match) {
    Column({ space: 4 }) {
      Row() {
        Text(item.teamName1)
          .fontSize(13)
          .fontColor(this.getTheme().textPrimary)
          .fontWeight(700)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)

        Text(`${item.team1Point}-${item.team2Point}`)
          .fontSize(15)
          .fontColor(this.getTheme().textPrimary)
          .fontWeight(800)
          .margin({ left: 8, right: 8 })

        Text(item.teamName2)
          .fontSize(13)
          .fontColor(this.getTheme().textPrimary)
          .fontWeight(700)
          .maxLines(1)
          .textAlign(TextAlign.End)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)
      }
      .width('100%')

      Row() {
        Text(item.date.toLocaleDateString())
          .fontSize(10)
          .fontColor(this.getTheme().textMuted)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('35%')

        Column() {
          this.resultStatusText(item, 10)
        }
        .layoutWeight(1)
        .margin({ left: 8 })
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
    }
    .width('86%')
    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
    .backgroundColor(Color.Transparent)
  }

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 6 }) {
          Blank().height(12)

          Row({ space: 4 }) {
            Text(this.getSportTitle())
              .fontSize(15)
              .fontColor(this.getTheme().textPrimary)
              .fontWeight(800)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            Text($r('app.string.matches_results_suffix'))
              .fontSize(15)
              .fontColor(this.getTheme().accentStrong)
              .fontWeight(800)
          }
          .width('76%')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          TextInput({ placeholder: $r('app.string.matches_filter_team_placeholder'), text: this.filterText })
            .placeholderColor(this.getTheme().inputPlaceholder)
            .placeholderFont({ size: 10 })
            .fontColor(this.getTheme().textPrimary)
            .fontSize(10)
            .width('80%')
            .height(34)
            .backgroundColor(this.getTheme().panel)
            .borderRadius(17)
            .padding({ left: 12, right: 12 })
            .border({ width: 1, color: this.getTheme().accent })
            .onChange((value: string) => {
              this.filterText = value;
              this.syncVisibleMatchCount();
              this.activeCardIndex = 0;
            })

          Row({ space: 8 }) {
            Toggle({ type: ToggleType.Switch, isOn: this.showListMode })
              .selectedColor(this.getTheme().accent)
              .onChange((isOn: boolean) => {
                this.showListMode = isOn;
                this.activeCardIndex = 0;
              })

            Text(this.showListMode ? $r('app.string.matches_list_view') : $r('app.string.matches_card_view'))
              .fontSize(11)
              .fontColor(this.getTheme().accentStrong)

            Blank()

            Text(`${this.getVisibleMatches().length}/${this.getFilteredMatches().length}`)
              .fontSize(11)
              .fontColor(this.getTheme().textSecondary)
          }
          .width('80%')
          .alignItems(VerticalAlign.Center)

          Row({ space: 10 }) {
            Slider({
              value: this.visibleMatchCount,
              min: 1,
              max: this.getSliderMax(),
              step: 1,
              style: SliderStyle.InSet
            })
              .layoutWeight(1)
              .selectedColor(this.getTheme().accentStrong)
              .blockColor(this.getTheme().accentStrong)
              .trackColor(this.getTheme().sliderTrack)
              .showTips(true)
              .onChange((value: number) => {
                this.visibleMatchCount = Math.round(value);
                this.syncVisibleMatchCount();
                this.activeCardIndex = 0;
              })

            Progress({
              value: this.getVisibleMatches().length,
              total: this.getSliderMax(),
              type: ProgressType.Ring
            })
              .width(34)
              .color(this.getTheme().accentStrong)
              .style({ strokeWidth: 5 })
          }
          .width('80%')
          .alignItems(VerticalAlign.Center)

          Divider()
            .strokeWidth(1)
            .color(this.getTheme().divider)
            .width('80%')

          if (this.getFilteredMatches().length === 0) {
            Column({ space: 5 }) {
              Text($r('app.string.matches_no_matches_found'))
                .fontSize(14)
                .fontColor(this.getTheme().textPrimary)

              Text($r('app.string.matches_try_another_team'))
                .fontSize(11)
                .fontColor(this.getTheme().textSecondary)
            }
            .height(180)
            .justifyContent(FlexAlign.Center)
          } else if (this.showListMode) {
            Stack() {
              List({ space: 4 }) {
                ForEach(this.getVisibleMatches(), (item: Match) => {
                  ListItem() {
                    Column() {
                      this.compactRow(item)
                    }
                    .width('100%')
                    .alignItems(HorizontalAlign.Center)
                  }
                }, (item: Match) => this.getMatchKey(item))
              }
              .width('100%')
              .height('100%')
              .scrollBar(BarState.Off)
            }
            .width('92%')
            .height(250)
          } else {
            Swiper() {
              ForEach(this.getVisibleMatches(), (item: Match) => {
                this.swiperCard(item)
              }, (item: Match) => this.getMatchKey(item))
            }
            .indicator(
              new DotIndicator()
                .selectedColor(this.getTheme().accentStrong)
                .color(this.getTheme().swiperDot)
            )
            .onChange((index: number) => {
              this.activeCardIndex = index;
            })
            .width('90%')
            .height(240)

            Row({ space: 2 }) {
              Text($r('app.string.matches_card_label'))
                .fontSize(10)
                .fontColor(this.getTheme().accentStrong)
              Text(`${this.activeCardIndex + 1} / ${this.getVisibleMatches().length}`)
                .fontSize(10)
                .fontColor(this.getTheme().accentStrong)
            }
          }
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .padding({ bottom: 12 })
      }
      .scrollBar(BarState.Off)
      .linearGradient({
        direction: GradientDirection.Bottom,
        repeating: false,
        colors: [[this.getTheme().backgroundTop, 0], [this.getTheme().backgroundBottom, 1]]
      })
      .height('100%')
      .width('100%')
    }.onReady((ctx: NavDestinationContext) => {
      this.pageStack = ctx.pathStack;
      const params = ctx.pathInfo.param as SportType;
      this.sportType = params;
      this.matches = this.matchesViewModel.getMatches(this.sportType)
      this.color = this.matchesViewModel.getBackgroundColor(this.sportType)
      this.visibleMatchCount = Math.min(2, this.matches.length > 0 ? this.matches.length : 1);
    })
    .hideBackButton(true)
  }
}

