//
//  ViewController.swift
//  MyswipApp
//
//  Created by VERTEX24 on 2019/08/10.
//  Copyright © 2019 VERTEX24. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 透明なやつ
    @IBOutlet weak var baseCard: UIView!
    // good,badを表示するやつ
    @IBOutlet weak var likeImage: UIImageView!
    
    
    // ユーザーカード
    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var person3: UIView!
    @IBOutlet weak var person4: UIView!
    @IBOutlet weak var person5: UIView!
    
    // ベースカードの中心
    var centerOfCard: CGPoint!
    //ユーザーカードの配列
    var personList: [UIView] = []
    // 選択されたカードの数
    var selectedCardCount: Int = 0
    // ユーザーリスト
    let nameList: [String] = ["津田梅子","ジョージ・ワシントン","ガリレオ・ガリレイ","板垣退助","ジョン万次郎"]
    // いいねをされた人の名前の配列
    var likeName: [String] = []
    
    // viewのレイアウト処理が完了した時に呼ばれる
    override func viewDidLayoutSubviews() {
        // ベースカードの中心を代入
        centerOfCard = baseCard.center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // personListにperson1から5を追加
        personList.append(person1)
        personList.append(person2)
        personList.append(person3)
        personList.append(person4)
        personList.append(person5)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToLikedList" {
            let vc = segue.destination as! LikedTableViewController
            
            vc.likedName = likeName
        }
    }
    
    // ベースカードをもとに戻す関数
    func resetCard(){
        // 位置を戻す
        baseCard.center = centerOfCard
        // 角度を戻す
        baseCard.transform = .identity
    }
    
    
    
    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
        // これは透明カードのことスワイプで動くviewを定数にする
        let card = sender.view!
        // 動いた距離
        let point = sender.translation(in: view)  // 大本のviewからどれだけ動いたかを見る
        // 元の中心の座標にう動いた分の座標を足して動いた先の座標を取得する
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        // ユーザーカードにも同じ動きをさせる
        personList[selectedCardCount].center = CGPoint(x: card.center.x + point.x, y:card.center.y + point.y)
        
        // 元の位置と移動先との差
        let xfromCenter = card.center.x - view.center.x
        
        // 角度をつける処理
        card.transform = CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)
        // ユーザーカードにも同じ処理
        personList[selectedCardCount].transform = CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)
        
        
        if xfromCenter > 0{
            // good表示
            likeImage.image = #imageLiteral(resourceName: "いいね")     // image Literal
            likeImage.isHidden = false
            
        }else if xfromCenter < 0{
            // bad表示
            likeImage.image = #imageLiteral(resourceName: "よくないね")
            likeImage.isHidden = false
        }
        
        
        
        
        // 元の位置に戻す処理
        if sender.state == UIGestureRecognizer.State.ended {  // 指を離したとき
            
            
            if card.center.x < 50 {
                // 左に大きくスワイプしたときの処理
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    // 該当のユーザーカードを画面外(マイナス方向)へ飛ばす
                    self.personList[self.selectedCardCount].center = CGPoint(x:self.personList[self.selectedCardCount].center.x - 500, y: self.personList[self.selectedCardCount].center.y)
                })
                // ベースカードの位置と角度を戻す
                resetCard()
                // good,bad表示を隠す
                likeImage.isHidden = true
                // カウントを1増やす
                selectedCardCount += 1
                
                
                if selectedCardCount >= personList.count {
                    // 遷移処理
                    performSegue(withIdentifier: "ToLikedList", sender: self)
                }
                
            } else if card.center.x > self.view.frame.width - 50 {
                // 右に大きくスワイプしたときの処理
                
                UIView.animate(withDuration: 0.5, animations: {
                    // ベースカードを元の位置に戻す
                    self.baseCard.center = self.centerOfCard
                    // 該当のユーザーカードを画面外(プラス方向)へ飛ばす
                    self.personList[self.selectedCardCount].center = CGPoint(x:self.personList[self.selectedCardCount].center.x + 500, y: self.personList[self.selectedCardCount].center.y)
                })
                // ベースカードの位置と角度を戻す
                resetCard()
                // good,bad表示を隠す
                likeImage.isHidden = true
                 // いいねの時だけカウントするv
                likeName.append(nameList[selectedCardCount])
                // カウントを1増やす
                selectedCardCount += 1
                
                if selectedCardCount >= personList.count {
                    // 遷移処理
                    performSegue(withIdentifier: "ToLikedList", sender: self)
                }
               
                
            }else {
                // アニメーションアニメーションをつける
                UIView.animate(withDuration: 0.5, animations: {
                    
                    
                    // ベースカードを元の位置に戻す
                    // クロージャ内でviewControllerのプロパティにアクセスする場合は自身のviewControllerのインスタンスを指すselfを頭に付ける必要がある
                    // ユーザーカードを元の位置に戻す
                    self.personList[self.selectedCardCount].center = self.centerOfCard
                    // ユーザーカードにも同じ処理
                    self.personList[self.selectedCardCount].transform = .identity
                    // ベースカードの位置と角度を戻す
                    self.resetCard()
                    // good,bad表示を隠す
                    self.likeImage.isHidden = true
                }
                )
            }
            
        }
        
    }
    
}

