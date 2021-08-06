//
//  PersonalOptionDetailViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/04.
//

import UIKit

class PersonalOptionDetailViewController: UIViewController { // 2021.08.04 조혜지 퍼스널 옵션을 선택하는 BottomSheet

    @IBOutlet weak var lblPersonalName: UILabel!
    @IBOutlet weak var lblOptionName: UILabel!
    @IBOutlet weak var btnPersonalShape: UIButton!
    @IBOutlet weak var lblCustomMessage: UILabel!
    @IBOutlet weak var lblAddTitle: UILabel!
    @IBOutlet weak var lblAddCount: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnAddOption1: UIButton!
    @IBOutlet weak var btnAddOption2: UIButton!
    @IBOutlet weak var lblAddTitle2: UILabel!
    @IBOutlet weak var lblAddCount2: UILabel!
    @IBOutlet weak var btnMinus2: UIButton!
    @IBOutlet weak var btnPlus2: UIButton!
    @IBOutlet weak var lblAddTitle3: UILabel!
    @IBOutlet weak var lblAddCount3: UILabel!
    @IBOutlet weak var btnMinus3: UIButton!
    @IBOutlet weak var btnPlus3: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnSmall: UIButton!
    @IBOutlet weak var btnRegular: UIButton!
    @IBOutlet weak var btnBig: UIButton!
    @IBOutlet weak var btnSmall2: UIButton!
    @IBOutlet weak var btnRegular2: UIButton!
    @IBOutlet weak var btnBig2: UIButton!
    @IBOutlet weak var btnLid: UIButton!
    
