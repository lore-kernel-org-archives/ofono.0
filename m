Content-Type: multipart/mixed; boundary="===============0309828768639074812=="
MIME-Version: 1.0
From: Bassem BOUBAKER <bassem.boubaker@actia.fr>
Subject: RE: Ofono is not generating core dump
Date: Thu, 02 Nov 2017 11:56:48 +0000
Message-ID: <AM4PR01MB1873EB735F7AE29561B474739C5C0@AM4PR01MB1873.eurprd01.prod.exchangelabs.com>
In-Reply-To: <3186ceaa-7d5a-6dcc-7cbc-490480ec9203@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0309828768639074812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Good! That worked! I'm able to get my core dump when I commented out the si=
gnal handling sections under src/main.c and src/log.c.

I'm wondering, core dump are very useful when debugging. Why not to mainlin=
e the fact that ofono does it's own backtrace and core dumping at the same =
time or maybe to choose between one of them.


De : Jonas Bonn <jonas@southpole.se>
Envoy=C3=A9 : jeudi 2 novembre 2017 11:37
=C3=80 : ofono(a)ofono.org; Bassem BOUBAKER
Objet : Re: Ofono is not generating core dump
=C2=A0 =


On 11/02/2017 11:35 AM, Bassem BOUBAKER wrote:
> Hi,
>
> When trying to trace ofono crushes, I have noticed that it does not gener=
ate any core dump on my file system.
>
> I'm sure that the issue is not coming from my system because I have verif=
ied that my kernel is good for handling core dump when an app crashes.
>
> Is this related to signal catching from ofono side?

Yes.

src/main.c sets up signal handling whereby it catches SEG faults and =

does it's own backtrace.=C2=A0 Comment this out of ofono and you'll get you=
r =

core dumps back!

/Jonas

>
>
> Regards,
> Bassem.
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono


ofono Info Page
lists.ofono.org
To see the collection of prior postings to the list, visit the ofono Archiv=
es. Using ofono: To post a message to all the list members, send email ...



   =20
--===============0309828768639074812==--

