//  main.swift
//  ColorBytesToFloat
//
//  Created by Garces, Johann (TEKsystems) on 2/3/16.
//  Copyright © 2016 johannmg. All rights reserved.
//

import Foundation
import AppKit

// - MARK: Extensions
extension String {
    var floatVal: Float {
        return (self as NSString).floatValue
    }
}

extension Float {
    var fff: String {
        return String(format: "%.3f", self)
    }
}
// - MARK: Enums
enum OperatingMode {
  case ByteToFloat, RgbToUIColor, RgbaToUIColor, HexToUIColor
}

// - MARK: Global Variables
var response: String = ""
var autoToClipboard = true
var mode = OperatingMode.RgbToUIColor
var kb = NSFileHandle.fileHandleWithStandardInput()
var inputData: NSData?

// - MARK: Main Helper Functions
func getKeyboardData(){
  
  inputData = kb.availableData
  var tempDirtyInput = NSString(data: inputData!, encoding: NSUTF8StringEncoding) as! String
  tempDirtyInput = tempDirtyInput.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
  response = tempDirtyInput.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "#"))  //for hex
}

func printHelp(){
  //TODO: print help
  var output = ""
  output += "Quick little app by JohannMG to make moving RBG or HEX to UI Colors faster \r\n"
  output += "Modes----------\r\n"
  output += "byte: convert bytes (0-255) to itsfloat values\r\n"
  output += "rgb: convert RRR GGG BBB into a UIColor string\r\n"
  output += "rgba: convert RRR GGG BBB AAA into a UIColor string with alpha \r\n"
  output += "hex: convert hex values #FFAF00 into UIColor string \r\n"
  output += "RGB value sperators can be: space, comma(,), period(.), or slash(\\) \r\n"
  
  output += "Autopaste------\r\n"
  output += "by default, pastes to your clipboard to make things quick\r\n"
  output += "use `autopaste off` or `autopaste on` to toggle\r\n"
  
  output += "Help------\r\n"
  output += "Shows this screen :] \r\n"
  
  
  
  print(output)
}

func toPasteboard(toPaste : String){
  let pb = NSPasteboard.generalPasteboard()
  pb.clearContents()
  pb.writeObjects([toPaste])
}

// - MARK: Begin application
print ("RGB to Swift UIColor by @johann_mg")
print ("Type `autopaste off` to disable automatic pasting to clipboard")
print ("Modes: byte, rgb, rgba, hex. Options: help, autopaste")
print ("Starting in rgb mode: Enter input as  RRR GGG BBB ")

// - MARK: Main loop
while response != "q" && response != "quit"{
  
  getKeyboardData()
  
  
  switch (response) {
    
  //check for mode changes
  case "byte":
    mode = .ByteToFloat
    print("Set mode to Byte to Float. Input integers")
    continue
    
  case "rgb":
    mode = .RgbToUIColor
    print("Set mode to RGB, enter input as  RRR GGG BBB")
    continue
    
  case "rgba":
    mode = .RgbaToUIColor
    print("Set mode to RGBA, enter input as  RRR GGG BBB AAA")
    continue
    
  case "hex":
    mode = .HexToUIColor
    print("Set mode to Hex, enter input as #FAFF00, hash optional")
    continue
    
  //autocopy settings
  case "autocopy off":
    autoToClipboard = false
    print("Automatic copying off")
    continue
    
  case "autocopy on":
    autoToClipboard = true
    print("Automatic copying on")
    continue
    
  case "autocopy":
    print("turn on/off using `autocopy on` or `autocopy off`")
    continue
    
  case "help", "halp":
    printHelp()
    continue
  
  default: break
  }
  
  var uicolorOutput = ""
  switch( mode ){

  case .ByteToFloat:
    uicolorOutput = "\(response.floatVal / 255.0)"
    print (uicolorOutput)
    if autoToClipboard { toPasteboard(uicolorOutput) }
    
  case .RgbToUIColor:
    let varArray:[String] = response.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: " ,./"))
    if varArray.count < 3 {
      print ("Too few inputs, should be in format `RRR GGG BBB`")
      break
    }
    uicolorOutput = "UIColor(red: \((varArray[0].floatVal/255.0).fff), "
    uicolorOutput +=      "green: \((varArray[1].floatVal/255.0).fff), "
    uicolorOutput +=       "blue: \((varArray[2].floatVal/255.0).fff), alpha: 1.00)"
    print (uicolorOutput)
    if autoToClipboard { toPasteboard(uicolorOutput) }
    
  case .RgbaToUIColor:
    let varArray:[String] = response.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: " ,./"))
    if varArray.count < 4 {
      print ("Too few inputs, should be in format `RRR GGG BBB AAA`")
      break
    }
    uicolorOutput = "UIColor(red: \((varArray[0].floatVal/255.0).fff), "
    uicolorOutput +=      "green: \((varArray[1].floatVal/255.0).fff), "
    uicolorOutput +=       "blue: \((varArray[2].floatVal/255.0).fff), "
    uicolorOutput +=      "alpha: \((varArray[3].floatVal/255.0).fff))"
    print(uicolorOutput)
    if autoToClipboard { toPasteboard(uicolorOutput) }
  
  case .HexToUIColor:
    if response.characters.count != 6 {
      print("Wrong RGB hexadecimal input, should be `RRGGBB`")
      break
    }
    //get string bits
    let rr = response.substringWithRange(Range<String.Index>(start: response.startIndex, end: response.startIndex.advancedBy(2) ))
    let gg = response.substringWithRange(Range<String.Index>(start: response.startIndex.advancedBy(2), end: response.startIndex.advancedBy(4) ))
    let bb = response.substringWithRange(Range<String.Index>(start: response.startIndex.advancedBy(4), end: response.startIndex.advancedBy(6) ))
    
    //get values from that
    let rrInt = Float ( UInt8(strtoul(rr, nil, 16)) )
    let ggInt = Float ( UInt8(strtoul(gg, nil, 16)) )
    let bbInt = Float ( UInt8(strtoul(bb, nil, 16)) )
    
    uicolorOutput += "UIColor(red: \(  (rrInt/255.0).fff), "
    uicolorOutput +=       "green: \( (ggInt/255.0).fff ), "
    uicolorOutput +=        "blue: \( (bbInt/255.0).fff ), alpha: 1.00)"
    print (uicolorOutput)
    if autoToClipboard { toPasteboard(uicolorOutput) }
    
    
    
    
  }//end switch
  
  
}



