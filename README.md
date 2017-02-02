
SISTEMA DE GERENCIAMENTO DE EVENTOS

Feito em Java + Postgresql + Bootstrap + JavaScript

DESCRIÇÃO GERAL
Devem existir 3 papéis de usuários: administrador, membro e participante.

Um participante pode cadastrar-se a qualquer momento. Guarda-se dos participantes o id, login, nome completo, foto, cpf (opcional), rg (opcional), nome para o crachá, e-mail, endereço (logradouro e complemento, bairro, cep, cidade e estado), telefones (tipo -- residencial, comercial, celular ou recado --, DDD e número), data de nascimento, estado civil, escolaridade, profissão, instituição de origem, como ficou sabendo do evento e um campo descritivo informando se estará participando do evento juntamente com alguma outra pessoa. A conta pode ser local ou utilizando o OAuth, tendo como padrão a opção de autenticação via Facebook, obtendo-se os dados básicos a partir do OAuth e complementando-se manualmente o cadastro. O cadastramento de endereços preferencialmente deverá buscar dados do serviço web 'Busca CEP' dos Correios.

A função do administrador é gerenciar usuários, podendo criar, modificar ou excluir usuários e atribuir papéis a usuários do sistema. O administrador pode transformar um usuário participante em membro ou administrador. Se um administrador cadastra um usuário, a conta fica sendo do tipo local. Os papéis são cumulativos, isto é, um membro é um participante e um administrador é um membro, tendo acesso às respectivas interfaces.

Um usuário do tipo membro pode criar, modificar e excluir eventos. Dos eventos, guarda-se título, descrição, informações importantes e entidade promotora. Um evento pode ter várias edições, sendo que cada uma possui um local, período, preço e formas de pagamento disponíveis, escolhidas de uma lista (dinheiro ou cheque à vista, cheque em 2x, etc.). De uma entidade promotora guarda-se o nome e descrição e deve poder ser selecionada a partir de uma lista, podendo ser cadastrada a qualquer momento. O local deve poder ser escolhido a partir de uma lista de opções, podendo ser incluído um novo local a qualquer momento, fornecendo-se o nome do local, endereço, telefone (opcional) e coordenadas geográficas (opcional). O período pode ser: (i) único, contendo data e horário de início e de término, (ii) múltiplo, isto é, é formado por vários períodos (cada um com data e horário de início e término) ou (iii) periódico, tem data de início e de término, dia(s) da semana e horário de início e término. Por padrão, ao criar-se um evento, as inscrições estão bloqueadas, devendo existir uma funcionalidade para que um membro abra as inscrições a qualquer momento. As inscrições são encerradas automaticamente após o início do evento, podendo ser encerradas manualmente a qualquer momento.

Os eventos que estão com as inscrições abertas devem aparecer listados na página principal do sistema. Qualquer pessoa pode ver as informações de eventos, mas apenas usuários logados podem inscrever-se. Após inscrever-se, a situação da inscrição fica no status pendente, até que um usuário do tipo membro altere a inscrição para o status confirmada. Após ser confirmada, o sistema deve abrir uma opção de pagamento, informando-se o valor da inscrição do evento, o valor de fato pago (pode haver desconto) e a forma de pagamento escolhida pelo participante, e também uma opção de comparecimento (um checkbox para indicar se a pessoa compareceu ou não, para cada período do evento). Não é necessário nenhum tipo de pagamento automatizado (cartão de crédito, geração de boleto, etc.), trata-se de um cadastramento simples. O sistema deve permitir a emissão de recibo para inscrições pagas, quando solicitado por um usuário do tipo membro.

O sistema deve apresentar um conjunto de estatísticas, calculadas a partir dos dados armazenados.

INTERFACES

Visitante:
- Lista de eventos com inscrições abertas, sem opção de inscrição - OK
- Opção para criação de conta - OK
- Opção para login - OK

Participante (logado):
- Lista de eventos com inscrições abertas, com opção de inscrição - OK
- Lista de eventos nos quais fez inscrição, incluindo-se eventos passados com status (confirmação, pagamento e comparecimento)
  - Para eventos ativos (i.e., que ainda não foram realizados), deve-se permitir cancelar a inscrição ou alterar a opção de pagamento
- Opção para alteração de dados pessoais - OK
- Opção para logout - OK

Membro:
- Cadastros "gerais": de entidades promotoras, formas de pagamento, locais de eventos e outros - OK
- Cadastro de eventos
  - Lista de todos os eventos, indicando o título, entidade promotora, período e status (ativo/passado) - OK 
  - Opções de busca por: título, entidade promotora e período - OK
  - Opções de alteração de evento e cadastramento de novo evento - OK
- Cadastro de usuários
  - Lista de todos os participantes/membros cadastrados no sistema - OK
  - Opção para modificação de cadastro de participantes/membros, incluindo um campo de observações (não visível ao usuário)
  - Opção de criação de usuário participante - OK
- Gerenciamento de evento
  - Opção para alteração dos dados do evento - ok
  - Lista de participantes no evento (data de inscrição, nome e status, com opção de ordenação por qualquer um desses campos) - ok
    - Nome do usuário deve ser link para cadastro do usuário - ok
  - Opções para inscrever partipante no evento, confirmar inscrição efetuada ou cancelar a inscrição - ok 
  - Opção para importar inscrições em bloco de outro evento
  - Opções para registrar pagamento - OK
-  emitir recibo e registrar comparecimento de participantes
  - Opção de "imprimir" lista de inscritos, com escolha de campos a incluir na listagem e campo de ordenação
  - Visualização de renda total (soma dos valores de fato pagos) - ok

- Estatísticas
  - Número de participantes em um evento específico
    - Total - ok
    - Por sexo - ok 
    - Por instituição de origem - ok

    - Por faixa etária: até 10 anos, 10-20 anos, 20-30 anos, etc. - ok
    - Por combinações de sexo e faixa etária - ok
  - Número de participantes por evento (escolhendo-se um número de eventos da lista de eventos e apresentando-se como pontos em uma linha do tempo)
    - Total - ok
    - Por sexo - ok
    - Por faixa etária: até 10 anos, 10-20 anos, 20-30 anos, etc. - ok
    - Por combinações de sexo e faixa etária - ok
    - Por instituição de origem - ok

Administrador:
- Cadastro de usuários - OK
  - Lista de todos os participantes/membros cadastrados no sistema - OK
  - Opção de conceder perfil de membro ou administrador a usuários e de retirar essa concessão - OK
