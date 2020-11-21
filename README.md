This repository is for my digital Resume, visit the live deployed version at [Jay Chakalasiya - Resume](https://jay-chakalasiya.github.io/digital-resume).

If you find any conflicts or have any suggestions, please reach out to me at <chakalasiyajay00@gmail.com>

# Deployment

If you like the template and want to make a similar resume, Tjust follow the simle steps
- Fork this repository _(I recommend keeping th same name "digital-resume", you might need to make some changes if you change the name)_
- Update your details in the `data/data.yml` file. 
- Go to github repository settings, and in the Github Pages section, select branch as `master` and directory as `root`. you can find more about Github pages [here](https://pages.github.com/).
- Now go to `https://<YOUR-GITHUB-USERNAME>.github.io/<RESUME-REPOSITORY-NAME>`, 

Your resume is successfully deployed.

## Structure/Files:
```
Root.
|   favicon.ico              # Website Icon
|   file_structure.txt       
|   index.html               # Overall layout of home page
|   README.md
|   _config.yml              # Add your Google-Analytics Tracking ID here(if any)
|      
+---assets
|   +---css
|   |       main.scss
|   |       
|   +---images
|   |       profile.png      # Profile pictures goes onto resume
|   |       
|   +---js
|   |   |   main.js
|                   
+---_data
|       data.yml             # All the resume data  goes here
|       
+---_includes                # Don't modify this files, unless you are expert and know what changes you want to make
|       about.html
|       analytics.html
|       career-profile.html
|       contact.html
|       education.html
|       experiences.html
|       footer.html
|       head.html
|       interests.html
|       language.html
|       projects.html
|       publications.html
|       scripts.html
|       sidebar.html
|       skills.html
|       
+---_layouts
|       compress.html
|       default.html
|       
\---_sass
    |   ...
    |   
    \---skins
            _berry.scss
            _blue.scss
            _ceramic.scss
            _green.scss
            _orange.scss
            _turquoise.scss
```

# Licenses
This repository is licensed under MIT license, I have modified the [online-cv](https://github.com/sharu725/online-cv/) theme for the purpose.

Feel free to reach out to me on <chakalasiyajay00@gmail.com> in case of attributions or license conflicts.

# Contribute
If you fork and make some significant design changes, please send a merge request, I will be happy to add you as a contributor as well.


