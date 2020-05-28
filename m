Content-Type: multipart/mixed; boundary="===============5561399929911216112=="
MIME-Version: 1.0
From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH] Adds optional phone number parameter to ofono-phonesim
Date: Thu, 28 May 2020 12:17:56 +0200
Message-ID: <20200528101756.4xr3bstjj4htpiih@lem-wkst-02.lemonage>
In-Reply-To: <DB7PR10MB2012E817D8D929B468140A88C2B10@DB7PR10MB2012.EURPRD10.PROD.OUTLOOK.COM>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5561399929911216112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bettina-Jennifer,

whatever way you chose to send your patches, this is totally messed up.
It would be very hard to extract usable information from this email. It
looks like you wanted to send two patches, but it is just one email.
Your email does include text and html parts, which is also not good.
If you want someone to:
* look at your patches
* try them out
* comment on them
* or even include them in the ofono repository
you have to follow the steps documented in the HACKING file of ofono.
Especially the "Submitting patches" section.
Really please use git send-email to send your patches or at least send
them in a format that is acceptable by git am.

Regards,
Lars

On Wed, May 27, 2020 at 09:51:37AM +0000, Bettina Jennifer Riedl wrote:
> Hello,
> =

> this patch adds an optional phone number parameter to ofono-phonesim, ins=
tead of using the default number.
> =

> Greetings
> Bettina
> =

> Michael Klemm:
> Added phone number as additional parameter (1/2)
> AUTHORS: Mention Michael's contributions      (2/2)
> =

