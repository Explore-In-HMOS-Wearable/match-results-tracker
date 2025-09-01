import { basketballColor, footballColor, volleyballColor } from '../common/Constants';
import { SportType } from '../common/Enums';
import { Match } from '../models/Match';

export class MatchesViewModel {
  getBackgroundColor(sportType: SportType): ResourceColor {
    switch (sportType) {
      case SportType.football:
        return footballColor;
      case SportType.basketball:
        return basketballColor;
      case SportType.volleyball:
        return volleyballColor;
    }
  }

  getMatches(sportType: SportType): Array<Match> {
    switch (sportType) {
      case SportType.football:
        return footballMatchesData;
      case SportType.basketball:
        return basketballMatchesData;
      case SportType.volleyball:
        return volleyballMatchesData;
    }
  }
}

export const footballMatchesData: Array<Match> = [
  new Match(
    'Manchester Splitted',
    'Nevertoon',
    3,
    1,
    SportType.football,
    new Date(2025, 4, 17),
  ),
  new Match(
    'Old Boys',
    'Pliezig',
    2,
    2,
    SportType.football,
    new Date(2025, 4, 20),
  ),
  new Match(
    'Al-Hady',
    'Aş-Şams',
    0,
    1,
    SportType.football,
    new Date(2025, 4, 21),
  ),
  new Match(
    'Cordoba City',
    'Real Barcelona',
    1,
    1,
    SportType.football,
    new Date(2025, 4, 27),
  )
]

const basketballMatchesData: Array<Match> = [
  new Match(
    'Manchester Splitted',
    'Nevertoon',
    120,
    128,
    SportType.basketball,
    new Date(2025, 4, 15),
  ),
  new Match(
    'Old Boys',
    'Pliezig',
    98,
    105,
    SportType.basketball,
    new Date(2025, 4, 28),
  ),
  new Match(
    'Al-Hady',
    'Aş-Şams',
    102,
    89,
    SportType.basketball,
    new Date(2025, 5, 3),
  ),
  new Match(
    'Cordoba City',
    'Real Barcelona',
    104,
    117,
    SportType.basketball,
    new Date(2025, 5, 5),
  )
]

const volleyballMatchesData: Array<Match> = [
  new Match(
    'Manchester Splitted',
    'Nevertoon',
    3,
    1,
    SportType.volleyball,
    new Date(2025, 3, 14),
  ),
  new Match(
    'Old Boys',
    'Pliezig',
    3,
    2,
    SportType.volleyball,
    new Date(2025, 3, 15),
  ),
  new Match(
    'Al-Hady',
    'Aş-Şams',
    2,
    3,
    SportType.volleyball,
    new Date(2025, 3, 18),
  ),
  new Match(
    'Cordoba City',
    'Real Barcelona',
    1,
    3,
    SportType.volleyball,
    new Date(2025, 3, 21),
  )
]