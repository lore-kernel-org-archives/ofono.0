Content-Type: multipart/mixed; boundary="===============8178848974662721205=="
MIME-Version: 1.0
From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH 1/2] atmodem: Detect usage of AT+CGEREP
Date: Mon, 31 Aug 2020 13:09:08 +0200
Message-ID: <20200831110908.teaqx77c6ghszua2@lem-wkst-02.lemonage>
In-Reply-To: <e235d27e-8dd2-dc49-6f7c-3da2a8b81615@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8178848974662721205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2020 at 11:49:02AM -0500, Denis Kenzior wrote:
> Hi Lars,
> =

> > > So in theory this could be written like:
> > > int max =3D -1;
> > > iter_open_list(&iter);
> > > =

> > > while (iter_next_range(&iter, &max1, &max2)) {
> > > 	if (max2 > max)
> > > 		max =3D max2;
> > > }
> > > =

> > > iter_close_list(&iter);
> > =

> > I can do this and it does indeed work! :-)
> > =

> > This may be my personal thing, but I find this not very intuitive and
> > hard to read.
> > =

> > To make this more intuitive can we:
> > * move your proposed while loop to a new function
> > * name that function ...iter_next_range_or_list (or something like that)
> > * put that function into gatresult.c
> =

> I'm confused.  iter_next_range specifically handles ranges as defined by =
ITU
> v.250.  See section 5.7.3.1 "Range of Values".
> =

> Here's a small quote:
> "If more than one value is supported, then the values may be listed
> individually, separated by comma characters (IA5 2/12), or, when a
> continuous range of values is supported, by the first value in the range,
> followed by a hyphen character (IA5 2/13), followed by the last value in =
the
> range. The specification of single values and ranges of values may be
> intermixed within a single information text. In all cases, the supported
> values shall be indicated in ascending order."
> =

> The only thing the user has to do is open up a list, since some modems get
> this wrong and don't enclose the entire set in '()'
> =

> > * and in the new at_cgerep_test_cb just use this function ?
> =

> How would you return the set of supported settings?  I guess you could use
> something like l_uintset, but even knowing the valid theoretical range is
> tricky.
> =

> > =

> > I can imagine this new function can be of use at other places as well.
> > What do you think ?
> =

> Given my confusion above, no idea?

Well, given your various hints I think I slowly get how this is supposed
to work.
The main misunderstanding I had was about the role of iter_next_range().
I thought, it should iterate over the whole thing inside the paranthesis
'()' and give me the min and max of this thing. And it did not make
sense to me that it does behave differently for (0,1) and (0-1). Why
should I iterate multiple times inside of the paranthesis with its min -
max calling interface ?
This was what I meant with the function iter_next_range_or_list() as I
called it above that does what I originally expected from the
iter_next_range().

Ok, I will post a solution with your proposed while-loop.

Many thanks for your hints Denis!

Regards,
Lars

--===============8178848974662721205==--

