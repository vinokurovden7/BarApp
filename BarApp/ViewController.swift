//
//  ViewController.swift
//  BarApp
//
//  Created by Денис Винокуров on 27.04.2021.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Элементы экрана:
    
    // Кнопки
    @IBOutlet weak var startStopButtonShift: UIButton!
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var clearBeerRevenueButton: UIButton!
    
    // Изображения пива
    @IBOutlet weak var imageFirstBeer: UIImageView!
    @IBOutlet weak var imageSecondBeer: UIImageView!
    @IBOutlet weak var imageThirdBeer: UIImageView!
    @IBOutlet weak var imageFourBeer: UIImageView!
    
    // Наименования пива
    @IBOutlet weak var nameFirstBeer: UILabel!
    @IBOutlet weak var nameSecondBeer: UILabel!
    @IBOutlet weak var nameThirdBeer: UILabel!
    @IBOutlet weak var nameFourBeer: UILabel!
    
    // Наименования страны производства пива
    @IBOutlet weak var countryFirstBeer: UILabel!
    @IBOutlet weak var countrySecondBeer: UILabel!
    @IBOutlet weak var countryThirdBeer: UILabel!
    @IBOutlet weak var countryFourBeer: UILabel!
    
    // Цена пива за литр
    @IBOutlet weak var priceFirstBeer: UILabel!
    @IBOutlet weak var priceSecondBeer: UILabel!
    @IBOutlet weak var priceThirdBeer: UILabel!
    @IBOutlet weak var priceFourBeer: UILabel!
    
    // Остаток пива
    @IBOutlet weak var remainingFirstBeer: UILabel!
    @IBOutlet weak var remainingSecondBeer: UILabel!
    @IBOutlet weak var remainingThirdBeer: UILabel!
    @IBOutlet weak var remainingFourBeer: UILabel!
    
    // Количество литров для продажи
    @IBOutlet weak var countLitersFirstBeer: UITextField!
    @IBOutlet weak var countLitersSecondBeer: UITextField!
    @IBOutlet weak var countLitersThirdBeer: UITextField!
    @IBOutlet weak var countLitersFourBeer: UITextField!
    
    // Выручка от продажи пива
    @IBOutlet weak var beerRevenueLabel: UILabel!
    
    //MARK: Переменные
    
    private var startedShift = false
    private var heinekenBeer: Beer?
    private var budBeer: Beer?
    private var stellaArtoisBeer: Beer?
    private var baltikaBeer: Beer?
    
    //MARK: Жизненный цикл:
    
    // View загружено в память
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heinekenBeer = Beer(imageNameBeer: "heineken", nameBeer: "Heineken", priceBeer: 100.3, countryBeer: "Нидерланды", remainingBeer: 80)
        budBeer = Beer(imageNameBeer: "bud", nameBeer: "Bud", priceBeer: 105, countryBeer: "Чехия", remainingBeer: 50.5)
        stellaArtoisBeer = Beer(imageNameBeer: "stellaArtois", nameBeer: "Stella Artois", priceBeer: 97, countryBeer: "Великобритания", remainingBeer: 120)
        baltikaBeer = Beer(imageNameBeer: "baltika", nameBeer: "Балтика", priceBeer: 90.8, countryBeer: "Россия", remainingBeer: 103.5)
        
    }
    
    // Перед отображением View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: Начальные установки элементов экрана
        // Скругление кнопки открытия и закрытия смены
        startStopButtonShift.layer.cornerRadius = startStopButtonShift.frame.height / 2
        // Скругление кнопки продажи пива
        sellButton.layer.cornerRadius = 10
        // Скругление кнопки обнуления выручки
        clearBeerRevenueButton.layer.cornerRadius = 10
        // Отключение взаимодействия с кнопками и полями ввода
        sellButton.isEnabled = false
        enabledScreenElements()
        
        // Проверка на существование экземпляров классов
        guard let heinekenBeer = heinekenBeer, let budBeer = budBeer, let stellaArtoisBeer = stellaArtoisBeer, let baltikaBeer = baltikaBeer else {return}
        
        //MARK: Установка изображения пива
        imageFirstBeer.image = heinekenBeer.getImageBeer()
        imageSecondBeer.image = budBeer.getImageBeer()
        imageThirdBeer.image = stellaArtoisBeer.getImageBeer()
        imageFourBeer.image = baltikaBeer.getImageBeer()
        
        //MARK: Установка наименования пива
        nameFirstBeer.text = heinekenBeer.getNameBeer()
        nameSecondBeer.text = budBeer.getNameBeer()
        nameThirdBeer.text = stellaArtoisBeer.getNameBeer()
        nameFourBeer.text = baltikaBeer.getNameBeer()
        
        //MARK: Установка страны пива
        countryFirstBeer.text = heinekenBeer.getCountry()
        countrySecondBeer.text = budBeer.getCountry()
        countryThirdBeer.text = stellaArtoisBeer.getCountry()
        countryFourBeer.text = baltikaBeer.getCountry()
        
        //MARK: Установка цены пива
        priceFirstBeer.text = "\(String(format: "%.2f", heinekenBeer.getPrice())) ₽"
        priceSecondBeer.text = "\(String(format: "%.2f", budBeer.getPrice())) ₽"
        priceThirdBeer.text = "\(String(format: "%.2f", stellaArtoisBeer.getPrice())) ₽"
        priceFourBeer.text = "\(String(format: "%.2f", baltikaBeer.getPrice())) ₽"
        
        //MARK: Установка остатка пива
        remainingFirstBeer.text = "Остаток:\n\(String(format: "%.2f", heinekenBeer.getRemaining())) Л"
        remainingSecondBeer.text = "Остаток:\n\(String(format: "%.2f", budBeer.getRemaining())) Л"
        remainingThirdBeer.text = "Остаток:\n\(String(format: "%.2f", stellaArtoisBeer.getRemaining())) Л"
        remainingFourBeer.text = "Остаток:\n\(String(format: "%.2f", baltikaBeer.getRemaining())) Л"
        
        beerRevenueLabel.text = "Выручка: \(String(format: "%.2f", BeerManager.shared.revenueBeer)) ₽"
        
    }
    
    //MARK: Обработчики кнопок:
    
    /// Открытие и закрытие смены
    @IBAction func startStopShiftButtonAction(_ sender: UIButton) {
        
        // Смена статуса открытия смены
        startedShift = !startedShift
        
        // Если смена открыта
        if startedShift {
            startStopButtonShift.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
            startStopButtonShift.backgroundColor = .systemRed
            // Включение взаимодействия с кнопками и полями ввода
            sellButton.isEnabled = true
            clearBeerRevenueButton.isEnabled = true
        } else {
            startStopButtonShift.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            startStopButtonShift.backgroundColor = .systemGreen
            // Отключение взаимодействия с кнопками и полями ввода
            sellButton.isEnabled = false
            clearBeerRevenueButton.isEnabled = false
        }
        
        enabledScreenElements()
        
    }
    
    /// Продажа пива
    @IBAction func sellButtonAction(_ sender: UIButton) {
        
        // Проверка на существование экземпляров классов
        guard let heinekenBeer = heinekenBeer, let budBeer = budBeer, let stellaArtoisBeer = stellaArtoisBeer, let baltikaBeer = baltikaBeer else {return}
        
        // Переменная для временного хранения суммы выручки
        var revenue: Double = 0
        
        // Первое поле
        let stringCountLitersFirstBeer = countLitersFirstBeer.text?.replacingOccurrences(of: ",", with: ".") ?? "0"
        if let revenueFirstBeer = Double(stringCountLitersFirstBeer) {
            // Если введенное количество литров не превышает количество остаточного объема
            if revenueFirstBeer <= heinekenBeer.getRemaining() {
                revenue += revenueFirstBeer * heinekenBeer.getPrice()
                updateRemainingBeer(countLitersBeer: revenueFirstBeer, beer: heinekenBeer)
                remainingFirstBeer.text = heinekenBeer.getRemaining() < 0.5 ? "Закончилось" : "Остаток:\n\(String(format: "%.2f", heinekenBeer.getRemaining())) Л"
            }
        }
        
        // Второе поле
        let stringCountLitersSecondBeer = countLitersSecondBeer.text?.replacingOccurrences(of: ",", with: ".") ?? "0"
        if let revenueSecondBeer = Double(stringCountLitersSecondBeer) {
            // Если введенное количество литров не превышает количество остаточного объема
            if revenueSecondBeer <= budBeer.getRemaining() {
                revenue += revenueSecondBeer * budBeer.getPrice()
                updateRemainingBeer(countLitersBeer: revenueSecondBeer, beer: budBeer)
                remainingSecondBeer.text = budBeer.getRemaining() < 0.5 ? "Закончилось" : "Остаток:\n\(String(format: "%.2f", budBeer.getRemaining())) Л"
            }
        }
        
        // Третье поле
        let stringCountLitersThidBeer = countLitersThirdBeer.text?.replacingOccurrences(of: ",", with: ".") ?? "0"
        if let revenueThirdBeer = Double(stringCountLitersThidBeer) {
            // Если введенное количество литров не превышает количество остаточного объема
            if revenueThirdBeer <= stellaArtoisBeer.getRemaining() {
                revenue += revenueThirdBeer * stellaArtoisBeer.getPrice()
                updateRemainingBeer(countLitersBeer: revenueThirdBeer, beer: stellaArtoisBeer)
                remainingThirdBeer.text = stellaArtoisBeer.getRemaining() < 0.5 ? "Закончилось" : "Остаток:\n\(String(format: "%.2f", stellaArtoisBeer.getRemaining())) Л"
            }
        }
        
        // Четвертое поле
        let stringCountLitersFourBeer = countLitersFourBeer.text?.replacingOccurrences(of: ",", with: ".") ?? "0"
        if let revenueFourBeer = Double(stringCountLitersFourBeer) {
            // Если введенное количество литров не превышает количество остаточного объема
            if revenueFourBeer <= baltikaBeer.getRemaining() {
                revenue += revenueFourBeer * baltikaBeer.getPrice()
                updateRemainingBeer(countLitersBeer: revenueFourBeer, beer: baltikaBeer)
                remainingFourBeer.text = baltikaBeer.getRemaining() < 0.5 ? "Закончилось" : "Остаток:\n\(String(format: "%.2f", baltikaBeer.getRemaining())) Л"
            }
        }
        
        // Если сумма выручки больше 0
        if revenue > 0 {
            updateRevenueBeer(revenue: revenue)
            countLitersFirstBeer.text = ""
            countLitersSecondBeer.text = ""
            countLitersThirdBeer.text = ""
            countLitersFourBeer.text = ""
        }
        
        enabledScreenElements()
        
    }
    
    /// Сброс выручки
    @IBAction func clearBeerRevenueButtonAction(_ sender: UIButton) {
        updateRevenueBeer(revenue: 0)
        beerRevenueLabel.text = "Выручка: \(String(format: "%.2f", BeerManager.shared.revenueBeer)) ₽"
    }
    
    //MARK: Overrides методы:
    
    /// Нажатие на любое пустое место на экране, чтобы скрыть клавиатуру
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Кастомные функции:
    
    /// Обновить значение выручки
    /// - Parameter revenue: значение выручки
    private func updateRevenueBeer(revenue: Double) {
        if revenue > 0 {
            BeerManager.shared.revenueBeer += revenue
        } else {
            BeerManager.shared.revenueBeer = revenue
        }
        beerRevenueLabel.text = "Выручка: \(String(format: "%.2f", BeerManager.shared.revenueBeer)) ₽"
    }
    
    /// Обновить остаток пива
    /// - Parameters:
    ///   - countLitersBeer: количество проданных литров
    ///   - beer: проданное пиво
    private func updateRemainingBeer(countLitersBeer: Double, beer: Beer) {
        beer.setRemaining(countLiters: countLitersBeer)
    }
    
    /// Отключение или включение взаимодействия с TextFields и Lables
    private func enabledScreenElements() {
        
        // Проверка на существование экземпляров классов
        guard let heinekenBeer = heinekenBeer, let budBeer = budBeer, let stellaArtoisBeer = stellaArtoisBeer, let baltikaBeer = baltikaBeer else {return}
        
        // Отключение или включение взаимодействия с TextFields
        countLitersFirstBeer.isEnabled = heinekenBeer.getRemaining() > 0.5
        countLitersSecondBeer.isEnabled = budBeer.getRemaining() > 0.5
        countLitersThirdBeer.isEnabled = stellaArtoisBeer.getRemaining() > 0.5
        countLitersFourBeer.isEnabled = baltikaBeer.getRemaining() > 0.5
        
        // Отключение или включение взаимодействия с Lables
        nameFirstBeer.isEnabled = heinekenBeer.getRemaining() > 0.5
        countryFirstBeer.isEnabled = heinekenBeer.getRemaining() > 0.5
        priceFirstBeer.isEnabled = heinekenBeer.getRemaining() > 0.5
        remainingFirstBeer.isEnabled = heinekenBeer.getRemaining() > 0.5
        
        nameSecondBeer.isEnabled = budBeer.getRemaining() > 0.5
        countrySecondBeer.isEnabled = budBeer.getRemaining() > 0.5
        priceSecondBeer.isEnabled = budBeer.getRemaining() > 0.5
        remainingSecondBeer.isEnabled = budBeer.getRemaining() > 0.5
        
        nameThirdBeer.isEnabled = stellaArtoisBeer.getRemaining() > 0.5
        countryThirdBeer.isEnabled = stellaArtoisBeer.getRemaining() > 0.5
        priceThirdBeer.isEnabled = stellaArtoisBeer.getRemaining() > 0.5
        remainingThirdBeer.isEnabled = stellaArtoisBeer.getRemaining() > 0.5
        
        nameFourBeer.isEnabled = baltikaBeer.getRemaining() > 0.5
        countryFourBeer.isEnabled = baltikaBeer.getRemaining() > 0.5
        priceFourBeer.isEnabled = baltikaBeer.getRemaining() > 0.5
        remainingFourBeer.isEnabled = baltikaBeer.getRemaining() > 0.5
        
    }
    
    
}
