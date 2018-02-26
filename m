Content-Type: multipart/mixed; boundary="===============4992514415292445572=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Ofono LTE modems and connman services
Date: Mon, 26 Feb 2018 15:37:43 +0100
Message-ID: <0643a0f2-e7ab-3b6e-30b3-d922ba325dbb@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4992514415292445572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The following issue is causing us some grief and I really need some =

guidance on how to approach this.  This is being sent to both the ofono =

and connman mailing lists because it's not really clear to me who's =

doing the right/wrong thing here...

The connman ofono plugin does the following:
i)  It powers up (enables) the modem
ii)  If cellular tech is enabled, it brings the modem online

For an LTE-modem, this second step results in a default bearer being =

attached and thereby the modem is 'connected'.  The third connman step, =

setting the ofono context to Active, is not required for LTE; the =

context becomes 'Active=3Dtrue' right away.

The above effectively means that it's not possible to have an LTE modem =

that does not auto-connect (in connman terms).

Now the APN that ofono sets on the LTE context is 'automatic'; that was =

selected because connman _requires_ some APN or else it ignores the =

context altogther.

If the modem roams away from LTE connectivity and wants to fallback to =

UMTS/GSM, it needs another context with a valid APN.  So now the modem =

has two 'internet' contexts ('automatic' and APN) which connman presents =

as two distinct services.

These two services, as far as I can tell, end up competing with each =

other when connecting and a mess ensues... if the lower numbered context =

is the 3G context, connman goes into an endless loop attempting to set =

it Active and continuously failing when the tech switches to LTE.

The question is, what are the expectations here:
i)   What does it mean for connman to see two 'internet' contexts since =

it sets up two services for them?
ii)  How is a modem supposed to roam between LTE and UMTS/GSM networks =

when one requires an APN and the other does not.
iii) Not auto-connecting an LTE modem means not bringing it online; what =

implications does this have for connman?

The above is currently a bit of a confusing mess and both ofono and =

connman get themselves tied in a knot when the modem switches between =

LTE and non-LTE techs.  Any guidance on how to approach this would be =

appreciated.

Thanks,
Jonas




--===============4992514415292445572==--

