import UIKit
import SnapKit

final class ViewController: UIViewController {
	
	private let label: UILabel = {
		let label = UILabel()
		label.backgroundColor = .white
		label.text = Constants.Text.hello
		label.textAlignment = .center
		label.layer.cornerRadius = Constants.Layout.cornerRadius
		label.clipsToBounds = true
		return label
	}()
	
	private let button: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = .systemPink
		button.setTitle(Constants.Text.buttonTitle, for: .normal)
		button.titleLabel?.font = .boldSystemFont(ofSize: Constants.Font.buttonSize)
		button.setTitleColor(.white, for: .normal)
		button.layer.cornerRadius = Constants.Layout.cornerRadius
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
	}
	
	private func setupUI() {
		view.backgroundColor = .systemFill
		
		view.addSubview(label)
		view.addSubview(button)
		
		setupConstraints()
		
		button.addTarget(
			self, action: #selector(openNextScreen), for: .touchUpInside
		)
	}
	
	@objc
	private func openNextScreen() {
		let controller = TwoViewController()
		controller.completion = { [weak self] text in
			self?.label.text = text
		}
		
		navigationController?.pushViewController(controller, animated: true)
	}
}

private extension ViewController {
	func setupConstraints() {
		label.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.width.equalToSuperview().multipliedBy(Constants.Layout.labelWidthMultiplier)
			$0.height.equalTo(label.snp.width).multipliedBy(Constants.Layout.labelHeightMultiplier)
		}
		
		button.snp.makeConstraints {
			$0.top.equalTo(label.snp.bottom).offset(Constants.Layout.verticalSpacing)
			$0.centerX.equalTo(label)
			$0.width.equalToSuperview().multipliedBy(Constants.Layout.buttonWidthMultiplier)
			$0.height.equalTo(button.snp.width).multipliedBy(Constants.Layout.buttonHeightMultiplier)
		}
	}
}
