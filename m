Content-Type: multipart/mixed; boundary="===============6526251428543226741=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/6] PPP Patches v3
Date: Mon, 22 Mar 2010 20:47:16 -0700
Message-ID: <1269316036.4851.60.camel@localhost.localdomain>
In-Reply-To: <20100322202202.252f0bae@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6526251428543226741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> > > > Changes since v2 - corrected whitespace. =

> > > =

> > > all the patches have been applied.
> > > =

> > > So form now on please send smaller patches as soon as you have them
> > > ready and tested. If you need comments or have questions, you can use
> > > the mailing list as well.
> > =

> > some additional comments from my side.
> > =

> > If you have variables that are only valid inside the scope of a
> > statement, then I prefer if you only declare them there. This makes the
> > code a bit simpler to read. Check the patch I just pushed to give you an
> > example.
> > =

> > Also please find access to a 32-bit system if you are running 64-bit or
> > vice versa. Our build system is strict and will turn turn all casting
> > mistakes in an error.
> > =

> > Please be present on #ofono IRC as much as possible so people can report
> > such things. Remember that your code is now part of the tree and it can
> > break the build.
>
> I just started reviewing the changes you made and the first =

> patch I hit I discovered that you broke something.  Would you like to
> revert the patches and let me review them first, or should I just send =

> a patch to the mailing list to fix what you broke?

send patches to the mailing list to fix them. The PPP code is in
development so it is just fine. I prefer to keep reverts for code that
is suppose to be stable.

If I did break something, then I am worried that the code gets too
complex. Such little changes should not have broken anything. Except I
made a stupid typo or thinking mistake (which happens of course). If it
fundamentally changes the code flow, then we do have a bigger problem.

Regards

Marcel



--===============6526251428543226741==--

