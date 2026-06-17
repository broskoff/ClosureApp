import UIKit

final class TwoViewController: UIViewController {
	
	var completion: ((String) -> ())?
	
	private let textField: UITextField = {
		let textField = UITextField()
		textField.backgroundColor = .white
		textField.layer.cornerRadius = Constants.Layout.cornerRadius
		textField.clipsToBounds = true
		textField.placeholder = Constants.Text.placeholder
		textField.textAlignment = .center
		return textField
	}()
	
	private let button: UIButton = {
		var configuration = UIButton.Configuration.filled()
		
		configuration.baseBackgroundColor = .systemPink
		configuration.baseForegroundColor = .white
		
		var attributes = AttributeContainer()
		attributes.font = .boldSystemFont(ofSize: Constants.Font.buttonSize)
		
		configuration.attributedTitle = AttributedString(
			Constants.Text.transferTextButtonTitle,
			attributes: attributes
		)
		
		configuration.cornerStyle = .medium
		
		return UIButton(configuration: configuration)
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		setupKeyboardObserver()
	}
	
	private func setupUI() {
		view.backgroundColor = .systemGreen
		
		view.addSubview(textField)
		view.addSubview(button)
		
		setupConstraints()
		
		button.addTarget(
			self, action: #selector(didTapButton), for: .touchUpInside
		)
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		
		view.addGestureRecognizer(tapGesture)
	}
	
	@objc
	func hideKeyboard() {
		view.endEditing(true)
	}
	
	@objc
	private func didTapButton() {
		getDataAndBack()
	}
	
	private func getDataAndBack() {
		guard let text = textField.text, !text.isEmpty else {
			completion?(Constants.Text.noData)
			navigationController?.popViewController(animated: true)
			return
		}
		
		completion?(text)
		navigationController?.popViewController(animated: true)
	}
}

private extension TwoViewController {
	func setupConstraints() {
		textField.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.width.equalToSuperview().multipliedBy(Constants.Layout.textFieldWidthMultiplier)
			$0.height.equalTo(textField.snp.width).multipliedBy(Constants.Layout.textFieldHeightMultiplier)
		}
		
		button.snp.makeConstraints {
			$0.top.equalTo(textField.snp.bottom).offset(Constants.Layout.verticalSpacing)
			$0.centerX.equalTo(textField)
			$0.width.equalToSuperview().multipliedBy(Constants.Layout.secondButtonWidthMultiplier)
			$0.height.equalTo(button.snp.width).multipliedBy(Constants.Layout.secondButtonHeightMultiplier)
		}
	}
}

private extension TwoViewController {
	func setupKeyboardObserver() {
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillShow),
			name: UIResponder.keyboardWillShowNotification,
			object: nil
		)
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillHide),
			name: UIResponder.keyboardWillHideNotification,
			object: nil)
	}
	
	@objc
	func keyboardWillShow(_ notification: Notification) {
		view.frame.origin.y = Constants.Layout.keyboardOffset
	}
	
	@objc
	func keyboardWillHide(_ notification: Notification) {
		view.frame.origin.y = Constants.Layout.defaultViewOriginY
	}
}
