Content-Type: multipart/mixed; boundary="===============3990126621753048780=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH] Mark ofono/*.h symbolink links as built sources
Date: Mon, 29 Nov 2010 16:36:35 +0200
Message-ID: <201011291636.35689.remi.denis-courmont@nokia.com>
In-Reply-To: <1291022295.4795.13.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3990126621753048780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Monday 29 November 2010 11:18:15 ext Marcel Holtmann, you wrote:
> Hi Remi,
> =

> > This forces automake/make to build them first if needed (as before).
> > But it avoids marking every single header as a dependency of every
> > single object. Thus we do not need a bogus full rebuild of the tree
> > everytime a header is added.
> =

> I had this before, but it caused problems with make distcheck. So you
> have double checked that this still works?

Yes, I get that:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ofono-0.36 archives ready for distribution: =

ofono-0.36.tar.gz
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============3990126621753048780==--

