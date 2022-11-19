import UIKit
import Social

public class TwitterCounterContainerView: UIView {
    
    let maxLength = 280
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        return scroll
    }()
    
    lazy var scrollContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var twitterLogo: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "logo-twitter-png-5860")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var charactersStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.axis = .horizontal
        return stack
    }()
    
    lazy var charactersTypedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9647058824, blue: 0.9960784314, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var charactersTypedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Characters Typed"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var charactersTypedWhiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        if #available(iOS 11.0, *) {
            view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        return view
    }()
    
    lazy var charactersTypedNumbersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0/\(maxLength)"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    lazy var charactersRemainingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9025290012, green: 0.966232121, blue: 0.9957594275, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var charactersRemainingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Characters Remaining"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var charactersRemainingWhiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        if #available(iOS 11.0, *) {
            view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        return view
    }()
    
    lazy var charactersRemainingNumbersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(maxLength)"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    lazy var tweetTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 12
        textView.backgroundColor = .white
        textView.layer.borderColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        textView.layer.borderWidth = 1
        textView.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        textView.dataDetectorTypes = .link
        textView.delegate = self
        textView.text = "Start typing! You can enter up to 280 characters"
        textView.textColor = #colorLiteral(red: 0.4437957406, green: 0.4556506872, blue: 0.4520581365, alpha: 1)
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        
        return textView
    }()
    
    lazy var textOptionsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.spacing = 0
        stack.axis = .horizontal
        return stack
    }()
    
    lazy var copyTextBTN: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Copy Text", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.662745098, blue: 0.4392156863, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTappedCopyText), for: .touchUpInside)
        return button
    }()
    
    lazy var clearTextBTN: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clear Text", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.003921568627, blue: 0.1450980392, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTappedClearText), for: .touchUpInside)
        return button
    }()
    
    lazy var postTweetBTN: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Post Tweet", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.662745098, blue: 0.9568627451, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTappedPostTweet), for: .touchUpInside)
        return button
    }()
    
    public init() {
        super.init(frame: .zero)
        layoutUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUserInterface() {
        addSubViews()
        setupScroll()
        setupScrollContainerView()
        setupTwitterLogo()
        setupCharactersStack()
        setupCharactersTypedView()
        setupCharactersRemainingView()
        setupCharactersTypedLabel()
        setupCharactersTypedWhiteView()
        setupCharactersTypedNumbersLabel()
        setupCharactersRemainingLabel()
        setupCharactersRemainingWhiteView()
        setupCharactersRemainingNumbersLabel()
        setupTweetTextView()
        setupTextOptionsStack()
        setupCopyTextButton()
        setupClearTextButton()
        setupPostTweetBTN()
    }
    
    private func addSubViews() {
        addSubview(scrollView)
        scrollView.addSubview(scrollContainerView)
        scrollContainerView.addSubview(twitterLogo)
        scrollContainerView.addSubview(charactersStack)
        scrollContainerView.addSubview(tweetTextView)
        scrollContainerView.addSubview(textOptionsStack)
        scrollContainerView.addSubview(postTweetBTN)
        
        charactersStack.addArrangedSubview(charactersTypedView)
        charactersStack.addArrangedSubview(charactersRemainingView)
        
        charactersTypedView.addSubview(charactersTypedLabel)
        charactersTypedView.addSubview(charactersTypedWhiteView)
        
        charactersTypedWhiteView.addSubview(charactersTypedNumbersLabel)
        
        charactersRemainingView.addSubview(charactersRemainingLabel)
        charactersRemainingView.addSubview(charactersRemainingWhiteView)
        
        charactersRemainingWhiteView.addSubview(charactersRemainingNumbersLabel)
        
        textOptionsStack.addArrangedSubview(copyTextBTN)
        textOptionsStack.addArrangedSubview(clearTextBTN)
    }
    
    private func setupScroll() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setupScrollContainerView() {
        NSLayoutConstraint.activate([
            scrollContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContainerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            scrollContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
    }
    
    private func setupTwitterLogo() {
        NSLayoutConstraint.activate([
            twitterLogo.topAnchor.constraint(equalTo: scrollContainerView.topAnchor, constant: 30),
            twitterLogo.centerXAnchor.constraint(equalTo: self.scrollContainerView.centerXAnchor),
            twitterLogo.heightAnchor.constraint(equalToConstant: 58),
            twitterLogo.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupCharactersStack() {
        NSLayoutConstraint.activate([
            charactersStack.topAnchor.constraint(equalTo: twitterLogo.bottomAnchor, constant: 10),
            charactersStack.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 15),
            charactersStack.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -15),
            charactersStack.heightAnchor.constraint(equalToConstant: 108),
        ])
    }
    
    private func setupCharactersTypedView() {
        NSLayoutConstraint.activate([
            charactersTypedView.heightAnchor.constraint(equalToConstant: 108)
        ])
    }
    
    private func setupCharactersRemainingView() {
        NSLayoutConstraint.activate([
            charactersRemainingView.heightAnchor.constraint(equalToConstant: 108)
        ])
    }
    
    private func setupCharactersTypedLabel() {
        NSLayoutConstraint.activate([
            charactersTypedLabel.topAnchor.constraint(equalTo: charactersTypedView.topAnchor, constant: 6),
            charactersTypedLabel.centerXAnchor.constraint(equalTo: charactersTypedView.centerXAnchor),
            charactersTypedLabel.heightAnchor.constraint(equalToConstant: 23)
        ])
    }
    
    private func setupCharactersTypedWhiteView() {
        NSLayoutConstraint.activate([
            charactersTypedWhiteView.leadingAnchor.constraint(equalTo: charactersTypedView.leadingAnchor, constant: 1),
            charactersTypedWhiteView.trailingAnchor.constraint(equalTo: charactersTypedView.trailingAnchor, constant: -1),
            charactersTypedWhiteView.bottomAnchor.constraint(equalTo: charactersTypedView.bottomAnchor, constant: -1),
            charactersTypedWhiteView.heightAnchor.constraint(equalToConstant: 73)
        ])
    }
    
    private func setupCharactersTypedNumbersLabel() {
        NSLayoutConstraint.activate([
            charactersTypedNumbersLabel.centerXAnchor.constraint(equalTo: charactersTypedWhiteView.centerXAnchor),
            charactersTypedNumbersLabel.centerYAnchor.constraint(equalTo: charactersTypedWhiteView.centerYAnchor)
        ])
    }
    
    private func setupCharactersRemainingLabel() {
        NSLayoutConstraint.activate([
            charactersRemainingLabel.topAnchor.constraint(equalTo: charactersRemainingView.topAnchor, constant: 6),
            charactersRemainingLabel.centerXAnchor.constraint(equalTo: charactersRemainingView.centerXAnchor),
            charactersRemainingLabel.heightAnchor.constraint(equalToConstant: 23)
        ])
    }
    
    private func setupCharactersRemainingWhiteView() {
        NSLayoutConstraint.activate([
            charactersRemainingWhiteView.leadingAnchor.constraint(equalTo: charactersRemainingView.leadingAnchor, constant: 1),
            charactersRemainingWhiteView.trailingAnchor.constraint(equalTo: charactersRemainingView.trailingAnchor, constant: -1),
            charactersRemainingWhiteView.bottomAnchor.constraint(equalTo: charactersRemainingView.bottomAnchor, constant: -1),
            charactersRemainingWhiteView.heightAnchor.constraint(equalToConstant: 73)
        ])
    }
    
    private func setupCharactersRemainingNumbersLabel() {
        NSLayoutConstraint.activate([
            charactersRemainingNumbersLabel.centerXAnchor.constraint(equalTo: charactersRemainingWhiteView.centerXAnchor),
            charactersRemainingNumbersLabel.centerYAnchor.constraint(equalTo: charactersRemainingWhiteView.centerYAnchor)
        ])
    }
    
    private func setupTweetTextView() {
        NSLayoutConstraint.activate([
            tweetTextView.topAnchor.constraint(equalTo: charactersStack.bottomAnchor, constant: 24),
            tweetTextView.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            tweetTextView.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),
            tweetTextView.heightAnchor.constraint(equalToConstant: 239)
        ])
    }
    
    private func setupTextOptionsStack() {
        NSLayoutConstraint.activate([
            textOptionsStack.topAnchor.constraint(equalTo: tweetTextView.bottomAnchor, constant: 24),
            textOptionsStack.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            textOptionsStack.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupCopyTextButton() {
        NSLayoutConstraint.activate([
            copyTextBTN.heightAnchor.constraint(equalToConstant: 40),
            copyTextBTN.widthAnchor.constraint(equalToConstant: 93)
        ])
    }
    
    private func setupClearTextButton() {
        NSLayoutConstraint.activate([
            clearTextBTN.heightAnchor.constraint(equalToConstant: 40),
            clearTextBTN.widthAnchor.constraint(equalToConstant: 93)
        ])
    }
    
    private func setupPostTweetBTN() {
        NSLayoutConstraint.activate([
            postTweetBTN.topAnchor.constraint(equalTo: textOptionsStack.bottomAnchor, constant: 24),
            postTweetBTN.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            postTweetBTN.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),
            postTweetBTN.bottomAnchor.constraint(equalTo: scrollContainerView.bottomAnchor, constant: -189),
            postTweetBTN.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    @objc func didTappedCopyText() {
        guard tweetTextView.text != "Start typing! You can enter up to 280 characters" || tweetTextView.text == "" else {
            return
        }
        UIPasteboard.general.string = tweetTextView.text
    }
    
    @objc func didTappedClearText() {
        tweetTextView.text = ""
        charactersTypedNumbersLabel.text = "0/\(maxLength)"
        charactersRemainingNumbersLabel.text = "\(maxLength)"
    }
    
    @objc func didTappedPostTweet() {
//        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
//            let tweetController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//            if tweetTextView.textColor == .black {
//                tweetController?.setInitialText(tweetTextView.text)
//            } else {
//                return
//            }
//        } else {
//            print("there is no account")
//            return
//        }
        if tweetTextView.textColor == .black, let tweetText = tweetTextView.text {
            let twitterHooks = "twitter://post?message=\(tweetText)"
            let twitterUrl = URL(string: twitterHooks)!

            if (UIApplication.shared.canOpenURL(URL(string:"twitter://")!)) {
                print("Twitter is installed")
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(twitterUrl)
                } else {
                    // Fallback on earlier versions
                }
            } else {
                UIApplication.shared.openURL(twitterUrl)
            }
        } else {
            
        }
    }
    
    func urlExists(_ input: String) -> (Bool, Int) {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
        
        for match in matches {
            guard let range = Range(match.range, in: input) else { continue }
            let url = input[range]
            return (true, url.count)
        }
        return (false, 0)
    }
}

extension TwitterCounterContainerView: UITextViewDelegate {
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
       
        guard textView.text.count + (text.count - range.length) <= maxLength else {
            return false
        }
        
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        if updatedText.isEmpty {
            
            textView.text = "Start typing! You can enter up to 280 characters"
            textView.textColor = #colorLiteral(red: 0.4437957406, green: 0.4556506872, blue: 0.4520581365, alpha: 1)
            charactersTypedNumbersLabel.text = "0/\(maxLength)"
            charactersRemainingNumbersLabel.text = "\(maxLength)"
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
        
        else if textView.textColor == #colorLiteral(red: 0.4437957406, green: 0.4556506872, blue: 0.4520581365, alpha: 1) && !text.isEmpty {
            textView.textColor = UIColor.black
            if text.contains(UIPasteboard.general.string ?? "") {
                if let pastedText = UIPasteboard.general.string {
                    charactersTypedNumbersLabel.text = "\(pastedText.count)/\(maxLength)"
                    charactersRemainingNumbersLabel.text = "\(maxLength-pastedText.count)"
                }
            } else {
                charactersTypedNumbersLabel.text = "1/\(maxLength)"
                charactersRemainingNumbersLabel.text = "\(maxLength-1)"
            }
            textView.text = text
        }
        
        else {
            return true
        }
        
        return false
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        let x = urlExists(textView.text)
        
        if x.0 {
            let y = textView.text.count - x.1
            charactersTypedNumbersLabel.text = "\(162+y)/\(maxLength)"
            charactersRemainingNumbersLabel.text = "\(118-y)"
        } else {
            charactersTypedNumbersLabel.text = "\(textView.text.count)/\(maxLength)"
            charactersRemainingNumbersLabel.text = "\(maxLength - textView.text.count)"
        }
    }
}
