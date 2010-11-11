Content-Type: multipart/mixed; boundary="===============0275350392975974192=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4 1/2] stemodem: Add RTNL functionality managing CAIF
 Network Interfaces.
Date: Thu, 11 Nov 2010 14:29:07 +0900
Message-ID: <1289453347.3266.32.camel@aeonflux>
In-Reply-To: <1288967075-17434-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0275350392975974192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> I'm sorry about the formatting for the v3 version of this patch.
> I used git send-email via my gmail account, and ended up with base64 =

> MIME content encoding. I dont' know what went wrong :-(
> =

> I think I have closed most of your review comments so far. I kept using
> sendto as I don't quite get how to use g_io_channel_write_chars for rtnl =
socket.
> (I think connman is using sendto as well.) I still set g_caif_devices =3D=
 NULL just in
> case someone in future does init/exit more than once.
> =

> The patch has been tested activating/deactivation and I have run valgrind=
 showing
> no leaks on some unit tests (not yet upstreamed).

what happens for network triggered deactivation. Some networks here
disconnect the GPRS context used MMS. Has some funny behavior that need
to be taken into account.

>  Makefile.am                  |    2 +
>  drivers/stemodem/caif_rtnl.c |  379 ++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/stemodem/caif_rtnl.h |   29 ++++
>  3 files changed, 410 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/stemodem/caif_rtnl.c
>  create mode 100644 drivers/stemodem/caif_rtnl.h
> =

