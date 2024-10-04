-- Carregando a biblioteca Fluent
print("Carregando Fluent...")
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Player3030/teste/refs/heads/main/main.lua"))()
if not Fluent then
    error("Falha ao carregar Fluent.")
end
print("Fluent carregado.")

-- Carregando o SaveManager
print("Carregando SaveManager...")
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Player3030/teste/refs/heads/main/Addons/SaveManager.lua"))()
if not SaveManager then
    error("Falha ao carregar SaveManager.")
end
print("SaveManager carregado.")

-- Carregando o InterfaceManager
print("Carregando InterfaceManager...")
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Player3030/teste/main/Addons/InterfaceManager.lua"))()
if not InterfaceManager then
    error("Falha ao carregar InterfaceManager.")
end
print("InterfaceManager carregado.")

-- Criando a janela da interface
local Window = Fluent:CreateWindow({
    Title = "Fluent " .. Fluent.Version,
    SubTitle = "by dawid",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- O desfoque pode ser detectável, desativar se necessário
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Usado quando não há tecla de minimizar
})

-- Adicionando abas
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- Notificação inicial
Fluent:Notify({
    Title = "Notificação",
    Content = "Esta é uma notificação",
    SubContent = "SubConteúdo", -- Opcional
    Duration = 5 -- Defina como nil para não fazer a notificação desaparecer
})

-- Adicionando elementos na aba Principal
Tabs.Main:AddParagraph({
    Title = "Parágrafo",
    Content = "Este é um parágrafo.\nSegunda linha!"
})

Tabs.Main:AddButton({
    Title = "Botão",
    Description = "Botão muito importante",
    Callback = function()
        Window:Dialog({
            Title = "Título",
            Content = "Este é um diálogo",
            Buttons = {
                {
                    Title = "Confirmar",
                    Callback = function()
                        print("Diálogo confirmado.")
                    end
                },
                {
                    Title = "Cancelar",
                    Callback = function()
                        print("Diálogo cancelado.")
                    end
                }
            }
        })
    end
})

local Toggle = Tabs.Main:AddToggle("MyToggle", { Title = "Alternar", Default = false })

Toggle:OnChanged(function()
    print("Alternar alterado:", Options.MyToggle.Value)
end)

Options.MyToggle:SetValue(false)

local Slider = Tabs.Main:AddSlider("Slider", {
    Title = "Deslizante",
    Description = "Este é um deslizante",
    Default = 2,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Callback = function(Value)
        print("Deslizante alterado:", Value)
    end
})

Slider:OnChanged(function(Value)
    print("Deslizante mudou:", Value)
end)

Slider:SetValue(3)

local Dropdown = Tabs.Main:AddDropdown("Dropdown", {
    Title = "Dropdown",
    Values = {"um", "dois", "três", "quatro", "cinco", "seis", "sete", "oito", "nove", "dez", "onze", "doze", "treze", "quatorze"},
    Multi = false,
    Default = 1,
})

Dropdown:SetValue("quatro")

Dropdown:OnChanged(function(Value)
    print("Dropdown alterado:", Value)
end)

local MultiDropdown = Tabs.Main:AddDropdown("MultiDropdown", {
    Title = "Dropdown Múltiplo",
    Description = "Você pode selecionar múltiplos valores.",
    Values = {"um", "dois", "três", "quatro", "cinco", "seis", "sete", "oito", "nove", "dez", "onze", "doze", "treze", "quatorze"},
    Multi = true,
    Default = {"sete", "doze"},
})

MultiDropdown:SetValue({
    três = true,
    cinco = true,
    sete = false
})

MultiDropdown:OnChanged(function(Value)
    local Values = {}
    for Value, State in next, Value do
        table.insert(Values, Value)
    end
    print("Dropdown múltiplo alterado:", table.concat(Values, ", "))
end)

local Colorpicker = Tabs.Main:AddColorpicker("Colorpicker", {
    Title = "Selecionador de Cores",
    Default = Color3.fromRGB(96, 205, 255)
})

Colorpicker:OnChanged(function()
    print("Selecionador de cores alterado:", Colorpicker.Value)
end)

Colorpicker:SetValueRGB(Color3.fromRGB(0, 255, 140))

local TColorpicker = Tabs.Main:AddColorpicker("TColorpicker", {
    Title = "Selecionador de Cores com Transparência",
    Description = "mas você pode alterar a transparência.",
    Transparency = 0,
    Default = Color3.fromRGB(96, 205, 255)
})

TColorpicker:OnChanged(function()
    print("TColorpicker alterado:", TColorpicker.Value, "Transparência:", TColorpicker.Transparency)
end)

local Keybind = Tabs.Main:AddKeybind("Keybind", {
    Title = "Tecla de Atalho",
    Mode = "Toggle", -- Sempre, Alternar, Segurar
    Default = "LeftControl", -- String como o nome do atalho (MB1, MB2 para botões do mouse)

    Callback = function(Value)
        print("Tecla de atalho clicada!", Value)
    end,

    ChangedCallback = function(New)
        print("Tecla de atalho alterada!", New)
    end
})

Keybind:OnClick(function()
    print("Tecla de atalho clicada:", Keybind:GetState())
end)

Keybind:OnChanged(function()
    print("Tecla de atalho alterada:", Keybind.Value)
end)

-- Loop para verificar se a tecla de atalho está pressionada
task.spawn(function()
    while true do
        wait(1)
        local state = Keybind:GetState()
        if state then
            print("Tecla de atalho está sendo pressionada")
        end
        if Fluent.Unloaded then break end
    end
end)

Keybind:SetValue("MB2", "Toggle") -- Define atalho para MB2, modo para Segurar

local Input = Tabs.Main:AddInput("Input", {
    Title = "Entrada",
    Default = "Padrão",
    Placeholder = "Placeholder",
    Numeric = false, -- Permite apenas números
    Finished = false, -- Chama callback apenas quando pressionar enter
    Callback = function(Value)
        print("Entrada alterada:", Value)
    end
})

Input:OnChanged(function()
    print("Entrada atualizada:", Input.Value)
end)

-- Configuração dos Addons
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "O script foi carregado.",
    Duration = 8
})

-- Carregar configurações automaticamente
SaveManager:LoadAutoloadConfig()
