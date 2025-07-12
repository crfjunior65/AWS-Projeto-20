# Diagrama - Arquitetura e Documentação Visual

## Contexto do Diretório

Este diretório contém todos os diagramas de arquitetura, fluxos de processo e documentação visual do projeto AWS-Projeto-20. Os diagramas servem como referência visual para entender a arquitetura da solução, fluxos de dados e relacionamentos entre componentes da infraestrutura AWS.

### Finalidade Principal
- Documentar visualmente a arquitetura da solução
- Facilitar o entendimento da infraestrutura AWS
- Servir como referência para implementação
- Apoiar apresentações e documentação técnica

### Relação com Outros Componentes
- **Terraform**: Implementa a arquitetura documentada nos diagramas
- **Entrega**: Diagramas utilizados nas propostas e apresentações
- **Docker**: Mostra como os containers se integram na arquitetura
- **GLPI**: Ilustra o posicionamento da aplicação na infraestrutura

### Tecnologias/Linguagens Principais
- **Draw.io** - Ferramenta de diagramação
- **Lucidchart** - Diagramas colaborativos
- **AWS Architecture Icons** - Ícones oficiais da AWS
- **Visio** - Diagramas técnicos
- **PlantUML** - Diagramas como código

## Estrutura de Arquivos

```
Diagrama/
├── Diagrama-G6-P20-v3.drawio          # Versão final da arquitetura
├── Diagrama-G6-P20-v2.drawio          # Versão intermediária
├── Diagrama-G6-P20-v1.drawio          # Versão inicial
├── Diagrama-G6-P20-v3.png             # Exportação em PNG (v3)
├── Diagrama-G6-P20-v3.pdf             # Exportação em PDF (v3)
├── Diagrama-G6-P20-v3.jpg             # Exportação em JPG (v3)
├── Diagrama-G6-P20-v3.webp            # Exportação em WebP (v3)
├── Diagrama-G6-P20-v3.html            # Versão interativa HTML
└── infrastrucutre.drawio              # Diagrama de infraestrutura detalhado
```

## Fluxo de Trabalho

### 1. Criação de Diagramas
```
Requisitos → Rascunho → Revisão → Refinamento → Versão Final
```

### 2. Processo de Versionamento
- v1: Conceito inicial e componentes básicos
- v2: Refinamento com feedback da equipe
- v3: Versão final com todos os detalhes

### 3. Exportação para Múltiplos Formatos
```bash
# Exportar do Draw.io
File → Export as → [PNG/PDF/JPG/HTML]

# Otimizar para diferentes usos
- PNG: Documentação técnica
- PDF: Propostas formais
- JPG: Apresentações
- HTML: Versão interativa
```

## Configuração

### Ferramentas Recomendadas
- **Draw.io** (app.diagrams.net) - Principal
- **Lucidchart** - Colaboração
- **AWS Architecture Center** - Referências
- **Visio** - Diagramas técnicos avançados

### Padrões de Diagramação
- **Cores**: Paleta AWS oficial
- **Ícones**: AWS Architecture Icons
- **Fontes**: Arial ou Helvetica
- **Tamanhos**: Legíveis em diferentes escalas
- **Layout**: Fluxo da esquerda para direita

### Configurações do Draw.io
```json
{
  "grid": true,
  "gridSize": 10,
  "guides": true,
  "tooltips": true,
  "connect": true,
  "arrows": true,
  "fold": true,
  "page": "A4",
  "pageScale": 1,
  "pageFormat": "A4"
}
```

## Boas Práticas

### 1. Consistência Visual
- Usar ícones oficiais da AWS
- Manter paleta de cores consistente
- Padronizar tamanhos e espaçamentos
- Usar nomenclatura clara e consistente

### 2. Clareza e Legibilidade
- Evitar sobreposição de elementos
- Usar cores contrastantes
- Incluir legendas quando necessário
- Manter texto legível em diferentes tamanhos

### 3. Organização Lógica
- Agrupar componentes relacionados
- Mostrar fluxo de dados claramente
- Separar camadas (apresentação, aplicação, dados)
- Indicar conexões e dependências

### 4. Versionamento
- Nomear arquivos com versão e data
- Manter histórico de versões
- Documentar mudanças principais
- Exportar em múltiplos formatos

## Diagramas Principais

### Diagrama de Arquitetura v3 (Final)
**Arquivo**: `Diagrama-G6-P20-v3.drawio`

**Componentes Principais**:
- **Internet Gateway**: Entrada da internet
- **Application Load Balancer**: Distribuição de carga
- **ECS Cluster**: Orquestração de containers
- **RDS MySQL**: Banco de dados gerenciado
- **EFS**: Sistema de arquivos compartilhado
- **S3**: Armazenamento de objetos
- **CloudFront**: CDN global
- **Route 53**: DNS gerenciado
- **VPC**: Rede virtual privada

