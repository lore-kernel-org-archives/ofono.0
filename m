Content-Type: multipart/mixed; boundary="===============1191173949292161177=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 6/6] drivers: support for auth NONE
Date: Fri, 05 Oct 2018 06:13:41 +0200
Message-ID: <CAKSBH7FgsEsj3EMJSUFZT4DSunJUE6j1y9=KK=mkfhhR28dWDA@mail.gmail.com>
In-Reply-To: <e4bf5417-581a-cc25-c90b-04c17a013e59@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1191173949292161177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Oct 5, 2018 at 6:09 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> >> Not according to any compiler I tried.  I literally tested this before
> >> sending the above email on both GCC 7.3 and GCC 8.2.  So what compiler
> >> are you using?
> >
> > default ubuntu 18.04 compiler:
> > gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
>
> This was the same on my box.  I bet you were just missing the
>
> if (auth_to_foo() < 0) part

maybe. I will go for the mbim way, in any case.

>
> > I will submit a new patch later today.
> > Would you please comment on the [PATCH 4/6] too, about the plugins, so
> > I will take care of both together?
> >
>
> Done.  And please re-submit the entire series.  Otherwise I get lost
> what version goes with what.

Ok. The series now has 5 parts, because you have taken the 5/6 for gatchat.

>
> Regards,
> -Denis

Regards,
Giacinto

--===============1191173949292161177==--

