#!/bin/env ruby
# encoding: utf-8

class EliminationMethods
  @elimination_types = [
    "Pratinho de planta",
    "Pneu",
    "Lixo (recipientes inutilizados)",
    "Pequenos Recipientes utilizáveis",
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
    @prantinho = ["Elimine fazendo furos no pratinho", 
        "Prato removido (ou seja, não mais utilizado)", 
        "Coloque areia", 
        "Retire a água e esfregue para remover possíveis ovos (uma vez por semana)",
        "Outro método"
  ]
  end


  def self.pneu
    @pneu = ["Desfaça-se do pneu (entregue ao serviço de limpeza)",
          "Arranje um uso alternativo para o pneu: preencha com terra e faça uma horta; preencha com areia, terra e cimento e utilize como degrau", 
          "Transferir o pneu sem água para um local coberto e seco",
          "Cubra o pneu com algo que não se transforme em um foco potencial do mosquito",
        "Outro método"]
  end

  def self.lixo
    @lixo = ["Jogá-los em uma lixeira bem tampada",
        "Organize um mutirão de limpeza na vizinhança (coordenado pelos Agentes de Vigilância Sanitária)", "Outro método"]
  end

  def self.pequenos
    @pequenos = ["Remova a água e esfregue uma vez por semana; ou, no caso de bebedouros de animais e aves, trocar a água e limpar diariamente",
        "Virar de cabeça para baixo, secar e armazenar", "Outro método"]
  end

  def self.grandes
    @grandes = ["Cobrir a caixa d’água:  cobrir adequadamente com capa apropriada",
        "Outros recipientes: esfregue, seque, cubra ou sele", "Outro método"]
  end

  def self.calha
    @calha = ["Desentupir e limpar", "Outro método"]
  end

  def self.registros
    @registros = ["Sele com cobertura impermeável para prevenir a penetração da água e ainda ter acesso ao registro",
        "Preencha com areia ou terra e mude o acesso à válvula", "Outro método"]
  end

  def self.laje
    @laje = ["Limpá-las", "Outro método"]
  end

  def self.piscinas
    @piscinas = ["Piscinas em uso: esfregue e limpe uma vez por semana",
        "Piscinas que não estão em uso: esfregue, seque e vire ao contrário", "Outro método"]
  end

  def self.pocas
    @pocas = ["Seque e preenche com areia ou terra",
        "Comunique as poças grandes aos AVS para o tratamento com veneno", "Outro método"]
  end

  def self.ralos
    @ralos = ["Regar semanalmente com água sanitária na proporção de uma colher de sopa para um litro de água",
        "Retire a  água acumulada nas folhas", "Outro método"]
  end

  def self.plantas
    @plantas = ["Regar semanalmente com água sanitária na proporção de uma colher de sopa para um litro de água",
        "Retire a  água acumulada nas folhas", "Outro método"]
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