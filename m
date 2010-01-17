Content-Type: multipart/mixed; boundary="===============4489716008932927331=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC 3/3] STE-plugin: Adding STE plugin
Date: Sun, 17 Jan 2010 13:40:32 -0800
Message-ID: <1263764432.5591.104.camel@localhost.localdomain>
In-Reply-To: <1263749312-6567-4-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4489716008932927331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> Added implementation for STE modem; STE modem driver, and STE specific
> drivers for gprs, network registration and voice call. =

> =

> This patch uses CAIF sockets. CAIF patch for net-next-2.6 will be
> contributed on netdev(a)vger.kernel.org soon.

can you please split these into smaller patches so they are easier to
review. I am thinking of something the like this; one per network
registration, one per voice call, one per GPRS.

You are making some core changes and we need to have a close look at
them and what the potential impact would be.

This is not a complete review, but I making some comments on obvious
things.

> index 0000000..1d5d8db
> --- /dev/null
> +++ b/drivers/stemodem/gprs-context.c
> @@ -0,0 +1,612 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2010 ST-Ericsson AB.
> + *  Author: Marit Henriksen, marit.xx.henriksen(a)stericsson.com.

As mentioned before, we track authorship via GIT. So ensure that the GIT
commits are properly done.

> +#include <linux/types.h>
> +#include <net/if.h>
> +#include <sys/ioctl.h>
> +#include <arpa/inet.h>
> +#include <linux/caif/caif_socket.h>
> +#include <linux/caif/if_caif.h>

This is dangerous until the CAIF subsystem is actually merged and
present everywhere. Please consider adding an option to enable stemodem
driver (like we do for atmodem and isimodem).

It might make sense to have a local copy of the required structure and
constants to allow an easier complication. Of course this depends on
having CAIF at least in net-next-2.6 tree.

> +/* TODO: should parse_xml function to be moved to e.g. atutil? */

First question. Why not use the XML parse that comes with GLib.

