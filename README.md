# Sécurité réseau avec NetworkPolicy

### Topologie

![](diagram.png)

### 1 - Déployer l'ensemble des ressources du répertoire manifests manuellement ou à l'aide de ACM 

L'image de l'application de test est automatiquement bâtie avec s2i. Attendre que le build soit terminé et que les Pods puissent consommer l'image. 

### 2 - Vérifier la liste des routes et vérifier que les accès sont fonctionnels. 

Exemple: ( le FQDN doit être ajusté en fonction de votre environnement )

#### Liste des routes
```
oc get route
NAME              HOST/PORT                                                                            PATH   SERVICES          PORT   TERMINATION     WILDCARD
billing-service   billing-service-integrations-networkpolicy.apps.dev-sandbox-flgwm.azmouimetlab.com   /      billing-service   9002   edge/Redirect   None
ui-admin          ui-admin-integrations-networkpolicy.apps.dev-sandbox-flgwm.azmouimetlab.com          /      ui-admin          8080   edge/Redirect   None
ui-user           ui-user-integrations-networkpolicy.apps.dev-sandbox-flgwm.azmouimetlab.com           /      ui-user           8080   edge/Redirect   None
```

#### Tester l'accès aux routes UI user et UI admin
```
curl https://ui-user-integrations-networkpolicy.apps.dev-sandbox-flgwm.azmouimetlab.com --insecure
{"hostname":"ui-user-6df9fbb747-zgs45","status":"ok"}

curl https://ui-admin-integrations-networkpolicy.apps.dev-sandbox-flgwm.azmouimetlab.com --insecure
{"hostname":"ui-admin-79b8bc8557-scpnf","status":"ok"}
```

#### Tester l'accès à la route Leak

La route pointe directement sur le service billing et qui ouvre potentiellement une brèche de sécurité.

```
curl https://billing-service-integrations-networkpolicy.apps.dev-sandbox-flgwm.azmouimetlab.com --insecure
{"hostname":"billing-service-76cbf84dd8-nswv7","status":"ok"}
```

### 3 - Fermer tous les accès réseau au projet

```
oc apply -f networkpolicy/default-deny.yaml
```

Revérifier l'accès aux routes à l'aide des commandes curl précédentes. À noter qu'aucun service n'est maintenant disponible. 

### 4 - Autoriser l'accès aux UI user et admin uniquement

```
oc apply -f networkpolicy/ingresspolicy.yaml
``` 

Revérifier l'accès aux routes à l'aide des commandes curl précédentes. À noter que seuls les UI user et admin sont maintenant accessibles. Le service billing n'est plus accessible de l'externe. 



