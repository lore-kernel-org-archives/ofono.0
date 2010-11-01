Content-Type: multipart/mixed; boundary="===============7050786950936137751=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2 1/2] stemodem: Add RTNL functionality managing CAIF
 Network Interfaces.
Date: Mon, 01 Nov 2010 22:04:14 +0100
Message-ID: <1288645454.3322.137.camel@aeonflux>
In-Reply-To: <1288642636-7505-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7050786950936137751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

>  Makefile.am                  |    2 +
>  drivers/stemodem/caif_rtnl.c |  365 ++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/stemodem/caif_rtnl.h |   40 +++++
>  3 files changed, 407 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/stemodem/caif_rtnl.c
>  create mode 100644 drivers/stemodem/caif_rtnl.h

just to be clear. You want to name it like this? I am just asking here
since I made a few proposals.

> +#define NLMSG_TAIL(nmsg) \
> +	((struct rtattr *) (((void *) (nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg_len)))

We don't have this one as part of some kernel includes?

> +struct iplink_req {
> +	struct nlmsghdr n;
> +	struct ifinfomsg i;
> +	char pad[1024];
> +	int request_id;
> +	struct rtnl_req_param req;
> +	struct rtnl_rsp_param rsp;
> +};
> +
> +static GSList *pending_requests;
> +static GIOChannel *channel;
> +static guint32 rtnl_seqnr;
> +static guint  rtnl_watch;

To be fair, you don't need both, the GIOChannel and the watch. You can
just add the watch and then unref the GIOChannel and set it to close on
unref. That way when the watch gets removed or you remove it, the
GIOChannel and the underlaying socket will be automatically closed as
well.

> +static gboolean get_ifname(struct ifinfomsg *msg, int bytes,
> +				const char **ifname)
> +{
> +	struct rtattr *attr;
> +
> +	for (attr =3D IFLA_RTA(msg); RTA_OK(attr, bytes);
> +			attr =3D RTA_NEXT(attr, bytes))
> +
> +		if (attr->rta_type =3D=3D IFLA_IFNAME &&
> +				ifname !=3D NULL) {
> +			*ifname =3D RTA_DATA(attr);
> +			return TRUE;
> +		}
> +
> +	return FALSE;
> +}

After I stared long enough at it, I realized that the code is fine, but
that was not obvious to me. In this case please use for () { } with the
curly braces around it. It improves readability.

And I know that other times we don't do { } for single statements, but
here is does helps my poor human brain ;)


> +static void store_newlink_param(struct iplink_req *req, unsigned short t=
ype,
> +					int index, unsigned flags,
> +					unsigned change, struct ifinfomsg *msg,
> +					int bytes)
> +{
> +	const char *ifname =3D NULL;
> +
> +	get_ifname(msg, bytes, &ifname);
> +	strncpy(req->rsp.ifname, ifname,
> +			sizeof(req->rsp.ifname));
> +	req->rsp.ifname[sizeof(req->rsp.ifname)-1] =3D '\0';
> +	req->rsp.ifindex =3D index;
> +}
> +
> +static int send_rtnl_req(struct iplink_req *req)
> +{
> +	struct sockaddr_nl addr;
> +	int sk, ret;
> +
> +	sk =3D g_io_channel_unix_get_fd(channel);
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.nl_family =3D AF_NETLINK;
> +
> +	ret =3D sendto(sk, req, req->n.nlmsg_len, 0,
> +			(struct sockaddr *) &addr, sizeof(addr));
> +	if (ret < 0)
> +		return ret;
> +	return 0;
> +}