> +static char *parse_xml(char * xml, char* tag)
> +{

Please use consistent coding style. It is "char *xml". And it is always
like this. No extra space after * or char*.

> +    char *begin;
> +    char *end;
> +    int len;
> +    char *res =3D NULL;
> +    char *start =3D (char *)g_malloc(strlen(tag)+3);
> +    char *stop =3D (char *)g_malloc(strlen(tag)+4);

No casting of malloc function. It is not needed. And extra spaces
between operation. Meaning malloc(strlen(tag) + 3).

This applies to all code.

> +	if (create) {
> +		if (ioctl(s, SIOCCAIFNETNEW, &ifr) < 0) {
> +			ofono_debug("Failed to create IP interface for CAIF");
> +			goto error;
> +		}
> +
> +		s =3D socket(PF_INET, SOCK_DGRAM, 0);
> +		if (s < 0) {
> +			ofono_debug("Failed to create socket.");
> +			goto error;
> +		}
> +
> +		/* Set IP address */
> +		memset(&sin, 0, sizeof(struct sockaddr));
> +		sin.sin_family =3D AF_INET;
> +
> +		if (inet_pton(AF_INET, ip, &sin.sin_addr) <=3D 0) {
> +			ofono_debug("inet_pton failed, will not be"
> +				"able to set the IP address");
> +			goto error;
> +		}
> +		memcpy(&ifr.ifr_addr, &sin, sizeof(struct sockaddr));
> +
> +		if (ioctl(s, SIOCSIFADDR, &ifr) < 0) {
> +			ofono_debug("Failed to set IP address for"
> +			" interface: %s", ifr.ifr_name);
> +			goto error;
> +		}

oFono is never setting the IP address, netmask or any other
configuration option. The only thing that oFono does is bringing the
interface up. Systems like ConnMan do the IP configuration.

Please see the comments in the documentation on how we expose IP
interfaces. Check with ConnMan and how we configure them.

> +		if (ioctl(s, SIOCSIFMTU, &ifr) < 0)
> +			ofono_debug("Failed to set MTU for interface: %s",
> +				ifr.ifr_name);
> +	} else {
> +		if (ioctl(s, SIOCGIFINDEX, &ifr) =3D=3D 0) {
> +			if (ioctl(s, SIOCCAIFNETREMOVE, &ifr) < 0) {
> +				ofono_debug("Failed to remove IP interface"
> +					"for CAIF");
> +				goto error;
> +			}
> +		} else {
> +			ofono_debug("Did not find interface (%s) to remove",
> +					interface);
> +			goto error;
> +		}
> +	}

Having create and remove in the same function seems hard to read. Why
not have one for creating the interface and one for removing it. From
what I see so far, it is not much more code. And makes it a lot easier
to read and understand for other people.

> +	g_at_result_iter_init(&iter, result);
> +	for (i =3D 0; i < g_at_result_num_response_lines(result); i++) {
> +		g_at_result_iter_next(&iter, NULL);
> +		res_string =3D strdup(g_at_result_iter_raw_line(&iter));
> +
> +		if (strstr(res_string, "ip_address")) {
> +			ip =3D g_strdup(parse_xml(res_string,
> +						"ip_address"));
> +		} else if ((strstr(res_string, "subnet_mask"))) {
> +			netmask =3D g_strdup(parse_xml(res_string,
> +						"subnet_mask"));
> +		} else if ((strstr(res_string, "mtu"))) {
> +			mtu =3D g_strdup(parse_xml(res_string,
> +						"mtu"));
> +		} else if ((strstr(res_string, "default_gateway"))) {
> +			gateway =3D g_strdup(parse_xml(res_string,
> +						"default_gateway"));
> +		} else if ((strstr(res_string, "dns_server"))) {
> +			str =3D g_strdup(parse_xml(res_string,
> +						"dns_server"));
> +
> +			if (numdns < MAX_DNS)
> +				dns[numdns++] =3D str;
> +		}

I would prefer if you do the parsing in one function that goes through
the XML ones. Just give it pointers to the fields you wanna have it
extract or a special combined structure. This looks highly inefficient
to me.

> +	conn->interface =3D g_malloc(10);
> +	if (!conn->interface)
> +		goto error;

Please double check with the GLib documentation on memory allocation.
The g_malloc failure would result in halt of the program. What you want
here is g_try_malloc.

Also for 10 bytes, please don't bother with an allocation. Just include
a char array in the conn structure.

> +
> +	sprintf(conn->interface, "caif%u", conn->device);
> +
> +	if (!caif_if_create_remove(conn->interface, ip,
> +			mtu, netmask, conn->channel_id, TRUE)) {
> +		ofono_error("Failed to create caif interface %s.",
> +			conn->interface);
> +		conn->interface =3D NULL;
> +	}

Yeah, I really prefer caif_if_create() and caif_if_remove(). This is not
really intuitive at all.

> +	/* Need to change to gsm_permissive syntax in order to
> +	 * parse the response from EPPSD (xml) */
> +	g_at_chat_set_syntax(gcd->chat, g_at_syntax_new_gsm_permissive());

Is this an issue with your modem firmware or an issue in the v1 parser.
If it is the modem firmware, then just use the permissive parser all the
time and switch to E0.

> +static void cgev_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	GAtResultIter iter;
> +	const char *event;
> +
> +	dump_response("cgev_notify", TRUE, result);
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CGEV:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
> +		return;
> +
> +	if (g_str_has_prefix(event, "NW REACT ") ||
> +			g_str_has_prefix(event, "NW DEACT ") ||
> +			g_str_has_prefix(event, "ME DEACT ")) {
> +		/* Ask what primary contexts are active now */
> +
> +		g_at_chat_send(gcd->chat, "AT+CGACT?", cgact_prefix,
> +				ste_cgact_read_cb, gc, NULL);
> +
> +		return;
> +	}
> +}

The return statement in the if clause is kinda pointless. Seems like
either your code tried to be more complex or you are missing something.

> +static int stemodem_init(void)
> +{
> +	/* Initialize voicecall driver */
> +	struct ofono_voicecall_driver *at_vcdrv;
> +	struct ofono_voicecall_driver *ste_vcdrv;
> +	struct ofono_netreg_driver *at_netdrv;
> +	struct ofono_netreg_driver *ste_netdrv;
> +
> +	ste_voicecall_init();
> +
> +	at_vcdrv =3D ofono_voicecall_driver_get("atmodem");
> +	ste_vcdrv =3D ofono_voicecall_driver_get("stemodem");
> +
> +	if (at_vcdrv && ste_vcdrv) {
> +		ste_vcdrv->remove =3D at_vcdrv->remove;
> +		ste_vcdrv->swap_without_accept =3D at_vcdrv->swap_without_accept;
> +		ste_vcdrv->send_tones =3D at_vcdrv->send_tones;
> +	} else {
> +		if (!ste_vcdrv)
> +			ofono_debug("Could not get ofono_voicecall_driver"
> +					"from stemodem");
> +		if (!at_vcdrv)
> +			ofono_debug("Could not get ofono_voicecall_driver"
> +					"from atmodem");
> +	}
> +
> +	/* Initialize netreg driver */
> +	ste_netreg_init();
> +
> +	at_netdrv =3D ofono_netreg_driver_get("atmodem");
> +	ste_netdrv =3D ofono_netreg_driver_get("stemodem");
> +
> +	if (at_netdrv && ste_netdrv) {
> +		ste_netdrv->remove =3D at_netdrv->remove;
> +		ste_netdrv->registration_status =3D
> +			at_netdrv->registration_status;
> +		ste_netdrv->current_operator =3D at_netdrv->current_operator;
> +		ste_netdrv->list_operators =3D at_netdrv->list_operators;
> +		ste_netdrv->register_auto =3D at_netdrv->register_auto;
> +		ste_netdrv->register_manual =3D at_netdrv->register_manual;

So far this, I really like to see a description on what's the difference
in the network registration and voice call atoms.

We do need to understand what is actually needed.

> +	/* Create a CAIF socket for AT Service */
> +	fd =3D socket(AF_CAIF, SOCK_SEQPACKET, CAIFPROTO_AT);
> +
> +	/* Connect to the AT Service at the modem */
> +	connect(fd, (struct sockaddr *) &addr, sizeof(addr));
> +	channel =3D g_io_channel_unix_new(fd);

You need to check the results of socket() and connect() calls.

Regards

Marcel



--===============4489716008932927331==--

