# ws_cars

Teste técnico.

O objetivo é fazer um aplicativo que liste carros vindos de uma api, dando a opção do usuário demonstrar interesse no carro.
Quando um interesse é demonstardo ele é salvo localmente. Um serviço realiza o envio de todos os interesses registrados de tempos em tempos, em um intervalo pré definido.

## Escolhas técnica

A ideia foi organizar o projeto em uma arquitetura simples porém escálavel, da forma como eu gostaria de fazer um projeto de porte pequeno.

Ele é divido da seguinte forma :

- Core: Responsável pelos componentes de uso geral no app
- Infra: Camada onde é feita a abstração de fontes de dados, como banco de dados locais, serviços http, etc.
- Repositories: Responsável por tratar os dados, cuidando do envio e busca de dados.
- Presentation: Responsável por exibir dados para o usuário.

A escolha dos packages e do gerenciamento de estados foram feitos baseada na simplicidade dos packages e familiaridade do desenvolvedor com os mesmos.

## Rodando o app

Para rodar o app o seguinte comando é necessário:

- flutter run --dart-define=API_BASE_URL=URL DA API
