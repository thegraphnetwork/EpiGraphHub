
<!--
*** Template found on 
*** https://github.com/othneildrew/Best-README-Template/blob/master/BLANK_README.md
*** To avoid retyping too much info. Do a search and replace for the following:
*** github_username, repo_name, twitter_handle, email, project_title, project_description
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/thegraphnetwork/EpiGraphHub">
    <img src="images/EGH.png" alt="Logo" width="300" height=300" >
  </a>

  <h3 align="center">EPIGRAPHHUB</h3>

  <p align="center">
    Health Data Hub & Data Analysis Ecosystem for Rapid Epidemic Outbreak Response
    <br />
    <a href="https://epigraphhub.readthedocs.io"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://epigraphhub.org">View Platform</a>
    ·
    <a href="https://github.com/thegraphnetwork/GRAPHnetEpiApp/issues">Report Bug</a>
    ·
    <a href="https://github.com/thegraphnetwork/GRAPHnetEpiApp/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project



### Built With





<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites



### Installation




<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

See Sphynx demo
<!-- ARCHITECURE -->

![archi2](images/EPIHUB_DOCU-ARCHITECTURE_DATA.svg)

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/thegraphnetwork/GRAPHnetEpiApp/issues) for a list of proposed features (and known issues).

Check our wiki for complementary informations



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.
Contact us to get involved in the project and join our team on discord

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/ProposedFeature`)
3. Commit your Changes (`git commit -m 'Add some ProposedFeature'`)
4. Push to the Branch (`git push origin feature/ProposedFeature`)
5. Open a Pull Request


<!-- LICENSE -->
## Development

To create a new environment for EpiGraphHub, you can use it using
conda or docker.

Also, ensure you have the `.env` file with the correct configuration.
You can copy its structure from `.env.tpl`.

### Conda

If you don't have **conda** installed, you can install it from
[here](https://github.com/mamba-org/mamba#micromamba). Micromamba 
is a miniconda version with mamba, a powerful installer that is much
faster than the conda installer.

Create your new environtment running the following command:

```bash
$ mamba env create -n conda/prod.yaml
```

To activate your new environment with all the packages installed, run:

```bash
$ conda activate epigraphhub
```

### Docker

The project provides a **docker-compose** file with one service for production
and the other two services for development. Also, there is a **Makefile**
that helps to manage the docker services.

NOTE: The following instructions are focused on development, but could be also used
for production with small changes.

First, let's pull and build the images:

```bash
$ make docker-build
```

Start the services:

```bash
$ docker-up SERVICES=epigraphhub
```

Before moving forward, check if the services are working properly:

```bash
$ ./docker/healthcheck.sh epigraphhub
```

Now, prepare the development database:

```bash
$ make docker-prepare-db
```

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.


<!-- CONTACT -->
## Contact

Project Link: [https://github.com/thegraphnetwork/GRAPHnetEpiApp](https://github.com/thegraphnetwork/GRAPHnetEpiApp)

Linked-in : https://www.linkedin.com/company/the-graph-network



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

*TBD* []()





<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/thegraphnetwork/GRAPHnetEpiApp.svg?style=for-the-badge
[contributors-url]: https://github.com/thegraphnetwork/GRAPHnetEpiApp/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/thegraphnetwork/GRAPHnetEpiApp.svg?style=for-the-badge
[forks-url]: https://github.com/thegraphnetwork/GRAPHnetEpiApp/network/members
[stars-shield]: https://img.shields.io/github/stars/thegraphnetwork/GRAPHnetEpiApp.svg?style=for-the-badge
[stars-url]: https://github.com/thegraphnetwork/GRAPHnetEpiApp/stargazers
[issues-shield]: https://img.shields.io/github/issues/thegraphnetwork/GRAPHnetEpiApp.svg?style=for-the-badge
[issues-url]: https://github.com/thegraphnetwork/GRAPHnetEpiApp/issues
[license-shield]: https://img.shields.io/github/license/thegraphnetwork/GRAPHnetEpiApp.svg?style=for-the-badge
[license-url]: https://github.com/thegraphnetwork/GRAPHnetEpiApp/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/company/the-graph-network
