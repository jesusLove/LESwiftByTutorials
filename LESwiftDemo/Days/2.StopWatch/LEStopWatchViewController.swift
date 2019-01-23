//
//  LEStopWatchViewController.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/17.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit

class LEStopWatchViewController: UIViewController {

    fileprivate let mainStopWatch = LEStopWatch()
    fileprivate let lapStopWatch = LEStopWatch()
    fileprivate var isPlay = false
    fileprivate var laps:[String] = []
    fileprivate let identifierCell = "lapCell"
    
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var lapTimeLB: UILabel!
    @IBOutlet weak var lapResetBtn: UIButton!
    @IBOutlet weak var startPauseBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 给Button设置为圆形
        let initCircleBtn:(UIButton) -> Void = {button in
            button.layer.cornerRadius = button.bounds.size.width * 0.5
            button.backgroundColor = .white
        }
        initCircleBtn(lapResetBtn)
        initCircleBtn(startPauseBtn)
        lapResetBtn.isEnabled = false
        
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    
    /// 开始和暂停
    @IBAction func startPauseTimer(_ sender: Any) {
        lapResetBtn.isEnabled = true
        
        changeButton(button: lapResetBtn, title: "Lap", titleColor: .black)
        unowned let weakSelf = self
        // 未运行
        if !isPlay {
            // 两个定时器
            mainStopWatch.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
                weakSelf.updateMainTimer()
            })
            lapStopWatch.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
                weakSelf.updateLapTimer()
            })
            RunLoop.current.add(mainStopWatch.timer, forMode: RunLoop.Mode.common)
            RunLoop.current.add(lapStopWatch.timer, forMode: RunLoop.Mode.common)
            isPlay = true
            changeButton(button: startPauseBtn, title: "Stop", titleColor: .red)
        } else {
            // 暂停
            mainStopWatch.timer.invalidate()
            lapStopWatch.timer.invalidate()
            isPlay = false
            changeButton(button: startPauseBtn, title: "Start", titleColor: .green)
            changeButton(button: lapResetBtn, title: "Reset", titleColor: .black)
        }
    }
    
    @IBAction func lapStopTimer(_ sender: Any) {
        if !isPlay {
            resetMainTimer()
            resetLapTimer()
            changeButton(button: lapResetBtn, title: "Lap", titleColor: .lightGray)
            lapResetBtn.isEnabled = false
        } else {
            if let timeLBText = timeLB.text {
                laps.append(timeLBText)
            }
            tableView.reloadData()
            resetLapTimer()
            unowned let weakSelf = self
            lapStopWatch.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
                weakSelf.updateLapTimer()
            })
            RunLoop.current.add(lapStopWatch.timer, forMode: RunLoop.Mode.common)
        }
    }

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        lapStopWatch.timer.invalidate()
        mainStopWatch.timer.invalidate()
    }
}

// MARK: - 私有方法
fileprivate extension LEStopWatchViewController {
    // 更新计时
    func updateMainTimer() {
        updateTimer(mainStopWatch, label: timeLB)
    }
    func updateLapTimer() {
        updateTimer(lapStopWatch, label: lapTimeLB)
    }
    func updateTimer(_ stopWatch: LEStopWatch, label: UILabel) {
        stopWatch.counter += 0.05
        let minutes = (Int)(stopWatch.counter / 60)
        let seconds = stopWatch.counter.truncatingRemainder(dividingBy: 60)
        
        var minutesStr = "\(minutes)"
        if minutes < 10 {
            minutesStr = "0\(minutes)"
        }
        var secondStr = String(format: "%.2f", seconds)
        if seconds < 10.0 {
            secondStr = "0" + secondStr
        }
        label.text = minutesStr + ":" + secondStr
    }
    
    // 重置计时
    func resetMainTimer() {
        resetTimer(mainStopWatch, label: timeLB)
        laps.removeAll()
        tableView.reloadData()
    }
    func resetLapTimer() {
        resetTimer(lapStopWatch, label: lapTimeLB)
    }
    
    func resetTimer(_ stopWatch: LEStopWatch, label: UILabel) {
        stopWatch.timer.invalidate()
        stopWatch.counter = 0.0
        label.text = "00:00:00"
    }
    
    
    // 修改Btn的title和titleColor
    func changeButton(button: UIButton, title: String, titleColor: UIColor) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
    }
}

// MARK: - UITableViewDelegate
extension LEStopWatchViewController : UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension LEStopWatchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)
        if let labelNum = cell.viewWithTag(11) as? UILabel {
            labelNum.text = "Lap\(laps.count - indexPath.row)"
        }
        if let labelTimer = cell.viewWithTag(12) as? UILabel {
            labelTimer.text = laps[laps.count - indexPath.row - 1]
        }
        return cell
    }
}
