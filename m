Content-Type: multipart/mixed; boundary="===============1171324341703612788=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: Ofono is not generating core dump
Date: Thu, 02 Nov 2017 11:37:43 +0100
Message-ID: <3186ceaa-7d5a-6dcc-7cbc-490480ec9203@southpole.se>
In-Reply-To: <AM4PR01MB1873D4D7ED61624752C054DF9C5C0@AM4PR01MB1873.eurprd01.prod.exchangelabs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1171324341703612788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

does it's own backtrace.  Comment this out of ofono and you'll get your =

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



--===============1171324341703612788==--

