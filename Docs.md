# TPSLib | Demo 0.1V
---
## O que e TPSLib? 

**TPSLIB** e uma interface gráfica do Roblox feita para hubs e interfaces dentro da plataforma, feita para novas interfaces em jogos com anti-cheat

---
## Como instalar?
Para instalar o TpsLib você vai usar o loadstring de instalação da source do TPSLib.lua no seu código
```lua
local TPSLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/legalgal380/TPSLib/refs/heads/main/TPSLib.lua"))()

```

Assim você vai conseguir utilizar as funções com o pacote instalado 
## Como criar uma janela?
Para você usar agora a janela no pacote você irá utilizar a função de criar a janela
```lua
local win = TPSLib:Window({
    Name = "Preview da Lib",
    TopbarTheme = "azul", 
    WindowTheme = "Neon"
})
```
Assim você agora irá poder usar elementos na janela
### Tabela de valores 

| Name:       | TopbarTheme                         | WindowTheme             |
| ----------- | ----------------------------------- | ----------------------- |
| string      | string                              | string                  |
| qualquer um | vermelho, azul, roxo, amarelo e etc | Neon, Dark, Light e etc |
## Elementos
O único elemento disponível até **AGORA**
e o botão
```lua
win:Button("Meu Botão", "verde", function()
    print("Botão clicado!")
end)
```

E isso divertisse!
