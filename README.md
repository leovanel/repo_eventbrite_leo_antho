# README
<h1>Bienvenue sur notre REPO </h1>

<p>Codé avec coeur par Leo et Anthony de la team Montpellier pour la formation The Hacking Project</p>

<p>voici le lien HEROKU : https://safe-eyrie-82559.herokuapp.com/</p>


<h2>1. Introduction</h2>
<p>Dans ce projet, tu vas reprendre le projet de la veille pour y construire tes premières vues. Tu vas installer Devise sur ton application et construire les premières vues.</p>

<p>Plus en détails, voici ce que nous attendons de toi :</p>

<ul>
  <li>Tu dois installer Devise sur l'application, et brancher le model <code>User</code> à Devise</li>
  <li>Tu vas brancher Bootstrap à ton application</li>
  <li>Tu vas faire un header qui comprend les liens importants de ton application, puis le mettre pour toutes les vues de ton application</li>
  <li>Tu vas faire la page d'accueil du site</li>
  <li>Tu vas faire la page profil d'un utilisateur</li>
  <li>Tu vas faire la page de création d'événement</li>
  <li>Tu vas faire la page qui affiche un événement</li>
</ul>

<p>Cela peut paraître flou, mais avec le REST, quelques méthodes de controllers, et un branchement Devise, ton application sera faite bien plus rapidement que la semaine qu'il t'a fallu pour l'application Gossip Project (alors que les deux applications sont très similaires). Ceci est dû principalement au fait que tu commences à gérer la fougère. Bravo ;)</p>

<h2>2. Le projet</h2>

<p>Avant de commencer, nous allons faire la première vue de l'application : la page d'accueil. Cette page d'accueil est la liste des événements de ta ville, donc l'index des événements. Génère un <code>events_controller</code>, avec la méthode index. Branche cette méthode index à la page d'accueil du site.</p>

<h3>2.1. Branchement de Bootstrap</h3>
<p>Bootstrap te permettra d'avoir une navbar qui te permet de naviguer dans l'application. Cette navbar contiendra les liens suivants :</p>

