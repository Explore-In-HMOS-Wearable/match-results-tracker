import { curves } from '@kit.ArkUI';

@Component
export struct AnimatedText {

  @Prop message: string;
  @State opacityValue: number = 1; // Opacity value for animation
  @State translateY: number = 0; // Translation value for animation

  build() {
    Column() {
      Text(this.message) // Display the text from the array
        .opacity(this.opacityValue) // Apply opacity animation
        .translate({ y: this.translateY }) // Apply translation animation
        .fontSize(30)
        .fontWeight(800)
        .fontColor('#ff00ff39')
        .textShadow({ radius: 20, color: '#ff00ff39', offsetX: 0, offsetY: 0 })
        .animation({
          curve: curves.customCurve((fraction) => {
            return Math.pow(fraction, 5); // Custom easing curve
          }),
          iterations: -1,
          duration: 1500,
          playMode: PlayMode.Alternate,
        })
        .onAppear(() => {
          this.opacityValue = this.opacityValue === 1 ? 0 : 1;
        })
    }
  }
 }
