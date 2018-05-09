Content-Type: multipart/mixed; boundary="===============3277778613830549756=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: AT error handling
Date: Wed, 09 May 2018 08:53:13 -0500
Message-ID: <f753184a-f54a-3858-dc9a-dbf234fc2ff5@gmail.com>
In-Reply-To: <AM5PR1001MB1171748B26B24E311D6AB16996990@AM5PR1001MB1171.EURPRD10.PROD.OUTLOOK.COM>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3277778613830549756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mattias,

On 05/09/2018 03:28 AM, Mattias M=C3=A5nsson wrote:
> I have a problem with a modem and USB suspend where the OK from some AT =

> commands are sometimes=C2=A0lost. This will be corrected by the vendor, b=
ut =

> it got me wondering how Ofono handles problems like this. As I can see, =

> there is no timeouts for AT commands that doesn't respond? Or have I =

> missed something? It seemed to me that Ofono got stuck in the initial =


This question comes up periodically.  The answer is that GAtChat does =

not have a built-in mechanism for AT command timeouts.  There are =

several reasons for this:

1. It is hard to pick a default timeout that will work in most cases. =

Some commands can take a large amount of time (e.g. COPS operator discovery)
2. If a timeout does trigger, there's really no way to recover reliably. =

  While ITU v.250 does mention the possibility of command cancelation, =

most firmware simply does not support this or only supports a subset of =

commands where this can work.  And even then the behavior can vary =

wildly between implementations.

> setup forever if this happens.=C2=A0In my experience you can't trust that=
 a =


Yep

> modem will always respond and in that case it might be good to have a =

> timeout and reset the modem or something like that.

There's nothing stopping you from implementing a heart-beat check or =

similar logic inside the modem driver itself.  However, the logic of =

'what to do' in case the heart beat stops is quite modem model/firmware =

specific.  This has to be handled by each driver individually.

There's also the possibility that modem firmware itself has a built-in =

heart-beat / crash detector.  This is why ofono_modem_reset was =

introduced and is/was used for modems that have been productized...

Regards,
-Denis

--===============3277778613830549756==--