**Fluxos Representados**:
1. **Usuário → CloudFront → ALB → ECS**
2. **ECS → RDS** (dados da aplicação)
3. **ECS → EFS** (arquivos compartilhados)
4. **ECS → S3** (backups e logs)

### Diagrama de Infraestrutura Detalhado
**Arquivo**: `infrastrucutre.drawio`

**Detalhamentos**:
- Subnets públicas e privadas
- Security Groups e NACLs
- Auto Scaling Groups
- Monitoring e Logging
- Backup e Disaster Recovery

## Evolução dos Diagramas

### Versão 1 (v1)
- **Foco**: Componentes básicos
- **Elementos**: EC2, RDS, S3
- **Limitações**: Arquitetura simples, sem alta disponibilidade

### Versão 2 (v2)
- **Melhorias**: Adição de Load Balancer e Auto Scaling
- **Elementos**: ALB, ECS, CloudFront
- **Refinamentos**: Múltiplas AZs, redundância

### Versão 3 (v3) - Final
- **Completude**: Arquitetura completa e otimizada
- **Elementos**: Todos os serviços AWS necessários
- **Detalhes**: Security Groups, monitoramento, backup

## Especificações Técnicas

### Componentes AWS Documentados

#### Rede e Conectividade
- **VPC**: 10.20.0.0/16
- **Subnets Públicas**: 10.20.101.0/24, 10.20.102.0/24, 10.20.103.0/24
- **Subnets Privadas**: 10.20.201.0/24, 10.20.202.0/24, 10.20.203.0/24
- **Subnets Database**: 10.20.21.0/24, 10.20.22.0/24, 10.20.23.0/24

#### Computação
- **ECS Cluster**: Fargate e EC2
- **Auto Scaling**: Min: 2, Max: 10, Desired: 3
- **Load Balancer**: Application Load Balancer

#### Armazenamento
- **RDS**: MySQL 8.0, Multi-AZ
- **EFS**: General Purpose, Encrypted
- **S3**: Standard, Versioning enabled

#### Segurança
- **Security Groups**: Regras específicas por camada
- **IAM Roles**: Least privilege principle
- **Encryption**: Em trânsito e repouso

## Comandos Úteis

### Exportação de Diagramas
```bash
# Exportar PNG de alta qualidade
File → Export as → PNG → Scale: 200% → Transparent: Yes

# Exportar PDF para documentação
File → Export as → PDF → Include: All pages

# Exportar HTML interativo
File → Export as → HTML → Include: Links and tooltips
```

### Validação de Diagramas
- Verificar se todos os componentes estão conectados
- Validar fluxos de dados
- Confirmar nomenclatura consistente
- Testar legibilidade em diferentes tamanhos

## Integração com Documentação

### Uso nas Propostas
- Diagrama principal na proposta técnica
- Versões simplificadas para executivos
- Detalhamentos técnicos para implementação

### Uso nas Apresentações
- Slides com diagramas de alto nível
- Animações para mostrar fluxos
- Versões focadas em benefícios

### Uso na Implementação
- Referência para configuração do Terraform
- Guia para deployment
- Validação da arquitetura implementada

## Métricas e Validação

### Critérios de Qualidade
- **Completude**: Todos os componentes representados
- **Precisão**: Correspondência com implementação real
- **Clareza**: Fácil entendimento por diferentes públicos
- **Consistência**: Padrões visuais mantidos

### Feedback Recebido
- Arquitetura bem estruturada
- Diagramas claros e profissionais
- Boa evolução entre versões
- Adequação aos padrões AWS

## Troubleshooting

### Problemas Comuns
1. **Arquivo não abre**: Verificar versão do Draw.io
2. **Exportação com qualidade baixa**: Ajustar configurações de DPI
3. **Elementos desalinhados**: Usar grid e guias
4. **Cores inconsistentes**: Usar paleta de cores salva

### Soluções
- Manter backup dos arquivos .drawio
- Usar versões estáveis do Draw.io
- Exportar em múltiplos formatos
- Validar visualização em diferentes dispositivos

## Próximos Passos

### Melhorias Futuras
- Diagramas de sequência para fluxos complexos
- Diagramas de deployment detalhados
- Documentação de disaster recovery
- Diagramas de monitoramento e alertas

### Manutenção
- Atualizar diagramas conforme mudanças na arquitetura
- Manter sincronização com implementação
- Revisar periodicamente para otimizações
- Documentar novas versões adequadamente

## Contatos e Suporte

Para dúvidas sobre os diagramas:
- **Equipe**: Grupo 6 - Projeto 20
- **Ferramenta**: Draw.io (app.diagrams.net)
- **Referência**: AWS Architecture Center
- **Padrões**: AWS Well-Architected Framework
