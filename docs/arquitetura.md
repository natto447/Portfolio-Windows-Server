# Arquitetura do Laboratório Windows Server + Active Directory

## 1. Visão geral

Este laboratório simula uma infraestrutura de TI corporativa utilizando máquinas virtuais para representar um ambiente com servidor, controlador de domínio e estação cliente.

O objetivo é praticar atividades comuns de administração de infraestrutura Windows, incluindo Active Directory, DNS, DHCP, Group Policy, gerenciamento de usuários e grupos, compartilhamento de arquivos e troubleshooting.

---

## 2. Ambiente utilizado

### Servidor

* Sistema operacional: Windows Server
* Nome do servidor: **SERVIDORWIN**
* Função principal: Domain Controller
* Serviços:

  * Active Directory Domain Services (AD DS)
  * DNS
  * DHCP
  * Group Policy
  * File Server
* Domínio: `empresa.local`

### Máquina cliente

* Sistema operacional: Windows
* Função: estação de trabalho
* Participação: membro do domínio `empresa.local`

### Virtualização

* Hypervisor: **Microsoft Hyper-V**

---

## 3. Topologia

```text
                    INTERNET / HOST
                          │
                          │
                    Microsoft Hyper-V
                          │
             ┌────────────┴────────────┐
             │                         │
             │                         │
       SERVIDORWIN                  CLIENTE
       Windows Server              Windows
             │                         │
             │                         │
             └───────────┬─────────────┘
                         │
                    Domínio Windows
                     empresa.local
```

---

## 4. Servidor SERVIDORWIN

O servidor `SERVIDORWIN` atua como controlador de domínio do ambiente.

Principais responsabilidades:

```text
SERVIDORWIN
│
├── Active Directory
│
├── DNS
│
├── DHCP
│
├── Group Policy
│
└── File Server
```

O Active Directory é responsável pelo gerenciamento centralizado de:

* Usuários
* Grupos
* Computadores
* Unidades Organizacionais
* Políticas de segurança
* Autenticação no domínio

---

## 5. Domínio

O domínio utilizado no laboratório é:

```text
empresa.local
```

O domínio permite centralizar a autenticação e o gerenciamento dos computadores e usuários do ambiente.

Exemplo:

```text
Usuário
   │
   ▼
Autenticação
   │
   ▼
SERVIDORWIN
   │
   ▼
empresa.local
```

---

## 6. Estrutura de OUs

A estrutura organizacional utilizada no Active Directory foi criada para representar uma empresa fictícia.

```text
empresa.local
│
└── Empresa
    │
    ├── Computadores
    │   ├── Desktops
    │   └── Notebooks
    │
    ├── Desligados
    │
    ├── Grupos
    │
    ├── Impressoras
    │
    ├── Servidores
    │   ├── Linux
    │   └── Windows
    │
    └── Usuarios
        ├── Administrativo
        ├── Comercial
        ├── Financeiro
        ├── RH
        ├── Suporte
        └── TI
```

A utilização de OUs permite organizar os objetos do Active Directory e facilita a aplicação de políticas administrativas e de segurança.

---

## 7. Usuários e grupos

Foram criadas contas de usuários distribuídas de acordo com os departamentos da empresa.

Os grupos de segurança são utilizados para facilitar o controle de acesso aos recursos.

Exemplo:

```text
GG-TI
│
├── Usuário 1
├── Usuário 2
└── Usuário 3
```

Em um ambiente corporativo, o controle de acesso por grupos permite administrar permissões de forma mais eficiente do que atribuir permissões individualmente.

---

## 8. Computadores

As estações de trabalho são cadastradas no Active Directory após ingressarem no domínio.

Exemplo:

```text
empresa.local
│
└── Empresa
    │
    └── Computadores
        │
        └── Desktops
            │
            └── Computador Cliente
```

Após o ingresso no domínio, o computador passa a fazer parte do ambiente corporativo e pode receber políticas, autenticação centralizada e acesso aos recursos disponibilizados pelo servidor.

---

## 9. DNS

O DNS é utilizado para resolução de nomes dentro do domínio.

Exemplo:

```text
SERVIDORWIN
    │
    ▼
SERVIDORWIN.empresa.local
```

O cliente utiliza o servidor DNS do domínio para localizar recursos e serviços do Active Directory.

Testes realizados:

```powershell
nslookup empresa.local
```

```powershell
nslookup SERVIDORWIN.empresa.local
```

```powershell
Resolve-DnsName empresa.local
```

Esses testes permitem verificar se o cliente consegue resolver corretamente os nomes do domínio e do controlador de domínio.

---

## 10. DHCP

O DHCP é responsável pela distribuição automática de configurações de rede para as estações clientes.

São distribuídos parâmetros como:

