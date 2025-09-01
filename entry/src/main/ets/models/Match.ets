import { SportType } from '../common/Enums';

export class Match {
  teamName1: string;
  teamName2: string;
  team1Point: number;
  team2Point: number;
  type: SportType;
  date: Date;

  constructor(teamName1: string, teamName2: string, team1Point: number, team2Point: number, type: SportType,
    date: Date) {
    this.teamName1 = teamName1;
    this.teamName2 = teamName2;
    this.team1Point = team1Point;
    this.team2Point = team2Point;
    this.type = type;
    this.date = date;
  }
}