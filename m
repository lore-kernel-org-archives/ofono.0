Content-Type: multipart/mixed; boundary="===============1991431615636958201=="
MIME-Version: 1.0
From: Mark van der Putten <mark.van.der.putten@intemo.com>
Subject: Getting gprs context username and password
Date: Thu, 06 Sep 2018 18:31:11 +0200
Message-ID: <18999ee1-a1e2-1fe5-4cbc-e8791e531094@intemo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1991431615636958201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the gemalto plugin (static void gemalto_post_sim(struct ofono_modem
*modem)) or maybe something sooner in startup phase I would like to
implement AT^SGAUTH

> AT^SGAUTH specifies the authentication protocol, password and user
name to be
> given if a Packet Domain network requires authentication and the
subscriber
> uses AT+CGACT for PDP context activation.

Because connecting with lte to this private APN must be done with radius
authentication.
Hard coding does the trick, but what would be the correct ofono way to
execute the following:

g_at_chat_send(data->app, "AT^SGAUTH=3D1,2,\"xxx\",\"xxx\"",NULL, NULL,
NULL, g_free);

substituting xxx with username and password.

PS gprs context 1 has correct values for:
[context1]
Name=3Dgprs
AccessPointName=3Dprivate.apn
Username=3Dxxx
Password=3Dxxx
AuthenticationMethod=3Dchap
Type=3Dinternet
Protocol=3Dip


Regards,
Mark

Please consider the environment before printing this email. This e-mail, an=
d any files transmitted with it, is confidential and is intended solely for=
 the use of the person or entity to whom it is addressed. If you have recei=
ved this e-mail in error, please notify the sender and delete it from your =
records. On all our offers, sales and deliveries our General Terms of Deliv=
ery are applicable, excluding all other Terms and Conditions. Our terms hav=
e been deposited at the Chamber of commerce Eindhoven (The Netherlands), re=
ference number 17065041, a copy of these terms is enclosed with all quotati=
ons, a hardcopy also can be send on your request. You can find our General =
Terms online at https://www.intemo.com/wp-content/uploads/2018/05/FHI-Algem=
ene-Leveringsvoorwaarden-2014-ENGELS.pdf Op al onze aanbiedingen, verkopen =
en leveringen zijn, met uitsluiting van alle andere voorwaarden, onze algem=
ene voorwaarden van toepassing. Deze zijn gedeponeerd bij de Kamer van Koop=
handel te Eindhoven onder nummer 17065041. Bij iedere offerte hoe ook verzo=
nden zijn de algemene voorwaarden bijgevoegd, een kopie kan op aanvraag ook=
 per post worden toegezonden. U kunt onze algemene voorwaarden online inzie=
n op https://www.intemo.com/wp-content/uploads/2018/05/FHI-Algemene-Leverin=
gsvoorwaarden-2014-NEDERLANDS.pdf

--===============1991431615636958201==--

