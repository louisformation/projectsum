# Utilisation de l'image officielle Maven pour construire l'application
FROM maven

# Copier le fichier JAR généré depuis le répertoire target du projet local vers le repertoire racine de l'image
# Ici, on copie le fichier JAR dans le répertoire racine de l'image sous le nom 'app.jar'
COPY target/calculator-0.0.1-SNAPSHOT.jar /app.jar

# Définir la commande à exécuter lorsque le conteneur démarre
# On utilise 'java -jar' pour exécuter l'application Java en lançant le JAR que l'on a copié dans l'image
CMD ["java", "-jar", "/app.jar"]