> diff --git a/Makefile.am b/Makefile.am
> index 05082de..f163b0a 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -226,6 +226,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
>  			drivers/stemodem/stemodem.c \
>  			drivers/stemodem/voicecall.c \
>  			drivers/stemodem/radio-settings.c \
> +			drivers/stemodem/caif_rtnl.c \
> +			drivers/stemodem/caif_rtnl.h \
>  			drivers/stemodem/gprs-context.c \
>  			drivers/stemodem/caif_socket.h \
>  			drivers/stemodem/if_caif.h
> diff --git a/drivers/stemodem/caif_rtnl.c b/drivers/stemodem/caif_rtnl.c
> new file mode 100644
> index 0000000..ad58c93
> --- /dev/null
> +++ b/drivers/stemodem/caif_rtnl.c
> @@ -0,0 +1,379 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2010 ST-Ericsson AB.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <net/if.h>
> +#include <net/if_arp.h>
> +#include <fcntl.h>
> +#include <linux/rtnetlink.h>
> +
> +#include <glib.h>
> +
> +#include <ofono/log.h>
> +
> +#include "if_caif.h"
> +#include "caif_rtnl.h"
> +
> +#define NLMSG_TAIL(nmsg) \
> +	((struct rtattr *) (((void *) (nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg_len)))

We have no global define this? You wanted to look into that. What was
the outcome of it?

> +struct iplink_req {
> +	struct nlmsghdr n;
> +	struct ifinfomsg i;
> +	char pad[1024];

What is this huge pad for? It looks totally fishy to me.

> +
> +	int request_id;
> +	int type;
> +	int conn_id;
> +	gpointer user_data;
> +	gboolean loop_enabled;
> +
> +	char ifname[IF_NAMESIZE];
> +	int  ifindex;
> +	caif_rtnl_create_cb_t callback;
> +};
> +
> +static GSList *pending_requests;
> +static guint32 rtnl_seqnr;
> +static guint  rtnl_watch;

Get rid of the double spaces for rtnl_watch.

> +static GIOChannel *channel;

If we follow your convention here and not to overload variables this
might be better named rtnl_channel.

And yes, I am fine with keeping it since there is no way to connect a
netlink socket properly to just use send(). You will require to use
sendto for everything.

> +static gboolean get_ifname(struct ifinfomsg *msg, int bytes,
> +				const char **ifname)
> +{
> +	struct rtattr *attr;
> +
> +	for (attr =3D IFLA_RTA(msg); RTA_OK(attr, bytes);
> +		attr =3D RTA_NEXT(attr, bytes)) {
> +
> +		if (attr->rta_type =3D=3D IFLA_IFNAME &&
> +				ifname !=3D NULL) {
> +
> +			*ifname =3D RTA_DATA(attr);
> +			return TRUE;
> +		}
> +	}
> +
> +	return FALSE;
> +}

Any reason why not just return const char * and take NULL as FALSE?

> +static void store_newlink_param(struct iplink_req *req, unsigned short t=
ype,
> +					int index, unsigned flags,
> +					unsigned change, struct ifinfomsg *msg,
> +					int bytes)
> +{
> +	const char *ifname =3D NULL;
> +
> +	get_ifname(msg, bytes, &ifname);
> +	strncpy(req->ifname, ifname,
> +			sizeof(req->ifname));
> +	req->ifname[sizeof(req->ifname)-1] =3D '\0';
> +	req->ifindex =3D index;
> +}

So I think that store_newlink_... and get_ifname can be nicely combined
into one helper function. And using extract_parameters() function name
is a bit better.

And please only add parameters to that function that you really need in
there. And the iplink_req should be last parameter.

As one general is to have input parameters first and then the output
parameters last. So read this something like extract values from this
structure to this structure.

> +static int send_rtnl_req(struct iplink_req *req)
> +{
> +	struct sockaddr_nl addr;
> +	int sk =3D g_io_channel_unix_get_fd(channel);
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.nl_family =3D AF_NETLINK;
> +
> +	return sendto(sk, req, req->n.nlmsg_len, 0,
> +			(struct sockaddr *) &addr, sizeof(addr));
> +}

I don't think this should be a separate function. You use it only twice
and having it close to the code using it would be better.

> +static struct iplink_req *find_request(guint32 seq)
> +{
> +	GSList *list;
> +
> +	for (list =3D pending_requests; list; list =3D list->next) {
> +		struct iplink_req *req =3D list->data;
> +
> +		if (req->n.nlmsg_seq =3D=3D seq)
> +			return req;
> +	}
> +
> +	return NULL;
> +}

I would move this function up in this file at the top. It should go
close to the variable declaration for pending_request.

> +static void rtnl_client_response(struct iplink_req *req, int result)
> +{
> +
> +	if (req->callback && req->n.nlmsg_type =3D=3D RTM_NEWLINK)
> +		req->callback(result, req->user_data,
> +				req->ifname, req->ifindex);
> +
> +	pending_requests =3D g_slist_remove(pending_requests, req);
> +	g_free(req);
> +}

I don't like this split out. You already checked the nlmsg_type and here
you keep checking it again just to reuse some code. This looks like
waste to me.

> +static void parse_rtnl_message(void *buf, size_t len)
> +{
> +	struct ifinfomsg *msg;
> +	struct iplink_req *req;

Make it const void *buf.

An you can have more than one RTNL message inside this buffer. You need
to be able to handle this. Otherwise you might loose responses. The case
of just calling return when you received one of the two messages you
care about is not really acceptable.

> +	while (len > 0) {
> +		struct nlmsghdr *hdr =3D buf;
> +
> +		if (!NLMSG_OK(hdr, len))
> +			break;
> +
> +		if (hdr->nlmsg_type =3D=3D RTM_NEWLINK) {
> +			req =3D g_slist_nth_data(pending_requests, 0);
> +			if (req =3D=3D NULL)
> +				break;

How does this work? You just pick the first pending request and don't
really compare the sequence number. Who guarantees the order of these
events. I don't think we should be doing this.

> +			msg =3D (struct ifinfomsg *) NLMSG_DATA(hdr);
> +			store_newlink_param(req, msg->ifi_type,
> +					msg->ifi_index, msg->ifi_flags,
> +					msg->ifi_change, msg,
> +					IFA_PAYLOAD(hdr));
> +			rtnl_client_response(req, 0);
> +			return;
> +
> +		} else if (hdr->nlmsg_type =3D=3D NLMSG_ERROR) {

So I would prefer if you use a switch statement here. It is just easier
to read. Especially inside a while() loop.

> +			req =3D find_request(hdr->nlmsg_seq);
> +			if (req =3D=3D NULL)
> +				break;
> +
> +			DBG("nlmsg error req");
> +			rtnl_client_response(req, -1);
> +			return;
> +		}

If I understand this right, then you can always find the pending request
and remove it here. No need for rtnl_client_response at all.

> +		len -=3D hdr->nlmsg_len;
> +		buf +=3D hdr->nlmsg_len;
> +	}
> +}
> +
> +static int add_attribute(struct nlmsghdr *n, int maxlen, int type,
> +				const void *data, int datalen)
> +{
> +	int len =3D RTA_LENGTH(datalen);
> +	struct rtattr *rta;
> +
> +	if ((int)(NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len)) > maxlen) {

Why is this (int) cast needed. Can we just not used proper parameter for
maxlen in the first place?

> +		DBG("attribute to large for message %d %d %d\n",
> +				n->nlmsg_len, len, maxlen);
> +		return -1;
> +	}
> +
> +	rta =3D NLMSG_TAIL(n);
> +	rta->rta_type =3D type;
> +	rta->rta_len =3D len;
> +	memcpy(RTA_DATA(rta), data, datalen);
> +	n->nlmsg_len =3D NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len);
> +
> +	return 0;
> +}
> +
> +static int prep_rtnl_newlink_req(struct iplink_req *req)
> +{
> +	char type[] =3D "caif";

Please don't do this. I think this is a waste.

> +	struct rtattr *linkinfo;
> +	struct rtattr *data;
> +
> +	req->n.nlmsg_len =3D NLMSG_LENGTH(sizeof(struct ifinfomsg));
> +	req->n.nlmsg_flags =3D NLM_F_REQUEST|NLM_F_CREATE|NLM_F_EXCL;
> +	req->n.nlmsg_type =3D RTM_NEWLINK;
> +	req->n.nlmsg_seq =3D ++rtnl_seqnr;
> +	req->i.ifi_family =3D AF_UNSPEC;
> +
> +	linkinfo =3D NLMSG_TAIL(&req->n);
> +	add_attribute(&req->n, sizeof(*req), IFLA_LINKINFO,
> +			NULL, 0);
> +	add_attribute(&req->n, sizeof(*req), IFLA_INFO_KIND,
> +			type, strlen(type));

So add_attribute(..., "caif", 4) should be just fine.

> +	data =3D NLMSG_TAIL(&req->n);

Why is this assignment here and only used later on. I see that you do it
for length calculation, but use a common variable name like data is a
bit confusing.

> +	add_attribute(&req->n, sizeof(*req), IFLA_INFO_DATA,
> +			NULL, 0);
> +
> +	switch (req->type) {
> +

No empty line here.

> +	case IFLA_CAIF_IPV4_CONNID:
> +		add_attribute(&req->n, sizeof(*req),
> +				IFLA_CAIF_IPV4_CONNID, &req->conn_id,
> +				sizeof(req->conn_id));
> +		break;
> +
> +	case IFLA_CAIF_IPV6_CONNID:
> +		add_attribute(&req->n, sizeof(*req),
> +				IFLA_CAIF_IPV6_CONNID, &req->conn_id,
> +				sizeof(req->conn_id));
> +		break;
> +
> +	case __IFLA_CAIF_UNSPEC:
> +	case IFLA_CAIF_LOOPBACK:
> +	case __IFLA_CAIF_MAX:
> +		DBG("unsupported linktype");
> +		return -EINVAL;
> +	}
> +
> +	if (req->loop_enabled) {
> +		int loop =3D 1;
> +		add_attribute(&req->n, sizeof(*req),
> +				IFLA_CAIF_LOOPBACK, &loop, sizeof(loop));
> +	}
> +
> +	data->rta_len =3D (void *)NLMSG_TAIL(&req->n) - (void *)data;
> +	linkinfo->rta_len =3D (void *)NLMSG_TAIL(&req->n) - (void *)linkinfo;
> +
> +	return 0;
> +}
> +
> +static void prep_rtnl_dellink_req(struct iplink_req *req, int ifindex)
> +{
> +	req->n.nlmsg_len =3D NLMSG_LENGTH(sizeof(struct ifinfomsg));
> +	req->n.nlmsg_flags =3D NLM_F_REQUEST|NLM_F_CREATE|NLM_F_EXCL;
> +	req->n.nlmsg_type =3D RTM_DELLINK;
> +	req->n.nlmsg_seq =3D ++rtnl_seqnr;
> +	req->i.ifi_family =3D AF_UNSPEC;
> +	req->i.ifi_index =3D ifindex;
> +}

