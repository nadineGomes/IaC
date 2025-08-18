# ☁️ IaC com GitHub Actions e Terraform

Este repositório demonstra um fluxo de trabalho de **Infraestrutura como Código (IaC)**, automatizando o provisionamento de recursos na AWS usando GitHub Actions e Terraform.

---

### Visão Geral do Projeto

O objetivo principal é simplificar o deploy de infraestruturas de forma modular e controlada. O fluxo de trabalho é iniciado manualmente através da aba **Actions** do GitHub, eliminando a dependência de Issues para cada deploy.

O projeto é dividido em módulos reutilizáveis, permitindo o provisionamento de recursos específicos de forma independente:

1.  **Módulo S3**: Provisiona um S3 Bucket configurado para hospedagem de site estático, com liberação de acesso público.
2.  **Módulo EC2**: Provisiona uma instância EC2, pronta para ser acessada.

---

### Módulos de Infraestrutura

* **`modules/s3-website`**:
    * **Propósito**: Cria e configura um S3 Bucket para hospedar um site estático.
    * **Variáveis de Entrada**: `bucket_name`.

* **`modules/ec2-instance`**:
    * **Propósito**: Provisiona uma instância EC2 baseada em Ubuntu.
    * **Variáveis de Entrada**: `instance_name`

---

### Como Usar

1.  **Configure as chaves da AWS**: Adicione suas chaves `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY` como segredos no seu repositório GitHub para que o pipeline tenha as permissões necessárias.

2.  **Execute o Workflow no GitHub Actions**:
    * Vá para a aba **`Actions`** do repositório.
    * No menu à esquerda, selecione o workflow que deseja executar (por exemplo, `Create S3 Static Site`).
    * Clique em **`Run workflow`**.
    * No campo `bucket_name`, insira o nome único para o seu bucket e clique em `Run workflow`.
    * Para o EC2, o processo é o mesmo, mas você fornecerá o `name` da sua instância.

3.  **Verifique a URL e a Conexão**:
    * Após a conclusão do processo, verifique o status na sua conta da AWS.
    * Para o S3, a URL pode ser encontrada na configuração de hospedagem estática do bucket.
    * Para a instância EC2, a conexão é feita via SSH usando o IP público da instância.
