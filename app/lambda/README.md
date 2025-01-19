Aqui está um modelo de **README.md** para o seu projeto:

---

# **AWS Lambda S3 Logger**

Este projeto implementa uma função AWS Lambda em Python que registra a data e hora de sua execução em um arquivo armazenado em um bucket S3. Ele verifica se o arquivo existe; se não, cria o arquivo e registra a data e hora atual. Se o arquivo já existir, a Lambda lê a última execução, retorna a informação e atualiza o registro com a nova data e hora.

---

## **Funcionalidades**

- Armazena informações da última execução em um arquivo S3.
- Cria o arquivo automaticamente na primeira execução.
- Atualiza o arquivo a cada nova execução.
- Desenvolvido para aprendizado e demonstração de AWS Lambda com Python.

---

## **Pré-requisitos**

1. **AWS CLI configurado:**
   - Certifique-se de que o AWS CLI esteja instalado e configurado:
     ```bash
     aws configure
     ```

2. **Python 3.9 ou superior.**

3. **Dependências do projeto:**
   - Instale as dependências usando o `requirements.txt`.

4. **Terraform**:
   - Para provisionar a infraestrutura AWS, é necessário instalar o Terraform.

---

## **Estrutura do Projeto**

```plaintext
aws-lab/
├── lambda_function.py    # Código principal da função Lambda
├── requirements.txt      # Dependências da função Lambda
├── terraform/
│   ├── main.tf           # Configuração principal do Terraform
│   ├── variables.tf      # Variáveis do Terraform
│   ├── outputs.tf        # Saída do Terraform
│   └── provider.tf       # Configuração do provider AWS
└── README.md             # Este arquivo
```

---

## **Instruções de Uso**

### **1. Configurar o Bucket S3**
Atualize o nome do bucket no arquivo `terraform/variables.tf`:
```hcl
variable "bucket_name" {
  default = "nome-do-seu-bucket-unique"
}
```

### **2. Provisionar Infraestrutura**
Use o Terraform para criar a infraestrutura necessária (bucket S3 e Lambda).

#### **Passos:**
1. Inicialize o Terraform:
   ```bash
   terraform init
   ```

2. Valide a configuração:
   ```bash
   terraform validate
   ```

3. Crie o plano de execução:
   ```bash
   terraform plan -out=tfplan
   ```

4. Aplique o plano:
   ```bash
   terraform apply -auto-approve tfplan
   ```

---

### **3. Testar a Lambda Localmente**

#### **Configurar Ambiente Virtual**
1. Crie o ambiente virtual:
   ```bash
   python -m venv venv
   ```

2. Ative o ambiente virtual:
   ```bash
   source venv/Scripts/activate
   ```

3. Instale as dependências:
   ```bash
   pip install -r requirements.txt
   ```

4. Execute o código localmente (opcional):
   - Use um simulador para eventos do AWS Lambda.

---

### **4. Testar no AWS**
1. No console da AWS, acesse a função Lambda criada pelo Terraform.
2. Configure um evento de teste e execute a função.
3. Verifique os logs no **CloudWatch** e o arquivo no bucket S3.

---

## **Exemplo de Resposta**
### **Primeira Execução**
```json
{
  "message": "Lambda executed for the first time.",
  "current_execution": "2025-01-18T15:00:00.000Z"
}
```

### **Execuções Subsequentes**
```json
{
  "message": "Lambda executed successfully.",
  "last_execution": "2025-01-18T15:00:00.000Z",
  "current_execution": "2025-01-18T16:00:00.000Z"
}
```

---

## **Limpeza da Infraestrutura**
Para remover todos os recursos provisionados pelo Terraform:
```bash
terraform destroy -auto-approve
```

---

## **Licença**
Este projeto é apenas para fins educacionais e está disponível sob a licença MIT.

---

Se precisar de mais ajustes ou instruções, é só avisar! 🚀