Actually having some generic function with a parameter of nlmsg_type
that fills these details would be a good thing.

> +static gboolean netlink_event(GIOChannel *chan,
> +				GIOCondition cond, gpointer data)
> +{
> +	unsigned char buf[4096];
> +	gsize len;
> +	GIOError err;
> +
> +	if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR)) {
> +		rtnl_watch =3D 0;
> +		return FALSE;
> +	}
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	err =3D g_io_channel_read(chan, (gchar *) buf, sizeof(buf), &len);
> +	if (err) {
> +		if (err =3D=3D G_IO_ERROR_AGAIN)
> +			return TRUE;
> +		rtnl_watch =3D 0;
> +		return FALSE;
> +	}

Just use recv() here. I know that I would prefer to be using GIOChannel
functions, but they don't work well on netlink sockets anyway, so don't
bother with them at all.

Sorry for confusing you and sending you into the wrong direction first.

> +	parse_rtnl_message(buf, len);
> +
> +	return TRUE;
> +}
> +
> +int caif_rtnl_init(void)
> +{
> +	struct sockaddr_nl addr;
> +	int sk, err;
> +
> +	sk =3D socket(PF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
> +	if (sk < 0)
> +		return sk;
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.nl_family =3D AF_NETLINK;
> +	addr.nl_groups =3D RTMGRP_LINK | RTMGRP_IPV4_IFADDR | RTMGRP_IPV4_ROUTE;

You need IPV4_IFADDR and IPV4_ROUTE as well. I don't see you making use
of them. Please only set LING since we don't wanna wake ofonod up for
anything else.

> +	err =3D bind(sk, (struct sockaddr *) &addr, sizeof(addr));
> +	if (err < 0) {
> +		close(sk);
> +		return err;
> +	}
> +
> +	channel =3D g_io_channel_unix_new(sk);
> +	g_io_channel_set_flags(channel, G_IO_FLAG_NONBLOCK, NULL);
> +	g_io_channel_set_close_on_unref(channel, TRUE);
> +
> +	rtnl_watch =3D g_io_add_watch(channel,
> +				G_IO_IN | G_IO_NVAL | G_IO_HUP | G_IO_ERR,
> +				netlink_event, NULL);
> +	pending_requests =3D NULL;

Please don't bother with setting it here to zero. Just set the global
variable to NULL. The init and exit will be only called once anyway.

> +
> +	return 0;
> +}
> +
> +void caif_rtnl_exit(void)
> +{
> +	GSList *list;
> +
> +	if (rtnl_watch > 0)
> +		g_source_remove(rtnl_watch);
> +
> +	g_io_channel_unref(channel);
> +
> +	for (list =3D pending_requests; list; list =3D list->next) {
> +		struct iplink_req *req =3D list->data;
> +		g_free(req);
> +	}
> +
> +	g_slist_free(pending_requests);
> +}
> +
> +
> +int caif_rtnl_create_interface(gpointer user_data, int type, int connid,
> +		gboolean loop, caif_rtnl_create_cb_t cb)
> +{
> +	int err;
> +	struct iplink_req *req;

I prefer structs before int. Just a minor style thing.

> +
> +	req =3D g_try_new0(struct iplink_req, 1);
> +	if (req =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	req->user_data =3D user_data;
> +	req->type =3D type;
> +	req->conn_id =3D connid;
> +	req->loop_enabled =3D loop;
> +	req->callback =3D cb;
> +
> +	err =3D prep_rtnl_newlink_req(req);
> +	if (err < 0)
> +		goto error;

So if we split out creating the NLMSG header into one helper functions,
then you can easily prep the RTNL newlink message here inside the
function.

This will also allow you to remove req->loop_enabled variables since I
don't see need for storing them.

> +
> +	err =3D send_rtnl_req(req);
> +	if (err < 0)
> +		goto error;
> +

Same here. Just putting the sendto() directly in here seems just fine.

> +	pending_requests =3D g_slist_append(pending_requests, req);
> +	return 0;

Extra empty line before a label please.

> +error:
> +	g_free(req);
> +	return err;
> +
> +}
> +
> +int caif_rtnl_delete_interface(int ifid)
> +{
> +	struct iplink_req req;
> +	int err;
> +	memset(&req, 0, sizeof(req));
> +	prep_rtnl_dellink_req(&req, ifid);
> +
> +	err =3D send_rtnl_req(&req);
> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}

Comments from above apply here.

> diff --git a/drivers/stemodem/caif_rtnl.h b/drivers/stemodem/caif_rtnl.h
> new file mode 100644
> index 0000000..8eb1e5f
> --- /dev/null
> +++ b/drivers/stemodem/caif_rtnl.h
> @@ -0,0 +1,29 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2010 ST-Ericsson AB.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +typedef void (*caif_rtnl_create_cb_t) (int result, gpointer user_data,
> +		char *ifname, int ifindex);

Please don't use GLib types here. Using int and void * is better.

So the user_data parameter should come always last. Do we need index and
ifname? I think inside oFono we only care about ifname.

> +extern int caif_rtnl_create_interface(gpointer user_data, int type, int =
connid,
> +		gboolean loop, caif_rtnl_create_cb_t cb);

The user_data is always the last parameter. The only exception would be
having a destruct callback.

Please use int for loop.

> +extern int caif_rtnl_delete_interface(int ifid);
> +
> +extern int caif_rtnl_init(void);
> +extern void caif_rtnl_exit(void);

Regards

Marcel



--===============0275350392975974192==--