* Endereço IPv4
* Máscara de rede
* Gateway
* Servidor DNS

Fluxo:

```text
CLIENTE
   │
   ▼
 DHCP
   │
   ├── IP
   ├── Máscara
   ├── Gateway
   └── DNS
```

O DHCP facilita a configuração das estações, evitando a necessidade de configurar manualmente as informações de rede em cada computador.

---

## 11. Group Policy

As Group Policies são utilizadas para aplicar configurações de forma centralizada aos usuários e computadores do domínio.

Exemplo:

```text
empresa.local
      │
      ▼
     GPO
      │
      ▼
Computadores / Usuários
```

Foi criada uma GPO de demonstração para validar o funcionamento das políticas no cliente.

A aplicação da política foi validada utilizando:

```cmd
gpupdate /force
```

e:

```cmd
gpresult /r
```

O comando `gpresult /r` permite verificar as políticas de grupo aplicadas ao computador e ao usuário.

---

## 12. File Server

O servidor também disponibiliza compartilhamentos de arquivos para os departamentos.

Exemplo:

```text
\\SERVIDORWIN\TI
\\SERVIDORWIN\RH
\\SERVIDORWIN\Financeiro
\\SERVIDORWIN\Comercial
```

O controle de acesso pode ser realizado utilizando grupos do Active Directory e permissões NTFS.

Exemplo:

```text
Grupo GG-TI
     │
     ▼
  Pasta TI
     │
     ├── Leitura
     ├── Modificação
     └── Controle conforme necessidade
```

Essa estrutura permite controlar quais usuários podem acessar ou modificar os arquivos de cada departamento.

---

## 13. Administração com PowerShell

O ambiente foi administrado utilizando PowerShell e os módulos do Active Directory.

Exemplos de atividades:

```powershell
Get-ADUser -Filter *
```

```powershell
Get-ADGroup -Filter *
```

```powershell
Get-ADComputer -Filter *
```

```powershell
Get-ADDomain
```

```powershell
Get-ADDomainController
```

```powershell
Get-ADOrganizationalUnit -Filter *
```

Esses comandos permitem consultar informações do domínio e administrar objetos do Active Directory de forma eficiente.

Também foram criados scripts específicos para consultas e diagnóstico do ambiente.

---

## 14. Troubleshooting

Foram simulados cenários comuns encontrados em ambientes de suporte e infraestrutura.

Exemplos:

* Usuário desabilitado
* Problemas de autenticação
* Computador fora do domínio
* Falha de resolução DNS
* Falha de comunicação com o Domain Controller
* GPO não aplicada
* Problemas de acesso a compartilhamentos
* Problemas de configuração IP

### Diagnóstico de usuário

```powershell
Get-ADUser -Identity usuario -Properties Enabled,LockedOut
```

### Teste de conectividade

```powershell
Test-Connection SERVIDORWIN
```

### Teste DNS

```powershell
Resolve-DnsName empresa.local
```

### Verificação das políticas

```cmd
gpresult /r
```

Esses testes permitem identificar problemas relacionados à conta do usuário, conectividade, DNS e aplicação das políticas de grupo.

---

## 15. Fluxo de autenticação

O funcionamento básico do ambiente pode ser representado da seguinte forma:

```text
Usuário
   │
   ▼
Computador Cliente
   │
   ▼
DNS
   │
   ▼
SERVIDORWIN
   │
   ▼
Active Directory
   │
   ▼
Autenticação
   │
   ▼
Acesso aos recursos
```

O cliente utiliza o DNS para localizar os serviços do domínio e se comunica com o `SERVIDORWIN`, que realiza a autenticação através do Active Directory.

---

## 16. Objetivos técnicos demonstrados

Este laboratório demonstra conhecimentos práticos em:

* Windows Server
* Active Directory
* Active Directory Users and Computers
* Domain Controller
* DNS
* DHCP
* Group Policy
* File Server
* SMB
* NTFS
* PowerShell
* Gerenciamento de usuários
* Gerenciamento de grupos
* Gerenciamento de computadores
* Organização por OUs
* Ingresso de máquinas no domínio
* Troubleshooting de infraestrutura
* Virtualização com Microsoft Hyper-V

---

## 17. Evidências

As evidências da implementação estão disponíveis na pasta:

```text
imagens/
```

Os scripts utilizados na administração e diagnóstico estão disponíveis em:

```text
scripts/
```

As principais evidências incluem:

* Ambiente do servidor
* Configuração do domínio
* Domain Controller
* Estrutura das OUs
* Usuários
* Grupos
* Computadores
* Ingresso do cliente no domínio
* Testes de conectividade
* DNS
* DHCP
* GPO
* File Server
* Troubleshooting

Este documento apresenta a arquitetura lógica do laboratório e complementa as evidências visuais e os scripts utilizados no projeto.
