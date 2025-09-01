import { basketballColor, footballColor, volleyballColor } from '../common/Constants';
import { SportType } from '../common/Enums';
import { Sport } from '../models/Sport';

export const sportsViewModel: Array<Sport> = [
  new Sport(
    'Football',
    footballColor,
    $rawfile('football.png'),
    SportType.football,
  ),
  new Sport(
    'Basketball',
    basketballColor,
    $rawfile('basketball.png'),
    SportType.basketball,
  ),
  new Sport(
    'Volleyball',
    volleyballColor,
    $rawfile('volleyball.png'),
    SportType.volleyball,
  )
]