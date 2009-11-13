Content-Type: multipart/mixed; boundary="===============1210351548919964231=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Patch on unsupported AT command
Date: Fri, 13 Nov 2009 17:58:27 +0100
Message-ID: <1258131507.3299.22.camel@violet>
In-Reply-To: <200911131038.30246.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1210351548919964231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > I think this might need a GAtChat quirk function where we can add extra
> > terminator responses that will be recognized. And maybe even translated
> > into something meaningful.
> =

> Originally I had the terminators freely definable on the GAtChat + some =

> hardcoded ones, but abandoned that approach since it didn't seem useful.  =

> Perhaps this needs to be resurrected.
> =

> >
> > Denis, or do you want this quirked in every plugin or modem driver?
> =

> I do prefer non-standard terminators to be setup in the plugin/driver.

I meant adding something like g_at_chat_add_terminator() or so.

Regards

Marcel



--===============1210351548919964231==--