<ul>
  <li>Lien pour accéder à l'accueil du site (et donc la liste des événements)</li>
  <li>Lien pour créer un événement (<code>events#new</code>)</li>
  <li>Liens de profil :
  <ul>
    <li>Si le visiteur n'est pas connecté, un dropdown "S'inscrire / Se connecter" avec deux liens : 
    <ul>
      <li>"S'inscrire", qui correspond à l'inscription d'un utilisateur (<code>registrations#new</code>).</li>
      <li>"Se connecter", qui correspond à une connexion d'utilisateur (<code>sessions#new</code>).</li>
    </ul></li>
    <li>Si l'utilisateur est connecté, un dropdown "Mon profil" avec deux liens :
    <ul>
      <li>"Mon profil", qui est la page qui affiche le profil de l'utilisateur (<code>users#show</code>).</li>
      <li>"Se déconnecter", qui correspond à un logout (<code>sessions#destroy</code>).</li>
    </ul></li>
  </ul></li>
</ul>

<p>Fais donc cette navbar. Comme les routes de ces liens ne sont pas encore définies, mets <code>#</code> aux urls des liens. On les implémentera au fur et à mesure.</p>

<h3>2.2. Branchement de Devise</h3>
<p>Passons aux choses sérieuses. Nous allons passer par Devise pour toute l'authentification de ton application. Installe Devise et branche-la au model <code>User</code> comme vu dans le cours : </p>

<div class="card box-shadow-0 border-danger">
  <div class="card-content collapse show">
    <div class="card-body">
      <h4 class="card-title">⚠️ ALERTE ERREUR COMMUNE</h4>
      <p>En temps normal, on créé le model user en même temps que le branchement Devise. Cependant, si l'on tavait demandé hier de faire la base de données ET brancher les emails ET brancher Devise, ton pauvre cerveau aurait déclaré forfait 😵</p>

<p>On va donc t'aider pour cette migration un peu rocambolesque. Ne t'en fais pas, ça va bien se passer et rien ne te pêtera à la gueule. Grosso modo, on va juste changer le fichier de migration.</p>

      <p>Installe Devise comme prévu, puis génère le devise user via <code>$ rails g devise user</code>. Cela va créer un fichier de migration, qui n'est pas bon. En effet, comme Devise est ajouté sur un model déjà existant, la gem ne sait pas trop comment gérer cette migration donc il y aura quelques éléments à changer. Ce sera l'occasion de réviser en douceur les migrations avec ce petit pas à pas. Super non ?</p>

      <p>Encore une fois, en général on créé le model via son ajout avec Devise ; mais comme il y avait beaucoup d'informations à gérer hier, on a pensé à ta santé mentale et à ton cerveau.</p>

      <p>Déjà, Devise avait compris que ton model <code>User</code> existe déjà : le fichier de migration ne fait plus <code>create_table</code>, mais <code>change_table</code> (si l'on compare avec celui donné dans la ressource). Malin. L'autre changement majeur par rapport à la ressource est qu'il ne fait plus <code>def change</code>, mais <code>def self.up</code> et <code>def self.down</code>. En gros Devise te laisse plus de choix dans ce que tu veux faire. Sympa, mais on s'en bat un peu les couilles pour le moment.</p>

<p>Maintenant, si tu regardes le <code>self.down</code>, tu devrais voir les lignes suivantes :</p>

<pre><code class="language-ruby">def self.down
  # By default, we don't want to make any assumption about how to roll back a migration when your
  # model already existed. Please edit below which fields you would like to remove in this migration.
  raise ActiveRecord::IrreversibleMigration
end</code></pre>
  

<p>En gros, Devise te dit "on ne sait pas trop comment tu as géré ton model user jusqu'à présent, donc la seule ligne que l'on va mettre est <code>raise ActiveRecord::IrreversibleMigration</code>". Cette ligne va balancer une erreur et tu devras changer à la main le <code>self.down</code> pour faire marcher le rollback. Pour résumer, tu peux faire des migrations vers up, mais vers down il va te balancer une erreur. On va rectifier cela.</p>

<p>Enfin, avec un peu d'attention, tu peux remarquer que le fichier de migration va créer une colonne pour les emails et une colonne pour les encrypted_password. Comme tu l'as déjà fait hier, pas besoin de les ajouter. D'ailleurs si tu fais ta migration, cela plantera en te disant que les colonnes emails et encrypted_password existent déjà.</p>

<p>Pour résumer, voici ce qu'il faut faire pour faire marcher ton fichier de migration :</p>
<ul>
  <li>remplace <code>def self.up</code> par <code>def change</code></li>
  <li>vire toutes les lignes qui concernent <code>def self.down</code> (le <code>def.self.down</code> ainsi que le <code>end</code>, ainsi que ce qui est à l'intérieur)</li>
  <li>vire les lignes qui ajoutent une colonne <code>email</code> et une colonne <code>encrypted_password</code></li>
</ul>

<p>Voilou ! Tu pourras faire des migrations, des rollbacks, utiliser Devise comme un chef, faire la samba, et siroter un thé pendant que tes cookies seront cuisinés par cette gem qui fait le café (cette blague est drôle parce que en fait j'ai utilisé thé et café dans la même phrase. trolol).</p>    </div>
  </div>
</div>


<p>Une fois que Devise est branchée, je veux que tu génères les views de Devise :</p>

<ul>
  <li><code>app/views/devise/registrations/new.html.erb</code> : inscription au site : accessible depuis la navbar</li>
  <li><code>app/views/devise/sessions/new.html.erb</code> : connexion au site : accessible depuis la navbar</li>
  <li><code>app/views/devise/passwords/new.html.erb</code> : l'écran "mot de passe oublié ?" où tu rentres ton adresse email pour recevoir un email de réinitialisation de mot de passe : accessible grâce à la partial <code>shared_links</code></li>
  <li><code>app/views/devise/registrations/edit.html.erb</code> : l"écran pour modifier son email et son mot de passe : accessible depuis la page profil.</li>
  <li><code>app/views/devise/passwords/edit.html.erb</code> : la vue où tu rentres ton nouveau mot de passe (tu y accèdes en cliquant dans le lien "réinitialiser le mot de passe" dans ton email de réinitialisation de mot de passe) : accessible depuis l'email de demande de changement de mot de passe.</li>
</ul>

<p>Nous te laissons ajouter les liens d'inscription et de connexion à la navbar, puis de faire en sorte que toutes les views affichent bien la navbar.</p>


<p>Enfin, pour que Devise fonctionne correctement, il te faut faire le branchement du mailer. Rien de plus frustrant de faire une demande de réinitialisation de mot de passe et de ne jamais recevoir son mot de passe. Fais donc les modifications nécessaires pour que Devise envoie bien les emails de récupération.</p>

<p>Une fois que tu as fait cela, pousse le tout sur Heroku et assure toi que ça marche aussi bien que sur ton ordi !</p>

<p>Et là, tu réalises que tu viens de réaliser un système complet d'authentification d'utilisateurs, fonctionnel et en production. C'est une excellente étape vers un site fonctionnel et tu peux être fier de toi.</p>


<h3>2.3. Faire les premières views</h3>
<p>Avant de passer à cette partie, assure toi que l'ensemble des fonctionnalités demandées ci-dessus fonctionne au poil : c'est le minimum pour valider le projet.</p>
<p>Dans cette partie, nous allons construire les premières views pour que l'application commence à marcher. C'est un processus long donc tu n'arriveras probablement pas à tout faire :</p>

<ol>
  <li>La page d'accueil du site (<code>events#index</code>)</li>
  <li>La page profil d'un utilisateur (<code>users#show</code>) => Essaye de finir cette view</li>
  <li>La page de création d'un événement (<code>events#new</code>) => Super si tu arrives jusqu'ici</li>
  <li>La page d'affichage d'un événement (<code>events#show</code>) => Pour les plus déterminés</li>
</ol>

<p>Tu peux commencer à générer les controllers, leurs méthodes, et écrire les routes pour ces premières views. Bien entendu, il est interdit d'utiliser les routes en <code>GET</code>/<code>POST</code> et tu devras utiliser <code>resources</code>.</p>

<h4>2.3.1. La page d'accueil</h4>
<p>La page d'accueil du site affiche tous les événements de l'application. Pour chaque événement, tu pourras cliquer sur un lien qui t'emmènera vers la page <code>show</code> de l'événement. La page d'accueil invitera l'utilisateur à créer son événement.</p>

<p>Pour le front, on est comme d'habitude fans <a href="https://getbootstrap.com/docs/4.0/examples/" target="_blank">des exemples</a> de Bootstrap. La page <a href="https://getbootstrap.com/docs/4.0/examples/jumbotron/" target="_blank">jumbotron</a> par exemple a l'air de bien correspondre à ce que l'on veut en page d'accueil.</p>

<p>Bien sûr assure toi que ton seed génère quelques <code>Event</code> afin de donner un peu de contenu à cette page d'accueil.</p>

<h4>2.3.2. La page profil d'un utilisateur</h4>
<p>La page profil d'un utilisateur devra afficher les informations de l'utilisateur : prénom, nom, description, e-mail (la plupart de ces informations ne sont pas encore renseignées par l'utilisateur, mais le but de cette page est de vous faire faire ce qui va suivre).</p>

<p>La page de profil d'un utilisateur va afficher les événements qu'il a créés (un <code>title</code> et un lien pour chaque <code>Event</code> dont il est administrateur).</p>


<p>Ensuite, la page de profil d'un utilisateur ne doit pas être accessible par ces deux types de personnes :</p>

<ul>
  <li>Les visiteurs non connectés (<code>authenticate_user!</code>)</li>
  <li>Les utilisateurs connectés, mais qui ne sont pas sur la page de leur profil (user 23 n'a pas le droit d'aller sur la page profil de user 36). Pour ceci, il te faudra coder une méthode spécifique et t'assure qu'elle est appelée avant (ou au début) de la méthode <code>users#show</code></li>
</ul>

<p>En gros, la page profil ne doit être accessible que par la personne concernée. La page de profil doit aussi insérer un lien pour l'édition de l'email et du mot de passe informations importantes (<code>registrations#edit</code>). Les autres informations (la description, le prénom, le nom) ne seront pas éditables.</p>


<p><b>BONUS pour ceux qui sont en GODMODE</b> : vous pouvez ajouter un lien pour éditer les informations de profil (<code>users#edit</code>) : la description, le prénom, le nom.</p>

<h4>2.3.3. Création d'un événement</h4>
<p>À partir de la navbar (et de la page d'accueil), il est possible de créer un événement. La création d'événement demandera :</p>

<ul>
  <li>Sa <code>start_date</code></li>
  <li>Sa <code>duration</code></li>
  <li>Son <code>title</code></li>
  <li>Sa <code>description</code></li>
  <li>Son <code>price</code></li>
  <li>Sa <code>location</code> (un input normal suffira)</li>
</ul>

<p>Nous t'invitons à regarder <a href="https://getbootstrap.com/docs/4.0/components/forms/" target="_blank">la page des formulaires de Bootstrap</a> pour t'inspirer sur les visuels que tu peux utiliser.</p>

<p>Quand un événement est créé, le <code>current_user</code> doit y être associé en tant qu'administrateur. Cela veut dire que Devise devra authentifier l'utilisateur avant de pouvoir faire <code>new</code> ou <code>create</code>. Une fois l'événement créé, l'utilisateur sera redirigé vers la page <code>show</code> de l'événement.</p>

<h4>2.3.4. Afficher un événement</h4>
<p>C'est long de tout implémenter non ? Si tu es arrivé jusqu'ici, BRAVO ! Maintenant tu vas afficher un événement. Cette page devra montrer :</p>

<ul>
  <li>Le titre de l'événement</li>
  <li>Sa description complète</li>
  <li>Le nombre d'inscrits à l'événement</li>
  <li>Le créateur (son email suffira)</li>
  <li>Sa date de début, et sa date de fin (la date de fin est une méthode d'instance)</li>
  <li>Le lieu de l'événement</li>
  <li>Son prix</li>
</ul>

<p>Demain nous verrons la page pour s'inscrire à l'événement en tant que participant.</p>


<h2>3. Rendu attendu</h2>
<p>Un repo GitHub accueillant l'app Rails avec un maximum des fonctionnalités ci-dessus. Le tout doit être disponible sur Heroku (lien dans le README).</p>
<p>Avec ceci, tu as une belle application où les gens peuvent voir la liste des événements disponibles dans leur ville. C'est un excellent début et tu peux être fier de toi.</p>
<p> Demain nous allons ajouter les fonctionnalités pour rejoindre un événement et ton application sera prête et fonctionnelle pour être montrée à la Terre entière. À partir de jeudi on implémentera des fonctionnalités pas indispensables, mais qui vont agrémenter l'expérience utilisateur (gestion des images, interface administrateur).</p>
