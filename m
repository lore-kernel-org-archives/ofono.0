Content-Type: multipart/mixed; boundary="===============4149480789546073309=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: IPV6 question
Date: Thu, 06 Oct 2016 12:29:42 -0500
Message-ID: <57F68A06.80607@gmail.com>
In-Reply-To: <CAH4ZQwvMbA+quNT5QmdQUM1f5CdjwgVL2k4k45Lo-ZSJC_z72g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4149480789546073309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 10/06/2016 02:13 AM, Enrico Sau wrote:
> Hi Denis,
>
>     Which modem are you using, if its no secret?
>
>
> =E2=80=8BNo secrets, I'm using this:
> http://www.telit.com/cellular/4g-modules/xe910-family/
> The V2 series.

Okay, I should have one around somewhere.  Not sure I have a provider =

that allows dual stack contexts though.

>
>     It looks like IPV6CP was never properly integrated into GAtPPP
>     logic. At least I don't see ipv6cp_new() inside gatchat/gatppp.c
>     anywhere.  You might have to extend gatppp.c to manage IPV6CP as well.
>
>
> =E2=80=8BI will look into it.
> Do you think is a difficult task?=E2=80=8B

Shouldn't be particularly difficult assuming IPV6CP itself was done =

properly.  You might need to tweak GAtPPPConnectFunc to relay the ipv6 =

address and tell GAtPPP which protocols to run.  E.g. ipv6cp, ipcp, or both.

> =E2=80=8B=E2=80=8B
>
> =E2=80=8BI extended several ofono interfaces fot telit modems.
> I will find the time to submit some changes sooner or later=E2=80=8B.
>

Cool.

Regards,
-Denis

--===============4149480789546073309==--

