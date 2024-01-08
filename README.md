# lms-community.github.io
This is the web page for the LMS Community repository

The site is based on mkdocs-material (https://squidfunk.github.io/mkdocs-material/). 

To get a local development environment up you can do the following:

1. Follow the installation instructions on https://squidfunk.github.io/mkdocs-material/getting-started/ to make sure that mkdocs-material is installed on your system.
2. Clone this repository (or fork this repository).
3. Use `mkdocs serve` (or `docker run --rm -it -p 8000:8000 -v ${PWD}:/docs squidfunk/mkdocs-material` if you're using the Docker image) to setup a live preview server from the local repository. The server will automatically rebuild the site upon saving.
4. Point your browser to [localhost:8000](http://localhost:8000).

Adding a page is very simple, just add the appropriate .md page under the docs folder and the page is automatically picked up and added to the navigation. Please see https://squidfunk.github.io/mkdocs-material/reference/ for more information about the framework.
