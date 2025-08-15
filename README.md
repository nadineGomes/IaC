# ☁️ IaC com GitHub Actions e Terraform

Este repositório demonstra um fluxo de trabalho de **Infraestrutura como Código (IaC)**, automatizando a criação de recursos na AWS usando GitHub Actions e Terraform.

---

### Visão Geral do Projeto

O objetivo principal é simplificar o deploy de **sites estáticos**. O fluxo de trabalho é iniciado de forma 100% automatizada a partir de uma **Issue do GitHub**, eliminando a necessidade de comandos manuais.

Ao abrir uma nova Issue, o pipeline de **CI/CD** entra em ação para executar as seguintes etapas:

1.  **Criação de um S3 Bucket**: O Terraform provisiona um novo bucket no Amazon S3.
2.  **Configuração de Hospedagem de Site Estático**: O bucket é configurado para funcionar como um servidor de páginas web, com arquivos de `index.html` e `404.html`.
3.  **Liberação de Acesso Público**: As permissões de acesso são ajustadas para que o bucket possa servir o conteúdo publicamente.

Isso permite que você tenha um ambiente de hospedagem pronto para suas páginas web de maneira rápida e segura, apenas com um título de issue.

---

### Como Usar

1.  **Configure as chaves da AWS**: Adicione suas chaves `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY` como segredos no seu repositório GitHub.
2.  **Abra uma nova Issue**: Crie uma nova Issue no repositório. O pipeline será ativado, criando um S3 Bucket com o nome derivado do título da issue. Exemplo: ```static-site[título-da-sua-issue]```
3.  **Verifique a URL**: Após a conclusão do processo, você pode ver os detalhes na URL do bucket S3.
