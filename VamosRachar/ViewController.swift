//
//  ViewController.swift
//  VamosRachar
//
//  Created by Gustavo Lemos on 13/08/21.
//

//Imports básicos e do AVFoundation para fazer o TTS
import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {
    //Criação do TTS
    let tts = AVSpeechSynthesizer()

    //Declaração das labels e textfields
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var txtvAmigos: UITextField!
    @IBOutlet weak var txtvReais: UITextField!
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var btnLanguage: UIButton!
    //Var para definir o idioma. Pode ser en-us ou pt-br
    var idiomaStr = "en-us"
    
    //Função que roda ao abrir a view
    override func viewDidLoad() {
        super.viewDidLoad()
        //Target de ação feito quando o texto dos textfields é editado
        txtvReais.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        txtvAmigos.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupIdioma()
    
        
    }
    //Função chamada quando o botão de TTS é apertado
    @IBAction func ttsPressed(_ sender: Any) {
        //ttsSpeech recebe o texto da label de resultado e o fala
        let ttsSpeech = AVSpeechUtterance(string: labelResult.text!)
        
            ttsSpeech.voice = AVSpeechSynthesisVoice(language: idiomaStr)
        
        tts.speak(ttsSpeech)
    }
    func setupIdioma(){
        
    }
    @IBAction func mudarIdioma(_ sender: Any) {
        if(idiomaStr == "en-us"){
            labelTitle.text = "Vamos Rachar!"
            btnLanguage.setTitle("EN-US", for: UIControl.State.normal)
            idiomaStr = "pt-br"
            return
        }
        if (idiomaStr == "pt-br"){
            labelTitle.text = "Let's Split!"
            btnLanguage.setTitle("PT-BR", for: UIControl.State.normal)
            idiomaStr = "en-us"
            return
        }
        
    }
    //Função chamada quando o botão de Share é apertado
    @IBAction func sharePressed(_ sender: Any) {
        //O activityVC pega o texto atual da label de resultado e envia pra compartilhamento
        let activityVC = UIActivityViewController(activityItems: [labelResult.text!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        //A apresentação da view de compartilhamento do sistema
        self.present(activityVC, animated: true, completion: nil)
    }
    //Função chamada quando o textfield dos valores é alterado
    @objc func textFieldChanged(){
        //Verificação de preenchimento dos campos pra impedir tentativas de divisão por zero
        if (txtvReais.text!.isEmpty || txtvAmigos.text!.isEmpty){
            print("Um dos campos está vazio")
        }
        else{
            //Typecast dos campos para Float e realização do cálculo
            var amigos = Float(txtvAmigos.text!)
            var reais = Float(txtvReais.text!)
            var result = reais!/amigos!
            print(amigos,reais,result)
            labelResult.text = String(result)
        }
        
        
    }
}

