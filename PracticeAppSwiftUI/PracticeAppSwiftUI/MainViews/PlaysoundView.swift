//
//  PlaysoundView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 18.05.2024.
//

import AVFoundation
import SwiftUI

class PlayingTimer {
    var timer: Timer?
    var timerTickedHandler: (() -> Void)?
    
    deinit {
        print("timer were deinitialized")
    }
    
    func configure() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true)  { [weak self] timer in
            self?.timerTickedHandler?()
        }
        timer?.fire()
    }
    
    @objc private func timerTicked() {
        timerTickedHandler?()
    }
}

struct PlaysoundView: View {
    @State var sliderValue: Double = 0.0
    @State var currentPlayingTimeString: String?
    @State var isPlaying = false
    @State var audioPlayer: AVAudioPlayer?
    @State var audioDuration = 0.0
    @State var audioDurationText: String?
    @State var currentChapterName = ""
    var timer = PlayingTimer()
    let chapterNames = ["testSound1", "testSound2"]
        
    var body: some View {
        @State var player : AVAudioPlayer!
        
        VStack {
            Text(currentChapterName)
            
            Slider(value: $sliderValue) {
                
            } minimumValueLabel: {
                Text(currentPlayingTimeString ?? "0:00")
            } maximumValueLabel: {
                Text(audioDurationText ?? "")
            } onEditingChanged: { _ in
                setPlayer(time: Double(sliderValue))
            }

            
            HStack(spacing: UIScreen.main.bounds.width / 7 - 5) {
                Button(action: {
                    changeChapterPressed(goForward: false)
                }) {
                    Image(systemName: "backward.end.fill").font(.title)
                }
                
                Button(action: {
                    changeCurrentTime(for: -10)
                }) {
                    Image(systemName: "gobackward.10").font(.title)
                }
                Button(action: {
                    if self.isPlaying == false {
                        playAudio()
                    }else{
                        pauseAudio()
                    }
                    
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.title)
                }
                
                Button(action: {
                    changeCurrentTime(for: 10)
                }) {
                    Image(systemName: "goforward.10").font(.title)
                    
                }
                Button(action: {
                    changeChapterPressed(goForward: true)
                }) {
                    Image(systemName: "forward.end.fill").font(.title)
                }
            }
            .frame(height: 30)
            .foregroundColor(.black)

        }
        .padding()
        .onAppear {
            prepare(sound: "testSound1", type: "mp3")
            playAudio()
        }
        
    }
    
    private func changeChapterPressed(goForward: Bool) {
        guard let currentFileName = audioPlayer?.url?.deletingPathExtension().lastPathComponent,
              let currentIndex = chapterNames.firstIndex(of: currentFileName) else {
            return
        }
        
        let newIndex: Int
        if goForward {
            newIndex = currentIndex + 1
        } else {
            newIndex = max(currentIndex - 1, 0)
        }
        
        if chapterNames.count > newIndex {
            let backAudioName = chapterNames[newIndex]
            prepare(sound: backAudioName, type: "mp3")
            playAudio()
        } else if currentIndex <= 0 {
            print("already plaing first chapter")
        }
    }
    
    func prepare(sound: String, type: String) {
        currentChapterName = sound
        sliderValue = 0.0
        audioPlayer?.stop()
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                if let audioPlayer = audioPlayer {
                    audioDuration = audioPlayer.duration
                    audioDurationText = secondsToHoursMinutesSeconds(Int(audioPlayer.duration))
                }
            } catch {
                print("error")
            }
        }
    }
    
    private func playAudio() {
        audioPlayer?.play()
        timer.timer?.invalidate()
        isPlaying = true
        timer.timerTickedHandler = {
            sliderValue = (1 / audioDuration) + sliderValue
            if let audioPlayer = audioPlayer {
                currentPlayingTimeString = secondsToHoursMinutesSeconds(Int(audioPlayer.currentTime))
            }
//            print(sliderValue)
        }
        timer.configure()
        
    }
    
    private func pauseAudio() {
        audioPlayer?.pause()
        isPlaying = false
        timer.timer?.invalidate()
    }
    
    private func setPlayer(time: Double) {
        if let audioPlayer = audioPlayer {
            audioPlayer.currentTime = audioPlayer.duration * time
        }
        
    }
    
    private func changeCurrentTime(for seconds: Int) {
        if let audioPlayer = audioPlayer {
            audioPlayer.currentTime = audioPlayer.currentTime + Double(seconds)
            sliderValue = audioPlayer.currentTime / audioPlayer.duration
        }
    }
    
    private func secondsToHoursMinutesSeconds(_ seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter.string(from: TimeInterval(seconds))!
    }
    
}
    

#Preview {
    PlaysoundView()
}
