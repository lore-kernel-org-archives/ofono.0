Content-Type: multipart/mixed; boundary="===============1552623321695483770=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Autotool improvements.
Date: Fri, 09 Oct 2009 11:02:37 +0200
Message-ID: <1255078957.3286.7.camel@localhost.localdomain>
In-Reply-To: <200910091136.33436.remi@remlab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1552623321695483770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi guys,

> > Bootstrap script now tries to use explicitly versioned automake, which
> > makes life easier with scratchbox and friends. Bootstrap also uses
> > autoreconf instead of explictly running various autotools.
> =

> As autoreconf already uses those variables, I wonder why not just call it=
 and =

> be done with it.

when I started using the bootstrap stuff we use accross BlueZ, ConnMan,
oFono etc. the autoreconf was horrible and broken. Let me look into this
again and see how we can make this more consistent. Especially since
everybody should use automake-1.11 do get the sexy silent build system.

Regards

Marcel



--===============1552623321695483770==--

