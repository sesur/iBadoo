# iBadoo este inca in proces de dezvoltare. 

La momentul de fata sunt realizate partea de UI-ul si chat-ul in mare masura. 
Am migrat aplicatia la ultima versiune disponibila de Swift 4.2  


Design-ul aplicatiei poate fi gasit aici:
https://www.dropbox.com/sh/63cwujf16ip46f3/AABOc-DTJhK359uwVMnRV9dna?dl=0


Ghid de utilizare:

Rularea aplicatiei:
    1. Descarca aplicatia utilizind comanda "pull" de pe github.

    2. Din directoriu parinte al proiectului ruleaza fisierul ".xcworkspace" pentru a start proiectul (Coman + R)

    Proiectul va rula fara probleme imediat dupa ce va fi descarcat de pe GitHub, in caz ca se doreste ca backendul sa fie setata pe un alt account Firebase (la moment este setat pe accountul personal), urmareste instructiunile Configurarea Firebase in proiect.   




Back-endul e realizat cu ajutorul framework-lui Firebase. Pentru a putea reconfigura backendul pe un alt account Firebase,  urmareste pasii de configurare a librariei in proiect. 

Configurarea Firebase in proiect: 

    1. Pentru a utliza acest framework este necesar mai intii crearea unui accout & logarea pe https://firebase.google.com

    2. Sterge "GoogleService-Info.plist" din proiectul "iBadoo". 

    3. In Firebase -  Go to Console -> Add project - adauga un proiect in Firebase conform instructiunilor sugerate de documentia frameowrk-ului

    4. Integreaza "GoogleService-Info.plist" din accountul tau in proiectul descarcat de pe git, conform instructiunilor Firebase. 

    4. Dupa integrarea fisierului "GoogleService-Info.plist" in proiect, ruleaza aplicatia (Coman + R). 
    PS: Celelate componente sunt setate deja in proiect, structura bazei de date



Bugs: 
La chat este necesar de a fixa urmatorul bug- orice ulitizator poate vizualiza mesajele si altor utilizatori.



Utilizarea aplicatiei la moment : 

Register: 
Pentru aceasta ramura este elaborata doar partea de UI si navigare, fara functional aditional. 

Login/Log out:
Functioneaza doar autentificarea si logarea prin Facebook, dupa logarea reusita in facebook se va efectua navigarea catre aplicatia principala (TabBarController). 

Radar: 

Aplicatia principala va incepe cu Controllerul si animatiile "Radar" - care incepe imedia cautarea tuturor persoanelor inregistrate in aceasta aplicatie. Dupa ce se va finisa cautatea se vor afisha lista tuturo persoanelor gasite si cu care se poate de comunicat. 

Pentru a incepe chatul cu persoana dorita este necesar sa faci swipe de la dreapta-stinga -> write/add friend/bock, acestea vor fi optiunile ce vor aprea. Functioneaza doare optiunea "write". La accesarea optiunii "write" se va efectua navigarea catre pagina de chat. 

Inbox:

La accesarea "Inbox" va fi afisata lista de persoane cu care s-a comunicat, sortate dupa timpul de receptionare/expediare a mesajului. La fiecare persoana din aceasta lista se va afisa in mod real-time ultimul mesaj trimis/primit. Selecteaza persoana cu care doresti sa comunici pentru a scrie un mesaj. 

Chat:

In "Chat" se afiseaza in mod real-time lista cu toate mesaje discutatea intre doua persoane, daca se navigeaza back catre Inbox Controller, apoi iarasi daca dorim sa navigam catre Chat Controller la una din persoane cu care am discutat, se va pastra doar ultimul mesaj expediat/primit.

Favorites & Alarm: e creat doar partea de UI. 

Profile: 

Va avisa nume/prenumele/profileImage perosnei care s-a logat. 

    Profile pictures - va accesa toate pozele/imaginile din dispozitiv. La selectea unei imagini va aparea un popup cu optiunea de a stergere (nu este elaborata partea functionala, doar UI-ul)
    Log out - dezlogarea. 
    
    




















