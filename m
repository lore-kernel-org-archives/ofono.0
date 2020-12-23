Content-Type: multipart/mixed; boundary="===============3222081102616225131=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH 3/5] gemalto: gprs: support automatic context activation
Date: Wed, 23 Dec 2020 23:41:31 +0300
Message-ID: <X+Ore+aBV4PX7UN+@curiosity>
In-Reply-To: <8e4275be-13f3-33a6-5aa6-1df088ab724a@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3222081102616225131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

> > Implement read_settings function to get configuration for automatic
> > contexts. Fix the issue uncovered by added support for automatic
> > context activation: do not use AT+CGACT for the contexts handled
> > by AT^SWWAN. As per modem specs, CGACT context can not be reused
> > for SWWAN. Though that worked for some reason when automatic
> > context was reactivated without proper deactivation.
> > ---
> >   drivers/gemaltomodem/gprs-context.c | 110 +++++++++++++++-------------
> >   1 file changed, 59 insertions(+), 51 deletions(-)

<snip>

> > +static void swwan_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> > +{
> > +	struct ofono_gprs_context *gc =3D user_data;
> > +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> > +	struct ofono_error error;
> >   	DBG("ok %d", ok);
> >   	if (!ok) {
> > -		struct ofono_error error;
> > -
> > +		ofono_error("Unable to activate context");
> > +		ofono_gprs_context_deactivated(gc, gcd->active_context);
> >   		gcd->active_context =3D 0;
> =

> This seems a bit strange.  Are you signaling success to the core too early

Correct, this is intended behavior. See my further comments regarding
SWWAN command and its processing.
 =

> > -
> >   		decode_at_error(&error, g_at_result_final_response(result));
> >   		gcd->cb(&error, gcd->cb_data);
> > -
> >   		return;
> >   	}
> > -
> > -	snprintf(buf, sizeof(buf), "AT^SWWAN=3D1,%u", gcd->active_context);
> > -	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> > -
> > -	modem =3D ofono_gprs_context_get_modem(gc);
> > -	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
> > -	ofono_gprs_context_set_interface(gc, interface);
> > -
> > -	/* Use DHCP */
> > -	ofono_gprs_context_set_ipv4_address(gc, NULL, 0);
> > -
> > -	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
> >   }
> >   static void cgdcont_enable_cb(gboolean ok, GAtResult *result,
> > -				gpointer user_data)
> > +			gpointer user_data)
> =

> nit: This is superfluous and also see doc/coding-style.txt item M4

Fixed in v2.

<snip>

> > -	snprintf(buf, sizeof(buf), "AT+CGACT=3D1,%u", gcd->active_context);
> > -
> > -	if (g_at_chat_send(gcd->chat, buf, none_prefix,
> > -				cgact_enable_cb, gc, NULL) =3D=3D 0)
> > -		goto error;
> > +	snprintf(buf, sizeof(buf), "AT^SWWAN=3D1,%u", gcd->active_context);
> > +	if (g_at_chat_send(gcd->chat, buf, none_prefix, swwan_cb, gc, NULL)) {
> =

> Note, this returns > 0 when the command has been queued, not that it has
> been sent or replied to yet...
> =

> > +		set_gprs_context_interface(gc);
> > +		/* Use DHCP */
> > +		ofono_gprs_context_set_ipv4_address(gc, NULL, 0);
> =

> If these modems can only do DHCP, then might be cleaner to move the 'Use
> DHCP' bits into set_gprs_context_interface.  And maybe rename it to make
> things clearer, if needed.

Good point, fixed in v2.

> =

> > -	return;
> > +		CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
> =

> Are you sure you don't want to wait until swwan_cb to return success to t=
he
> core?  AT^SWWAN can still fail...?

AT^SWWAN command is yet another way to activate a PDP context. AT commands
spec for this modem is a bit vague about SWWAN details, but according to
other materials from Gemalto as well as my experiments, this command
activates internal DHCP server, so DHCP client can be started for modem
USB ethernet interfaces. Based on my observations, SWWAN command does
not return until DHCP flow is completed.

So the idea is to send SWWAN command to modem and make it possible to
start DHCP flow right away. I assume that I need both things: mark
interface for DHCP and signal success to the core. Callback swwan_cb is
supposed to handle the case when SWWAN command fails: mark context as
deactivated and let oFono proceed with further connection attempts.

> > +		return;
> > +	}
> > -error:
> >   	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
> >   }
> =

> <snip>
> =

> > @@ -185,17 +170,39 @@ static void gemalto_gprs_deactivate_primary(struc=
t ofono_gprs_context *gc,
> >   	gcd->cb =3D cb;
> >   	gcd->cb_data =3D data;
> > -	snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u", cid);
> > +	snprintf(buf, sizeof(buf), "AT^SWWAN=3D0,%u", gcd->active_context);
> >   	if (g_at_chat_send(gcd->chat, buf, none_prefix,
> > -				cgact_disable_cb, gc, NULL) =3D=3D 0)
> > -		goto error;
> > -
> > -	return;
> > +				deactivate_cb, gc, NULL))
> > +		return;
> > -error:
> >   	CALLBACK_WITH_FAILURE(cb, data);
> > +}
> > +
> > +static void gemalto_gprs_read_settings(struct ofono_gprs_context *gc,
> > +					unsigned int cid,
> > +					ofono_gprs_context_cb_t cb, void *data)
> > +{
> > +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> > +	char buf[64];
> > +
> > +	DBG("cid %u", cid);
> > +
> > +	gcd->active_context =3D cid;
> > +	gcd->cb =3D cb;
> > +	gcd->cb_data =3D data;
> > +
> > +	snprintf(buf, sizeof(buf), "AT^SWWAN=3D1,%u", gcd->active_context);
> =

> nit: doc/coding-style.txt item M1

Fixed in v2.

> > +	if (g_at_chat_send(gcd->chat, buf, none_prefix, swwan_cb, gc, NULL)) {
> > +		set_gprs_context_interface(gc);
> > +		/* Use DHCP */
> > +		ofono_gprs_context_set_ipv4_address(gc, NULL, 0);
> > +		CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
> =

> Are you sure you don't want to wait until swwan_cb to return success to t=
he
> core?  I mean AT^SWWAN might still fail...?
> =

> I also find it a bit strange that an already-active context needs to go
> through the SWWAN dance, but if that's the way the firmware works, OK.
> Might be worth a comment...?

As I mentioned earlier, according to my understanding, SWWAN dance is
required to enable link on USB ethernet interface provided by modem
and to start internal DHCP server so that host software (e.g. ConnMan or
NetworkManager) could setup interface properly.

Sure, I can add a comment. What whould be better: to add a comment in
driver or to write a more detailed commit message ?

Regards,
Sergey
--===============3222081102616225131==--

