# ArmorPaint — GitHub Actions (Linux x64 e Windows x64)

Este repositório contém workflows para compilar o ArmorPaint no GitHub Actions. Você não precisa instalar nada no seu PC: o build roda na máquina hospedada pelo GitHub e você só baixa o resultado final.

## Builds disponíveis

| Workflow | Arquivo | Runner | Artefato |
| --- | --- | --- | --- |
| `Build ArmorPaint Linux x64` | `.github/workflows/build-armorpaint-linux.yml` | `ubuntu-24.04` | `ArmorPaint-Linux-x64` |
| `Build ArmorPaint Windows x64` | `.github/workflows/build-armorpaint.yml` | `windows-latest` | `ArmorPaint-Windows-x64` |

O runner de Linux está fixado em `ubuntu-24.04` de propósito: é a mesma base do **Linux Mint 22.3** (x86_64), então o binário usa o mesmo glibc do seu computador e roda direto, sem depender de container ou AppImage.

---

## Build para Linux (Linux Mint 22.3 / Ubuntu 24.04)

### Passo a passo

1. Abra o repositório no GitHub.
2. Vá em **Actions** → **Build ArmorPaint Linux x64**.
3. Clique em **Run workflow** → **Run workflow**.
4. Aguarde a execução terminar (verde ✓).
5. Abra a execução concluída.
6. Em **Artifacts**, baixe `ArmorPaint-Linux-x64`. Você receberá um ZIP contendo `ArmorPaint-Linux-x64.tar.gz`.
7. No terminal, na pasta de downloads:

   ```bash
   unzip ArmorPaint-Linux-x64.zip
   tar -xzf ArmorPaint-Linux-x64.tar.gz
   cd ArmorPaint-Linux-x64
   ./ArmorPaint.sh
   ```

8. Opcional, para criar o atalho no menu:

   ```bash
   ./instalar-desktop.sh
   ```

### O que o workflow faz

1. Baixa este repositório (guarda os scripts da pasta `linux/`).
2. Baixa o código-fonte oficial `armory3d/armorpaint` (com submódulos e histórico completo).
3. Instala as dependências de compilação do `base/docs/linux_deps.md`:
   `make clang libvulkan-dev libgtk-3-dev libssl-dev libx11-dev libxi-dev libxrandr-dev libxcursor-dev libasound2-dev`.
4. Verifica a árvore de fonte e limpa builds anteriores.
5. Executa `../base/make --target linux --compile` (Release x64, Vulkan) na pasta `paint`.
6. Confere o resultado: `paint/build/out/ArmorPaint`, `ldd` sem bibliotecas faltando.
7. Empacota em `ArmorPaint-Linux-x64.tar.gz` (o `tar.gz` preserva o bit de execução — um ZIP comum perderia) e publica como Artifact.

### Sobre o pacote

- `ArmorPaint.sh` — inicializador que executa o programa a partir da própria pasta (necessário, pois o `data/` fica ao lado do executável).
- `instalar-desktop.sh` — cria o atalho em `~/.local/share/applications/armorpaint.desktop` (sem sudo).
- `LEIA-ME.txt` — as mesmas instruções em texto dentro do pacote.

Se na sua máquina faltar alguma biblioteca em tempo de execução:

```bash
sudo apt install libvulkan1 mesa-vulkan-drivers
```

---

## Build para Windows x64

1. Abra a aba **Actions**.
2. Se aparecer a mensagem perguntando se você quer habilitar workflows, habilite.
3. Selecione `Build ArmorPaint Windows x64`.
4. Clique em `Run workflow`.
5. Aguarde a execução terminar.
6. Abra a execução concluída.
7. No final da página, em `Artifacts`, baixe `ArmorPaint-Windows-x64`.
8. Extraia o ZIP no Windows.
9. Execute `ArmorPaint.exe`.

O workflow usa `actions/checkout` para baixar o código diretamente no runner, inicializa o ambiente do Visual Studio, executa `base/make`, compila a configuração Release x64 e publica o ZIP como Artifact.

---

## Importante

Os workflows acompanham o `main` atual do repositório oficial do ArmorPaint. Portanto, uma alteração futura no ArmorPaint pode quebrar a compilação. Nesse caso, abra o log da etapa que falhou.

O build é feito em máquinas hospedadas pelo GitHub. Seu PC só precisa baixar o artefato final.

## Se a build falhar

Não tente alterar comandos aleatoriamente.

Abra: `Actions` → execução que falhou → etapa vermelha.

Copie as últimas ~30-50 linhas do erro e envie-as para mim. A partir delas podemos ajustar o workflow para a versão atual do ArmorPaint.
