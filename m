Content-Type: multipart/mixed; boundary="===============9132254328230178062=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: RE: [RFC 3/3] STE-plugin: Adding STE plugin
Date: Mon, 18 Jan 2010 19:22:03 +0100
Message-ID: <61D8D34BB13CFE408D154529C120E07991D7BA@eseldmw101.eemea.ericsson.se>
In-Reply-To: <1263764432.5591.104.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9132254328230178062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.
Thank you for your feedback. We hope to get new patch-set out tomorrow
with most of your comments fixed.

Marcel Holtmann wrote:
> Hi Sjur,
> =

> review. I am thinking of something the like this; one per network
> registration, one per voice call, one per GPRS.  =

> =

> You are making some core changes and we need to have a close look at
> them and what the potential impact would be. =


Sure, will split up better next time. =


>> +#include <arpa/inet.h>
>> +#include <linux/caif/caif_socket.h>
>> +#include <linux/caif/if_caif.h>
> =

> This is dangerous until the CAIF subsystem is actually merged and
> present everywhere. Please consider adding an option to enable
> stemodem driver (like we do for atmodem and isimodem).  =


OK, we'll put this on our todo-list.

> It might make sense to have a local copy of the required structure
> and constants to allow an easier complication. Of course this depends
> on having CAIF at least in net-next-2.6 tree.  =


OK, agree. I'll supply the CAIF specific patches next time.
Should we put the CAIF header files into ofono/include/caif?

> =

>> +/* TODO: should parse_xml function to be moved to e.g. atutil? */
> =

> First question. Why not use the XML parse that comes with GLib.

OK. Is it "Simple XML Subset Parser" you refer to? If you have any pointer =

to sample code using this XML parser we would appreciate it.


> oFono is never setting the IP address, netmask or any other
> configuration option. The only thing that oFono does is bringing the
> interface up. Systems like ConnMan do the IP configuration.  =

> =

> Please see the comments in the documentation on how we expose IP
> interfaces. Check with ConnMan and how we configure them.

OK, we're returning the relevant parameters from activate_primary so that
all PDP Context parameters including interface name,
ip-address, netmask, dns,  etc are available in PrimaryDataContext. =

And leave the interface created but not configured.
Does this sound ok?
 =

> =

> Having create and remove in the same function seems hard to read. Why
> not have one for creating the interface and one for removing it. From
> what I see so far, it is not much more code. And makes it a lot
> easier to read and understand for other people.   =

> =

OK, we'll split this up.

> I would prefer if you do the parsing in one function that goes
> through the XML ones. Just give it pointers to the fields you wanna
> have it extract or a special combined structure. This looks highly
> inefficient to me.   =


OK, see comments on XML above.

> =

>> +	conn->interface =3D g_malloc(10);
>> +	if (!conn->interface)
>> +		goto error;
> =

> Please double check with the GLib documentation on memory allocation.
> The g_malloc failure would result in halt of the program. What you
> want here is g_try_malloc. =

> =

> Also for 10 bytes, please don't bother with an allocation. Just
> include a char array in the conn structure. =


Yes I agree, we will fix this.

> =

> Yeah, I really prefer caif_if_create() and caif_if_remove(). This is
> not really intuitive at all. =


OK, sure.

> =

>> +	/* Need to change to gsm_permissive syntax in order to
>> +	 * parse the response from EPPSD (xml) */
>> +	g_at_chat_set_syntax(gcd->chat, g_at_syntax_new_gsm_permissive());
> =

> Is this an issue with your modem firmware or an issue in the v1
> parser. =

> If it is the modem firmware, then just use the permissive parser all
> the time and switch to E0. =


Setting permissive mode was done in order to be able to parse =

the XML response from  EPPSD (Propriatery Activate PDP context). =

But we can try if we can run with this mode default if you think =

this is better.

> =

