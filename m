Content-Type: multipart/mixed; boundary="===============6327687846828656447=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC 3/3] STE-plugin: Adding STE plugin
Date: Mon, 18 Jan 2010 13:27:02 -0800
Message-ID: <1263850022.5591.145.camel@localhost.localdomain>
In-Reply-To: <61D8D34BB13CFE408D154529C120E07991D7BA@eseldmw101.eemea.ericsson.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6327687846828656447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> Thank you for your feedback. We hope to get new patch-set out tomorrow
> with most of your comments fixed.

sounds great.

> > It might make sense to have a local copy of the required structure
> > and constants to allow an easier complication. Of course this depends
> > on having CAIF at least in net-next-2.6 tree.  =

> =

> OK, agree. I'll supply the CAIF specific patches next time.
> Should we put the CAIF header files into ofono/include/caif?

Have a look at how we do it for the Phonet/ISI modem. Also we only need
a few constants (AF_CAIF, proto etc.) and mainly only the socket
structure for CAIF.

This should be easy to fix actually. More important is that we can
disable stemodem support via configure so people with an old kernel can
compile it. We are in a chicken and egg problem with the AF_CAIF
constant anyway. Until the CAIF subsystem is in net-next-2.6, the
actually number for it is not assigned.

> >> +/* TODO: should parse_xml function to be moved to e.g. atutil? */
> > =

> > First question. Why not use the XML parse that comes with GLib.
> =

> OK. Is it "Simple XML Subset Parser" you refer to? If you have any pointe=
r =

> to sample code using this XML parser we would appreciate it.

Yes, I am talking about that one. It is similar to expact and the only
example, I have is in the BlueZ source code. I think Google code search
will reveal more useful examples.

> > oFono is never setting the IP address, netmask or any other
> > configuration option. The only thing that oFono does is bringing the
> > interface up. Systems like ConnMan do the IP configuration.  =

> > =

> > Please see the comments in the documentation on how we expose IP
> > interfaces. Check with ConnMan and how we configure them.
> =

> OK, we're returning the relevant parameters from activate_primary so that
> all PDP Context parameters including interface name,
> ip-address, netmask, dns,  etc are available in PrimaryDataContext. =

> And leave the interface created but not configured.
> Does this sound ok?

Yes, sounds good. Please have a look at how we do it for Ericsson MBM
and Option HSO modems. We just send the D-Bus signal with all the
details and that is it.

I forgot to mention the reasoning behind. oFono is incapable of making
any kind of good decision when it comes to handling IP collision since
it only knows about its scope. Systems like ConnMan have the full
insight in whole networking to make proper decisions.

> > =

> >> +	/* Need to change to gsm_permissive syntax in order to
> >> +	 * parse the response from EPPSD (xml) */
> >> +	g_at_chat_set_syntax(gcd->chat, g_at_syntax_new_gsm_permissive());
> > =

> > Is this an issue with your modem firmware or an issue in the v1
> > parser. =

> > If it is the modem firmware, then just use the permissive parser all
> > the time and switch to E0. =

> =

> Setting permissive mode was done in order to be able to parse =

> the XML response from  EPPSD (Propriatery Activate PDP context). =

> But we can try if we can run with this mode default if you think =

> this is better.

Can you post an example (manually via cu or minicom and with ATE1) on
how this looks like. My question here is if you are actually following
the strict v1 syntax. If you don't then that is basically a bug on the
modem side. I don't even know if v1 has any kind of capabilities to
handle XML properly in the first place.

The point here is if you can not use v1 parser, then just use permissive
from the beginning and avoid switching at runtime. The capability of
switching at runtime mainly only exists for testing purposes. With the
permissive parser you just have to ensure ATE0 inside the modem plugin.
See the other users for an example.

> >> +static void cgev_notify(GAtResult *result, gpointer user_data) {
> >> +	struct ofono_gprs_context *gc =3D user_data;
> >> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> >> +	GAtResultIter iter; +	const char *event;
> >> +
> >> +	dump_response("cgev_notify", TRUE, result);
> >> +
> >> +	g_at_result_iter_init(&iter, result);
> >> +
> >> +	if (!g_at_result_iter_next(&iter, "+CGEV:"))
> >> +		return;
> >> +
> >> +	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
> >> +		return; +
> >> +	if (g_str_has_prefix(event, "NW REACT ") ||
> >> +			g_str_has_prefix(event, "NW DEACT ") ||
> >> +			g_str_has_prefix(event, "ME DEACT ")) {
> >> +		/* Ask what primary contexts are active now */
> >> +
> >> +		g_at_chat_send(gcd->chat, "AT+CGACT?", cgact_prefix,
> >> +				ste_cgact_read_cb, gc, NULL);
> >> +
> >> +		return;
> >> +	}
> >> +}
> > =