> (1/2)
> diff --git a/src/main.cpp b/src/main.cpp
> index 712e767..a20bc1a 100644
> --- a/src/main.cpp
> +++ b/src/main.cpp
> @@ -28,13 +28,14 @@ static void usage()
> {
>      qWarning() << "Usage:"
>                 << QFileInfo(QCoreApplication::instance()->applicationFil=
ePath()).fileName().toLocal8Bit().constData()
> -               << "[-v] [-p port] [-gui] filename";
> +               << "[-v] [-p port] [-gui] [-n number] filename";
>      exit(-1);
> }
>  int main(int argc, char **argv)
> {
>      QString filename =3D nullptr;
> +    QString number =3D "+491701234567";
>      QCoreApplication *app;
>      int port =3D 12345;
>      int index;
> @@ -61,6 +62,15 @@ int main(int argc, char **argv)
>          } else if ( strcmp(argv[index],"-h") =3D=3D 0
>                  || strcmp(argv[index],"-help") =3D=3D 0 ) {
>              usage();
> +        } else if ( strcmp(argv[index],"-n") =3D=3D 0
> +                || strcmp(argv[index],"-num") =3D=3D 0 ) {
> +            index++;
> +            if (index >=3D argc) {
> +                qWarning() << "ERROR: Got -n but missing phone number";
> +                usage();
> +            } else {
> +                number =3D argv[index];
> +            }
>          } else {
>              // must be filename.  SHOULD be last argument.
>              if (index !=3D argc-1) {
> @@ -85,7 +95,7 @@ int main(int argc, char **argv)
>      } else
>          app =3D new QCoreApplication(argc, argv);
> -    PhoneSimServer *pss =3D new PhoneSimServer(filename, port, nullptr);
> +    PhoneSimServer *pss =3D new PhoneSimServer(filename, port, number, n=
ullptr);
> =

> diff --git a/src/server.cpp b/src/server.cpp
> index 3ff7def..856a90f 100644
> --- a/src/server.cpp
> +++ b/src/server.cpp
> @@ -22,13 +22,12 @@
> #include "hardwaremanipulator.h"
> #include <qdebug.h>
> -static int phonenumber =3D 555000;
> -
> -PhoneSimServer::PhoneSimServer(const QString &f, quint16 port, QObject *=
parent)
> +PhoneSimServer::PhoneSimServer(const QString &f, quint16 port, const QSt=
ring &n, QObject *parent)
>      : QTcpServer(parent), fact(nullptr), currentRules(nullptr)
> {
>      listen( QHostAddress::Any, port );
>      filename =3D f;
> +    number =3D n;
> }
>  PhoneSimServer::~PhoneSimServer()
> @@ -47,7 +46,6 @@ void PhoneSimServer::setHardwareManipulator(HardwareMan=
ipulatorFactory *f)
> void PhoneSimServer::incomingConnection(qintptr s)
> {
>    SimRules *sr =3D new SimRules(s, this, filename, fact);
> -    sr->setPhoneNumber(QString::number(phonenumber));
> -    phonenumber++;
> +    sr->setPhoneNumber(number);
>      currentRules =3D sr;
> }
> =

> diff --git a/src/server.h b/src/server.h
> index 9175359..6790be4 100644
> --- a/src/server.h
> +++ b/src/server.h
> @@ -32,7 +32,7 @@ class HardwareManipulatorFactory;
> class PhoneSimServer : public QTcpServer
> {
> public:
> -    PhoneSimServer(const QString &, quint16 port, QObject *parent =3D nu=
llptr);
> +    PhoneSimServer(const QString &, quint16 port, const QString &, QObje=
ct *parent =3D nullptr);
>      ~PhoneSimServer() override;
>      void setHardwareManipulator(HardwareManipulatorFactory *f);
> @@ -44,6 +44,7 @@ protected:
>  private:
>      QString filename;
> +    QString number;
> =

> =

> =

> (2/2)
> diff --git a/AUTHORS b/AUTHORS
> index 9b8a840..d8e107f 100644
> --- a/AUTHORS
> +++ b/AUTHORS
> @@ -15,3 +15,4 @@ Jussi Pakkanen <jussi.pakkanen@canonical.com>
> James Prestwood <james.prestwood@linux.intel.com>
> Simon Busch <morphis@gravedo.de>
> Jonah Br=C3=BCchert <jbb.prv@gmx.de>
> +Michael Klemm <mklemm@assystem.com>
> _________________________________________________________________________=
____________
> =

> Expleo Germany GmbH
> Sitz der Gesellschaft | Corporate Headquarters: M=C3=BCnchen
> Handelsregister | Commercial Register: Amtsgericht M=C3=BCnchen HRB 83252
> Gesch=C3=A4ftsf=C3=BChrung | Management: Ralph Gillessen, Josef Mitterhub=
er
> =

> This message contains information that may be privileged or confidential.=
 It is intended only for the person to whom it is addressed.
> If you are not the intended recipient, you are not authorized to read, pr=
int, retain, copy, disseminate, distribute, or use this message or any part=
 thereof.
> If you receive this message in error, please notify the sender immediatel=
y and delete all copies of this message.
> _________________________________________________________
> =

> EMAIL LEGAL MENTION / DISCLAIMER
> =

> This message contains information that may be privileged or confidential =
and is the property of the Expleo Services SAS, RCS Versailles 831 178 348,=
 located, 3 avenue des Pr=C3=A9s, 78180 Montigny Le Bretonneux - France. It=
 is intended only for the person to whom it is addressed. If you are not th=
e intended recipient, you are not authorized to read, print, retain, copy, =
disseminate, distribute, or use this message or any part thereof. If you re=
ceive this message in error, please notify the sender immediately and delet=
e all copies of this message.
> =

> Ce message contient des informations qui peuvent =C3=AAtre privil=C3=A9gi=
=C3=A9es ou confidentielles et elles sont de la propri=C3=A9t=C3=A9 d'Exple=
o Services SAS, RCS Versailles 831 178 348, situ=C3=A9, 3 avenue des Pr=C3=
=A9s, 78180 Montigny le Bretonneux-France. Il est destin=C3=A9 uniquement =
=C3=A0 la personne =C3=A0 qui est adress=C3=A9. Si vous n'=C3=AAtes pas le =
destinataire vis=C3=A9, vous n'=C3=AAtes pas autoris=C3=A9 =C3=A0 lire, imp=
rimer, conserver, copier, diffuser, distribuer ou utiliser ce message ou to=
ute partie de celui-ci. Si vous recevez ce message par erreur, veuillez en =
avertir imm=C3=A9diatement l'exp=C3=A9diteur et supprimer toutes les copies=
 de ce message.

> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org

--===============5561399929911216112==--

