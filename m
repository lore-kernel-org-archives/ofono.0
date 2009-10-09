Content-Type: multipart/mixed; boundary="===============4635000110572767500=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [PATCH] Autotool improvements.
Date: Fri, 09 Oct 2009 12:10:28 +0300
Message-ID: <200910091210.28754.remi@remlab.net>
In-Reply-To: <1255078957.3286.7.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4635000110572767500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 09 October 2009 12:02:37 Marcel Holtmann, you wrote:
> > > Bootstrap script now tries to use explicitly versioned automake, which
> > > makes life easier with scratchbox and friends. Bootstrap also uses
> > > autoreconf instead of explictly running various autotools.
> >
> > As autoreconf already uses those variables, I wonder why not just call =
it
> > and be done with it.
>
> when I started using the bootstrap stuff we use accross BlueZ, ConnMan,
> oFono etc. the autoreconf was horrible and broken. Let me look into this
> again and see how we can make this more consistent. Especially since
> everybody should use automake-1.11 do get the sexy silent build system.

VLC has been using autoreconf without problem for a while.
We require automake 1.9.

-- =

R=C3=A9mi Denis-Courmont

--===============4635000110572767500==--

