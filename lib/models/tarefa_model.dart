/// Esta classe define o que é uma "Tarefa" dentro do seu sistema.
class TaskModel {
  String title; // Armazena o nome da tarefa (ex: "Comprar pão")
  bool isCompleted; // Armazena o estado: true (feito)

  // O Construtor: É usado para criar uma nova tarefa.
  // 'required this.title' obriga a dar um nome.
  // 'this.isCompleted = false' faz com que toda tarefa nova comece desmarcada.
  TaskModel({required this.title, this.isCompleted = false});

  // Método toJson: Transforma o objeto TaskModel em um Mapa (JSON).
  Map<String, dynamic> toJson() => {"title": title, "isCompleted": isCompleted};

  // Método Factory fromJson: Faz o caminho inverso.
  // Ele pega os dados salvos no celular (em formato JSON) e os transforma
  // de volta em um objeto TaskModel que o Flutter consegue exibir na tela.
  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      TaskModel(title: json["title"], isCompleted: json["isCompleted"]);
}
