# AWS Lab - Infraestrutura com Terraform

Este projeto contém a infraestrutura como código (IaC) para provisionar uma aplicação utilizando **AWS** e **Terraform**. Ele cobre a criação de recursos como ECS (Elastic Container Service), ALB (Application Load Balancer), VPC, subnets e demais configurações necessárias para o funcionamento da aplicação.

---

## 📋 Funcionalidades

- Configuração de uma **VPC** com subnets públicas.
- Criação de um **ALB** com regras de roteamento.
- Configuração do **ECS** com Fargate para execução de containers.
- Integração com **Amazon ECR** para armazenamento de imagens Docker.
- Configuração de grupos de segurança (**Security Groups**) para controle de acesso.
- Configuração de networking com **Internet Gateway** e rotas apropriadas.

---

## 🛠️ Pré-requisitos

- **AWS CLI** configurado com credenciais válidas.
- **Terraform** instalado (versão >= 1.5.0).
- Acesso ao console da AWS com permissões administrativas.

---

## 🚀 Como usar

### 1. Clone o repositório

```bash
git clone https://github.com/fabianomonteiro/aws-lab.git
cd aws-lab/infra
```

### 2. Configure as variáveis

Edite o arquivo `terraform.tfvars` com os valores apropriados para o seu ambiente:

```hcl
vpc_id = "vpc-04340f982249a9dee"
subnets = ["subnet-01e71bde9988e585f", "subnet-06acd55143a048132"]
region = "us-east-1"
desired_count = 2
cluster_name = "kotlin-ecs-cluster"
target_group_arn = "arn:aws:elasticloadbalancing:..."
```

### 3. Inicialize o Terraform

```bash
terraform init
```

### 4. Valide a configuração

```bash
terraform validate
```

### 5. Planeje a aplicação

```bash
terraform plan
```

### 6. Aplique a infraestrutura

```bash
terraform apply
```

---

## 📂 Estrutura do Projeto

```plaintext
.
├── modules/
│   ├── alb/               # Configuração do ALB e Target Groups
│   ├── ecs/               # Configuração do ECS e Fargate
│   └── vpc/               # Configuração da VPC, Subnets e Rotas
├── main.tf                # Arquivo principal do Terraform
├── variables.tf           # Definição das variáveis de entrada
├── outputs.tf             # Definição dos outputs
└── terraform.tfvars       # Valores das variáveis
```

---

## ⚙️ Desativando Deploys Automáticos

Se você deseja subir o código sem executar o deploy automático, veja [este guia](https://github.com/seu-usuario/aws-lab/docs/desativar-deploy.md) para desativar pipelines ou fluxos de CI/CD temporariamente.

---

## 🐛 Troubleshooting

### **Erro: Unable to Pull Secrets or Registry Auth**
- Verifique se as subnets utilizadas são públicas.
- Confirme se o grupo de segurança permite acesso à porta **443** (saída).
- Verifique as permissões do IAM Role associado ao ECS.

### **Erro: Timeout**
- Certifique-se de que o ALB e o Target Group estão configurados corretamente.
- Valide as rotas na tabela de rotas associada às subnets.

---

## 🤝 Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e pull requests.

---

## 📝 Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

---

## 📞 Suporte

Se você tiver dúvidas ou problemas, entre em contato com **famonteiro85@gmail.com**.