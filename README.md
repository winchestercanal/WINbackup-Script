<div align="center">

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=28&duration=3000&pause=1000&color=0078D7&center=true&vCenter=true&width=600&lines=WINbackup+%F0%9F%92%BE;Backup+e+Restaura%C3%A7%C3%A3o+para+Windows" alt="WINbackup" />

<br/>

[![Windows](https://img.shields.io/badge/Windows-0078D7?style=for-the-badge&logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![Batch Script](https://img.shields.io/badge/Batch_Script-.bat-4D4D4D?style=for-the-badge&logo=gnometerminal&logoColor=white)]()
[![Admin Required](https://img.shields.io/badge/Requer-Administrador-red?style=for-the-badge&logo=shield&logoColor=white)]()
[![YouTube](https://img.shields.io/badge/Tutorial-YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://youtu.be/ymOwOXdzHGQ)

<br/>

> **Script desenvolvido pelo [Canal WINchester](https://www.youtube.com/WINchesterCanal)**  
> Backup e restauração de drivers, arquivos pessoais e favoritos de navegadores — tudo em um só lugar.

<br/>

[📥 Download](#-download) · [🚀 Como Usar](#-como-usar) · [📂 Arquivos Pessoais](#-opção-1--arquivos-pessoais) · [🔧 Drivers](#-opção-2--drivers) · [🌐 Navegadores](#-opção-3--navegadores) · [🎥 Tutorial](#-tutorial)

</div>

---

## 📥 Download

<div align="center">

### **[⬇️ Clique aqui para baixar o WINbackup.bat](https://github.com/winchestercanal/driverbackup/blob/main/WINbackup.bat)**

</div>

> [!WARNING]
> Execute sempre com o botão direito → **"Executar como administrador"**

<div align="center">

### **Ou execute diretamente via PowerShell(Administrador):**

```powershell
irm https://raw.githubusercontent.com/winchestercanal/WINbackup-Script/refs/heads/main/WINbackup.bat -OutFile WINbackup.bat && cmd /c WINbackup.bat
```
</div>

---

## 🚀 Como Usar

Ao iniciar o script, o menu principal será exibido:

```
  ===================================================
    BACKUP E RESTAURACAO - WINchester
  ===================================================

    1 - Arquivos Pessoais (Backup)
    2 - DRIVERS (backup/restauração)
    3 - Navegadores (backup/restauração)
    4 - Acessar tutorial
    0 - Sair
```

Escolha a opção digitando o número correspondente e pressione **Enter**.

---

## 📂 Opção 1 — Arquivos Pessoais

Faz o backup das suas pastas pessoais para qualquer destino — HD externo, pendrive, pasta de rede, etc.

### 📁 Pastas disponíveis

| # | Pasta |
|---|-------|
| 1 | 📄 Documentos |
| 2 | 🖼️ Imagens |
| 3 | 🎵 Músicas |
| 4 | 🎬 Vídeos |
| 5 | ⬇️ Downloads |
| 6 | 🖥️ Desktop |
| 7 | 🔑 SSH |

### ⚙️ Modos de backup

<table>
<tr>
<td width="50%">

**`C` — Backup Completo**

Copia todas as 7 pastas de uma vez.

</td>
<td width="50%">

**`S` — Backup Seletivo**

Você escolhe quais pastas copiar.

```
Sua seleção: 1,3,5
```
*(Documentos, Músicas e Downloads)*

</td>
</tr>
</table>

Após escolher o modo, informe o **destino** do backup:

```
Informe o destino: L:\backup
```

---

## 🔧 Opção 2 — Drivers

Backup e restauração completa dos drivers do Windows usando `dism` e `pnputil`.

### 💾 Fazer Backup

Informe o destino onde deseja salvar:

```
Destino: L:\backup
```

O script criará automaticamente a pasta `DRIVERS` no destino e exportará todos os drivers instalados.

```
L:\backup\
└── DRIVERS\
    ├── driver1.inf
    ├── driver2.inf
    └── ...
```

### ♻️ Restaurar Drivers

Informe o caminho da pasta com os drivers do backup:

```
Caminho: L:\backup\DRIVERS
```

O script instalará automaticamente **todos os drivers `.inf`** encontrados na pasta.

---

## 🌐 Opção 3 — Navegadores

Backup e restauração dos **favoritos** do Microsoft Edge e Google Chrome.

> [!IMPORTANT]
> **As senhas NÃO são salvas automaticamente** por questões de segurança.  
> É necessário exportá-las manualmente em cada navegador.

### 🔖 Fazer Backup dos Favoritos

Escolha o navegador, informe o destino e o script salvará os favoritos em:

```
<destino>\
└── Navegadores\
    ├── Edge\
    │   └── Bookmarks
    └── Chrome\
        ├── Default\
        │   └── Bookmarks
        └── Profile 1\
            └── Bookmarks
```

> ✅ Suporte automático a **múltiplos perfis** do Chrome.

### 🔄 Restaurar Favoritos

Informe o caminho da pasta de backup. O script irá:

- 🔍 Localizar o arquivo `Bookmarks` automaticamente
- ⛔ Encerrar o navegador se estiver aberto (evita conflitos)
- 💾 Criar um backup do `Bookmarks` atual antes de sobrescrever
- ✅ Restaurar os favoritos no perfil padrão

---

### 🔐 Exportar / Importar Senhas Manualmente

| Navegador | Ação | Endereço |
|-----------|------|----------|
| ![Edge](https://img.shields.io/badge/Microsoft_Edge-0078D7?style=flat&logo=microsoftedge&logoColor=white) | Exportar / Importar senhas | `edge://settings/autofill/passwords` |
| ![Chrome](https://img.shields.io/badge/Google_Chrome-4285F4?style=flat&logo=googlechrome&logoColor=white) | Exportar / Importar senhas | `chrome://password-manager/settings` |

---

## 📋 Log de Execução

A cada execução, o script gera automaticamente um arquivo de log na mesma pasta:

```
drivers_backup_2025-03-06_143022.log
```

O log registra todas as ações, erros e avisos — útil para diagnóstico.

---

## 🎥 Tutorial

<div align="center">

[![Tutorial WINchester](https://img.shields.io/badge/▶_Assistir_Tutorial_Completo-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://youtu.be/ymOwOXdzHGQ)

</div>

---

## 🔗 Outros repositórios

<div align="center">

| Projeto | Descrição |
|---------|-----------|
| 🪟 [Komorebi Configs](https://github.com/winchestercanal/komorebi-configs) | Configurações do gerenciador de janelas Komorebi |
| 🎨 [YASB Configs](https://github.com/winchestercanal/Yasb) | Configurações da status bar YASB |

</div>

---

<div align="center">

Se este repositório te ajudou, deixe uma ⭐ no GitHub!

[![Canal WINchester](https://img.shields.io/badge/Canal_WINchester-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/WINchesterCanal)

</div>
