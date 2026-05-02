import { basketballColor, footballColor, volleyballColor } from '../common/Constants';
import { SportType } from '../common/Enums';
import { Sport } from '../models/Sport';

export const sportsViewModel: Array<Sport> = [
  new Sport(
    $r('app.string.sport_football'),
    footballColor,
    $rawfile('football.png'),
    SportType.football,
  ),
  new Sport(
    $r('app.string.sport_basketball'),
    basketballColor,
    $rawfile('basketball.png'),
    SportType.basketball,
  ),
  new Sport(
    $r('app.string.sport_volleyball'),
    volleyballColor,
    $rawfile('volleyball.png'),
    SportType.volleyball,
  )
]
