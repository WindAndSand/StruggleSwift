//
//  ReactiveSwiftViewController.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/11/28.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit //http://www.jianshu.com/p/3a56d10e99a7
import ReactiveCocoa
import ReactiveSwift
import enum Result.NoError
import Result

class ReactiveSwiftViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        self.usernameTextField.delegate = self;
        self.view.addSubview(self.usernameTextField)
        self.scopedExample(exampleDescription: "Welcome Chine") {
            print("欢迎来到中国🇨🇳！")
        }
        self.scopedExample(exampleDescription: "Subscription")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.signalMethod()
        //        冷信号
        self.bindSignal1()
        //        热信号
        self.bindSignal2()
//        self.bindSiganl2_1()
//        self.bindSiganl2_2()
        //        信号合并
        self.bindSignal4()
        //        信号的联合
        self.bindSignal5()
        //        调度器
        self.bindSiganl6()
        //        通知
        self.bindSignal7()
    //        迭代器
        self.bindSignal9()
//        on
        self.methodOn()
//        map
        self.methodMap()
//        filter
        self.methodFilter()
//        reduce
        self.methodReduce()
//        merge
        self.mergeOfMethodMerge()
//        concet
        self.concetOfMethodMerge()
//        latest
        self.latestOfMethodMerge()
//        FlatMapError
        self.methodFlatMapError()
//        retry
        self.MethodRetry()
//        属性绑定
        self.methodProperty()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    MARK: Singal
    func signalMethod()  {
//       mySignal 中用来发送事件的Observer
        var myObserver: Observer<Int, NoError>?
//       通过Signal的尾随闭包来获取Signal中用来发送消息的Observer
        let mySignal = Signal<Int, NoError> {
            (innerObserver) -> Disposable? in
            myObserver = innerObserver
            return nil
        }
        
        
//        创建两个观察者
        let subscriber01 = Signal<Int, NoError>.Observer(value: {print("Subscriber 01 received \($0)")}) //Observer<Int, NoError>(value: { print("Subscriber 01 received\($0)")})
        let subscriber02 = Observer<Int, NoError>(value: { print("Subscriber 02 received\($0)")})
        
//        信号和观察者绑定
        mySignal.observe(subscriber01)
        mySignal.observe(subscriber02)
//        使用发送器发送一个值
        myObserver?.send(value: 1000)

    }
    
//    MARK: 冷信号
    func bindSignal1(){
        //1.冷信号
        let producer = SignalProducer<String, NoError>.init { (observer, _) in
            print("新的订阅，启动操作")
            observer.send(value: "Hello")
            observer.send(value: "World")
            observer.sendCompleted()
        }
        
        //创建观察者 (多个观察者观察会有副作用)
        let sub1 = Observer<String, NoError>(value: {
            print("观察者1接受信号\($0)")
        })
        
        let sub2 = Observer<String, NoError>(value: {
            print("观察者2接受信号\($0)")
        })
        //观察者订阅信号
        print("观察者1订阅信号")
        producer.start(sub1)
        print("观察者2订阅信号")
        producer.start(sub2)
        
    }
