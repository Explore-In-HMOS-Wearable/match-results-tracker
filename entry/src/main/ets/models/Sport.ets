import { SportType } from '../common/Enums';

export class Sport {
  name: ResourceStr;
  gradientColor: ResourceColor;
  image: Resource;
  type: SportType;

  constructor(name: ResourceStr, gradientColor: ResourceColor, image: Resource, type: SportType) {
    this.name = name;
    this.gradientColor = gradientColor;
    this.image = image;
    this.type = type;
  }
}
