# CSTV
O CSTV é um APP de partidas de CS:GO de diversos torneios do mundo.

- O APP mostra todas as partidas de CS:GO a partir do dia atual, além de mostrar telas de detalhe das partida como: times, jogadores e horário.
- O APP possui 3 telas: Splash Screen, Tela principal (lista das partidas) e Tela de detalhes da partida.

## Detalhes sobre a implementação

O projeto foi implementado utilizando a arquitetura <pre>MVVM</pre> sem nehuma camada de navegação, como <pre>Router</pre> ou <pre>Coordinator</pre>, mas seria de fácil adoção de qualqur uma das soluções pois foi implementado <pre>Factories</pre> para criação das Viewcontrollers o que facilitaria na criação da nova camada.

Infelizmente devido ao tempo e a não adoção da técnica de TDD, não foram implementados testes no projeto 😔


## Screen Shots

### iPhone SE (3rd generation)

| <img src="https://user-images.githubusercontent.com/13156884/203861568-e94be8d7-c060-4b22-b9f8-b9bf708c6651.png" width=250 heigt=500/> | <img src="https://user-images.githubusercontent.com/13156884/203861589-c228b743-925a-4afd-aca2-22e26c48989d.png" width=250 heigt=500/> | <img src="https://user-images.githubusercontent.com/13156884/203861610-fec9cef9-589e-4b3b-87b8-e07103298b28.png" width=250 heigt=500/>

### iPhone 14 Pro

| <img src="https://user-images.githubusercontent.com/13156884/203862537-acde6718-0a1b-4951-9e78-60f92f454ff5.png" width=250 heigt=500/> | <img src="https://user-images.githubusercontent.com/13156884/203862554-90fd30de-9399-4e42-ad76-06bd4e82a11a.png" width=250 heigt=500/> | <img src="https://user-images.githubusercontent.com/13156884/203862571-5cce3f3f-6145-4d29-81a9-926d4f68bfd2.png" width=250 heigt=500/>

## Instruções do Build

<pre>
- Para clone via HTTPS: 
$ git clone https://github.com/ThiagoSantiago/CSTV.git

- Para clone via SSH: 
$ git clone git@github.com:ThiagoSantiago/CSTV.git

$ cd CSTV
$ cd CSTV
$ open CSTV.xcodeproj  
</pre>

Agora é só rodar o projeto! 🤓