//    MARK: - 热信号
    func bindSignal2(){
        
        //2.热信号 (通过管道创建)：创建信号和观察者
        //通过Signal.pipe()函数来初始化一个热信号. 这个函数会返回一个元组, 元组的第一个值是output(类型为Signal), 第二个值是input(类型为Observer). 我们通过output来订阅信号, 通过input来向信号发生信息.
        let (signalA, observerA) = Signal<String, NoError>.pipe()
        let (signalB, observerB) = Signal<Int, NoError>.pipe()
        
        Signal.combineLatest(signalA,signalB).observeValues { (value) in
            print("两个热信号收到的值\(value.0) + \(value.1)")
        }
        //订阅信号要在send之前
        signalA.observeValues { (value) in
            print("signalA : \(value)")
        }
        
        observerA.send(value: "sssss")
//                observerA.sendCompleted()
        observerB.send(value: 2)
//                observerB.sendCompleted()
        
        observerB.send(value: 100)
        //不sendCompleted和sendError 热信号一直激活
//                observerB.sendCompleted()
    }
    /*
    func bindSignal2_1(){
        //1.创建signal(output)和innerObserver(input)
        let (signal, innerObserver) = Signal.pipe()
        
        //2.创建Observer
        let outerObserver1 = Signal.Observer(value: { (value) in
            print("did received value: (value)")
        })
        //2.还是创建Observer
        let outerObserver2 = Signal.Observer { (event) in
            switch event {
            case let .value(value):
                print("did received value: (value)")
            default: break
            }
        }
        
        signal.observe(outerObserver1)//3.向signal中添加Observer
        signal.observe(outerObserver2)//3.还是向signal中添加Observer
        
        innerObserver.send(value: 1)//4.向signal发生信息(执行signal保存的所有Observer对象的Event处理逻辑)
        innerObserver.sendCompleted()//4.还是执向signal发生信息
    }
    
    typealias NSignal = ReactiveSwift.Signal
    func bindSignal2_2()  {
        //1.创建signal(output)和innerObserver(input)
        let (signal, innerObserver) = NSignal.pipe()
        
        signal.observeValues { (value) in   //2&3.创建Observer并添加到Signal中
            print("did received value: (value)")
        }
        signal.observeValues { (value) in   //2&3.还是创建Observer并添加到Signal中
            print("did received value: (value)")
        }
        
        innerObserver.send(value: 1) //4. ...
        innerObserver.sendCompleted() //4. ...
    }
    */
    //    MARK: - 监听文本框
    func bindSignal3(){
        //2文本输入框的监听
        self.usernameTextField.reactive.continuousTextValues.observeValues { (text) in
            print(text ?? "")
            
        }
        //监听黏贴进来的文本
        let result = self.usernameTextField.reactive.values(forKeyPath: "text")
        result.start { (text) in
            print(text)
        }
        
        //按钮监听
        signInButton.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            print("点击ann")
        }
    }
    
//    MARK: - 信号合并
//    合成后的新事件流只有在收到每个合成流的至少一个值后才会发送出去。接着就会把每个流的最新的值一起输出。
    func bindSignal4(){
//    信号合并 两个要被订阅combineLatest 才能被订阅，被订阅后，合并中其中一个sendNext都会激活订阅
        let (signalA, observerA) = Signal<String, NoError>.pipe()
        let (signalB, observerB) = Signal<Array<Any> , NoError>.pipe()
        Signal.combineLatest(signalA, signalB).observeValues { (value) in
            print("合并的信号:\(value)")
        }
        
        observerA.send(value: "xxx")
        observerA.sendCompleted()
        observerB.send(value: ["sdsd","ddddd"])
        observerB.sendCompleted()
        
    }
    
    
//    MARK: - 信号联合
//    zip中的信号都要被订阅才能激活,意味着如果是一个流的第N个元素，一定要等到另外一个流第N值也收到才会一起组合发出。
    func bindSignal5(){
        //5.信号联合
        let (signalA, observerA) = Signal<String, NoError>.pipe()
        let (signalB, observerB) = Signal<String, NoError>.pipe()
        
        //两个到需要订阅 才激活zip
        Signal.zip(signalA, signalB).observeValues { (value) in
            print("zip: \(value)")
        }
        
        observerA.send(value: "1")
//                observerA.sendCompleted()
        observerB.send(value: "2")
//                observerB.sendCompleted()
        observerB.send(value: "cc")
        observerA.send(value: "dd")
    }
    
//    MARK: 调度器
    func bindSiganl6() {
        //6.调度器
        QueueScheduler.main.schedule(after: Date.init(timeIntervalSinceNow: 3)) {
            print("主线程3秒过去了")
        }
        QueueScheduler.init().schedule(after: Date.init(timeIntervalSinceNow: 2)) {
            print("子线程2秒过去了")
        }
    }
    
//    MARK: 通知
    func bindSignal7(){
        //7.通知
        NotificationCenter.default.reactive.notifications(forName: Notification.Name(rawValue: "UIKeyboardWillShowNotification"), object: nil).observeValues { (notification) in
            print("键盘弹起")
        }
        
        NotificationCenter.default.reactive.notifications(forName: Notification.Name(rawValue:"UIKeyboardWillHideNotification"), object: nil).observeValues { (notification) in
            print("键盘收起")
        }
    }
    
