Content-Type: multipart/mixed; boundary="===============6596190916707358005=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Patch on unsupported AT command
Date: Fri, 13 Nov 2009 11:05:47 -0600
Message-ID: <200911131105.47291.denkenz@gmail.com>
In-Reply-To: <1258131507.3299.22.camel@violet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6596190916707358005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> Hi Denis,
>
> > > I think this might need a GAtChat quirk function where we can add ext=
ra
> > > terminator responses that will be recognized. And maybe even translat=
ed
> > > into something meaningful.
> >
> > Originally I had the terminators freely definable on the GAtChat + some
> > hardcoded ones, but abandoned that approach since it didn't seem useful.
> > Perhaps this needs to be resurrected.
> >
> > > Denis, or do you want this quirked in every plugin or modem driver?
> >
> > I do prefer non-standard terminators to be setup in the plugin/driver.
>
> I meant adding something like g_at_chat_add_terminator() or so.

Yes, that is what I meant as well.

Regards,
-Denis

--===============6596190916707358005==--

