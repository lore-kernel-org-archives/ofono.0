Content-Type: multipart/mixed; boundary="===============4239887555350636487=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH] Don't use c++ keyword in public header files
Date: Wed, 26 Jan 2011 14:15:41 -0200
Message-ID: <AANLkTi=pfa4T9UYQh_GMoRTVoB-6nwkv34PkdRj3QmPX@mail.gmail.com>
In-Reply-To: <1296035925.1520.102.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4239887555350636487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel

On Wed, Jan 26, 2011 at 7:58 AM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
>> It doesn't. Example:
>
> fair enough. Send a patch that uses one of the other proposed names. And
> you might wanna update the atmodem and isimodem driver as well to just
> be consistent.
>

Only atmodem implements the change_passwd method:

$ grep -RIn change_passwd drivers/*
drivers/atmodem/sim.c:882:static void at_change_passwd(struct ofono_sim *si=
m,
drivers/atmodem/sim.c:1038:	.change_passwd		=3D at_change_passwd,


I'm going to change it too.


regards,

Lucas De Marchi

--===============4239887555350636487==--

