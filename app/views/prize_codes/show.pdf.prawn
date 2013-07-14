pdf.text "CUPOM DE RESGATE DE PRÊMIO", :size => 30, :style => :bold

pdf.text "Nome de prêmio: #{@prize_code.prize.prize_name}"

pdf.text "Oferecido por: #{@prize.user.full_name}"
pdf.text "Resgatado por: #{@prize_code.user.full_name}"

pdf.text "Cupom: #{@prize_code.code}", :style => :bold
pdf.text "Eu, #{@prize_code.user.display_name}, portador do celular número #{@prize_code.user.phone_number}, participante do site Dengue Torpedo, com perfil na página http://denguetorpedo.com/users/12, solicito o resgate do prêmio acima."
    
pdf.text "Para retirar o seu prêmio compareça ao estabelecimento de porte desse cupom e de um documento válido com foto (ex. RG). Você pode tirar fotos do momento do resgate do prêmio e publicar no seu blog no site Dengue Torpedo.  Assim, você acumula mais 5 pontos. Em caso de dúvida escreva para contato@denguetorpedo.com"

pdf.text "Prazo: O cupom é válido em até 7 dias após a impressão."

pdf.text "Endereço: #{@prize.user.house.location.complete_address}"