# awesome-paper
Uma configuração monocromática do awesomeWM

### Menu de aplicativos nativo feito com ferramantas do awesomeWM.
<p align="center">
  <img src="https://github.com/Diego-Cesare/awesome-paper/blob/main/src/img_1.png" alt="Descrição da imagem 1" width="400" />
  <img src="https://github.com/Diego-Cesare/awesome-paper/blob/main/src/img_5.png" alt="Descrição da imagem 2" width="400" />
</p>


### Painel de informações uteis.
<p align="center">
  <img src="https://github.com/Diego-Cesare/awesome-paper/blob/main/src/img_2.png" alt="Descrição da imagem 1" width="400" />
  <img src="https://github.com/Diego-Cesare/awesome-paper/blob/main/src/img_6.png" alt="Descrição da imagem 2" width="400" />
</p>


### Widget de player de musica.
<p align="center">
  <img src="https://github.com/Diego-Cesare/awesome-paper/blob/main/src/img_3.png" alt="Descrição da imagem 1" width="400" />
  <img src="https://github.com/Diego-Cesare/awesome-paper/blob/main/src/img_7.png" alt="Descrição da imagem 2" width="400" />
</p>


### Centro de notificações
<p align="center">
  <img src="https://github.com/Diego-Cesare/awesome-paper/blob/main/src/img_4.png" alt="Descrição da imagem 1" width="400" />
  <img src="https://github.com/Diego-Cesare/awesome-paper/blob/main/src/img_8.png" alt="Descrição da imagem 2" width="400" />
</p>

### Instalação
Use a versão git do awesomeWM, se voce usa arch linux use:

	yay -S awsome-git

Se voce não é usuario de arch, então compile o pacote do github

https://github.com/awesomeWM/awesome

Clone este repositório

	git clone https://github.com/Diego-Cesare/awesome-paper.git

Copie a pasta awesome para ~/.config

	cp -r awesome-paper/awesome ~/.config

Se quiser usar os wallpapers então copie eles para a pasta de Imagens

	cp -r ~/.config/awesome/wallpapers/* ~/Imagens

Desta forma o própio widget de wallpapers do awesome ira funcionar.
Caso voce ja tenha imagens na pasta ~/Imagens, o widget ira reconhecer e exibir as imagens.

Se o caminho para suas imagens for diferente, modifique o arquivo...
	
	~/.config/awesome/widgets/wallpapers/wallpapers.lua

Troque o caminho da imagem na linha:

	local image_dir = os.getenv("HOME") .. "/Imagens"

Está customização usa algumas animações, por isso voce deve ter o *rubato instalado*

	sudo pacman -S luarocks
	sudo luarocks install rubato

Clone o repositóri *rubato* dentro da pasta ~/awesome/modules
Se a pasta *rubato* ja existir, remova ela e clone a nova

	git clone https://github.com/andOrlando/rubato.git

## Informações
#### Painel:
***Modulos da esquerda***

- Lançador de aplicativos (Menu) **use Super+M**.
- Painel de informações.
- Alternar entre tema **claro** e **escuro**.
- Areas de trabalho virtuais.
- Task List, com janelas abertas.

***Modulos da direita***

- Widget que alterna a cada 10 segundos, mostrando o clima e informações do ususario.
- Widget que pode ser alternado usando o click direito do mouse.
- Systemtray e modo flutuante do painel.

#### Aplicativos usados:

	Aplicativo						Atalho do teclado

	- Terminal:		Alacritty		(Super+Return)
	- Browser:		Google chrome		(Super+c)
	- Editor		VsCode			(Super+v)
	- Arquivos		Nemo			(Super+n)
	- Chat			Telegram		(Super+t)
     