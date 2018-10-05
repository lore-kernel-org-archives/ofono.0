Content-Type: multipart/mixed; boundary="===============0148929482794975867=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 6/6] drivers: support for auth NONE
Date: Fri, 05 Oct 2018 04:51:42 +0200
Message-ID: <CAKSBH7HHoEnjTMvqyG6KqRKuTOZN+pbCvj7CBm5510uBG47ktg@mail.gmail.com>
In-Reply-To: <582370e9-6ac2-987f-a458-6d3aa31e5bca@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0148929482794975867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Oct 5, 2018 at 4:47 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> >>
> >> I prefer we set a good example :)
> >
> > Then the cleanest way is to set a default in the switch, without any fu=
nction.
> > Ok?
> >
>
> That is not really great either.  We want to make sure that the compiler
> warns us if we add a new enumeration and don't take care of it in the
> code.  In fact we have a coding-style.txt entry for this as well, see
> item M12.  If there's code that uses default labels for enums, it is
> likely not compliant and should probably be fixed.
>

You are not giving any choice here, other than rewriting gcc.
The function I have tried, and the compiler still complains.
I need a way out: please decide for the lesser evil, and I'll do it.

> Regards,
> -Denis

Regards,
Giacinto

--===============0148929482794975867==--

