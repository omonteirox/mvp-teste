# 📦 Estrutura Padrão — Template SAP Cloud ERP

> Template reutilizável para projetos de desenvolvimento SAP S/4HANA Cloud Public Edition (GROW) com suporte a **Claude Code** e **Antigravity (Gemini)**.

---

## 🚀 Como Usar

### 1. Copiar para o novo projeto

```bash
# Copie toda a estrutura para o diretório do seu projeto
cp -r estrutura-padrao/.claude /caminho/do/projeto/
cp -r estrutura-padrao/.agents /caminho/do/projeto/
cp -r estrutura-padrao/.agent /caminho/do/projeto/
```

### 2. Personalizar o CLAUDE.md

Abra `.claude/CLAUDE.md` e preencha:
- **Nome do Projeto** — substitua `[NOME DO PROJETO]`
- **Objetivo** — descreva o objetivo específico
- **Naming Namespace** — ajuste `<NS>` para o namespace do projeto

### 3. Usar

| Ferramenta | Como invocar agentes |
|------------|---------------------|
| **Claude Code** | `/agents <nome-do-agente>` |
| **Antigravity** | `@<nome-do-agente>` ou via skills |

---

## 📁 Estrutura

```text
.claude/
├── CLAUDE.md                    # Contexto central do projeto
├── agents/                      # Agentes especializados
│   ├── sap-core/                # generalista, tech-lead, aprendiz
│   ├── sap-dev/                 # rap, cds, badi, reports specialists
│   ├── sap-integration/         # cpi-specialist
│   └── code-quality/            # abap-reviewer, abap-test-generator
├── commands/                    # Slash commands
│   ├── core/                    # /memory, /sync-context
│   └── workflow/                # /brainstorm, /define, /design, /build, /ship, /iterate
├── kb/                          # Knowledge Base
│   ├── abap/                    # concepts/ + patterns/ + quick-reference
│   ├── cds/                     # concepts/ + patterns/ + quick-reference
│   ├── rap/                     # concepts/ + patterns/ + quick-reference
│   ├── fiori/                   # concepts/ + quick-reference
│   ├── cpi/                     # concepts/ + patterns/ + quick-reference
│   ├── btp/                     # BTP overview
│   └── released/                # 20K+ released artifact indexes
│       ├── _index.md            # Como usar os indexes
│       ├── cds-views.txt        # 5.767 CDS views
│       ├── behavior-definitions.txt  # 302 BDEFs
│       ├── classes.txt          # 1.414 classes
│       ├── interfaces.txt       # 3.262 interfaces
│       └── tables.txt           # 9.641 tables
├── sdd/                         # Spec-Driven Development (AgentSpec SAP)
│   ├── _index.md                # Overview do workflow
│   ├── templates/               # 5 templates (BRAINSTORM→SHIPPED)
│   ├── features/                # Features em andamento
│   ├── reports/                  # Build reports
│   └── archive/                 # Features shipped
└── dev/                         # TODO: Dev Loop

.agents/skills/                  # Skills (10 SAP skills)
```

---

## 🤖 Agentes Disponíveis

| Agente | Categoria | O que faz |
|--------|-----------|-----------|
| `generalista` | SAP Core | Router — analisa prompt e direciona ao especialista |
| `tech-lead` | SAP Core | Decisões arquiteturais, Clean Core, code review |
| `aprendiz` | SAP Core | Registra erros e aprendizados na KB |
| `rap-specialist` | SAP Dev | RAP BOs, EML, draft, validations, actions |
| `cds-specialist` | SAP Dev | Busca e valida CDS Released (I_, C_, A_) |
| `badi-specialist` | SAP Dev | BAdIs, enhancements, pontos de extensão |
| `reports-specialist` | SAP Dev | Reports ABAP Cloud com SALV |
| `cpi-specialist` | Integration | iFlows, Groovy, XSLT, adapters, EIP |
| `abap-reviewer` | Code Quality | Code review focado em ABAP Cloud |
| `abap-test-generator` | Code Quality | Gera ABAP Unit Tests |

