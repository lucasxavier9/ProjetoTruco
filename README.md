# Projeto de Placar de Truco

## Descrição

Este projeto implementa um placar de truco em uma FPGA utilizando SystemVerilog, dividido em duas abordagens principais:

### 1. Abordagem Estrutural e Combinacional

A abordagem estrutural e combinacional usa módulos básicos, como somadores, comparadores e registradores para gerenciar a pontuação e os tentos. A lógica é organizada em módulos interconectados, cada um realizando uma função específica.

### 2. Projeto RTL

Na abordagem RTL (Register Transfer Level), a lógica é descrita em um nível mais abstrato, utilizando um datapath para gerenciar os dados e um controlador baseado em máquina de estados para coordenar o fluxo do jogo. Isso permite uma integração mais eficiente e uma descrição mais compacta do comportamento do sistema.

## Funcionamento

O sistema controla a pontuação e os tentos das duplas em um jogo de truco e exibe os resultados em displays de sete segmentos. Ele utiliza entradas de botões para incrementar a pontuação e realizar a contagem de tentos, com lógica para determinar quando o jogo termina e realizar o reset dos valores.

## Como Executar

1. **Configuração do Ambiente:**
   - Instale o Quartus Prime para compilação e síntese do projeto.
   - Instale o ModelSim para simulação.

2. **Compilação e Simulação:**
   - Abra o projeto no Quartus Prime e compile o design.
   - Utilize o ModelSim para simular e verificar o funcionamento do projeto.
   - Programe a FPGA com o arquivo compilado gerado pelo Quartus Prime.

## Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
