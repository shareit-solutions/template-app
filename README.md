# Template de Aplicação ArgoCD

Este template fornece uma estrutura base para deploy de aplicações no ArgoCD usando Helm charts, com separação de ambientes.

## Estrutura do Projeto

```
template-app/
├── charts/
│   └── app/                    # Helm chart da aplicação
│       ├── Chart.yaml
│       ├── values.yaml         # Valores padrão
│       ├── values-stg.yaml     # Valores específicos para staging
│       ├── values-prd.yaml     # Valores específicos para produção
│       └── templates/
│           ├── deployment.yaml
│           ├── service.yaml
│           ├── configmap.yaml
│           ├── secret.yaml
│           ├── ingress.yaml
│           └── hpa.yaml
├── argocd/
│   ├── application-stg.yaml    # Aplicação ArgoCD para staging
│   └── application-prd.yaml    # Aplicação ArgoCD para produção
└── README.md
```

## Como usar este template

1. **Clone ou copie este template** para o repositório da sua aplicação
2. **Personalize os valores** nos arquivos `values*.yaml` conforme sua aplicação
3. **Ajuste os manifestos** nos templates conforme necessário
4. **Configure as aplicações ArgoCD** editando os arquivos em `argocd/`
5. **Aplique no cluster** usando `kubectl apply -f argocd/`

## Configuração de Ambientes

### Staging (STG)
- Namespace: `app-name-stg`
- Recursos reduzidos
- Configurações de desenvolvimento

### Produção (PRD)
- Namespace: `app-name-prd` 
- Recursos otimizados
- Configurações de produção
- HPA habilitado

## Variáveis a serem substituídas

Ao usar este template, substitua as seguintes variáveis:

- `APP_NAME`: Nome da sua aplicação
- `REPO_URL`: URL do repositório Git da aplicação
- `IMAGE_REPOSITORY`: Repositório da imagem Docker
- `DOMAIN`: Domínio para o ingress

## Exemplo de uso

```bash
# Substituir variáveis no template
sed -i 's/APP_NAME/minha-app/g' argocd/*.yaml charts/app/*.yaml
sed -i 's/REPO_URL/https:\/\/github.com\/user\/repo.git/g' argocd/*.yaml
```