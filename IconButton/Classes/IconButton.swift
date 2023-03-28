//
//  IconButton.swift
//  Pods
//
//  Created by 王叶庆 on 2023/3/24.
//

import UIKit


open class IconButton: UIControl {

    public enum IconPosition {
        case left
        case top
        case right
        case bottom
    }
    
    private lazy var backgroundImageView: UIImageView = UIImageView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    private var titleMap: [UIControl.State.RawValue : String] = [:]
    private var titleColorMap: [UIControl.State.RawValue : UIColor] = [:]
    private var backgroundImageMap: [UIControl.State.RawValue : UIImage] = [:]
    private var imageMap: [UIControl.State.RawValue : UIImage] = [:]
    
    private let stackView = UIStackView()
        
    public var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6) {
        didSet {
            layoutMargins = contentInsets
            layoutMarginsDidChange()
        }
    }
    
    /// icon在控件中的位置 icon在左边标题就在右边 icon在上边标题就在下边 icon在右边标题就在左边 icon在下边标题就在上边
    public var iconPosition: IconPosition = .left {
        didSet {
            guard oldValue != iconPosition || stackView.arrangedSubviews.isEmpty else {
                return
            }
            layoutComponents()
        }
    }
    
    /// icon和标题之间的间距
    public var spacing: CGFloat = 6 {
        didSet {
            stackView.spacing = spacing
        }
    }
    
    public init(target: Any? = nil, action: Selector? = nil) {
        super.init(frame: .zero)
        guard let action = action else {
            return
        }
        addTarget(target, action: action, for: .touchUpInside)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        layoutMargins = contentInsets
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.isUserInteractionEnabled = false
        titleLabel.isUserInteractionEnabled = false
        stackView.isUserInteractionEnabled = false
        isUserInteractionEnabled = true
        layoutComponents()
    }
    
    
    public func updateUI(_ state: UIControl.State) {
        let defaultState = UIControl.State.normal.rawValue
        titleLabel.text = titleMap[state.rawValue] ?? titleMap[defaultState]
        titleLabel.textColor = titleColorMap[state.rawValue] ?? titleColorMap[defaultState]
        let image = imageMap[state.rawValue] ?? imageMap[defaultState]
        imageView.image = image
        
        if !backgroundImageMap.isEmpty {
            backgroundImageView.image = backgroundImageMap[state.rawValue] ?? backgroundImageMap[defaultState]
        }
    }
    
    public func layoutComponents() {
        let views = stackView.arrangedSubviews
        for view in views {
            stackView.removeArrangedSubview(view)
        }
        switch iconPosition {
        case .left:
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(titleLabel)
            stackView.spacing = spacing
            stackView.axis = .horizontal
            stackView.distribution = .fill
        case .right:
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(imageView)
            stackView.spacing = spacing
            stackView.axis = .horizontal
        case .top:
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(titleLabel)
            stackView.spacing = spacing
            stackView.axis = .vertical
        case .bottom:
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(imageView)
            stackView.spacing = spacing
            stackView.axis = .vertical
        }
    }
    
    open func setTitle(_ title: String?, for state: UIControl.State) {
        titleMap[state.rawValue] = title
        if state == self.state {
            titleLabel.text = title ?? titleMap[UIControl.State.normal.rawValue]
        }
    }

    open func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        titleColorMap[state.rawValue] = color
        if state == self.state {
            titleLabel.textColor = color ?? titleColorMap[UIControl.State.normal.rawValue]
        }
    }

    open func setImage(_ image: UIImage?, for state: UIControl.State) {
        guard let image = image else {
            return
        }
        imageMap[state.rawValue] = image
        if state == self.state {
            imageView.image = image
        }
    }

    open func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
        guard let image = image else {
            return
        }
        if backgroundImageView.superview != self {
            addSubview(backgroundImageView)
            sendSubviewToBack(backgroundImageView)
            backgroundImageView.isUserInteractionEnabled = false
        }
        backgroundImageMap[state.rawValue] = image
        if state == self.state {
            backgroundImageView.image = image
        }
    }
    
    open override var isHighlighted: Bool {
        get {
            super.isHighlighted
        }
        
        set {
            super.isHighlighted = newValue
            updateUI(state)
        }
    }
    
    open override var isSelected: Bool {
        get {
            super.isSelected
        }
        set {
            super.isSelected = newValue
            updateUI(state)
        }
    }
    
    open override var isEnabled: Bool {
        get {
            super.isEnabled
        }
        set {
            super.isEnabled = newValue
            updateUI(state)
        }
    }

}
