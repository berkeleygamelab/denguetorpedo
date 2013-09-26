pdf.text "CUPOM DE RESGATE DE PRÊMIO", :size => 30, :style => :bold

pdf.text "Nome de prêmio: #{@prize_code.prize.prize_name}", :style => :bold
pdf.move_down(10)
pdf.image @prize_code.prize.prize_photo.path, width: 200, height: 200

pdf.move_down(20)

pdf.text "Oferecido por: #{@prize.user.house.name}"
pdf.text "Resgatado por: #{@prize_code.user.full_name}"

pdf.move_down(10)

pdf.text "Cupom: #{@prize_code.code}", :style => :bold

pdf.move_down(10)
pdf.text "Eu, #{@prize_code.user.display_name}, portador do celular número #{@prize_code.user.phone_number}, participante do site Dengue Torpedo, com perfil na página http://denguetorpedo.com/users/12, solicito o resgate do prêmio acima."
    
pdf.text "Para retirar o seu prêmio compareça ao estabelecimento de porte desse cupom e de um documento válido com foto (ex. RG)"

pdf.move_down(10)
pdf.text "Resgate até: O cupom é válido em até 7 dias após a impressão. (até #{@deadline.strftime("%d/%m/%Y")})"

pdf.text "Endereço: #{@prize.user.house.location.complete_address}"