//    MARK: - KVO
    func bindSignal8(){
        //8KVO
        let result = self.usernameTextField.reactive.producer(forKeyPath: "text")
        result.start { (text) in
            print(text);
        }
    }
    
//    MARK: - 迭代器
    func bindSignal9() {
        //9.迭代器
        let array:[String] = ["name1", "name2"]
        var arrayIterator = array.makeIterator()
        while let temp = arrayIterator.next() {
            print(temp)
        }
        
        //swift系统自带
        array.forEach { (value) in
            print(value)
        }
    }
    
//    MARK: - on
//    可以通过 on来观察signal，生成一个新的信号，即使没有订阅者也会被触发。和 observe相似，也可以只观察你关注的某个事件。需要提到的是 producer要started后才会触发。
    public func methodOn() {
    
        let signal = SignalProducer<String , NoError>.init { (obsever, _) in
        obsever.send(value: "ddd")
        obsever.sendCompleted()
        }
        
        //可以通过 on来观察signal，生成一个新的信号，即使没有订阅者（sp.start()）也会被触发。
        let sp = signal.on(starting: {
        print("开始")
        }, started: {
        print("结束")
        }, event: { (event) in
        print("Event: \(event)")
        }, failed: { (error) in
        print("error: \(error)")
        }, completed: {
        print("信号完成")
        }, interrupted: {
        print("信号被中断")
        }, terminated: {
        print("信号结束")
        }, disposed: {
        print("信号清理")
        }) { (value) in
        print("value: \(value)")
        }
        
        sp.start()
    }
    
//    MARK: Map
//    Map映射 用于将一个事件流的值操作后的结果产生一个新的事件流。
    public func methodMap() {
        let (signal, observer) = Signal<String, NoError>.pipe()
        signal.map { (string) -> Int in
            return string.lengthOfBytes(using: .utf8)
            }.observeValues { (length) in
                print("length: \(length)")
        }
        
        observer.send(value: "lemon")
        
        observer.send(value: "something")
    }
    
//    MARK: - filter
//  filter函数可以按照之前预设的条件过滤掉不满足的值
    
    public func methodFilter() {
        let (signal, observer) = Signal<Int, NoError>.pipe()
        signal.filter { (value) -> Bool in
            return value % 2 == 0
            }.observeValues { (value) in
                print("\(value)能被2整除")
        }
        observer.send(value: 3)
        observer.send(value: 4)
        observer.send(value: 6)
        observer.send(value: 7)
    }
    
//    MARK: - reduce
//    reduce将事件里的值聚集后组合成一个值
    public func methodReduce() {
        let (signal, observer) = Signal<Int, NoError>.pipe()
        //reduce后的是聚合的次数
        signal.reduce(3) { (a, b) -> Int in
            //a是相乘后的值 b是传入值
            print("a:\(a) b:\(b)")
            return a * b
            }.observeValues { (value) in
                print(value)
        }
        
        observer.send(value: 2)
        observer.send(value: 5)
        observer.send(value: 4)
        //要注意的是最后算出来的值直到输入的流完成后才会被发送出去。
        observer.sendCompleted()

    }
    
//    MARK: - flatten
//    flatten 将一个事件流里的事件流变成一个单一的事件流。新的事件流的值按照指定的策略(FlattenStrategy)由内部的事件流的值组成。被压平的值按照会变成外层的流的类型。比如：一个SignalProducers里的Signal，被flatten后的类型是SignalProducers。
    
//    MARK: - 合并
//    简单的说就是merge按照时间顺序组成，concat则是按照里面整个流顺序组合。latest是只记录最近一次过来的值的那个流。
//    .Merge 策略将每个流的值立刻组合输出。无论内部还是外层的流如果收到失败就终止。
    public func mergeOfMethodMerge() {
        let (producerA, lettersObserver) = Signal<String, NoError>.pipe()
        let (producerB, numbersObserver) = Signal<String, NoError>.pipe()
        let (signal, observer) = Signal<Signal<String, NoError>, NoError>.pipe()
        signal.flatten(.merge).observeValues { (value) in
            print("value: \(value)")
        }
        observer.send(value: producerA)
        observer.send(value:producerB)
        observer.sendCompleted()
        lettersObserver.send(value:"a") // prints "a"
        numbersObserver.send(value:"1") // prints "1"
        lettersObserver.send(value:"b") // prints "b"
        numbersObserver.send(value:"2") // prints "2"
        lettersObserver.send(value:"c") // prints "c"
        numbersObserver.send(value:"3") // prints "3"
    }
    
