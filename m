Content-Type: multipart/mixed; boundary="===============0718122932578517123=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 6/6] drivers: support for auth NONE
Date: Fri, 05 Oct 2018 05:54:13 +0200
Message-ID: <CAKSBH7Gw_jc93AGGZsi+ZmZy910BJ6DdYOxwUF8bzmjeReHKvw@mail.gmail.com>
In-Reply-To: <b91ce547-a36b-91fa-6dfe-1326cca020ca@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0718122932578517123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>
> And if we ever add a new enumeration and forget to update this code, the
> compiler will complain.  This is what we want.  If we add a default:
> here, compiler will not warn us, that leads to bugs.

in this construct yes, I perfectly agree.

>
> Not according to any compiler I tried.  I literally tested this before
> sending the above email on both GCC 7.3 and GCC 8.2.  So what compiler
> are you using?

default ubuntu 18.04 compiler:
gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0

>
> >
> > Please note that the current code for qmimodem has a default already,
> > and it is the only way the compiler doesn't complain:
>
> And that is wrong and should be fixed.

I will do it, in the mbim way.
Even if technically this should be a different patch, in this episode
I am saving the world from the implicit lack of authentication, not
from the bad coding style.
But the two this time go together.

I will submit a new patch later today.
Would you please comment on the [PATCH 4/6] too, about the plugins, so
I will take care of both together?

>
> Regards,
> -Denis

Regards,
Giacinto

--===============0718122932578517123==--