    var receivedIndexPath: Int = 0
    var btnCount: Int = 0
    var espressoCount = SharePersonal.coffeeCount
    var espressoMessage: String = ""
    var decaffeination: Bool = false
    var halfDecaffeination: Bool = false
    var coffeeStateCount: Int = 0
    var hazelnutCount = SharePersonal.hSyrupCount
    var vanillaCount = SharePersonal.vSyrupCount
    var caramelCount = SharePersonal.cSyrupCount
    var icedMessage: String = ""
    var normalWhipS: Bool = false
    var normalWhipR: Bool = false
    var normalWhipB: Bool = false
    var espressoWhipS: Bool = false
    var espressoWhipR: Bool = false
    var espressoWhipB: Bool = false
    var whipMessage: String = ""
    var caramelS: Bool = false
    var caramelR: Bool = false
    var caramelB: Bool = false
    var chocolateS: Bool = false
    var chocolateR: Bool = false
    var chocolateB: Bool = false
    var caramelMessage: String = ""
    var chocolateMessage: String = ""
    var whipCount: Int = 0
    var caramleDrizzleCount: Int = 0
    var chocoDrizzleCount: Int = 0
    var beforePersonal: String = ""
    var afterPersonal: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSetting()
    }
    
    func initSetting() {
        beforePersonal = "\(SharePersonal.coffee)\(SharePersonal.vSyrup)\(SharePersonal.hSyrup)\(SharePersonal.cSyrup)\(SharePersonal.ice)\(SharePersonal.whip)\(SharePersonal.caramelDrizzle)\(SharePersonal.chocoDrizzle)\(SharePersonal.lid)"
        
        lblPersonalName.text = personalList[receivedIndexPath]
        btnPersonalShape.layer.cornerRadius = 20
        btnAddOption1.layer.borderWidth = 1
        btnAddOption1.layer.borderColor = UIColor.systemGray5.cgColor
        btnAddOption1.layer.cornerRadius = 10
        btnAddOption2.layer.borderWidth = 1
        btnAddOption2.layer.borderColor = UIColor.systemGray5.cgColor
        btnAddOption2.layer.cornerRadius = 10
        btnNo.layer.borderWidth = 1
        btnNo.layer.borderColor = UIColor.systemGray5.cgColor
        btnNo.layer.cornerRadius = 10
        btnSmall.layer.borderWidth = 1
        btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
        btnSmall.layer.cornerRadius = 10
        btnRegular.layer.borderWidth = 1
        btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
        btnRegular.layer.cornerRadius = 10
        btnBig.layer.borderWidth = 1
        btnBig.layer.borderColor = UIColor.systemGray5.cgColor
        btnBig.layer.cornerRadius = 10
        btnSmall2.layer.borderWidth = 1
        btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
        btnSmall2.layer.cornerRadius = 10
        btnRegular2.layer.borderWidth = 1
        btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
        btnRegular2.layer.cornerRadius = 10
        btnBig2.layer.borderWidth = 1
        btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
        btnBig2.layer.cornerRadius = 10
        btnLid.layer.borderWidth = 1
        btnLid.layer.borderColor = UIColor.systemGray5.cgColor
        btnLid.layer.cornerRadius = 10
        
        if receivedIndexPath == 1 {
            lblCustomMessage.text = "에스프레소를 커스텀으로 즐겨보세요!"
            lblOptionName.text = "추가 옵션"
            lblAddCount.text = String(SharePersonal.coffeeCount)
            if SharePersonal.coffeeState == 1 {
                btnAddOption1.layer.borderWidth = 1.5
                btnAddOption1.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                coffeeStateCount = 1
                espressoMessage = "디카페인"
            }else if SharePersonal.coffeeState == 2 {
                btnAddOption2.layer.borderWidth = 1.5
                btnAddOption2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                coffeeStateCount = 2
                espressoMessage = "1/2 디카페인"
            }
            
            if espressoCount != 0 {
                btnMinus.isEnabled = true
            }else {
                btnMinus.isEnabled = false
            }

            lblAddTitle.text = "에스프레소 샷"
            
            lblAddTitle2.isHidden = true
            lblAddCount2.isHidden = true
            btnPlus2.isHidden = true
            btnMinus2.isHidden = true
            lblAddTitle3.isHidden = true
            lblAddCount3.isHidden = true
            btnPlus3.isHidden = true
            btnMinus3.isHidden = true
            
            btnNo.isHidden = true
            btnSmall.isHidden = true
            btnRegular.isHidden = true
            btnBig.isHidden = true
            btnSmall2.isHidden = true
            btnRegular2.isHidden = true
            btnBig2.isHidden = true
            btnLid.isHidden = true
        }else if receivedIndexPath == 2 {
            lblCustomMessage.text = "시럽 권장수량 : 톨(3) 그란데(4) 벤티(5)"
            lblOptionName.text = "추가 옵션"
            lblAddCount.text = String(SharePersonal.vSyrupCount)
            lblAddCount2.text = String(SharePersonal.hSyrupCount)
            lblAddCount3.text = String(SharePersonal.cSyrupCount)

            lblAddTitle.text = "바닐라 시럽"
            lblAddTitle2.text = "헤이즐넛 시럽"
            lblAddTitle3.text = "카라멜 시럽"
            btnMinus.isEnabled = false
            btnMinus2.isEnabled = false
            btnMinus3.isEnabled = false
            btnAddOption1.isHidden = true
            btnAddOption2.isHidden = true

            btnNo.isHidden = true
            btnSmall.isHidden = true
            btnRegular.isHidden = true
            btnBig.isHidden = true
            btnNo.isHidden = true
            btnSmall.isHidden = true
            btnRegular.isHidden = true
            btnBig.isHidden = true
            btnSmall2.isHidden = true
            btnRegular2.isHidden = true
            btnBig2.isHidden = true
            btnLid.isHidden = true
        }else if receivedIndexPath == 3 {
            lblCustomMessage.text = "얼음의 양과 음료의 양은 무관합니다."
            lblOptionName.text = "기본 옵션"
            lblAddTitle.text = "얼음"
            btnRegular.layer.borderWidth = 1.5
            btnRegular.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
            if SharePersonal.ice == "얼음 없이, " {
                btnNo.layer.borderWidth = 1.5
                btnNo.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                icedMessage = "얼음 없이, "
            }else if SharePersonal.ice == "얼음 적게, " {
                btnSmall.layer.borderWidth = 1.5
                btnSmall.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                icedMessage = "얼음 적게, "
            }else if SharePersonal.ice == "얼음 보통, " {
                btnRegular.layer.borderWidth = 1.5
                btnRegular.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                icedMessage = "얼음 보통, "
            }else if SharePersonal.ice == "얼음 많이, " {
                btnBig.layer.borderWidth = 1.5
                btnBig.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                icedMessage = "얼음 많이, "
            }
            
            lblAddCount.isHidden = true
            btnMinus.isHidden = true
            btnPlus.isHidden = true
            btnAddOption1.isHidden = true
            btnAddOption2.isHidden = true
            lblAddTitle2.isHidden = true
            lblAddCount2.isHidden = true
            btnPlus2.isHidden = true
            btnMinus2.isHidden = true
            lblAddTitle3.isHidden = true
            lblAddCount3.isHidden = true
            btnPlus3.isHidden = true
            btnMinus3.isHidden = true
            btnSmall2.isHidden = true
            btnRegular2.isHidden = true
            btnBig2.isHidden = true
            btnLid.isHidden = true
        }else if receivedIndexPath == 4 {
            lblCustomMessage.text = "휘핑 크림을 커스텀으로 즐겨보세요!"
            lblOptionName.text = "추가 옵션"
            lblAddTitle.text = "일반 휘핑"
            lblAddTitle3.text = "에스프레소 휘핑"
            if SharePersonal.whipState == 1 {
                btnNo.layer.borderWidth = 1.5
                btnNo.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                whipCount = 1
                whipMessage = "일반 휘핑 적게, "
            }else if SharePersonal.whipState == 2 {
                btnSmall.layer.borderWidth = 1.5
                btnSmall.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                whipCount = 2
                whipMessage = "일반 휘핑 보통, "
            }else if SharePersonal.whipState == 3 {
                btnRegular.layer.borderWidth = 1.5
                btnRegular.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                whipCount = 3
                whipMessage = "일반 휘핑 많이, "
            }else if SharePersonal.whipState == 4 {
                btnSmall2.layer.borderWidth = 1.5
                btnSmall2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                whipCount = 4
                whipMessage = "에스프레소 휘핑 적게, "
            }else if SharePersonal.whipState == 5 {
                btnRegular2.layer.borderWidth = 1.5
                btnRegular2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                whipCount = 5
                whipMessage = "에스프레소 휘핑 보통, "
            }else if SharePersonal.whipState == 6 {
                btnBig2.layer.borderWidth = 1.5
                btnBig2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                whipCount = 6
                whipMessage = "에스프레소 휘핑 많이, "
            }
            
            lblAddCount.isHidden = true
            btnMinus.isHidden = true
            btnPlus.isHidden = true
            lblAddTitle2.isHidden = true
            lblAddCount2.isHidden = true
            btnPlus2.isHidden = true
            btnMinus2.isHidden = true
            lblAddCount3.isHidden = true
            btnPlus3.isHidden = true
            btnMinus3.isHidden = true
            btnAddOption1.isHidden = true
            btnAddOption2.isHidden = true
            
            btnBig.isHidden = true
            btnLid.isHidden = true
            
            btnNo.setTitle("적게", for: .normal)
            btnSmall.setTitle("보통", for: .normal)
            btnRegular.setTitle("많이", for: .normal)
        }else if receivedIndexPath == 5 {
            lblCustomMessage.text = "드리즐을 커스텀으로 즐겨보세요!"
            lblOptionName.text = "추가 옵션"
            lblAddTitle.text = "카라멜 드리즐"
            lblAddTitle3.text = "초콜릿 드리즐"
            if SharePersonal.caramelDrizzleState == 1 {
                btnNo.layer.borderWidth = 1.5
                btnNo.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                caramleDrizzleCount = 1
                caramelMessage = "카라멜 드리즐 적게, "
            }else if SharePersonal.caramelDrizzleState == 2 {
                btnSmall.layer.borderWidth = 1.5
                btnSmall.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                caramleDrizzleCount = 2
                caramelMessage = "카라멜 드리즐 보통, "
            }else if SharePersonal.caramelDrizzleState == 3 {
                btnRegular.layer.borderWidth = 1.5
                btnRegular.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                caramleDrizzleCount = 3
                caramelMessage = "카라멜 드리즐 많이, "
            }
            if SharePersonal.chocoDrizzleState == 1 {
                btnSmall2.layer.borderWidth = 1.5
                btnSmall2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                chocoDrizzleCount = 1
                chocolateMessage = "초콜릿 드리즐 적게, "
            }else if SharePersonal.chocoDrizzleState == 2 {
                btnRegular2.layer.borderWidth = 1.5
                btnRegular2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                chocoDrizzleCount = 2
                chocolateMessage = "초콜릿 드리즐 보통, "
            }else if SharePersonal.chocoDrizzleState == 3 {
                btnBig2.layer.borderWidth = 1.5
                btnBig2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                chocoDrizzleCount = 3
                chocolateMessage = "초콜릿 드리즐 많이, "
            }

            lblAddCount.isHidden = true
            btnMinus.isHidden = true
            btnPlus.isHidden = true
            lblAddTitle2.isHidden = true
            lblAddCount2.isHidden = true
            btnPlus2.isHidden = true
            btnMinus2.isHidden = true
            lblAddCount3.isHidden = true
            btnPlus3.isHidden = true
            btnMinus3.isHidden = true
            btnAddOption1.isHidden = true
            btnAddOption2.isHidden = true
            
            btnBig.isHidden = true
            btnLid.isHidden = true
            
            btnNo.setTitle("적게", for: .normal)
            btnSmall.setTitle("보통", for: .normal)
            btnRegular.setTitle("많이", for: .normal)
        }else {
            lblCustomMessage.text = "컵&리드 옵션을 선택해 주세요!"
            lblOptionName.text = "기본 옵션"
            lblAddTitle.text = "리드"
            if SharePersonal.lid != "" {
                btnLid.layer.borderWidth = 1.5
                btnLid.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                btnCount += 1
            }

            lblAddCount.isHidden = true
            btnMinus.isHidden = true
            btnPlus.isHidden = true
            lblAddTitle2.isHidden = true
            lblAddCount2.isHidden = true
            btnPlus2.isHidden = true
            btnMinus2.isHidden = true
            lblAddTitle3.isHidden = true
            lblAddCount3.isHidden = true
            btnPlus3.isHidden = true
            btnMinus3.isHidden = true
            btnAddOption1.isHidden = true
            btnAddOption2.isHidden = true
            
            btnNo.isHidden = true
            btnSmall.isHidden = true
            btnRegular.isHidden = true
            btnBig.isHidden = true
            btnSmall.isHidden = true
            btnRegular.isHidden = true
            btnBig.isHidden = true
            btnSmall2.isHidden = true
            btnRegular2.isHidden = true
            btnBig2.isHidden = true
        }
    }
    
    
    @IBAction func btnLid(_ sender: UIButton) {
        btnCount += 1
        
        if btnCount % 2 == 0 {
            btnLid.layer.borderWidth = 1
            btnLid.layer.borderColor = UIColor.systemGray5.cgColor
        }else {
            btnLid.layer.borderWidth = 1.5
            btnLid.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        }
    }
    
    @IBAction func btnAddOption1(_ sender: UIButton) {
        if espressoCount != 0 {
            if SharePersonal.coffeeState == 0 {
                if decaffeination == true {
                    btnAddOption1.layer.borderWidth = 1
                    btnAddOption1.layer.borderColor = UIColor.systemGray5.cgColor
                    btnAddOption2.layer.borderWidth = 1
                    btnAddOption2.layer.borderColor = UIColor.systemGray5.cgColor
                    espressoMessage = ""
                    decaffeination = false
                    coffeeStateCount = 0
                    SharePersonal.coffeeState = coffeeStateCount
                }else {
                    btnAddOption1.layer.borderWidth = 1.5
                    btnAddOption1.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                    btnAddOption2.layer.borderWidth = 1
                    decaffeination = true
                    halfDecaffeination = false
                    btnAddOption2.layer.borderColor = UIColor.systemGray5.cgColor
                    espressoMessage = "디카페인"
                    coffeeStateCount = 1
                    SharePersonal.coffeeState = coffeeStateCount
                }
            }else if SharePersonal.coffeeState == 1 {
                btnAddOption1.layer.borderWidth = 1
                btnAddOption1.layer.borderColor = UIColor.systemGray5.cgColor
                btnAddOption2.layer.borderWidth = 1
                btnAddOption2.layer.borderColor = UIColor.systemGray5.cgColor
                espressoMessage = ""
                coffeeStateCount = 0
                SharePersonal.coffeeState = coffeeStateCount
            }else {
                btnAddOption1.layer.borderWidth = 1.5
                btnAddOption1.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                btnAddOption2.layer.borderWidth = 1
                decaffeination = true
                halfDecaffeination = false
                btnAddOption2.layer.borderColor = UIColor.systemGray5.cgColor
                espressoMessage = "디카페인"
                coffeeStateCount = 1
                SharePersonal.coffeeState = coffeeStateCount
            }
        }else {
            let resultAlert = UIAlertController(title: "에스프레소 샷의 수량을 먼저 변경해주세요!", message: nil, preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnAddOption2(_ sender: UIButton) {
        if espressoCount != 0 {
            if SharePersonal.coffeeState == 0 {
                if halfDecaffeination == true {
                    btnAddOption1.layer.borderWidth = 1
                    btnAddOption1.layer.borderColor = UIColor.systemGray5.cgColor
                    btnAddOption2.layer.borderWidth = 1
                    btnAddOption2.layer.borderColor = UIColor.systemGray5.cgColor
                    halfDecaffeination = false
                    espressoMessage = ""
                    coffeeStateCount = 0
                    SharePersonal.coffeeState = coffeeStateCount
                }else {
                    btnAddOption1.layer.borderWidth = 1
                    btnAddOption1.layer.borderColor = UIColor.systemGray5.cgColor
                    btnAddOption2.layer.borderWidth = 1.5
                    btnAddOption2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                    decaffeination = false
                    halfDecaffeination = true
                    espressoMessage = "1/2 디카페인"
                    coffeeStateCount = 2
                    SharePersonal.coffeeState = coffeeStateCount
                }
            }else if SharePersonal.coffeeState == 2 {
                btnAddOption1.layer.borderWidth = 1
                btnAddOption1.layer.borderColor = UIColor.systemGray5.cgColor
                btnAddOption2.layer.borderWidth = 1
                btnAddOption2.layer.borderColor = UIColor.systemGray5.cgColor
                espressoMessage = ""
                coffeeStateCount = 0
                SharePersonal.coffeeState = coffeeStateCount
            }else {
                btnAddOption1.layer.borderWidth = 1
                btnAddOption1.layer.borderColor = UIColor.systemGray5.cgColor
                btnAddOption2.layer.borderWidth = 1.5
                btnAddOption2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                decaffeination = false
                halfDecaffeination = true
                espressoMessage = "1/2 디카페인"
                coffeeStateCount = 2
                SharePersonal.coffeeState = coffeeStateCount
            }
        }else {
            let resultAlert = UIAlertController(title: "에스프레소 샷의 수량을 먼저 변경해주세요!", message: nil, preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnMinus(_ sender: UIButton) {
        if receivedIndexPath == 1 {
            espressoCount -= 1
            lblAddCount.text = String(espressoCount)
            if espressoCount == 0 {
                btnMinus.isEnabled = false
                btnAddOption1.layer.borderWidth = 1
                btnAddOption1.layer.borderColor = UIColor.systemGray5.cgColor
                btnAddOption2.layer.borderWidth = 1
                btnAddOption2.layer.borderColor = UIColor.systemGray5.cgColor
                espressoMessage = ""
                coffeeStateCount = 0
                SharePersonal.coffeeState = coffeeStateCount
                decaffeination = false
                halfDecaffeination = false
            }
        }else if receivedIndexPath == 2 {
            vanillaCount -= 1
            lblAddCount.text = String(vanillaCount)
            if vanillaCount == 0 {
                btnMinus.isEnabled = false
            }
        }
    }
    
    @IBAction func btnPlus(_ sender: UIButton) {
        if receivedIndexPath == 1 {
            espressoCount += 1
            lblAddCount.text = String(espressoCount)
            btnMinus.isEnabled = true
        }else if receivedIndexPath == 2 {
            vanillaCount += 1
            lblAddCount.text = String(vanillaCount)
            btnMinus.isEnabled = true
        }
    }
    
    @IBAction func btnMinus2(_ sender: UIButton) {
        hazelnutCount -= 1
        lblAddCount2.text = String(hazelnutCount)
        if hazelnutCount == 0 {
            btnMinus2.isEnabled = false
        }
    }
    
    
    @IBAction func btnPlus2(_ sender: UIButton) {
        hazelnutCount += 1
        lblAddCount2.text = String(hazelnutCount)
        btnMinus2.isEnabled = true
    }
    
    
    @IBAction func btnMinus3(_ sender: UIButton) {
        caramelCount -= 1
        lblAddCount3.text = String(caramelCount)
        if caramelCount == 0 {
            btnMinus3.isEnabled = false
        }
    }
    
    @IBAction func btnPlus3(_ sender: UIButton) {
        caramelCount += 1
        lblAddCount3.text = String(caramelCount)
        btnMinus3.isEnabled = true
    }
    
    @IBAction func btnNo(_ sender: UIButton) {
        if receivedIndexPath == 3 {
            btnNo.layer.borderWidth = 1.5
            btnNo.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
            btnSmall.layer.borderWidth = 1
            btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
            btnRegular.layer.borderWidth = 1
            btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
            btnBig.layer.borderWidth = 1
            btnBig.layer.borderColor = UIColor.systemGray5.cgColor
            icedMessage = "얼음 없이, "
        }else if receivedIndexPath == 4 {
            if SharePersonal.whipState == 0 {
                if normalWhipS == true {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    normalWhipS = false
                    whipMessage = ""
                    whipCount = 0
                }else {
                    btnNo.layer.borderWidth = 1.5
                    btnNo.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    normalWhipS = true
                    normalWhipR = false
                    normalWhipB = false
                    espressoWhipS = false
                    espressoWhipR = false
                    espressoWhipB = false
                    whipMessage = "일반 휘핑 적게, "
                    whipCount = 1
                }
            }else if SharePersonal.whipState == 1 {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                normalWhipS = false
                whipMessage = ""
                whipCount = 0
            }else {
                btnNo.layer.borderWidth = 1.5
                btnNo.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                normalWhipS = true
                normalWhipR = false
                normalWhipB = false
                espressoWhipS = false
                espressoWhipR = false
                espressoWhipB = false
                whipMessage = "일반 휘핑 적게, "
                whipCount = 1
            }
        }else if receivedIndexPath == 5 {
            if SharePersonal.caramelDrizzleState == 0 {
                if caramelS == true {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    caramelS = false
                    caramelMessage = ""
                    caramleDrizzleCount = 0
                }else {
                    btnNo.layer.borderWidth = 1.5
                    btnNo.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    caramelS = true
                    caramelR = false
                    caramelB = false
                    caramelMessage = "카라멜 드리즐 적게, "
                    caramleDrizzleCount = 1
                }
            }else if SharePersonal.caramelDrizzleState == 1 {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                
                caramelS = false
                caramelMessage = ""
                caramleDrizzleCount = 0
            }else {
                btnNo.layer.borderWidth = 1.5
                btnNo.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                
                caramelS = true
                caramelR = false
                caramelB = false
                caramelMessage = "카라멜 드리즐 적게, "
                caramleDrizzleCount = 1
            }
        }
    }
    
    @IBAction func btnSmall(_ sender: UIButton) {
        if receivedIndexPath == 3 {
            btnNo.layer.borderWidth = 1
            btnNo.layer.borderColor = UIColor.systemGray5.cgColor
            btnSmall.layer.borderWidth = 1.5
            btnSmall.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
            btnRegular.layer.borderWidth = 1
            btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
            btnBig.layer.borderWidth = 1
            btnBig.layer.borderColor = UIColor.systemGray5.cgColor
            icedMessage = "얼음 적게, "
        }else if receivedIndexPath == 4 {
            if SharePersonal.whipState == 0 {
                if normalWhipR == true {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    normalWhipR = false
                    whipMessage = ""
                    whipCount = 0
                }else {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1.5
                    btnSmall.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    normalWhipS = false
                    normalWhipR = true
                    normalWhipB = false
                    espressoWhipS = false
                    espressoWhipR = false
                    espressoWhipB = false
                    whipMessage = "일반 휘핑 보통, "
                    whipCount = 2
                }
            }else if SharePersonal.whipState == 2 {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                normalWhipR = false
                whipMessage = ""
                whipCount = 0
            }else {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1.5
                btnSmall.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                normalWhipS = false
                normalWhipR = true
                normalWhipB = false
                espressoWhipS = false
                espressoWhipR = false
                espressoWhipB = false
                whipMessage = "일반 휘핑 보통, "
                whipCount = 2
            }
            
        }else if receivedIndexPath == 5 {
            if SharePersonal.caramelDrizzleState == 0 {
                if caramelR == true {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    caramelR = false
                    caramelMessage = ""
                    caramleDrizzleCount = 0
                }else {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1.5
                    btnSmall.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    caramelS = false
                    caramelR = true
                    caramelB = false
                    caramelMessage = "카라멜 드리즐 보통, "
                    caramleDrizzleCount = 2
                }
            }else if SharePersonal.caramelDrizzleState == 2 {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                
                caramelR = false
                caramelMessage = ""
                caramleDrizzleCount = 0
            }else {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1.5
                btnSmall.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                
                caramelS = false
                caramelR = true
                caramelB = false
                caramelMessage = "카라멜 드리즐 보통, "
                caramleDrizzleCount = 2
            }
        }
    }
    
    
    @IBAction func btnRegular(_ sender: UIButton) {
        if receivedIndexPath == 3 {
            btnNo.layer.borderWidth = 1
            btnNo.layer.borderColor = UIColor.systemGray5.cgColor
            btnSmall.layer.borderWidth = 1
            btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
            btnRegular.layer.borderWidth = 1.5
            btnRegular.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
            btnBig.layer.borderWidth = 1
            btnBig.layer.borderColor = UIColor.systemGray5.cgColor
            icedMessage = "얼음 보통, "
        }else if receivedIndexPath == 4 {
            if SharePersonal.whipState == 0 {
                if normalWhipB == true {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    normalWhipB = false
                    whipMessage = ""
                    whipCount = 0
                }else {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1.5
                    btnRegular.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    normalWhipS = false
                    normalWhipR = false
                    normalWhipB = true
                    espressoWhipS = false
                    espressoWhipR = false
                    espressoWhipB = false
                    whipMessage = "일반 휘핑 많이, "
                    whipCount = 3
                }
            }else if SharePersonal.whipState == 3 {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                normalWhipB = false
                whipMessage = ""
                whipCount = 0
            }else {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1.5
                btnRegular.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                normalWhipS = false
                normalWhipR = false
                normalWhipB = true
                espressoWhipS = false
                espressoWhipR = false
                espressoWhipB = false
                whipMessage = "일반 휘핑 많이, "
                whipCount = 3
            }
        }else if receivedIndexPath == 5 {
            if SharePersonal.caramelDrizzleState == 0 {
                if caramelB == true {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    caramelB = false
                    caramelMessage = ""
                    caramleDrizzleCount = 0
                }else {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1.5
                    btnRegular.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                    
                    caramelS = false
                    caramelR = false
                    caramelB = true
                    caramelMessage = "카라멜 드리즐 많이, "
                    caramleDrizzleCount = 3
                }
            }else if SharePersonal.caramelDrizzleState == 3 {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                
                caramelB = false
                caramelMessage = ""
                caramleDrizzleCount = 0
            }else {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1.5
                btnRegular.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                
                caramelS = false
                caramelR = false
                caramelB = true
                caramelMessage = "카라멜 드리즐 많이, "
                caramleDrizzleCount = 3
            }
        }
    }
    
    @IBAction func btnBig(_ sender: UIButton) {
        if receivedIndexPath == 3 {
            btnNo.layer.borderWidth = 1
            btnNo.layer.borderColor = UIColor.systemGray5.cgColor
            btnSmall.layer.borderWidth = 1
            btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
            btnRegular.layer.borderWidth = 1
            btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
            btnBig.layer.borderWidth = 1.5
            btnBig.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
            icedMessage = "얼음 많이, "
        }
    }
    
    @IBAction func btnSmall2(_ sender: UIButton) {
        if receivedIndexPath == 4 {
            if SharePersonal.whipState == 0 {
                if espressoWhipS == true {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    espressoWhipS = false
                    whipCount = 0
                    whipMessage = ""
                }else {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall2.layer.borderWidth = 1.5
                    btnSmall2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    normalWhipS = false
                    normalWhipR = false
                    normalWhipB = false
                    espressoWhipS = true
                    espressoWhipR = false
                    espressoWhipB = false
                    whipMessage = "에스프레소 휘핑 적게, "
                    whipCount = 4
                }
            }else if SharePersonal.whipState == 4 {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                espressoWhipS = false
                whipCount = 0
                whipMessage = ""
            }else {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall2.layer.borderWidth = 1.5
                btnSmall2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                normalWhipS = false
                normalWhipR = false
                normalWhipB = false
                espressoWhipS = true
                espressoWhipR = false
                espressoWhipB = false
                whipMessage = "에스프레소 휘핑 적게, "
                whipCount = 4
            }
        }else if receivedIndexPath == 5 {
            if SharePersonal.chocoDrizzleState == 0 {
                if chocolateS == true {
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    chocolateS = false
                    chocolateMessage = ""
                    chocoDrizzleCount = 0
                }else {
                    btnSmall2.layer.borderWidth = 1.5
                    btnSmall2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    chocolateS = true
                    chocolateR = false
                    chocolateB = false
                    chocolateMessage = "초콜릿 드리즐 적게, "
                    chocoDrizzleCount = 1
                }
            }else if SharePersonal.chocoDrizzleState == 1 {
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                chocolateS = false
                chocolateMessage = ""
                chocoDrizzleCount = 0
            }else {
                btnSmall2.layer.borderWidth = 1.5
                btnSmall2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                chocolateS = true
                chocolateR = false
                chocolateB = false
                chocolateMessage = "초콜릿 드리즐 적게, "
                chocoDrizzleCount = 1
            }
        }
    }
    
    @IBAction func btnRegular2(_ sender: UIButton) {
        if receivedIndexPath == 4 {
            if SharePersonal.whipState == 0 {
                if espressoWhipR == true {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    espressoWhipR = false
                    whipMessage = ""
                    whipCount = 0
                }else {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1.5
                    btnRegular2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    normalWhipS = false
                    normalWhipR = false
                    normalWhipB = false
                    espressoWhipS = false
                    espressoWhipR = true
                    espressoWhipB = false
                    whipMessage = "에스프레소 휘핑 보통, "
                    whipCount = 5
                }
            }else if SharePersonal.whipState == 5 {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                espressoWhipR = false
                whipMessage = ""
                whipCount = 0
            }else {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1.5
                btnRegular2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                normalWhipS = false
                normalWhipR = false
                normalWhipB = false
                espressoWhipS = false
                espressoWhipR = true
                espressoWhipB = false
                whipMessage = "에스프레소 휘핑 보통, "
                whipCount = 5
            }
        }else if receivedIndexPath == 5 {
            if SharePersonal.chocoDrizzleState == 0 {
                if chocolateR == true {
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    chocolateR = false
                    chocolateMessage = ""
                    chocoDrizzleCount = 0
                }else {
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1.5
                    btnRegular2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    chocolateS = false
                    chocolateR = true
                    chocolateB = false
                    chocolateMessage = "초콜릿 드리즐 보통, "
                    chocoDrizzleCount = 2
                }
            }else if SharePersonal.chocoDrizzleState == 2 {
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                chocolateR = false
                chocolateMessage = ""
                chocoDrizzleCount = 0
            }else {
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1.5
                btnRegular2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                chocolateS = false
                chocolateR = true
                chocolateB = false
                chocolateMessage = "초콜릿 드리즐 보통, "
                chocoDrizzleCount = 2
            }
        }
    }
    
    @IBAction func btnBig2(_ sender: UIButton) {
        if receivedIndexPath == 4 {
            if SharePersonal.whipState == 0 {
                if espressoWhipB == true {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    espressoWhipB = false
                    whipMessage = ""
                    whipCount = 0
                }else {
                    btnNo.layer.borderWidth = 1
                    btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall.layer.borderWidth = 1
                    btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular.layer.borderWidth = 1
                    btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1.5
                    btnBig2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                    
                    normalWhipS = false
                    normalWhipR = false
                    normalWhipB = false
                    espressoWhipS = false
                    espressoWhipR = false
                    espressoWhipB = true
                    whipMessage = "에스프레소 휘핑 많이, "
                    whipCount = 6
                }
            }else if SharePersonal.whipState == 6 {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                espressoWhipB = false
                whipMessage = ""
                whipCount = 0
            }else {
                btnNo.layer.borderWidth = 1
                btnNo.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall.layer.borderWidth = 1
                btnSmall.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular.layer.borderWidth = 1
                btnRegular.layer.borderColor = UIColor.systemGray5.cgColor
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1.5
                btnBig2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                
                normalWhipS = false
                normalWhipR = false
                normalWhipB = false
                espressoWhipS = false
                espressoWhipR = false
                espressoWhipB = true
                whipMessage = "에스프레소 휘핑 많이, "
                whipCount = 6
            }
        }else if receivedIndexPath == 5 {
            if SharePersonal.chocoDrizzleState == 0 {
                if chocolateB == true {
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1
                    btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                    
                    chocolateB = false
                    chocolateMessage = ""
                    chocoDrizzleCount = 0
                }else {
                    btnSmall2.layer.borderWidth = 1
                    btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnRegular2.layer.borderWidth = 1
                    btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                    btnBig2.layer.borderWidth = 1.5
                    btnBig2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                    
                    chocolateS = false
                    chocolateR = false
                    chocolateB = true
                    chocolateMessage = "초콜릿 드리즐 많이, "
                    chocoDrizzleCount = 3
                }
            }else if SharePersonal.chocoDrizzleState == 1 {
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1
                btnBig2.layer.borderColor = UIColor.systemGray5.cgColor
                
                chocolateB = false
                chocolateMessage = ""
                chocoDrizzleCount = 0
            }else {
                btnSmall2.layer.borderWidth = 1
                btnSmall2.layer.borderColor = UIColor.systemGray5.cgColor
                btnRegular2.layer.borderWidth = 1
                btnRegular2.layer.borderColor = UIColor.systemGray5.cgColor
                btnBig2.layer.borderWidth = 1.5
                btnBig2.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
                
                chocolateS = false
                chocolateR = false
                chocolateB = true
                chocolateMessage = "초콜릿 드리즐 많이, "
                chocoDrizzleCount = 3
            }
        }
    }
    
    @IBAction func btnPersonal(_ sender: UIButton) {
        if receivedIndexPath == 1 {
            if espressoCount != 0 {
                if espressoMessage == "" {
                    SharePersonal.coffee = "에스프레소 샷 \(espressoCount), "
                    SharePersonal.coffeeCount = espressoCount
                    SharePersonal.coffeePrice = (600 * espressoCount)
                }else {
                    SharePersonal.coffeeCount = espressoCount
                    SharePersonal.coffee = "\(espressoMessage) \(espressoCount), "
                    print(SharePersonal.coffee)
                    SharePersonal.coffeePrice = (600 * espressoCount) + 300
                }
            }
        }else if receivedIndexPath == 2 {
            if (vanillaCount != 0) {
                SharePersonal.vSyrup = "바닐라 시럽 \(vanillaCount), "
                SharePersonal.vSyrupCount = vanillaCount
                SharePersonal.vSyrupPrice = 600
            }
            if (hazelnutCount != 0) {
                SharePersonal.hSyrup = "헤이즐넛 시럽 \(hazelnutCount), "
                SharePersonal.hSyrupCount = hazelnutCount
                SharePersonal.hSyrupPrice = 600
            }
            if (caramelCount != 0) {
                SharePersonal.cSyrup = "카라멜 시럽 \(caramelCount), "
                SharePersonal.cSyrupCount = caramelCount
                SharePersonal.cSyrupPrice = 600
            }
        }else if receivedIndexPath == 3 {
            SharePersonal.ice = icedMessage
        }else if receivedIndexPath == 4 {
            SharePersonal.whip = whipMessage
            SharePersonal.whipState = whipCount
            if whipMessage != "" {
                SharePersonal.whipPrice = 600
            }
        }else if receivedIndexPath == 5 {
            SharePersonal.caramelDrizzle = caramelMessage
            SharePersonal.chocoDrizzle = chocolateMessage
            SharePersonal.caramelDrizzleState = caramleDrizzleCount
            SharePersonal.chocoDrizzleState = chocoDrizzleCount
            if caramleDrizzleCount != 0 {
                SharePersonal.carameldrizzlePrice = 600
            }
            if chocoDrizzleCount != 0 {
                SharePersonal.chocolatedrizzlePrice = 600
            }
        }else {
            if btnCount % 2 != 0 {
                SharePersonal.lid = "돔 리드로 변경, "
            }else {
                SharePersonal.lid = ""
            }
        }
        
        afterPersonal = "\(SharePersonal.coffee)\(SharePersonal.vSyrup)\(SharePersonal.hSyrup)\(SharePersonal.cSyrup)\(SharePersonal.ice)\(SharePersonal.whip)\(SharePersonal.caramelDrizzle)\(SharePersonal.chocoDrizzle)\(SharePersonal.lid)"

        if beforePersonal != afterPersonal {
            SharePersonalData.myMenuState = false
        }
        
        NotificationCenter.default.post(name: DidDismissPersonalOptionViewController, object: nil, userInfo: nil)
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
