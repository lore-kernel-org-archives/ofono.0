Content-Type: multipart/mixed; boundary="===============1831141235921974364=="
MIME-Version: 1.0
From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH 1/2] atmodem: Detect usage of AT+CGEREP
Date: Fri, 21 Aug 2020 10:34:44 +0200
Message-ID: <20200821083444.s43v6wf2tb2s7tlg@lem-wkst-02.lemonage>
In-Reply-To: <45c4a468-df10-ff48-8ec3-36291c3bd33f@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1831141235921974364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Aug 20, 2020 at 09:41:28AM -0500, Denis Kenzior wrote:
> > > So why not just run iter_next_range in a loop?  it actually understan=
ds both
> > > lists and ranges.  See cind_support_cb() for an example.
> > =

> > Ok, I can do this i a loop if you want.
> > =

> > > > +	/* if min1 =3D=3D max1 we had no range but a list and that
> > > > +	 * means we are interested in the last number of that list*/
> > > > +	if (min1 =3D=3D max1) {
> > > > +		while (!g_at_result_iter_close_list(&iter)) {
> > > > +			if (!g_at_result_iter_next_number(&iter, &max1))
> > > > +				break;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	if (!g_at_result_iter_skip_next(&iter)) {
> > > > +		two_arguments =3D false;
> > > > +		goto out;
> > > > +	}
> > > =

> > > Not sure what this is doing?  isn't +CGEREP just two lists ?  Accordi=
ng to 27.007:
> > > "+CGEREP:=C2=A0(list of supported <mode>s),(list of supported <bfr>s)"
> > =

> > Well, we have to deal with very different +CGEREP results. For example
> > on the quectel EC21 I get this:
> > =

> > "+CGEREP: (0-2),(0,1)"
> > =

> > and on the quectel M95 I get this:
> > =

> > "+CGEREP: (0,1)"
> > =

> > So what the code does is this:
> > It tries to parse a range with
> > =

> > g_at_result_iter_next_range(&iter, &min1, &max1)
> > =

> > Now two things can happen: It either parsed the range "(0-2)" then we
> > have min1 !=3D max1, or it tried to parse a list "(0,1)". This time
> > iter_next_range() breaks on the comma ',' and exits with
> > min1 =3D=3D max1 =3D=3D 0. Then we know, we did not find the maximum va=
lue yet
> > and we enter the loop:
> > =

> > =E2=96=B8=C2=B7=C2=B7=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=
=B7while (!g_at_result_iter_close_list(&iter)) {
> > =E2=96=B8=C2=B7=C2=B7=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=
=B7=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7if (!g_at_result_iter=
_next_number(&iter, &max1))
> > =E2=96=B8=C2=B7=C2=B7=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=
=B7=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=E2=96=B8=C2=B7=C2=B7=
=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7break;
> > =E2=96=B8=C2=B7=C2=B7=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=
=B7}
> > =

> > This does then loop to the end of the list until iter_close_list()
> > becomes true, which is at the closing paranthesis ')'. max1 then
> > contains the last item in that list (which we suspect to be the
> > maximum value).
> =

> So in theory this could be written like:
> int max =3D -1;
> iter_open_list(&iter);
> =

> while (iter_next_range(&iter, &max1, &max2)) {
> 	if (max2 > max)
> 		max =3D max2;
> }
> =

> iter_close_list(&iter);

I can do this and it does indeed work! :-)

This may be my personal thing, but I find this not very intuitive and
hard to read.

To make this more intuitive can we:
* move your proposed while loop to a new function
* name that function ...iter_next_range_or_list (or something like that)
* put that function into gatresult.c
* and in the new at_cgerep_test_cb just use this function ?

I can imagine this new function can be of use at other places as well.
What do you think ?

Regards,
Lars
--===============1831141235921974364==--

