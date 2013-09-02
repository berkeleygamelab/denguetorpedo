#!/bin/env ruby
# encoding: utf-8

class EliminationMethods
  @elimination_types = [
    "Pratinho de planta",
    "Pneu",
    "Lixo (recipientes inutilizados)",
    "Pequenos Recipientes utilizáveis",
    "Caixa d'água aberta na residência",
    "Grandes Recipientes Utilizáveis",
    "Calha",
    "Registros abertos",
    "Laje e terraços com água",
    "Piscinas",
    "Poças d’água na rua",
    "Ralos",
    "Plantas ornamentais que acumulam água (ex: bromélias)", 
    "Outro tipo"
  ]
  @elimination_field_select = [
    ["Pratinho de planta", 
      ["Elimine fazendo furos no pratinho", 
        "Prato removido (ou seja, não mais utilizado)", 
        "Coloque areia", 
        "Retire a água e esfregue para remover possíveis ovos (uma vez por semana)"]],
    ["Pneu", 
      ["Desfaça-se do pneu (entregue ao serviço de limpeza)",
        "Arranje um uso alternativo para o pneu: preencha com terra e faça uma horta; preencha com areia, terra e cimento e utilize como degrau", 
        "Transferir o pneu sem água para um local coberto e seco",
        "Cubra o pneu com algo que não se transforme em um foco potencial do mosquito"]],
    ["Lixo (recipientes inutilizados)", 
      ["Jogá-los em uma lixeira bem tampada",
        "Organize um mutirão de limpeza na vizinhança (coordenado pelos Agentes de Vigilância Sanitária)"]],
    ["Pequenos Recipientes utilizáveis", 
      ["Remova a água e esfregue uma vez por semana; ou, no caso de bebedouros de animais e aves, trocar a água e limpar diariamente",
        "Virar de cabeça para baixo, secar e armazenar"]],
    ["Grandes Recipientes Utilizáveis", 
      ["Cobrir a caixa d’água:  cobrir adequadamente com capa apropriada",
        "Outros recipientes: esfregue, seque, cubra ou sele"]],
    ["Calha", 
      ["Desentupir e limpar"]],
    ["Registros abertos", 
      ["Sele com cobertura impermeável para prevenir a penetração da água e ainda ter acesso ao registro",
        "Preencha com areia ou terra e mude o acesso à válvula"]],
    ["Laje e terraços com água", 
      ["Limpá-las"]],
    ["Piscinas", 
      ["Piscinas em uso: esfregue e limpe uma vez por semana",
        "Piscinas que não estão em uso: esfregue, seque e vire ao contrário"]],
    ["Poças d’água na rua", 
      ["Seque e preenche com areia ou terra",
        "Comunique as poças grandes aos AVS para o tratamento com veneno"]],
    ["Ralos", 
      ["Jogue água sanitária ou desinfetante semanalmente",
        "Elimine entupimento",
        "Vede ralos não utilizados"]],
    ["Plantas ornamentais que acumulam água (ex: bromélias)", 
      ["Regar semanalmente com água sanitária na proporção de uma colher de sopa para um litro de água",
        "Retire a  água acumulada nas folhas"]]
  ]
  
  def self.field_select
    @elimination_field_select
  end

  def self.types
    @elimination_types
  end
  
  def self.prantinho
    @prantinho = {"Elimine fazendo furos no pratinho" => "Elimine fazendo furos no pratinho (200 pontos)", 
        "Prato removido (ou seja, não mais utilizado)" => "Prato removido (ou seja, não mais utilizado, 200 pontos)", 
        "Coloque areia" => "Coloque areia (100 pontos)", 
        "Retire a água e esfregue para remover possíveis ovos (uma vez por semana)" => "Retire a água e esfregue para remover possíveis ovos (uma vez por semana, 50 pontos)",
        "Outro método" => "Outro método" 
  }
  end


  def self.pneu
    @pneu = {"Desfaça-se do pneu (entregue ao serviço de limpeza)" => "Desfaça-se do pneu (entregue ao serviço de limpeza, 50 pontos)",
          "Arranje um uso alternativo para o pneu: preencha com terra e faça uma horta; preencha com areia, terra e cimento e utilize como degrau" => "Arranje um uso alternativo para o pneu: preencha com terra e faça uma horta; preencha com areia, terra e cimento e utilize como degrau (450 pontos)", 
          "Transferir o pneu sem água para um local coberto e seco" => "Transferir o pneu sem água para um local coberto e seco (100 pontos)",
          "Cubra o pneu com algo que não se transforme em um foco potencial do mosquito" => "Cubra o pneu com algo que não se transforme em um foco potencial do mosquito (100 pontos)",
        "Outro método" => "Outro método"}
  end

  def self.lixo
    @lixo = {"Jogá-los em uma lixeira bem tampada" => "Jogá-los em uma lixeira bem tampada",
        "Organize um mutirão de limpeza na vizinhança (coordenado pelos Agentes de Vigilância Sanitária)" => "Organize um mutirão de limpeza na vizinhança (coordenado pelos Agentes de Vigilância Sanitária, 450 pontos)", "Participe de um mutirão de limpeza na vizinhança (coordenado pelos Agentes de Vigilância Sanitária) OBS: em locais onde não há atuação dos garis comunitários." => "Participe de um mutirão de limpeza na vizinhança (coordenado pelos Agentes de Vigilância Sanitária) OBS: em locais onde não há atuação dos garis comunitários. (350 pontos)", "Outro método" => "Outro método"}
  end

  def self.pequenos
    @pequenos = {"Remova a água e esfregue uma vez por semana; ou, no caso de bebedouros de animais e aves, trocar a água e limpar diariamente" => "Remova a água e esfregue uma vez por semana; ou, no caso de bebedouros de animais e aves, trocar a água e limpar diariamente (50 pontos)",
        "Virar de cabeça para baixo, secar e armazenar" => "Virar de cabeça para baixo, secar e armazenar (50 pontos)", "Outro método" => "Outro método"}
  end

  def self.caixa
    @caixa = {"Cobrir a caixa d’água" => "Cobrir a caixa d’água (450 pontos)", "Outro método" => "Outro método" }
  end
  def self.grandes
    @grandes = {"Vedar adequadamente com tapa e ou capa apropriada" => "Vedar adequadamente com tapa e ou capa apropriada (200 pontos)",
        "Outros recipientes: esfregue, seque, cubra ou sele" => "Outros recipientes: esfregue, seque, cubra ou sele (350 pontos)" , "Outro método" => "Outro método" }
  end

  def self.calha
    @calha = {"Desentupir e limpar" => "Desentupir e limpar (150 pontos)", "Outro método" => "Outro método"}
  end

  def self.registros
    @registros = {"Sele com cobertura impermeável para prevenir a penetração da água e ainda ter acesso ao registro" => "Sele com cobertura impermeável para prevenir a penetração da água e ainda ter acesso ao registro (300 pontos)",
        "Preencha com areia ou terra e mude o acesso à válvula" => "Preencha com areia ou terra e mude o acesso à válvula (300 pontos)", "Outro método" =>"Outro método"}
  end

  def self.laje
    @laje = {"Limpá-las" => "Limpá-las (50 pontos)", "Outro método" => "Outro método"}
  end

  def self.piscinas
    @piscinas = {"Piscinas em uso: esfregue e limpe uma vez por semana" => "Piscinas em uso: esfregue e limpe uma vez por semana (350 pontos)",
        "Piscinas que não estão em uso: esfregue, seque e vire ao contrário. Em casos de piscina de plástico desmonte e guarde." => "Piscinas que não estão em uso: esfregue, seque e vire ao contrário. Em casos de piscina de plástico desmonte e guarde (350 pontos)", "Outro método" => "Outro método"}
  end

  def self.pocas
    @pocas = {"Elimine a água com rodo ou vassoura" => "Elimine a água com rodo ou vassoura (50 pontos)", "Outro método" => "Outro método"}
  end

  def self.ralos
    @ralos = {"Jogue água sanitária ou desinfetante semenalmente." => "Jogue água sanitária ou desinfetante semenalmente (50 pontos)",
        "Elimina entupimento" => "Elimina entupimento (50 pontos)", "Vedar ralos não utilizados" => "Vede ralos não utilizados (50 pontos)", "Outro método" => "Outro método"}

  end

  def self.plantas
    @plantas = ["Regar semanalmente com água sanitária na proporção de uma colher de sopa para um litro de água" => "Regar semanalmente com água sanitária na proporção de uma colher de sopa para um litro de água (50 pontos)",
        "Retire a  água acumulada nas folhas" => "Retire a água acumulada nas folhas (50 pontos)", "Regar semanalmente com água sanitária na proporção de uma colher de sopa para um litro de água." => "Regar semanalmente com água sanitária na proporção de uma colher de sopa para um litro de água (50 pontos)", "Outro método" => "Outro método"]
  end

  def self.points
    @points = {self.prantinho[0] => 200, self.prantinho[1] => 200, self.prantinho[2] => 100, self.prantinho[3] => 50, self.pneu[0] => 50, self.pneu[1] => 450, self.pneu[2] => 100, self.pneu => 100, self.lixo[0] => 0, self.lixo[1] => 450, self.lixo[2] => 350, self.pequenos[0] => 50, self.pequenos[1] => 50, self.caixa[0] => 450, self.grandes[0] => 200, self.grandes[1] => 350, self.calha[0] => 150, self.registros[0] => 300, self.registros[1] => 300, self.laje[0] => 50, self.piscinas[0] => 350, self.piscinas[1] => 350, self.pocas[0] => 50, self.ralos[0] => 50, self.ralos[1] => 50, self.ralos[2] => 50, self.plantas[0] => 50, self.plantas[1] => 50, self.plantas[2] => 50}
  end

  def self.getEliminationTypeFromMethodSelect(method)
    @elimination_field_select.each do |elimination_category|
      elimination_category[1].each do |elimination_method|
        if (elimination_method == method)
          return elimination_category[0]
        end
      end
    end
    return ""
  end
  
end