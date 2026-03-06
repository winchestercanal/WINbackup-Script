# WINbackup – Script Automático de Backup

Este script foi desenvolvido pelo [Canal WINchester](https://www.youtube.com/WINchesterCanal) para facilitar o backup e restauração de drivers, arquivos pessoais e favoritos de navegadores no Windows, de forma simples e automática.

---

## 📥 Download do script

Faça o download do script diretamente aqui:

**[📄 WINbackup.bat](https://github.com/winchestercanal/driverbackup/blob/main/WINbackup.bat)**

> ⚠️ **IMPORTANTE:** Execute sempre como Administrador!

---

## 🚀 Como usar

Ao iniciar o script, você verá o **menu principal** com as seguintes opções:

```plaintext
  1 - Arquivos Pessoais (Backup)
  2 - DRIVERS (backup/restauração)
  3 - Navegadores (backup/restauração)
  4 - Acessar tutorial
  0 - Sair
```

---

## 📂 Opção 1 – Arquivos Pessoais (Backup)

Realiza o backup das suas pastas pessoais do Windows para um destino de sua escolha (ex: HD externo, pendrive).

### Pastas disponíveis para backup:
- Documentos
- Imagens
- Músicas
- Vídeos
- Downloads
- Desktop

### Modos de backup:

**`C` – Backup Completo**
Copia todas as pastas listadas acima de uma só vez.

**`S` – Backup Seletivo**
Permite escolher quais pastas deseja copiar. Digite os números separados por vírgula.

**Exemplo:**
```plaintext
Sua seleção: 1,3,5
```
*(Irá copiar apenas Documentos, Músicas e Downloads)*

Após escolher o modo, informe o destino do backup:
```plaintext
Exemplo: L:\backup
```

O script criará uma pasta com os arquivos organizados no destino informado.

---

## 🔧 Opção 2 – Drivers (Backup/Restauração)

### 2.1 – Fazer backup dos drivers

Informe o destino onde deseja salvar os drivers:

```plaintext
Exemplo: L:\backup
```

O script criará automaticamente a pasta `DRIVERS` no destino informado e exportará todos os drivers instalados com o comando `dism`.

### 2.2 – Restaurar drivers

Informe o caminho da pasta onde estão os drivers que deseja restaurar:

```plaintext
Exemplo: L:\backup\DRIVERS
```

O script percorrerá a pasta e instalará todos os drivers `.inf` encontrados usando `pnputil`.

---

## 🌐 Opção 3 – Navegadores (Backup/Restauração)

Realiza o backup e a restauração dos **favoritos** do Microsoft Edge e Google Chrome.

> ⚠️ **Atenção:** As senhas **não são salvas automaticamente** por questões de segurança. Você precisa exportá-las manualmente em cada navegador.

### 3.1 – Fazer backup dos favoritos

Escolha o(s) navegador(es) desejado(s) e informe o destino do backup.

Os favoritos serão salvos em:
```plaintext
<destino>\Navegadores\Edge\
<destino>\Navegadores\Chrome\
```

O script suporta **múltiplos perfis** do Chrome automaticamente.

**Para exportar senhas manualmente:**

| Navegador | Endereço |
|---|---|
| Microsoft Edge | `edge://settings/autofill/passwords` |
| Google Chrome | `chrome://password-manager/settings` |

### 3.2 – Restaurar favoritos

Escolha o navegador e informe o caminho da pasta de backup.

O script localizará o arquivo `Bookmarks` automaticamente, encerrará o navegador se estiver aberto para evitar conflitos, e restaurará os favoritos no perfil padrão.

> ℹ️ Um backup do arquivo `Bookmarks` atual é feito automaticamente antes de sobrescrever.

**Para importar senhas manualmente após a restauração:**

| Navegador | Endereço |
|---|---|
| Microsoft Edge | `edge://settings/autofill/passwords` |
| Google Chrome | `chrome://password-manager/settings` |

---

## 📋 Log de execução

A cada execução, o script gera automaticamente um arquivo de log na mesma pasta do script, com o nome:

```plaintext
drivers_backup_AAAA-MM-DD_HHMMSS.log
```

Esse arquivo registra todas as ações realizadas, incluindo erros e avisos, útil para diagnóstico.

---

## 🎥 Tutorial completo

Para entender como tudo funciona na prática, assista ao tutorial:

**[▶️ Assistir no YouTube](https://youtu.be/ymOwOXdzHGQ)**

---

## 🔗 Outros repositórios que você pode gostar

- 🪟 [Configurações do Komorebi](https://github.com/winchestercanal/komorebi-configs)
- 🎨 [Configurações do YASB](https://github.com/winchestercanal/Yasb)

---

Se este repositório te ajudou, considere deixar uma ⭐ no GitHub!
