import UIKit

class ViewController: UIViewController {
    
    var photoCategories = [
        "Travel" : "https://source.unsplash.com/600x600/?travel",
        "Animals" : "https://source.unsplash.com/600x600/?animals",
        "History" : "https://source.unsplash.com/600x600/?history",
        "Experimental" : "https://source.unsplash.com/600x600/?experimental"
    ]
    
    var currentCategory = ""
    
    var isStarted = false
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var randomPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Switch Photo", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(switchPhoto), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var musicButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play Music", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(playStopButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var selectCategoryPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Choose Category", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 25
        let itemsMenu = photoCategories.map { category, url in
            UIAction(title: category) { _ in
                self.currentCategory = category
                self.getRandomPhoto(url: url)
            }
        }
        button.menu = UIMenu(title: "", image: nil, options: .displayInline, children: itemsMenu)
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func getRandomPhoto(url: String) {
        let urlString = url
        guard let url = URL(string: urlString) else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        imageView.image = UIImage(data: data)
    }
    
    @objc func playStopButton() {
        if (isStarted) {
            isStarted = false
            MusicPlayer.shared.startStopMusicPlayer()
            musicButton.setTitle("Play Music", for: .normal)
        } else {
            isStarted = true
            MusicPlayer.shared.startStopMusicPlayer()
            musicButton.setTitle("Stop Music", for: .normal)
        }
    }

    @objc func switchPhoto() {
        getRandomPhoto(url: photoCategories[currentCategory] ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewHierarchy()
        setupLayout()
    }
    
//MARK: - Methods Setup Layout and ViewHierarchy
    
    func viewHierarchy() {
        view.addSubview(imageView)
        view.addSubview(randomPhotoButton)
        view.addSubview(selectCategoryPhotoButton)
        view.addSubview(musicButton)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 400),
            imageView.widthAnchor.constraint(equalToConstant: 400),
            
            randomPhotoButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 250),
            randomPhotoButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 100),
            randomPhotoButton.widthAnchor.constraint(equalToConstant: 180),
            randomPhotoButton.heightAnchor.constraint(equalToConstant: 80),
            
            selectCategoryPhotoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250),
            selectCategoryPhotoButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            selectCategoryPhotoButton.widthAnchor.constraint(equalToConstant: 200),
            selectCategoryPhotoButton.heightAnchor.constraint(equalToConstant: 80),
            
            musicButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 250),
            musicButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -100),
            musicButton.widthAnchor.constraint(equalToConstant: 200),
            musicButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
