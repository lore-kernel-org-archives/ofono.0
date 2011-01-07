Content-Type: multipart/mixed; boundary="===============6765521446248708130=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Fri, 07 Jan 2011 10:52:19 +0200
Message-ID: <201101071052.19202.remi.denis-courmont@nokia.com>
In-Reply-To: <4D250A05.8020405@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6765521446248708130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thursday 06 January 2011 02:17:09 ext Denis Kenzior, you wrote:
> >> If such context is not found create a new one with "Internet" type.
> > =

> > I don't really agree that we should create a context if no match is
> > found. I think the better sensible strategy is to hold this information
> > internally and only map it to a context once the user or provisioning
> > creates it.
> =

> From what I understood it should be quite safe to assume it is an
> internet context.  All IMS contexts will have a well-known APN and the
> only other one that would make sense for the network to activate
> automatically would be the internet one.
> =

> Perhaps this is the missing piece in the description? The fact that
> either the IMS or an Internet context is created.

It could be MMS(/WAP) or it could be some private corporate VPN. Or it coul=
d =

even be some other silliness from some operator(s). I have seen such thing, =

but I am unsure I can talk freely about the details :-(

I would definitely advise against marking unknown context as Internets.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============6765521446248708130==--

