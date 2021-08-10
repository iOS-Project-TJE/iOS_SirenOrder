//
//  LoginViewController.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/01.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
class LoginViewController: UIViewController {

    
    
    @IBOutlet weak var tfUserId: UITextField!
    @IBOutlet weak var tfUserPassWord: UITextField!

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnKakao: UIButton!
    
    // Kakao Login Info
    var kakaoUserEmail = ""
    var kakaoUserId = ""
    var kakaoUserPw = ""
    var kakaoUserNickname = ""
    
    var feedItem: NSMutableArray = NSMutableArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //텍스트필드 지우기
        remove()
        
        //textField 밑줄로 만들기
        setUnderLineId()
        setUnderLinePwd()
        
        //버튼 라운드
        setRadius()
        

    }//viewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        doQueryModel()
        remove()
    }
    
    func remove(){
        tfUserId.text?.removeAll()
        tfUserPassWord.text?.removeAll()
    }
    
    //query Model 실행 : 유저 정보 불러오기
    func doQueryModel(){
        let userinfoModel = UserInfoModel()
        userinfoModel.delegate = self
        userinfoModel.downloadItems()
        
    }//
    
   // Kakao Login 버튼
    @IBAction func btnKakao(_ sender: UIButton) {
        // 카카오톡 설치 여부 확인
          if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    // 예외 처리 (로그인 취소 등)
                    print("kakao login install",error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                   // do something
                    _ = oauthToken
                   // 어세스토큰
                   let accessToken = oauthToken?.accessToken
                    
                }
            }
          }else{
            
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            
               if let error = error {
                 print(error)
               }
               else {
                print("loginWithKakaoAccount() success.")
                UserApi.shared.me() {(user, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("me() success.")
                        var count: Int = 0
                        // Kakao 에서 받은 이메일 정보
                        self.kakaoUserEmail = String(user!.kakaoAccount!.email!)
                        self.kakaoUserNickname = String(user!.kakaoAccount!.profile!.nickname!)
                        // 임의의 아이디, 비밀번호 카카오변수에 넣기
                        self.kakaoUserId = String((user!.id!))
                        self.kakaoUserPw = "kakaoPassword"
                        
                        // 중복체크
                        for i in 0..<self.feedItem.count {
                            let item: LoginUserInfoModel = self.feedItem[i] as! LoginUserInfoModel
                            guard let email = item.userEmail else {
                                return
                            }
                            
                            // DB의 이메일과 현재 카카오 이메일 일치시 화면 넘기기
                            if email == self.kakaoUserEmail{
                                count += 1
                                // 카카오 변수에 넣음 임의 아이디 비밀번호 -> Share에 넣기
                                userId = self.kakaoUserId
                                // UserDefaults에 값넣기
                                UserDefaults.standard.set(self.kakaoUserId, forKey: "userId")
                                UserDefaults.standard.set(self.kakaoUserNickname, forKey: "userNickname")
                                guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") else{
                                    return
                                }

                                uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                                self.present(uvc, animated: true)
                                
                            }//if
                        }//for
                        if count == 0 {
                        // DB에 일치하는 이메일이 없을때 가입시키기!
                        let insertSignInfoModel = InsertSignInfoModel()
                        let result = insertSignInfoModel.insertItems(userId: self.kakaoUserId, userPw: self.kakaoUserPw, userNickname: self.kakaoUserNickname, userEmail: self.kakaoUserEmail)

                        let resultAlert = UIAlertController(title: "완료", message: "카카오톡으로 가입이 완료되었습니다.", preferredStyle: .alert)
                        let onAction = UIAlertAction(title: "확인", style: .default, handler: { ACTION in
                            // 카카오 변수에 넣음 임의 아이디 비밀번호 -> Share에 넣기
                            userId = self.kakaoUserId
                            // UserDefaults에 값넣기
                            UserDefaults.standard.set(self.kakaoUserId, forKey: "userId")
                            UserDefaults.standard.set(self.kakaoUserNickname, forKey: "userNickname")
                            //Home화면으로
                            guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") else{
                                return
                            }

                            uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                            self.present(uvc, animated: true)

                        })

                        resultAlert.addAction(onAction)
                        self.present(resultAlert, animated: true, completion: nil)
                        
                        
                            
                        }else{
                            let resultAlert = UIAlertController(title: "에러", message: "가입이 불가합니다. 다시 확인해주세요", preferredStyle: .alert)
                            let onAction = UIAlertAction(title: "확인", style: .default, handler: { ACTION in
                            })

                            resultAlert.addAction(onAction)
                            self.present(resultAlert, animated: true, completion: nil)

                        }
                        
                    }
                }

                //do something
                _ = oauthToken
               }
            }
          }//else
  
    }//btnKakao
    
    
    
  
    //로그인 버튼
    @IBAction func btnLogin(_ sender: UIButton) {
        var count: Int = 0
        
        for i in 0..<feedItem.count {
            let item: LoginUserInfoModel = feedItem[i] as! LoginUserInfoModel
            guard let id = item.userId else {
                return
            }
            guard let password = item.userPw else {
                return
            }
            
            if tfUserId.text == id && tfUserPassWord.text == password {
                // 아이디와 비밀번호가 일치하면
                count += 1
                //sharvar의 userId 에 넣어주기
                userId = tfUserId.text!
                UserDefaults.standard.set(tfUserId.text!, forKey: "userId")
                UserDefaults.standard.set(item.userNickname!, forKey: "userNickname")

//                self.performSegue(withIdentifier: "sgLoginToHome", sender: self)
                guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") else{
                    return
                }

                uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical

                self.present(uvc, animated: true)
                
            } // if
            
        } // for
        
        if count == 0 {
        // 아이디와 패스워드 2개 필드 입력 안했으면 경고!
        if tfUserId.text?.isEmpty == true && tfUserPassWord.text?.isEmpty == true{
            let idAlert = UIAlertController(title: "경고", message: "아이디와 패스워드를 입력해주세요", preferredStyle: .alert)
            let idAction = UIAlertAction(title: "확인", style: .default, handler: nil)
     
            idAlert.addAction(idAction)
            present(idAlert, animated: true, completion: nil)
        }else{
            //불일치시
            let idAlert = UIAlertController(title: "경고", message: "ID나 암호가 불일치 합니다!", preferredStyle: .alert)
            let idAction = UIAlertAction(title: "확인", style: .default, handler: {ACTION in
                self.remove()
                                         })
     
            idAlert.addAction(idAction)
            present(idAlert, animated: true, completion: nil)
            
        }
        }//if

    }//btnLogin
    

    // 아이디 찾기 버튼
    @IBAction func btnFindUserId(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "sgFindUserId", sender: self)

    }
    
 
    //회원가입 버튼
    @IBAction func btnSignUp(_ sender: UIButton) {
    
        self.performSegue(withIdentifier: "sgLoginToSignUp", sender: self)
        
    }//btnSignUp
    
    
    // 비밀번호 찾기
    @IBAction func btnFindUserPw(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "sgToFindUserPw", sender: self)

    }//btnFindUserPw
    

    
    //---------------------- 뷰 꾸미는 속성 (텍스트필드, 버튼)
    func setUnderLineId(){
        
        tfUserId.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: tfUserId.frame.size.height-1, width: tfUserId.frame.width, height: 1)
        border.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tfUserId.layer.addSublayer((border))
        tfUserId.textAlignment = .left
        tfUserId.textColor = UIColor.systemGray
    }
    
    func setUnderLinePwd(){
        
        tfUserPassWord.borderStyle = .none
        let border2 = CALayer()
        border2.frame = CGRect(x: 0, y: tfUserPassWord.frame.size.height-1, width: tfUserPassWord.frame.width, height: 1)
        border2.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tfUserPassWord.layer.addSublayer((border2))
        tfUserPassWord.textAlignment = .left
        tfUserPassWord.textColor = UIColor.systemGray
    }
    
    
    func setRadius(){
        btnLogin.layer.cornerRadius = 20
    }
    
    //터치
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}//---------

extension LoginViewController: UserInfoModelProtocol{
    func itemDownloaded(items: NSArray) {  
        feedItem = items as! NSMutableArray
    }
}//extension
