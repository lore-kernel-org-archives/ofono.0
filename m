Content-Type: multipart/mixed; boundary="===============7008841948180417437=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/6] PPP Patches v3
Date: Mon, 22 Mar 2010 21:51:38 -0700
Message-ID: <1269319898.11714.25.camel@localhost.localdomain>
In-Reply-To: <20100322210727.558b4197@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7008841948180417437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> > > > > > Changes since v2 - corrected whitespace. =

> > > > > =

> > > > > all the patches have been applied.
> > > > > =

> > > > > So form now on please send smaller patches as soon as you have th=
em
> > > > > ready and tested. If you need comments or have questions, you can=
 use
> > > > > the mailing list as well.
> > > > =

> > > > some additional comments from my side.
> > > > =

> > > > If you have variables that are only valid inside the scope of a
> > > > statement, then I prefer if you only declare them there. This makes=
 the
> > > > code a bit simpler to read. Check the patch I just pushed to give y=
ou an
> > > > example.
> > > > =

> > > > Also please find access to a 32-bit system if you are running 64-bi=
t or
> > > > vice versa. Our build system is strict and will turn turn all casti=
ng
> > > > mistakes in an error.
> > > > =

> > > > Please be present on #ofono IRC as much as possible so people can r=
eport
> > > > such things. Remember that your code is now part of the tree and it=
 can
> > > > break the build.
> > >
> > > I just started reviewing the changes you made and the first =

> > > patch I hit I discovered that you broke something.  Would you like to
> > > revert the patches and let me review them first, or should I just sen=
d =

> > > a patch to the mailing list to fix what you broke?
> > =

> > send patches to the mailing list to fix them. The PPP code is in
> > development so it is just fine. I prefer to keep reverts for code that
> > is suppose to be stable.
> > =

> > If I did break something, then I am worried that the code gets too
> > complex. Such little changes should not have broken anything. Except I
> > made a stupid typo or thinking mistake (which happens of course). If it
> > fundamentally changes the code flow, then we do have a bigger problem.
>
> I wanted this code to at least be able to send a packet over the wire,
> and with your changes we can't do that anymore.  The problem is that
> your little cosmetic change really did change the flow, simply because
> you didn't think through what you were doing.  Of course it is up to
> you if you want to have this code be completely non-functional rather
> than simply doing the revert.  I'll be glad to submit a patch later
> which fixes your fix and adds some comments so you know what is =

> actually happening.

I am not doing the revert since I do wanna figure out what broke it. And
actually I wanna have that recorded in the tree.

So Denis and I looked through my changes and he figured out what might
have broken it. So your attempt at doing code flow optimization with
g_list_length() throw me on the wrong error path. Please don't do this
since all the GLib functions will do proper empty list checking.

I fixed this now in the tree and it should restore it to a working code
base. I prefer if you don't do things like GList *list =3D NULL. These
initialization of variables lead to some complex code flow. And if you
do something wrong, the compiler will never warn.

Also in general it is preferred to do list =3D=3D NULL checking instead of
using g_list_legnth() functions.

Regards

Marcel



--===============7008841948180417437==--

