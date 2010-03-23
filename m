Content-Type: multipart/mixed; boundary="===============6952120159696861240=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/6] PPP Patches v3
Date: Tue, 23 Mar 2010 12:07:21 -0700
Message-ID: <1269371241.11714.99.camel@localhost.localdomain>
In-Reply-To: <20100323112617.169cded4@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6952120159696861240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> > > > And there was another problem with one variable being
> > > > guint16, but the is_option casts it back to guint8. We can't really=
 have
> > > > that. Once you start casting on that scale the compiler will not wa=
rn
> > > > you about type mismatches or if the value of argument is too big fo=
r its
> > > > type.
> > > =

> > > Can you please let me know which git commit this fix you made was?  I =

> > > want to review it because all of the option types should only be a by=
te
> > > anyway, so I am trying to figure out if there was a mistake somewhere =

> > > where we were using is_option to examine a 16 bit value.  I searched
> > > through the git log and can't figure out where this change was.  I
> > > can see where you changed the option type we are comparing to a regul=
ar
> > > guint to avoid compiler problems, but not the other issue you mention=
ed.
> > =

> > I had a second look at these. It is the is_proto_handler actually and
> > not the is_option. However that thing applies here. A helper function to
> > find that handle would be better then manually coding g_list_find_custom
> > in the functions.
>
> so is_proto_handler was casting a 16 bit value to an 8 bit value?  Or are=
 you
> just complaining about having g_list_find_custom in the routines.  It wou=
ld
> really be easier on me to understand what you are trying to tell me if you
> you posted your patches to the list next time.

I expect you to ensure that your patches compile on 32-bit systems. And
also that they work on 32-bit and 64-bit systems. In addition I expect
that little endian and big endian works smoothly.

In general I don't wanna have casting in the source since it is a
potential trap for errors. Without casting the compiler will warn us if
we make mistakes, without we run into troubles. Especially with the
different pointer sizes it is important to not cast.

So in this specific cases, I think the usage of g_list_find_custom is
not a good idea. Manually walking this in a helper function and ensuring
that the variable and parameters types are enforced.

In short summary:

1) No casting if not really really needed. Think twice before adding a
casting to the source code.

2) Think about your optimization and understand what you are trying to
optimize. Simple code flow is preferred. Only in hot path we should
attempt to optimize manually and then it needs to be documented in the
source code itself. Otherwise lets GCC do it for us. Walking the GLib
list manually is sometimes a lot simpler to read than trying to use
foreach type functions.

3) No variable initialization on declaration. There are a few exceptions
when it makes sense. However the general rule is not to do it. We want
the compiler to warn us about variables that we might use uninitialized.
In most cases this indicates a mistake in the code flow and that the
code is too complex.

Regards

Marcel



--===============6952120159696861240==--

