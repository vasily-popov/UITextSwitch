# UITextSwitch
UITextSwitch is a UIControl subclass which is similar to UISwitch, but with a text inside control on left or right side

![alt text](https://github.com/vascome/UITextSwitch/blob/master/offState.png)

![alt text](https://github.com/vascome/UITextSwitch/blob/master/onState.png)

Installation

Drag the “UITextSwitch.h and .m” file into your Xcode project

Usage via Interface Builder

Drag a custom view into your storyboard and change it’s class to “UITextSwitch”. Use the attributes inspector to optionally set the switch’s basic properties:

offText/onText String

isOn boolean

offColor/onColor color

borderColor color

backgroundColor color

borderWidth float

# UITwoStateSwitch

UITwoStateSwitch is a UIControl subclass which is similar to UISwitch. 
It has two switches inside and trigger the change by pressing one of the state. Highly configuarble and easy to change to fit any needs. 
BTW UISwitch can state by any click at them.

![alt text](https://github.com/vascome/UITextSwitch/blob/master/twoStateSwitch.png)

Installation

Drag the “UITwoStateSwitch.h and .m” file into your Xcode project

Usage via Interface Builder

Drag a custom view into your storyboard and change it’s class to “UITwoStateSwitch”. Use the attributes inspector to optionally set the switch’s basic properties:

for left active state:
 leftText - text inside state ,NSString
 leftIcon - image inside state, UIImage
 leftColor - state backgorund color, UIColor 
 leftTextColor - text color inside state, UIColor
 
 if leftIcon is set, left text is ignored.
 
for right active state:
 rightText - text inside state ,NSString
 rightIcon - image inside state, UIImage
 rightColor - state backgorund color, UIColor 
 rightTextColor - text color inside state, UIColor
 
 if rightIcon is set, right text is ignored.

for inactive state (both right and left)
 
 offColor - state backgorund color,UIColor
 offColor - text color inside state, UIColor
 offItemBorderColor - border color for inactive state.
 

generic control properties
 borderColor - UIColor
 backgroundColor - UIColor
 borderWidth - float
 
 
Only one state is active, left or right.
- (void)setActive:(BOOL)active animated:(BOOL)animated;
 if active = true - left is active, otherwise right is active. 

there are two blocks leftItemClickedBlock and rightItemClickedBlock

