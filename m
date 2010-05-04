Content-Type: multipart/mixed; boundary="===============8522093461445921434=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] usbpnmodem: configure usbpn interfaces automatically
Date: Tue, 04 May 2010 16:55:16 +0300
Message-ID: <m2n80fd4e751005040655r63b55f06t69bf9c1bcd94db22@mail.gmail.com>
In-Reply-To: <201004281908.08781.remi@remlab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8522093461445921434==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/4/28 R=C3=A9mi Denis-Courmont <remi@remlab.net>:
> Le mercredi 28 avril 2010 17:15:54 Pekka Pessi, vous avez =C3=A9crit :
>> 2010/4/28 R=C3=A9mi Denis-Courmont <remi@remlab.net>:
>> > I fail to see why we need this. usbpn is already autoconfigured by the
>> > kernel. It only needs to be brought administratively up.
>>
>> This is not the case with 2.6.31. Does it hurt with later kernels?
>
> Not all kernel versions support routing.

You are referring to the route setting with "this", not to the local
address setting? ;-o

> And I'd hate to duplicate existing
> kernel functionality in oFono user-space forever just for 2.6.31 (long te=
rm
> support is 2.6.32 by the way). There's probably two users in the entire w=
orld
> who care about the 2.6.31 + USB CDC Phonet + oFono - phonet-utils combina=
tion.

I'd like to think we have larger developer space for Meego. ;)

-- =

Pekka.Pessi mail at nokia.com

--===============8522093461445921434==--

