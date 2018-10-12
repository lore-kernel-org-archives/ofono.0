Content-Type: multipart/mixed; boundary="===============3867266262468103838=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH v2 0/5] lte atom proto and authentication
Date: Fri, 12 Oct 2018 10:25:19 +0200
Message-ID: <30b709cc-56a1-5e10-5eb5-6506a2434053@southpole.se>
In-Reply-To: <20181012081452.19086-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3867266262468103838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Wow... 45 minutes since your last submission and two minutes since I =

sent my last review email.=C2=A0 Impressive speed! ;)=C2=A0 Like I said, sl=
ow down...

Since I doubt any of my comments are incorporated here, I'll just wait =

for v3 before reading them again...


On 12/10/18 10:14, Giacinto Cifelli wrote:
> Second version of the lte atom, with selection of protocol and authentica=
tion.
> In this version the settings are applied as soon as a property is changed.

Include a long description here of what problem you are trying to solve =

and what approach you are using to solve that problem. Reading this =

description should be sufficient for me to be able to understand where =

the following sequence of patches is taking me.

For follow-up versions, include a little section "Changes in v2" that =

tells me how v2 differs from the series v1 that I, possibly, have =

already reviewed.

/Jonas

>
> Giacinto Cifelli (5):
>    lte-api: protocol and authentication properties
>    lte.h: added proto and authentication handling
>    src/lte: added proto and authentication handling
>    atmodem/lte: proto and authentication handling
>    Gemalto contributors so far
>
>   AUTHORS               |   2 +
>   doc/lte-api.txt       |  39 +++++++
>   drivers/atmodem/lte.c |  92 ++++++++++++++--
>   include/lte.h         |   5 +
>   src/lte.c             | 236 ++++++++++++++++++++++++++++++++----------
>   5 files changed, 307 insertions(+), 67 deletions(-)
>


--===============3867266262468103838==--