Can we just not do "return sendto(..." and then have the caller to a
proper "if send_rtnl_req() < 0)" check. Looks much simpler to me.

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
> +
> +static void rtnl_client_response(struct iplink_req *req)
> +{
> +
> +	if (req->req.callback && req->n.nlmsg_type =3D=3D RTM_NEWLINK)
> +		req->req.callback(&req->rsp);
> +
> +	pending_requests =3D g_slist_remove(pending_requests, req);
> +	g_free(req);
> +}
> +
> +static void parse_rtnl_message(void *buf, size_t len)
> +{
> +	struct ifinfomsg *msg;
> +	struct iplink_req *req;
> +
> +	while (len > 0) {
> +		struct nlmsghdr *hdr =3D buf;
> +		if (!NLMSG_OK(hdr, len))
> +			break;
> +		if (hdr->nlmsg_type =3D=3D RTM_NEWLINK) {
> +			req =3D g_slist_nth_data(pending_requests, 0);
> +			DBG("NEWLINK req:%p\n", req);
> +			if (req =3D=3D NULL)
> +				break;
> +			msg =3D (struct ifinfomsg *) NLMSG_DATA(hdr);
> +			store_newlink_param(req, msg->ifi_type,
> +					msg->ifi_index, msg->ifi_flags,
> +					msg->ifi_change, msg,
> +					IFA_PAYLOAD(hdr));
> +			rtnl_client_response(req);
> +			return;
> +
> +		} else if (hdr->nlmsg_type =3D=3D NLMSG_ERROR) {
> +			req =3D find_request(hdr->nlmsg_seq);
> +			DBG("NLMSG ERROR req:%p\n", req);
> +			if (req =3D=3D NULL)
> +				break;
> +			req->rsp.result =3D -1;
> +			rtnl_client_response(req);
> +			return;
> +		}
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
> +static int prep_rtnl_newlink_req(struct iplink_req *req,
> +					struct rtnl_req_param *param)
> +{
> +	char type[] =3D "caif";
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
> +
> +
> +	add_attribute(&req->n, sizeof(*req), IFLA_LINKINFO,
> +			NULL, 0);
> +
> +

You have double empty lines here (twice). Please remove them.

> +	add_attribute(&req->n, sizeof(*req), IFLA_INFO_KIND,
> +			type, strlen(type));
> +
> +	data =3D NLMSG_TAIL(&req->n);
> +	add_attribute(&req->n, sizeof(*req), IFLA_INFO_DATA,
> +			NULL, 0);
> +
> +	if (param->type =3D=3D IFLA_CAIF_IPV4_CONNID)
> +		add_attribute(&req->n, sizeof(*req),
> +				IFLA_CAIF_IPV4_CONNID, &param->conn_id,
> +				sizeof(param->conn_id));
> +	else if (param->type =3D=3D IFLA_CAIF_IPV6_CONNID)
> +		add_attribute(&req->n, sizeof(*req),
> +				IFLA_CAIF_IPV6_CONNID, &param->conn_id,
> +				sizeof(param->conn_id));
> +	else {
> +		DBG("unsupported linktype\n");
> +		return -EINVAL;
> +	}

Would be using a switch here a bit cleaner? Please use a switch.

> +	if (param->loop_enabled) {
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
> +
> +static gboolean netlink_event(GIOChannel *chan,
> +				GIOCondition cond, gpointer data)
> +{
> +	unsigned char buf[4096];
> +	gsize len;
> +	GIOError err;
> +
> +	if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR))
> +		return FALSE;

In this return case you need to set the global watch variable back to 0
since that watch will be gone now.

> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	err =3D g_io_channel_read(chan, (gchar *) buf, sizeof(buf), &len);
> +	if (err) {
> +		if (err =3D=3D G_IO_ERROR_AGAIN)
> +			return TRUE;
> +		return FALSE;

Same case here.

> +	}
> +
> +	parse_rtnl_message(buf, len);
> +
> +	return TRUE;
> +}
> +
> +int caif_rtnl_init(void)
> +{
> +	struct sockaddr_nl addr;
> +	int sk, ret;
> +
> +	sk =3D socket(PF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
> +	if (sk < 0)
> +		return sk;
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.nl_family =3D AF_NETLINK;
> +	addr.nl_groups =3D RTMGRP_LINK | RTMGRP_IPV4_IFADDR | RTMGRP_IPV4_ROUTE;
> +
> +	ret =3D bind(sk, (struct sockaddr *) &addr, sizeof(addr));
> +	if (ret < 0) {
> +		close(sk);
> +		return ret;
> +	}
> +
> +	channel =3D g_io_channel_unix_new(sk);
> +	g_io_channel_set_close_on_unref(channel, TRUE);
> +	rtnl_watch =3D g_io_add_watch(channel,
> +				G_IO_IN | G_IO_NVAL | G_IO_HUP | G_IO_ERR,
> +				netlink_event, NULL);

As described above. Just unref the GIOChannel and forget about it. And
then you can make the GIOChannel a local variable.

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
> +	for (list =3D pending_requests; list; list =3D list->next) {
> +		struct iplink_req *req =3D list->data;
> +		g_free(req);
> +		list->data =3D NULL;

Setting list->data =3D NULL is not really needed.

> +	}
> +
> +	g_slist_free(pending_requests);
> +	pending_requests =3D NULL;

No need to set pending_requests to NULL here.

> +
> +	g_io_channel_shutdown(channel, TRUE, NULL);
> +	g_io_channel_unref(channel);
> +
> +	channel =3D NULL;

As described above, this is no longer needed.
> +}
> +
> +
> +int caif_rtnl_create_interface(struct rtnl_req_param *req_param)
> +{
> +	int ret;

Please use err as variable instead of ret.

> +	struct rtnl_rsp_param resp_param;
> +	struct iplink_req *req;
> +
> +	memset(&resp_param, 0, sizeof(resp_param));
> +
> +	req =3D g_try_new0(struct iplink_req, 1);
> +	if (req =3D=3D NULL) {
> +		ret =3D -ENOMEM;
> +		goto error;
> +	}

This is rather pointless. Just to "return -ENOMEM;"

> +	resp_param.user_data =3D req_param->user_data;
> +
> +	req->req =3D *req_param;
> +	req->rsp =3D resp_param;
> +
> +	ret =3D prep_rtnl_newlink_req(req, req_param);
> +	if (ret < 0)
> +		goto error;
> +
> +	pending_requests =3D g_slist_append(pending_requests, req);
> +
> +	ret =3D send_rtnl_req(req);
> +	if (ret =3D=3D 0)
> +		return 0;

As mentioned above, this should be if (err < 0).

> +
> +	pending_requests =3D g_slist_remove(pending_requests, req);

You don't really have to play this append/remove game. You can just
append it after send_rtnl_req succeed. The read goes via the mainloop
anyway and we are a single threaded program. So the order is guaranteed.

> +error:
> +	g_free(req);
> +	return ret;
> +}
> +
> +int caif_rtnl_delete_interface(int ifid)
> +{
> +	struct iplink_req req;
> +
> +	memset(&req, 0, sizeof(req));
> +	prep_rtnl_dellink_req(&req, ifid);

And here you should add an extra empty line.

> +	return send_rtnl_req(&req);
> +}
> diff --git a/drivers/stemodem/caif_rtnl.h b/drivers/stemodem/caif_rtnl.h
> new file mode 100644
> index 0000000..3d171f9
> --- /dev/null
> +++ b/drivers/stemodem/caif_rtnl.h
> @@ -0,0 +1,40 @@
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

And an extra empty line here to separate copyright header and license
text from actual code.

> +struct rtnl_rsp_param {
> +	int result;
> +	gpointer user_data;
> +	char ifname[IF_NAMESIZE];
> +	int  ifindex;
> +};
> +
> +struct rtnl_req_param {
> +	void (*callback)(struct rtnl_rsp_param *param);
> +	gpointer user_data;
> +	int type;
> +	int conn_id;
> +	gboolean loop_enabled;
> +};
> +
> +extern int caif_rtnl_create_interface(struct rtnl_req_param *req);
> +extern int caif_rtnl_delete_interface(int ifid);

I am not really sold on this param stuct thingy btw. Why do you need
them? Just proper input params and output params for the callback
handler would do them same. Won't they?

> +
> +extern int caif_rtnl_init(void);
> +extern void caif_rtnl_exit(void);

I do need another look at the RTNL magic and casting. That always drives
my crazy when I look at that. In the meantime, please address these
details first.

Regards

Marcel



--===============7050786950936137751==--

