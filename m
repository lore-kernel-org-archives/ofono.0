Content-Type: multipart/mixed; boundary="===============3785915118144874042=="
MIME-Version: 1.0
From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH 1/2] atmodem: Detect usage of AT+CGEREP
Date: Thu, 20 Aug 2020 14:00:07 +0200
Message-ID: <20200820120007.v4tjzni73mg5gtba@lem-wkst-02.lemonage>
In-Reply-To: <8421397a-129b-0361-38d2-ebaa03e6dc11@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3785915118144874042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2020 at 10:07:58AM -0500, Denis Kenzior wrote:
> Hi Lars,
> =

> On 8/19/20 7:13 AM, poeschel(a)lemonage.de wrote:
> > From: Lars Poeschel <poeschel@lemonage.de>
> > =

> > Currently AT+CGEREP=3D2,1 is sent in case we don't know what the modem
> > needs. (default case) Not all modems understand this. So, we first query
> > what the modem supports with AT+CGEREP=3D? and then use this information
> > to be nice to the modem. This way modems, like the Quectel M95 that do
> > only understand AT+CGEREP=3D1 do also work nicely.
> =

> I think this is a nice improvement, couple of comments below:

Thanks. :-)

> > ---
> >   drivers/atmodem/gprs.c | 75 ++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 73 insertions(+), 2 deletions(-)
> > =

> > diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
> > index d829e2e6..3900b95b 100644
> > --- a/drivers/atmodem/gprs.c
> > +++ b/drivers/atmodem/gprs.c
> > @@ -45,6 +45,7 @@
> >   #define MAX_CONTEXTS 255
> >   static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
> > +static const char *cgerep_prefix[] =3D { "+CGEREP:", NULL };
> >   static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
> >   static const char *cgact_prefix[] =3D { "+CGACT:", NULL };
> >   static const char *none_prefix[] =3D { NULL };
> > @@ -647,6 +648,76 @@ static void gprs_initialized(gboolean ok, GAtResul=
t *result, gpointer user_data)
> >   	ofono_gprs_register(gprs);
> >   }
> > +static void at_cgerep_test_cb(gboolean ok, GAtResult *result,
> > +				gpointer user_data)
> > +{
> > +	struct ofono_gprs *gprs =3D user_data;
> > +	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
> > +	GAtResultIter iter;
> > +	int min1, max1 =3D 1, min2, max2 =3D 1;
> > +	gboolean two_arguments =3D true;
> > +	char buf[20];
> > +
> > +	if (!ok)
> > +		return;
> =

> Hmm, maybe a good idea here is to print a warning and call
> ofono_gprs_remove(). Otherwise this will just fail silently for someone.

Ok, I will update this.

> > +
> > +	g_at_result_iter_init(&iter, result);
> > +
> > +	g_at_result_iter_next(&iter, "+CGEREP:");
> > +
> > +	if (!g_at_result_iter_open_list(&iter))
> > +		return;
> =

> Ditto here

Same here.

> > +
> > +	if (!g_at_result_iter_next_range(&iter, &min1, &max1))
> > +		return;
> > +
> =

> So why not just run iter_next_range in a loop?  it actually understands b=
oth
> lists and ranges.  See cind_support_cb() for an example.

Ok, I can do this i a loop if you want.

> > +	/* if min1 =3D=3D max1 we had no range but a list and that
> > +	 * means we are interested in the last number of that list*/
> > +	if (min1 =3D=3D max1) {
> > +		while (!g_at_result_iter_close_list(&iter)) {
> > +			if (!g_at_result_iter_next_number(&iter, &max1))
> > +				break;
> > +		}
> > +	}
> > +
> > +	if (!g_at_result_iter_skip_next(&iter)) {
> > +		two_arguments =3D false;
> > +		goto out;
> > +	}
> =

> Not sure what this is doing?  isn't +CGEREP just two lists ?  According t=
o 27.007:
> "+CGEREP:=C2=A0(list of supported <mode>s),(list of supported <bfr>s)"

Well, we have to deal with very different +CGEREP results. For example
on the quectel EC21 I get this:

"+CGEREP: (0-2),(0,1)"

and on the quectel M95 I get this:

"+CGEREP: (0,1)"

So what the code does is this:
It tries to parse a range with

g_at_result_iter_next_range(&iter, &min1, &max1)

Now two things can happen: It either parsed the range "(0-2)" then we
have min1 !=3D max1, or it tried to parse a list "(0,1)". This time
iter_next_range() breaks on the comma ',' and exits with
min1 =3D=3D max1 =3D=3D 0. Then we know, we did not find the maximum value =
yet
and we enter the loop:

=E2=96=B8=C2=B7=C2=B7=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7whi=
le (!g_at_result_iter_close_list(&iter)) {
=E2=96=B8=C2=B7=C2=B7=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=E2=
=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7if (!g_at_result_iter_next_=
number(&iter, &max1))
=E2=96=B8=C2=B7=C2=B7=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=E2=
=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=E2=96=B8=C2=B7=C2=B7=C2=B7=
=C2=B7=C2=B7=C2=B7=C2=B7break;
=E2=96=B8=C2=B7=C2=B7=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7}

This does then loop to the end of the list until iter_close_list()
becomes true, which is at the closing paranthesis ')'. max1 then
contains the last item in that list (which we suspect to be the
maximum value).

Now we have min1 and max1 in both cases(list and range). Now if

g_at_result_iter_skip_next()

fails, we are at the end of the AT result and we had only one argument
to +CGEREP or we start trying to parse the second argument also. (See
below.)

At the end we construct our AT+CGEREP=3D string depending on if we had
two or only one argument.

Does this sound reasonable ?

> > +
> > +	if (!g_at_result_iter_open_list(&iter)) {
> > +		two_arguments =3D false;
> > +		goto out;
> > +	}
> > +
> > +	if (!g_at_result_iter_next_range(&iter, &min2, &max2)) {
> > +		two_arguments =3D false;
> > +		goto out;
> > +	}
> > +
> > +	if (min2 =3D=3D max2) {
> > +		while (!g_at_result_iter_close_list(&iter)) {
> > +			if (!g_at_result_iter_next_number(&iter, &max2)) {
> > +				break;
> > +			}
> > +		}
> > +	}
> > +
> > +out:
> > +	if (max1 > 2)
> > +		max1 =3D 2;
> > +
> > +	if (max2 > 1)
> > +		max2 =3D 1;
> > +
> > +	if (two_arguments)
> > +		sprintf(buf, "AT+CGEREP=3D%u,%u", max1, max2);
> > +	else
> > +		sprintf(buf, "AT+CGEREP=3D%u", max1);
> > +
> > +	g_at_chat_send(gd->chat, buf, none_prefix, gprs_initialized, gprs, NU=
LL);
> > +}
> > +
> >   static void at_cgreg_test_cb(gboolean ok, GAtResult *result,
> >   				gpointer user_data)
> >   {
> > @@ -701,8 +772,8 @@ retry:
> >   			gprs_initialized, gprs, NULL);
> >   		break;
> >   	default:
> > -		g_at_chat_send(gd->chat, "AT+CGEREP=3D2,1", none_prefix,
> > -			gprs_initialized, gprs, NULL);
> > +		g_at_chat_send(gd->chat, "AT+CGEREP=3D?", cgerep_prefix,
> > +			at_cgerep_test_cb, gprs, NULL);
> >   		break;
> >   	}
> > =

> =

> Regards,
> -Denis
--===============3785915118144874042==--

