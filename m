Content-Type: multipart/mixed; boundary="===============4073803244145329433=="
MIME-Version: 1.0
From: George Matveev <george@matveev.se>
Subject: Re: [PATCH] build: Update glib version in configure.ac
Date: Fri, 19 Nov 2010 10:25:03 +0100
Message-ID: <b15dad41b90dffb9b3e1adf169090637.squirrel@squirrel-webmail.surftown.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4073803244145329433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

you are right.
I've just corrected that and resubmitted the patch, please review.

Best regards,
George

--------------------------- Ursprungligt brev ----------------------------
=C3=84rende: Re: [PATCH] 	build: Update glib version in configure.ac
Fr=C3=A5n:   "Marcel Holtmann" <marcel@holtmann.org>
Datum:  Fr, 2010-11-19, 08:01 am
Till:   ofono(a)ofono.org
--------------------------------------------------------------------------

Hi George,

> function g_mkstemp_full in src/storage.c
> requires glib version 2.22 or higher
> ---
>  configure.ac |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

patch looks good, but your subject line has a ^I character in it and I
prefer not to figure out what git does with it. So please fix this
first.

Regards

Marcel


_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono



--===============4073803244145329433==--

