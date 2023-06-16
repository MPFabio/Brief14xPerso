                                                *** Déploiement d'une appli sur Azure avec Docker, Terraform et Jenkins ***
                                               
  Terraform as an infra :
  
  
  Déploiement d'une infrastructure composée de deux machines virtuelles ayant chacune son groupe de ressource et des caractéristiques distinctes :
  
  - Un environnement propice aux test (staging-env)
  - Un second pour la prod, nécessitant une taille plus élevée (prod-env)

Pour ce faire, l'utilisation des modules parents a été adoptée, permettant de récupérer les informations du module enfant (azure-webserver) et de proposer un code plus propre et fonctionnel. 

Les outputs propres aux modules parents sont renseigné en leur sein, le providers indispensable au bon fonctionnement ainsi que le main renseignant où les informations nécessaires au déploiement de l'infrastructure, les variables et le script.sh (via l'utilisation d'un custom data) doivent être trouvées.



  Jenkins as an automation server :
  
  Création d'un projet pipeline
  
  - Choisir GitHub project et renseigné le lien du repo
  - Définir un pipeline script from SCM
  

  Docker as a container orchestration :
  
  
  Création d'une image docker via Jenkinsfile à partir d'un Dockerfile selon les étapes :
   
  - Docker Build : docker build -t MyContainerName .
  - Docker Tag : docker tag MyContainerName MyDockerHubName/MyContainerName
  - Docker Login : docker login -u MyDockerHubName -p MyDockerHubPassword
  - Docker Push : docker push MyDockerHubName/MyContainerName
                     
                    
