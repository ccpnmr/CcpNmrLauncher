//
//  ViewController.swift
//  Launcher
//
//  Created by Luca Mureddu on 08/03/2022.
//  Copyright © 2022 CCPN. All rights reserved.


import Cocoa
import Foundation


class ViewController: NSViewController {
    let bundleURL = Bundle.main.bundleURL
    let contents = "Contents/"
    let resources = "Resources/"
    let analysis = "ccpnmrV3/" // this is the ccpn top dir name. bundles needs to have  all the contentent of Analysis inside the dir called as analysis var
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.isMovableByWindowBackground = true
        }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
        }

    @discardableResult
    func shell(_ args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
//        task.waitUntilExit()
        return task.terminationStatus
        }
    func _getRunningAppPath(_ appName: String) -> String {
        let analysisRelPath =  contents + resources + analysis
        let analysisPath = bundleURL.appendingPathComponent(analysisRelPath).absoluteString
        let appPath = analysisPath+"/bin/"+appName
        return appPath
    }
    
    func _runApp(_ appPath: String) {
        shell("open", "-a", "Terminal", appPath )
    }
    
    @IBAction func _close(_ sender: NSButton) {
         NSApplication.shared.terminate(self)
        }
    
    @IBAction func runFromIcon(_ sender: NSButton) {
        let appPath = _getRunningAppPath(sender.title)
        _runApp(appPath)
        }
    
    @IBAction func runFromSubMenu(_ sender: NSMenuItem) {
        let appPath = _getRunningAppPath(sender.title)
        _runApp(appPath)
        }
    
    
    @IBAction func revealTutorial(_ sender: NSMenuItem) {
        let analysisRelPath = contents + resources + analysis
        let analysisPath = bundleURL.appendingPathComponent(analysisRelPath).absoluteString
        let tut = analysisPath+"/tutorials"
        shell("open", tut )
        }
    
    @IBAction func reavelBin(_ sender: NSMenuItem) {
        let analysisRelPath =  contents + resources + analysis
        let analysisPath = bundleURL.appendingPathComponent(analysisRelPath).absoluteString
        let bin = analysisPath+"/bin"
        shell("open", bin)
        }
    
   
    @IBAction func reavelHiddenCcpn(_ sender: NSMenuItem) {
        let hiddenCCPN = "~.ccpn"
        shell("open", hiddenCCPN)
        }
    
    fileprivate func directoryExistsAtPath(_ path: String) -> Bool {
        var isDirectory = ObjCBool(true)
        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
        }
}


