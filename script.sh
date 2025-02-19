# Démarrer le conteneur Docker
    docker run -itd --name test -p8082:8080 ${DOCKER_IMAGE}:latest
# Attendre que le service soit prêt
sleep 10
# Tester le service avec l'adresse IP
response=$(curl -s "http://10.0.2.15:8082/sum?a=5&b=6")
echo "Réponse obtenue : $response"
if [ -z "$response" ]; then
 echo "Erreur : le service n'a pas répondu ou la réponse est vide"
 exit 1
fi
if [ "$response" -eq 11 ]; then
  echo "Test réussi : réponse attendue 11, obtenue $response"
    else
  echo "Test échoué : réponse attendue 11, obtenue $response"
  exit 1
fi