> > The return statement in the if clause is kinda pointless. Seems like
> > either your code tried to be more complex or you are missing
> > something.  =

> =

> Sure we can fix this, but this is actually just copied from gprs_context =
in "atmodem".
> BTW, the iter_init seems to be missing in atmodem's implementation, this =
is probably
> a bug in "atmodem".

Sounds like a bug in atmodem then. Can you point me to the lines where
you are seeing this. I will fix it if needed.

And btw. the { for functions belongs on the line after. I will do a
thorough review of your next patchset and look out for these :)

> >> +static int stemodem_init(void)
> >> +{
> >> +	/* Initialize voicecall driver */
> >> +	struct ofono_voicecall_driver *at_vcdrv;
> >> +	struct ofono_voicecall_driver *ste_vcdrv;
> >> +	struct ofono_netreg_driver *at_netdrv;
> >> +	struct ofono_netreg_driver *ste_netdrv;
> >> +
> >> +	ste_voicecall_init();
> >> +
> >> +	at_vcdrv =3D ofono_voicecall_driver_get("atmodem");
> >> +	ste_vcdrv =3D ofono_voicecall_driver_get("stemodem"); +
> >> +	if (at_vcdrv && ste_vcdrv) {
> >> +		ste_vcdrv->remove =3D at_vcdrv->remove;
> >> +		ste_vcdrv->swap_without_accept =3D at_vcdrv->swap_without_accept;
> >> +		ste_vcdrv->send_tones =3D at_vcdrv->send_tones;
> >> +	} else {
> >> +		if (!ste_vcdrv)
> >> +			ofono_debug("Could not get ofono_voicecall_driver" +					"from
> >> stemodem"); +		if (!at_vcdrv)
> >> +			ofono_debug("Could not get ofono_voicecall_driver" +					"from
> >> atmodem"); +	}
> >> +
> >> +	/* Initialize netreg driver */
> >> +	ste_netreg_init();
> >> +
> >> +	at_netdrv =3D ofono_netreg_driver_get("atmodem");
> >> +	ste_netdrv =3D ofono_netreg_driver_get("stemodem"); +
> >> +	if (at_netdrv && ste_netdrv) {
> >> +		ste_netdrv->remove =3D at_netdrv->remove;
> >> +		ste_netdrv->registration_status =3D
> >> +			at_netdrv->registration_status;
> >> +		ste_netdrv->current_operator =3D at_netdrv->current_operator;
> >> +		ste_netdrv->list_operators =3D at_netdrv->list_operators;
> >> +		ste_netdrv->register_auto =3D at_netdrv->register_auto;
> >> +		ste_netdrv->register_manual =3D at_netdrv->register_manual;
> > =

> > So far this, I really like to see a description on what's the
> > difference in the network registration and voice call atoms. =

> > =

> > We do need to understand what is actually needed.
> >
> For Voice call the main difference is that we're not doing polling with =

> CLCC, but are using our proprietary call events. This impacts most functi=
ons.
> The functions reusable from "atmodem" are "remove", "swap_without_accept"=
, and =

> "send_tones". I guess we could copy the three common functions from "atmo=
dem" into =

> "stemodem" voicecall.c if you prefer this.

I actually prefer if you copy them. If useful, we can create some common
helpers in drivers/atmodem/atutil.c. I leave this up to Denis to comment
on that.

> For Network Registration we have almost identical implementation, the dif=
ference
> is that for signal strength reporting we are using "AT+CIND" instead of "=
CSQ" and "CIEV".
> "CSQ" is not working for WCDMA in our case. =

> I see that in the initialization function there is a switch on vendor.
> I guess we could go for this approach if you think this is better.

We do exactly that for OFONO_VENDOR_CALYPSO and OFONO_VENDOR_OPTION_HSO
and so I think it is best that you guys follow that approach for now.

If this gets massively convoluted at some point, we will be thinking of
something. Right now I prefer to just follow exactly what we are doing
for other modems with the same problem.

Regards

Marcel



--===============6327687846828656447==--