//    Concat 策略是将内部的SignalProducer排序。外层的producer是马上被started。随后的producer直到前一个发送完成后才会start。一有失败立即传到外层。
    public func concetOfMethodMerge(){
        let (signalA, lettersObserver) = Signal<Any, NoError>.pipe()
        let (signalB, numberObserver) = Signal<Any, NoError>.pipe()
        
        let (siganl, observer) = Signal<Signal<Any, NoError>, NoError>.pipe()
        
        siganl.flatten(.concat).observeValues { (value) in
        print("value: \(value)")
        }
        observer.send(value: signalA)
        observer.send(value: signalB)
        observer.sendCompleted()
        
        lettersObserver.send(value: "dddd")//dddd
        numberObserver.send(value: 33)    //不打印
        
        lettersObserver.send(value: "sss")//sss
        lettersObserver.send(value: "ffff")//ffff
        lettersObserver.sendCompleted()
        //要前一个信号执行完毕后，下一个信号才能被订阅
        numberObserver.send(value: 44)// 44
    }
    
//    latest只接收最新进来的那个流的值
    public func latestOfMethodMerge() {
        let (signalA, lettersObserver) = Signal<Any, NoError>.pipe()
        let (signalB, numberObserver) = Signal<Any, NoError>.pipe()
        
        let (siganl, observer) = Signal<Signal<Any, NoError>, NoError>.pipe()
        
        siganl.flatten(.latest).observeValues { (value) in
            print("value: \(value)")
        }
        observer.send(value: signalA)
        //        observer.send(value: signalB)
        
        lettersObserver.send(value: "dddd")  //dddd
        numberObserver.send(value: 33)      //不打印
        lettersObserver.send(value: "sss")  //sss
        observer.send(value: signalB)
        //只接受最近进来的信号
        numberObserver.send(value: 44)  //44
        lettersObserver.send(value: "ffff") // 不打印
    }
    
//    MARK: - flatMapError
//    flatMapError捕捉一个由SignalProducer产生的失败，然后产生一个新的SignalProducer代替
    public func methodFlatMapError() {
        let (signal, observer) = Signal<Any, NSError>.pipe()
        let error = NSError.init(domain: "domian", code: 0, userInfo: nil)
        signal.flatMapError { (value) -> SignalProducer<Any, NoError> in
            return SignalProducer<Any, NoError>.init({ () -> String in
                return "sssss"
            })
            }.observeValues { (value) in
                print(value)
        }
        
        observer.send(value: 3333)
        observer.send(value: 444)
        observer.send(error: error)
    }
    
//    MARK: - retry
//    retry用于按照指定次数，在失败时重启SignalProducer。
    public func MethodRetry() {
        var tries = 0
        let limit = 2
        let error = NSError.init(domain: "domian", code: 0, userInfo: nil)
        
        let signal = SignalProducer<String, NSError >.init { (observer, _) in
            tries += 1
            if tries < limit {
                observer.send(error: error)
            }else{
                observer.send(value: "Success")
                observer.sendCompleted()
            }
        }
        
        // retry用于按照指定次数，在失败时重启SignalProducer。
        signal.on(failed:{e in
            print("Failure")
        }).retry(upTo:3).start { (event) in
            switch event {
            case .completed:
                print("Complete")
            //判断输出值是否相等
            case .value("Success"):
                print("ddd")
            case .interrupted:
                print("interrupted")
            case .failed(error):
                print(error)
            default:
                break
                
            }
        }
    }
    
//    MARK: - continuousTextValues
//     usernameTextField.reactive就是把usernameTextField变成可响应的，而continuousTextValues就是text值的信号。
    public func MethodContinuousTextValues() {
        self.usernameTextField.reactive.continuousTextValues.observe { (value) in
            print(value)
        }
    }
    
