import { SportType } from '../common/Enums';

export class Sport {
  name: string;
  gradientColor: ResourceColor;
  image: Resource;
  type: SportType;

  constructor(name: string, gradientColor: ResourceColor, image: Resource, type: SportType) {
    this.name = name;
    this.gradientColor = gradientColor;
    this.image = image;
    this.type = type;
  }
}