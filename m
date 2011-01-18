Content-Type: multipart/mixed; boundary="===============5863516129834734599=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] ste: Use UTF-8 as a default character set
Date: Tue, 18 Jan 2011 16:14:20 +0100
Message-ID: <1295363660.3873.207.camel@aeonflux>
In-Reply-To: <1295363423.10484.78.camel@lkunnasl-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5863516129834734599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Laase,

> > is it guaranteed that every single STE modem supports UTF-8 character
> > set?
> > =

> Based on information I have, yes, every single ste modem support UTF-8.
> =

> > I would rather see a new command checking for supported character sets
> > and then picking the default. And intermixing with ATE is not really
> > clean from my perspective.
> You want this to be changed accordingly? I tried to to follow minimalism
> in this simple change and not to introduce new functions. If command
> fails for some reason, modem uses its default value, which is IRA. It
> could be on a separate line, but still I would not add a call back for
> it, nothing to do if the command fails. I prefer the patch I sent, but
> you can decide =


so at least use AT+CSCS=3D\"UTF-8\" as a separate command after the init
command and put a comment above that all STE modems support UTF-8.

And to answer your question, I have seen other modems misbehaving when
it comes to charsets and even lying to use. That is why I asked ;)

Regards

Marcel



--===============5863516129834734599==--