>> +static void cgev_notify(GAtResult *result, gpointer user_data) {
>> +	struct ofono_gprs_context *gc =3D user_data;
>> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
>> +	GAtResultIter iter; +	const char *event;
>> +
>> +	dump_response("cgev_notify", TRUE, result);
>> +
>> +	g_at_result_iter_init(&iter, result);
>> +
>> +	if (!g_at_result_iter_next(&iter, "+CGEV:"))
>> +		return;
>> +
>> +	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
>> +		return; +
>> +	if (g_str_has_prefix(event, "NW REACT ") ||
>> +			g_str_has_prefix(event, "NW DEACT ") ||
>> +			g_str_has_prefix(event, "ME DEACT ")) {
>> +		/* Ask what primary contexts are active now */
>> +
>> +		g_at_chat_send(gcd->chat, "AT+CGACT?", cgact_prefix,
>> +				ste_cgact_read_cb, gc, NULL);
>> +
>> +		return;
>> +	}
>> +}
> =

> The return statement in the if clause is kinda pointless. Seems like
> either your code tried to be more complex or you are missing
> something.  =


Sure we can fix this, but this is actually just copied from gprs_context in=
 "atmodem".
BTW, the iter_init seems to be missing in atmodem's implementation, this is=
 probably
a bug in "atmodem".

> =

>> +static int stemodem_init(void)
>> +{
>> +	/* Initialize voicecall driver */
>> +	struct ofono_voicecall_driver *at_vcdrv;
>> +	struct ofono_voicecall_driver *ste_vcdrv;
>> +	struct ofono_netreg_driver *at_netdrv;
>> +	struct ofono_netreg_driver *ste_netdrv;
>> +
>> +	ste_voicecall_init();
>> +
>> +	at_vcdrv =3D ofono_voicecall_driver_get("atmodem");
>> +	ste_vcdrv =3D ofono_voicecall_driver_get("stemodem"); +
>> +	if (at_vcdrv && ste_vcdrv) {
>> +		ste_vcdrv->remove =3D at_vcdrv->remove;
>> +		ste_vcdrv->swap_without_accept =3D at_vcdrv->swap_without_accept;
>> +		ste_vcdrv->send_tones =3D at_vcdrv->send_tones;
>> +	} else {
>> +		if (!ste_vcdrv)
>> +			ofono_debug("Could not get ofono_voicecall_driver" +					"from
>> stemodem"); +		if (!at_vcdrv)
>> +			ofono_debug("Could not get ofono_voicecall_driver" +					"from
>> atmodem"); +	}
>> +
>> +	/* Initialize netreg driver */
>> +	ste_netreg_init();
>> +
>> +	at_netdrv =3D ofono_netreg_driver_get("atmodem");
>> +	ste_netdrv =3D ofono_netreg_driver_get("stemodem"); +
>> +	if (at_netdrv && ste_netdrv) {
>> +		ste_netdrv->remove =3D at_netdrv->remove;
>> +		ste_netdrv->registration_status =3D
>> +			at_netdrv->registration_status;
>> +		ste_netdrv->current_operator =3D at_netdrv->current_operator;
>> +		ste_netdrv->list_operators =3D at_netdrv->list_operators;
>> +		ste_netdrv->register_auto =3D at_netdrv->register_auto;
>> +		ste_netdrv->register_manual =3D at_netdrv->register_manual;
> =

> So far this, I really like to see a description on what's the
> difference in the network registration and voice call atoms. =

> =

> We do need to understand what is actually needed.
>
For Voice call the main difference is that we're not doing polling with =

CLCC, but are using our proprietary call events. This impacts most function=
s.
The functions reusable from "atmodem" are "remove", "swap_without_accept", =
and =

"send_tones". I guess we could copy the three common functions from "atmode=
m" into =

"stemodem" voicecall.c if you prefer this.

For Network Registration we have almost identical implementation, the diffe=
rence
is that for signal strength reporting we are using "AT+CIND" instead of "CS=
Q" and "CIEV".
"CSQ" is not working for WCDMA in our case. =

I see that in the initialization function there is a switch on vendor.
I guess we could go for this approach if you think this is better.
> =

>> +	/* Create a CAIF socket for AT Service */
>> +	fd =3D socket(AF_CAIF, SOCK_SEQPACKET, CAIFPROTO_AT); +
>> +	/* Connect to the AT Service at the modem */
>> +	connect(fd, (struct sockaddr *) &addr, sizeof(addr));
>> +	channel =3D g_io_channel_unix_new(fd);
> =

> You need to check the results of socket() and connect() calls.
Sure, will fix this.

Regards
Sjur Br=C3=A6ndeland

--===============9132254328230178062==--