//    MARK: - 按钮点击事件和其他事件转信号
    public func MethodClic() {
        self.signInButton.reactive.controlEvents(.touchUpInside).observe { (button) in
            print("点击按钮")
        }
    }
    
//    MARK: - 属性的绑定
   /* <~运算符是提供了几种不同的绑定属性的方式。注意这里绑定的属性必须是 MutablePropertyType类型的。
    
    property <~ signal 将一个属性和信号绑定在一起，属性的值会根据信号送过来的值刷新。
    property <~ producer 会启动这个producer，并且属性的值也会随着这个产生的信号送过来的值刷新。
    property <~ otherProperty将一个属性和另一个属性绑定在一起，这样这个属性的值会随着源属性的值变化而变化。
    */
    public func methodProperty() {
        var userName: MutableProperty<String?> = MutableProperty<String?>(nil)
        var userPw : MutableProperty<String?> = MutableProperty<String?>(nil)
        var logAction = Action<Void, Void, NoError> { (input: Void) -> SignalProducer< Void , NoError> in
            return SignalProducer{ (observer, disposable) in
                observer.send(value: ())
                observer.sendCompleted()
            }
        }
        
//        self.viewModel!.userName <~ usernameTextField.reactive.textValues
//        self.viewModel!.userPw <~ passwordTextField.reactive.textValues
//        signInButton.reactive.pressed = CocoaAction<UIButton>((viewModel?.logAction)!)
        
    }
    
    
    public func scopedExample(exampleDescription: String, _ action: () -> Void) {
        print("\n--- \(exampleDescription) ---\n")
        action()
    }
    public enum ErrorOne: Error {
        case Example(String)
    }
    
    public func scopedExample(exampleDescription: String?) {
        let producer = SignalProducer<Int, NoError> { observer, _ in
        print("New subscription, starting operation")
        observer.send(value: 1)
        observer.send(value: 2)
        }

        let subscriber1 = Observer<Int, NoError>(value: { print("Subscriber 1 received \($0)") })
        let subscriber2 = Observer<Int, NoError>(value: { print("Subscriber 2 received \($0)") })

        print("Subscriber 1 subscribes to producer")
        producer.start(subscriber1)

        print("Subscriber 2 subscribes to producer")
        // Notice, how the producer will start the work again
        producer.start(subscriber2)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //收起键盘
        textField.resignFirstResponder()
        //打印出文本框中的值
        print(textField.text ?? "")
        return true
    }
    
    lazy var usernameTextField: UITextField = {
        let userName = UITextField()
        userName.borderStyle = UITextBorderStyle.roundedRect
        userName.layer.masksToBounds = true
        userName.layer.cornerRadius = 12.0  //圆角半径
        userName.layer.borderWidth = 2.0  //边框粗细
        userName.layer.borderColor = UIColor.red.cgColor //边框颜色
        userName.placeholder="请输入用户名"
        userName.textAlignment = .left //水平左对齐
        userName.borderStyle = .none //先要去除边框样式
        userName.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        return userName
    }()
    
    lazy var passwordTextField: UITextField = {
        let userName = UITextField()
        userName.borderStyle = UITextBorderStyle.roundedRect
        userName.layer.masksToBounds = true
        userName.layer.cornerRadius = 12.0  //圆角半径
        userName.layer.borderWidth = 2.0  //边框粗细
        userName.layer.borderColor = UIColor.red.cgColor //边框颜色
        userName.placeholder="请输入用户名"
        userName.textAlignment = .left //水平左对齐
        userName.borderStyle = .none //先要去除边框样式
        userName.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        return userName
    }()
    lazy var signInFailureTextLabel: UILabel = {
        let signInFailure = UILabel()
        signInFailure.textColor=UIColor.red
        signInFailure.textAlignment=NSTextAlignment.center
        signInFailure.numberOfLines = 0
        signInFailure.adjustsFontSizeToFitWidth = true //当文字超出标签宽度时，自动调整文字大小，使其不被截断
        return signInFailure
    }()
    
    lazy var signInButton: UIButton = {
        let signIn = UIButton()
        signIn.setTitle("嘿嘿", for: .normal)
        signIn.setTitleColor(UIColor.blue, for: .normal)
        signIn.backgroundColor = UIColor.brown
        return signIn
    }()
    

}
