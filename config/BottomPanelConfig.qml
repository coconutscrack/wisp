import Quickshell
import QtQuick

QtObject {
  property int width: 100
  property int height: 100

  // property int radius: width < height ? width / 4 : height / 4
  property int radius: { let tmp_r = (width < height ? width / 4 : height / 4) 
  tmp_r > 20 ? 20 : tmp_r }
}
