# How to contribute

## Get Started!

Ready to contribute? Here’s how to set up `EpiGraphHub` for local development.

1.  Fork the `EpiGraphHub` repo on GitHub.

2.  Clone your fork locally:
```bash
$ git clone git@github.com:your_name_here/EpiGraphHub.git
```

3.  Prepare your local development environment:
```bash
$ mamba env create --file /conda/base.yaml
$ conda activate epigraphhub
$ pre-commit install
```

4.  Create a branch for local development:
```bash
$ git checkout -b name-of-your-bugfix-or-feature
```
Now you can make your changes locally.

5.  When you’re done making changes, commit your them and push your branch to GitHub:
```bash
$ git add . 
$ git commit -m “Your detailed description of your changes.”
$ git push origin name-of-your-bugfix-or-feature
```

6.  Submit a pull request through the GitHub website.

## Dependencies

The most common way to prepare your environment for EpiGraphHub is using conda and Docker.

If you don't have conda installed, install `mambaforge` from https://github.com/conda-forge/miniforge#mambaforge.
It will install conda + mamba and it will configure it to use conda-forge by default.

If you don't have Docker installed, check the documentation for more information: https://docs.docker.com/engine/install/


## Other help

- You can contribute by spreading a word about this project.
- It would also be a huge contribution to write a short article on how you are using this project.
- You can also share your best practices with us.