---

## 📚 Knowledge Base (34 arquivos)

| Domínio | Concepts | Patterns | Conteúdo |
|---------|----------|----------|----------|
| `abap/` | 3 | 4 | Cloud dev, SQL, OO, internal tables, strings, exceptions |
| `cds/` | 3 | 1 | Annotations, associations, ACL, view entity templates |
| `rap/` | 3 | 3 | Managed BO, draft, EML, validations, actions |
| `fiori/` | 2 | — | List Report, Object Page |
| `cpi/` | 2 | 2 | iFlows, EIP, Groovy templates, error handling |
| `btp/` | — | — | Platform overview |
| `released/` | — | — | **20.386 artefatos Released** (ver abaixo) |

---

## 🔍 Released Artifacts Index (20.386 artefatos)

Índices dos artefatos Released do SAP S/4HANA Cloud, extraídos do sistema standard.
Os agentes buscam pelo nome no listing e leem o arquivo fonte original.

| Tipo | Arquivo | Quantidade | Fonte |
|------|---------|------------|-------|
| CDS Views | `cds-views.txt` | 5.767 | `cds-help/cds/{NOME}.cds` |
| Behavior Definitions | `behavior-definitions.txt` | 302 | `cds-help/bdef/{NOME}.bdef` |
| Classes | `classes.txt` | 1.414 | `cds-help/classes/{NOME}.abap` |
| Interfaces | `interfaces.txt` | 3.262 | `cds-help/interfaces/{NOME}.abap` |
| Tables | `tables.txt` | 9.641 | `cds-help/tables/{NOME}.tabl` |

---

## 🛠️ Skills (10)

| Skill | Domínio |
|-------|--------|
| `sap-abap` | ABAP code, internal tables, OO, SQL, EML, constructor expressions |
| `sap-abap-cds` | CDS views, annotations, associations, DCL |
| `sap-rap` | RAP Business Objects |
| `sap-fiori-tools` | Fiori Elements, page editor, deployment |
| `sap-btp-best-practices` | BTP governance, security, resilience |
| `sap-btp-developer-guide` | BTP development, CAP, ABAP Cloud on BTP |
| `sap-btp-job-scheduling` | Job scheduling service |
| `sap-btp-master-data-integration` | MDI, master data replication |
| `sap-btp-intelligent-situation-automation` | Situation automation |
| `sapui5-cli` | UI5 CLI, build, dev server |

## 📋 SDD Workflow — Spec-Driven Development

Pipeline de 5 fases para desenvolvimento estruturado SAP Cloud ERP:

```text
/brainstorm → /define → /design → /build → /ship
   (0)          (1)       (2)       (3)      (4)
 Explorar      O quê     Como      Fazer    Fechar
```

| Command | Fase | O que faz |
|---------|------|----------|
| `/brainstorm` | 0 | Explorar ideias, YAGNI, Q&A, contexto SAP |
| `/define` | 1 | Requisitos + Clarity Score (min 12/15) |
| `/design` | 2 | Arquitetura + File Manifest + Agent Assignment |
| `/build` | 3 | Implementar + Clean Core check + Build Report |
| `/ship` | 4 | ADT checklist + Arquivar + Lessons Learned |
| `/iterate` | — | Atualizar qualquer fase mid-stream |

Documentação completa: `.claude/sdd/_index.md`

---

## 🔮 Roadmap

- [x] Knowledge Base (34 arquivos across 7 domínios)
- [x] Released Artifacts Index (20.386 artefatos)
- [x] SDD Workflow (AgentSpec SAP)
- [ ] Dev Loop (iteração estruturada com PROMPT.md)
- [ ] Telemetry (tracking de sessões)
- [ ] Mais commands (`/review`, `/create-pr`)
