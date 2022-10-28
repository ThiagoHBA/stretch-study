## PT-BR

### O que é este projeto?

Stretch Study é um projeto de estudo individual que busca utilizar boas práticas de código limpo, SOLID e arquitetura limpa. O projeto é construido utilizando o design pattern de UI MVP e testa os componentes usando teste Spies. Esse projeto se utiliza de duas APIs de aná
lise de texto, sendo esse um input do usuário. 

A primeira API se chama `Perspective` e busca analizar o gráu de toxidade contida em um texto. Mais detalhes de como funciona pode ser encontrado no link: https://perspectiveapi.com

A segunda API se chama `SENTIM` e a partir do texto enviado para a API, retorna o sentimento ele remete. Mais informações no link: https://sentim-api.herokuapp.com 

PS: A `SENTIM API` se encontra atualmente **fora do ar** e em breve ela será removida da aplicação.

### Como instalar para este projeto?

Esse projeto utiliza <a href="https://betterprogramming.pub/manage-secrets-in-your-ios-app-using-xcode-configuration-files-fbceb6e97f47">xcode configurations</a> para lidar com as chaves de API. Os passos da instalação serão detalhados a seguir:

- Faça o clone deste repositório utilizando o comando `git clone git@github.com:ThiagoHBA/stretch-study.git` no seu terminal no diretório onde deseja instalar o projeto.

- Abra o xcode na pasta onde o repositório foi instalado e adicione um novo arquivo no target da aplicação:
<img width="200" height= "350" alt="Screen Shot 2022-10-28 at 16 01 00" src="https://user-images.githubusercontent.com/56696275/198714563-050f678b-037e-46d5-bf54-db0c76b685ae.png">

- Na barra de pesquisa pesquise configurations e selecione o arquivo de tipo `Conffigurations Settings File`, clique em `Next`e nomeie o arquivo exatamente como `Configurations`:

<img width="400" alt="Screen Shot 2022-10-28 at 16 01 38"   src="https://user-images.githubusercontent.com/56696275/198715159-7fa1a77f-e2f2-4b22-a483-88ceb7952978.png"> <img width="500" alt="Screen Shot 2022-10-28 at 16 01 52" src="https://user-images.githubusercontent.com/56696275/198715375-80e414d8-efbf-4de8-821b-80f0acb80986.png">

- Após a criação do arquivo, crie uma linha de código que contém sua Perspective Api Key que deve ser gerada no link: https://perspectiveapi.com. O arquivo deverá ter a seguinte forma:

<img width="800" alt="Screen Shot 2022-10-28 at 16 02 48" src="https://user-images.githubusercontent.com/56696275/198715852-baaf6308-6323-45bf-8576-a7943bca64fa.png">

- Depois de ter o arquivo de configurações criado. Agora temos que fazer com que nosso projeto acesse esse arquivo e capture os dados contidos nele. Para isso, vamos no target do projeto, na aba `info` e definimos o arquivo de configuração como debug e release.

<img width="553" alt="Screen Shot 2022-10-28 at 16 05 19" src="https://user-images.githubusercontent.com/56696275/198716101-6f6f6fd0-63ce-473c-96f6-f151b7d069d8.png">



<img width="1389" alt="Screen Shot 2022-10-28 at 16 04 59" src="https://user-images.githubusercontent.com/56696275/198716092-41112e69-7d37-4497-9ba7-57afb67e428b.png">

Seguindo esses passos deve ser possível instalar com sucesso o repositório :)

### Tecnologias 

Este projeto possui as seguintes características:

- Swift
- UiKit
- ViewCode/AutoLayout
- APIs
- SwiftLint
- UnitTests 
- FileManager
- Spies
