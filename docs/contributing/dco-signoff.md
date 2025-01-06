---
layout: default
title: Developer Certificate of Origin (DCO) Sign Off
---

# Developer Certificate of Origin (DCO) Sign Off

## Basics

All contributors to Lyrion retain copyright to their work, but must only submit work which they have the rights to submit. See the [Developer Certificate of Origin](../dco.md).

We require all contributors to acknowledge that they have the rights to the code they're contributing by signing their commits in git using a "DCO Sign Off".

To sign your work, pass the `--signoff` option to `git commit`:

```bash
git commit --signoff -m"my commit"
```

Or short:

```bash
git commit -s -m"my commit"
```

Similarly you can sign-off a `git rebase`:

```bash
git rebase --signoff master
```

This will add a line similar to the following at the end of your commit:

```
Signed-off-by: Jimi Bendix <jimib@example.com>
```

By signing off a commit you're stating that you confirm the [Developer Certificate of Origin](../dco.md).

## Github checks

When you submit a pull request on Github, there will be a check for the sign-off message. If you forget to add the message, the pull request will be blocked. You can amend the situation using the following command, followed by a force push:

```bash
git commit --amend --signoff
```


## Commit message template

If you are too lazy to have to add the `-s` parameter on each and every commit, you can create a commit message template which includes the sign-off line. Create a simple text file, eg. `~/.gitmessage` or `[project's root].git/commitmessage` with the following content:

```

Signed-off-by: Jimi Bendix <jimib@example.com>
```

If you want to enable this template for all your git activity, register it globally:

```bash
git config --global commit.template ~/.gitmessage
```

If you prefer to have individual versions per repository, or if you only want it in some repo, do similarly at the root of your repository clone:

```bash
git config commit.template .git/commitmessage
```
