# Peasants, Agriculture, and Environment in the 1st Millennium CE Italian Countryside: A Bayesian approach

Detailed documentation of this repository is provided in the web version of this thesis, which can be accessed at: https://robertoragno.github.io/phd/


The website provides interactive maps of [archaeobotanical](https://robertoragno.github.io/phd/materials_archaeobotany.html) and [zooarchaeological](https://robertoragno.github.io/phd/materials_zooarchaeology.html) data from continental Italy dating to the 1st millennium CE, together with [bibliographical references](https://robertoragno.github.io/phd/sites_references.html), the [criteria used to create the database](https://robertoragno.github.io/phd/database.html), and archaeological and historical interpretations of the trends. The datasets are openly available for reuse in .CSV format. 

## Abstract
This dissertation explores the subsistence methods, economic systems and environmental adaptations of Italian peasant communities in the 1^st^ millennium CE, with a particular focus on the transitional period from the Roman Empire to the early medieval era. Existing work on agricultural production in this period has been based on literary sources and field surveys, or has focused on individual sites or regional collections, while a multi-source archaeological study is absent from the discourse. This dissertation addresses this gap by using environmental proxies, reconstructing the historical agricultural landscape through the occurrence patterns of plants and animals in legacy data. To this end, 190 botanical and 466 faunal assemblages from 309 sites are quantitatively analysed within a Bayesian framework, using multilevel binomial and beta-binomial models to account for overdispersion and class imbalance in the datasets. The results reveal a strong trend towards regionalisation in agricultural strategies during the early medieval period. In addition, these findings expose variations in agricultural techniques and dietary patterns across Roman settlements, shedding light on the extent to which Roman agricultural and economic frameworks persisted or changed during the early medieval transition, and the adaptive agricultural strategies adopted by farmers. The quantitative analytical findings of this dissertation are also contextualised alongside wider historical sources, archaeological evidence, and current debate, allowing for a bottom-up understanding of the agricultural regimes in question. This work represents the first attempt to use temporally and geographically diverse bioarchaeological data to visualise the Italian agricultural landscape across the *longue durée.* By systematising the data in an open database, this dissertation also represents an effort at quantitative knowledge sharing in archaeology. Overall, these novel perspectives on human-nature interaction allow scholars to methodologically, theoretically and empirically evaluate agricultural strategies during the transition from the Roman Empire to the politically fragmented landscape of the early medieval Italian peninsula.

## Repository Structure
This repository contains the files that were used to generate the online version of the dissertation. In particular:
- `/Quarto files`: Contains the .qmd files used to generate the HTML version of the thesis, and all the scripts used to perform the statistics on the datasets.
- `/Quarto files/archaeobotany.qmd`: This .qmd file contains (besides the textual output) the scripts used on the archaeobotanical dataset.
- `/Quarto files/zooarchaeology.qmd`: This .qmd file contains (besides the textual output) the scripts used on the zooarchaeological dataset.
- `/Quarto files/Database export`: Contains the datasets as queried from the database.

## Tools
To run these scripts, you need to have R installed on your system. The Quarto .qmd files were generated using RStudio.

## Contact
- Email: roberto.ragno@uniba.it
- Twitter: [@ragno_roberto](https://twitter.com/ragno_roberto)
