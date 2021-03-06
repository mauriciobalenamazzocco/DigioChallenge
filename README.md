<img src="/Documentation/Images/logodigio.png" width="385" height="285">

## Digio Challenge

Desafio proposto para o cargo de iOS developer

## Build and Runtime Requerimentos

* Xcode 13.2.1 or later
* Swift 5

## Arquitetura e Patterns

A arquitetura escolhida foi MVVM-C, por ser uma arquitetura mais simples, robusta, utilizada em diversos projetos, apresenta separação das camadas bem definidas visando facilidade nos futuros desenvolvimentos, manutenções e testes.
Arquiteturas como VIP, VIPER são mais complexas, para devs que nunca tiveram contato com estas arquiteturas precisam passar por uma curva de aprendizagem. 
O projeto segue os principios do SOLID, com responsabilidades definidas, clean code, injeção de dependência, separação das camadas.

<img src="/Documentation/Images/architecture.png" width="700" height="301">


## Bibliotecas 

* [Kingsfisher](https://github.com/onevcat/Kingfisher) - Facilita o gerenciamento de download das imagens. Se caso não pudesse usar esta lib, pode ser utilizado o URLSession para fazer o download. Ate para testes de snapshot seria ideal que tivesse sido imagens mokadas.
* [SwiftLint](https://github.com/realm/SwiftLint) - Utilizada para manter as boas práticas e convenções de código
* [iOSSnapshotTestCase](https://github.com/uber/ios-snapshot-test-case) - Facilita os testes de UI com Snapshot

## Testes

Projeto conta atualmente com 50%+ de code coverage e testes de Snapshot

## Outros

### API

Foi criado uma camada completa da API mesmo não utilizando todos os recursos.
Como esta api não retorna um erro de business, foi apenas criado um template de exemplo (ApiErrorResponse) 

### TODO:

* Interface customizada de erro.
* Criar um framework contendo todos os Mocks para poderem ser compartilhados entre os schemes de Teste.
* [XcodeGen](https://github.com/yonaskolb/XcodeGen) - Utilizar o XcodeGen, para resolver problemas de futuros conflitos no xcodeproj e otimização do projeto


## Outro Projeto

[GitCleanSwift](https://github.com/mauriciobalenamazzocco/GitCleanSwift) - Projeto utilizando arquitetura [VIP - Clean Swift](https://clean-swift.com/clean-swift-ios-architecture/vip-cycle/). O mesmo lista os repositórios com linguagem swift do github



