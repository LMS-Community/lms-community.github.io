# lyrion.org
This is the [web page](https://lyrion.org) for the LMS Community.

The site is based on mkdocs-material (https://squidfunk.github.io/mkdocs-material/).

## Setup a local development environment

To get a local development environment up you can do **one of the following**:

### Use docker

1. Clone this repository (or fork this repository).
2. Build the Docker image with additional plugins : `docker build -t mkdocs-material-with-plugins .`
3. Run `docker run --rm -it -p 8000:8000 -v ${PWD}:/docs mkdocs-material-with-plugins` to setup a live preview server from the local repository. The server will automatically rebuild the site upon saving.
4. Point your browser to [localhost:8000](http://localhost:8000).

### Install mkdocs-material

1. Follow the installation instructions on https://squidfunk.github.io/mkdocs-material/getting-started/ to make sure that mkdocs-material is installed on your system.
2. Clone this repository (or fork this repository).
3. Use `mkdocs serve`. The server will automatically rebuild the site upon saving.
4. Point your browser to [localhost:8000](http://localhost:8000).

## Edit the pages

Adding a page is very simple, just add the appropriate .md page under the docs folder.

If you want to add the page to the navigation you can expand the nav structure in the mkdocs.yml.

Please see https://squidfunk.github.io/mkdocs-material/reference/ for more information about the framework.

## Analytics data, download & plugins page

A few files are no longer maintained in the repository, but only updated at deployment time. They're pulling in data
and information from external sources which can change daily or more often. By not keeping them in the repository
we avoid unnecessary updates to the repo. A copy of the following files is still in the repository for local testing
purposes, but they're not updated automatically. Feel free to update them every now and then manually using the scripts
in the `tools` folder.

* `docs/analytics/stats.json` (tool: `tools/get-analytics-data.pl`)
* `docs/plugins/directory.md` (`tools/build-plugin-repository.pl`)
* `docs/downloads/downloads.yaml` (`tools/build-server-downloads-page.pl`)


## Testing the Github Actions workflow

In order to test the workflow, install [`act`](https://github.com/nektos/act). Then run the following:

```
act --pull=false workflow_dispatch -P ubuntu-24.04=catthehacker/ubuntu:act-latest --workflows .github/workflows/main.yml
```