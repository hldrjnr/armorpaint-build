# ArmorPaint Windows x64 — GitHub Actions

Este pacote contém um workflow para compilar o ArmorPaint no runner Windows do GitHub Actions.

## O que você precisa

- Uma conta GitHub.
- Criar um repositório seu. Recomendo público para usar o runner Windows padrão gratuitamente.
- Não precisa instalar Visual Studio, Git, Node ou ArmorPaint no seu PC.
- Não precisa baixar o código-fonte do ArmorPaint para o seu PC.

## Passo a passo

1. Entre em https://github.com/new
2. Crie um repositório chamado `armorpaint-build`.
3. Pode marcar `Public`.
4. Crie o repositório.
5. Dentro dele, crie a pasta:
   `.github/workflows/`
6. Envie o arquivo:
   `.github/workflows/build-armorpaint.yml`
7. Abra a aba `Actions`.
8. Se aparecer a mensagem perguntando se você quer habilitar workflows, habilite.
9. Selecione `Build ArmorPaint for Windows x64`.
10. Clique em `Run workflow`.
11. Aguarde a execução terminar.
12. Abra a execução concluída.
13. No final da página, em `Artifacts`, baixe `ArmorPaint-Windows-x64`.
14. Extraia o ZIP no Windows.
15. Execute `ArmorPaint.exe`.

## Importante

O workflow acompanha o `main` atual do repositório oficial. Portanto, uma alteração futura no ArmorPaint pode quebrar a compilação. Nesse caso, abra o log da etapa que falhou.

O build é feito em uma máquina Windows hospedada pelo GitHub. Seu PC só precisa baixar o ZIP final.

O workflow usa `actions/checkout` para baixar o código diretamente no runner, inicializa o ambiente do Visual Studio, executa `base/make`, compila a configuração Release x64 e publica o ZIP como Artifact.

## Se a build falhar

Não tente alterar comandos aleatoriamente.

Abra:
`Actions` → execução que falhou → etapa vermelha.

Copie as últimas ~30-50 linhas do erro e envie-as para mim. A partir delas podemos ajustar o workflow para a versão atual do ArmorPaint.
