Content-Type: multipart/mixed; boundary="===============6493393618178935720=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCHv2 1/2] stemodem: Add RTNL functionality managing CAIF Network
 Interfaces.
Date: Mon, 01 Nov 2010 21:17:15 +0100
Message-ID: <1288642636-7505-1-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1288630762.3322.120.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6493393618178935720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
Changes from last patch-set:
o squashed previous patches for rtnl.c, rtnl.h and Makefile.am into one pat=
ch
o renamed rtnl.[ch] to caif_rtnl.[ch]
o renamed rtnl_init and rtnl_exit to caif_rtnl_*
o renamed rtnl_create_caif_interface to caif_rtnl_create_interface.

 Makefile.am                  |    2 +
 drivers/stemodem/caif_rtnl.c |  365 ++++++++++++++++++++++++++++++++++++++=
++++
 drivers/stemodem/caif_rtnl.h |   40 +++++
 3 files changed, 407 insertions(+), 0 deletions(-)
 create mode 100644 drivers/stemodem/caif_rtnl.c
 create mode 100644 drivers/stemodem/caif_rtnl.h

diff --git a/Makefile.am b/Makefile.am
index 2562160..fdd363d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -226,6 +226,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/stemodem/stemodem.c \
 			drivers/stemodem/voicecall.c \
 			drivers/stemodem/radio-settings.c \
+			drivers/stemodem/caif_rtnl.c \
+			drivers/stemodem/caif_rtnl.h \
 			drivers/stemodem/gprs-context.c \
 			drivers/stemodem/caif_socket.h \
 			drivers/stemodem/if_caif.h
diff --git a/drivers/stemodem/caif_rtnl.c b/drivers/stemodem/caif_rtnl.c
new file mode 100644
index 0000000..2712df7
--- /dev/null
+++ b/drivers/stemodem/caif_rtnl.c
@@ -0,0 +1,365 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <net/if.h>
+#include <net/if_arp.h>
+#include <linux/rtnetlink.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+
+#include "if_caif.h"
+#include "caif_rtnl.h"
+
+#define NLMSG_TAIL(nmsg) \
+	((struct rtattr *) (((void *) (nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg_len)))
+
+struct iplink_req {
+	struct nlmsghdr n;
+	struct ifinfomsg i;
+	char pad[1024];
+	int request_id;
+	struct rtnl_req_param req;
+	struct rtnl_rsp_param rsp;
+};
+
+static GSList *pending_requests;
+static GIOChannel *channel;
+static guint32 rtnl_seqnr;
+static guint  rtnl_watch;
+
+static gboolean get_ifname(struct ifinfomsg *msg, int bytes,
+				const char **ifname)
+{
+	struct rtattr *attr;
+
+	for (attr =3D IFLA_RTA(msg); RTA_OK(attr, bytes);
+			attr =3D RTA_NEXT(attr, bytes))
+
+		if (attr->rta_type =3D=3D IFLA_IFNAME &&
+				ifname !=3D NULL) {
+			*ifname =3D RTA_DATA(attr);
+			return TRUE;
+		}
+
+	return FALSE;
+}
+
+static void store_newlink_param(struct iplink_req *req, unsigned short typ=
e,
+					int index, unsigned flags,
+					unsigned change, struct ifinfomsg *msg,
+					int bytes)
+{
+	const char *ifname =3D NULL;
+
+	get_ifname(msg, bytes, &ifname);
+	strncpy(req->rsp.ifname, ifname,
+			sizeof(req->rsp.ifname));
+	req->rsp.ifname[sizeof(req->rsp.ifname)-1] =3D '\0';
+	req->rsp.ifindex =3D index;
+}
+
+static int send_rtnl_req(struct iplink_req *req)
+{
+	struct sockaddr_nl addr;
+	int sk, ret;
+
+	sk =3D g_io_channel_unix_get_fd(channel);
+
+	memset(&addr, 0, sizeof(addr));
+	addr.nl_family =3D AF_NETLINK;
+
+	ret =3D sendto(sk, req, req->n.nlmsg_len, 0,
+			(struct sockaddr *) &addr, sizeof(addr));
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static struct iplink_req *find_request(guint32 seq)
+{
+	GSList *list;
+
+	for (list =3D pending_requests; list; list =3D list->next) {
+		struct iplink_req *req =3D list->data;
+
+		if (req->n.nlmsg_seq =3D=3D seq)
+			return req;
+	}
+
+	return NULL;
+}
+
+static void rtnl_client_response(struct iplink_req *req)
+{
+
+	if (req->req.callback && req->n.nlmsg_type =3D=3D RTM_NEWLINK)
+		req->req.callback(&req->rsp);
+
+	pending_requests =3D g_slist_remove(pending_requests, req);
+	g_free(req);
+}
+
+static void parse_rtnl_message(void *buf, size_t len)
+{
+	struct ifinfomsg *msg;
+	struct iplink_req *req;
+
+	while (len > 0) {
+		struct nlmsghdr *hdr =3D buf;
+		if (!NLMSG_OK(hdr, len))
+			break;
+		if (hdr->nlmsg_type =3D=3D RTM_NEWLINK) {
+			req =3D g_slist_nth_data(pending_requests, 0);
+			DBG("NEWLINK req:%p\n", req);
+			if (req =3D=3D NULL)
+				break;
+			msg =3D (struct ifinfomsg *) NLMSG_DATA(hdr);
+			store_newlink_param(req, msg->ifi_type,
+					msg->ifi_index, msg->ifi_flags,
+					msg->ifi_change, msg,
+					IFA_PAYLOAD(hdr));
+			rtnl_client_response(req);
+			return;
+
+		} else if (hdr->nlmsg_type =3D=3D NLMSG_ERROR) {
+			req =3D find_request(hdr->nlmsg_seq);
+			DBG("NLMSG ERROR req:%p\n", req);
+			if (req =3D=3D NULL)
+				break;
+			req->rsp.result =3D -1;
+			rtnl_client_response(req);
+			return;
+		}
+		len -=3D hdr->nlmsg_len;
+		buf +=3D hdr->nlmsg_len;
+	}
+}
+
+static int add_attribute(struct nlmsghdr *n, int maxlen, int type,
+				const void *data, int datalen)
+{
+	int len =3D RTA_LENGTH(datalen);
+	struct rtattr *rta;
+
+	if ((int)(NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len)) > maxlen) {
+		DBG("attribute to large for message %d %d %d\n",
+				n->nlmsg_len, len, maxlen);
+		return -1;
+	}
+
+	rta =3D NLMSG_TAIL(n);
+	rta->rta_type =3D type;
+	rta->rta_len =3D len;
+	memcpy(RTA_DATA(rta), data, datalen);
+	n->nlmsg_len =3D NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len);
+
+	return 0;
+}
+
+static int prep_rtnl_newlink_req(struct iplink_req *req,
+					struct rtnl_req_param *param)
+{
+	char type[] =3D "caif";
+	struct rtattr *linkinfo;
+	struct rtattr *data;
+
+	req->n.nlmsg_len =3D NLMSG_LENGTH(sizeof(struct ifinfomsg));
+	req->n.nlmsg_flags =3D NLM_F_REQUEST|NLM_F_CREATE|NLM_F_EXCL;
+	req->n.nlmsg_type =3D RTM_NEWLINK;
+	req->n.nlmsg_seq =3D ++rtnl_seqnr;
+	req->i.ifi_family =3D AF_UNSPEC;
+
+	linkinfo =3D NLMSG_TAIL(&req->n);
+
+
+	add_attribute(&req->n, sizeof(*req), IFLA_LINKINFO,
+			NULL, 0);
+
+
+	add_attribute(&req->n, sizeof(*req), IFLA_INFO_KIND,
+			type, strlen(type));
+
+	data =3D NLMSG_TAIL(&req->n);
+	add_attribute(&req->n, sizeof(*req), IFLA_INFO_DATA,
+			NULL, 0);
+
+	if (param->type =3D=3D IFLA_CAIF_IPV4_CONNID)
+		add_attribute(&req->n, sizeof(*req),
+				IFLA_CAIF_IPV4_CONNID, &param->conn_id,
+				sizeof(param->conn_id));
+	else if (param->type =3D=3D IFLA_CAIF_IPV6_CONNID)
+		add_attribute(&req->n, sizeof(*req),
+				IFLA_CAIF_IPV6_CONNID, &param->conn_id,
+				sizeof(param->conn_id));
+	else {
+		DBG("unsupported linktype\n");
+		return -EINVAL;
+	}
+
+	if (param->loop_enabled) {
+		int loop =3D 1;
+		add_attribute(&req->n, sizeof(*req),
+				IFLA_CAIF_LOOPBACK, &loop, sizeof(loop));
+	}
+
+	data->rta_len =3D (void *)NLMSG_TAIL(&req->n) - (void *)data;
+	linkinfo->rta_len =3D (void *)NLMSG_TAIL(&req->n) - (void *)linkinfo;
+
+	return 0;
+}
+
+static void prep_rtnl_dellink_req(struct iplink_req *req, int ifindex)
+{
+	req->n.nlmsg_len =3D NLMSG_LENGTH(sizeof(struct ifinfomsg));
+	req->n.nlmsg_flags =3D NLM_F_REQUEST|NLM_F_CREATE|NLM_F_EXCL;
+	req->n.nlmsg_type =3D RTM_DELLINK;
+	req->n.nlmsg_seq =3D ++rtnl_seqnr;
+	req->i.ifi_family =3D AF_UNSPEC;
+	req->i.ifi_index =3D ifindex;
+}
+
+static gboolean netlink_event(GIOChannel *chan,
+				GIOCondition cond, gpointer data)
+{
+	unsigned char buf[4096];
+	gsize len;
+	GIOError err;
+
+	if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR))
+		return FALSE;
+
+	memset(buf, 0, sizeof(buf));
+
+	err =3D g_io_channel_read(chan, (gchar *) buf, sizeof(buf), &len);
+	if (err) {
+		if (err =3D=3D G_IO_ERROR_AGAIN)
+			return TRUE;
+		return FALSE;
+	}
+
+	parse_rtnl_message(buf, len);
+
+	return TRUE;
+}
+
+int caif_rtnl_init(void)
+{
+	struct sockaddr_nl addr;
+	int sk, ret;
+
+	sk =3D socket(PF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
+	if (sk < 0)
+		return sk;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.nl_family =3D AF_NETLINK;
+	addr.nl_groups =3D RTMGRP_LINK | RTMGRP_IPV4_IFADDR | RTMGRP_IPV4_ROUTE;
+
+	ret =3D bind(sk, (struct sockaddr *) &addr, sizeof(addr));
+	if (ret < 0) {
+		close(sk);
+		return ret;
+	}
+
+	channel =3D g_io_channel_unix_new(sk);
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	rtnl_watch =3D g_io_add_watch(channel,
+				G_IO_IN | G_IO_NVAL | G_IO_HUP | G_IO_ERR,
+				netlink_event, NULL);
+
+	return 0;
+}
+
+void caif_rtnl_exit(void)
+{
+	GSList *list;
+
+	if (rtnl_watch > 0)
+		g_source_remove(rtnl_watch);
+
+	for (list =3D pending_requests; list; list =3D list->next) {
+		struct iplink_req *req =3D list->data;
+		g_free(req);
+		list->data =3D NULL;
+	}
+
+	g_slist_free(pending_requests);
+	pending_requests =3D NULL;
+
+	g_io_channel_shutdown(channel, TRUE, NULL);
+	g_io_channel_unref(channel);
+
+	channel =3D NULL;
+}
+
+
+int caif_rtnl_create_interface(struct rtnl_req_param *req_param)
+{
+	int ret;
+	struct rtnl_rsp_param resp_param;
+	struct iplink_req *req;
+
+	memset(&resp_param, 0, sizeof(resp_param));
+
+	req =3D g_try_new0(struct iplink_req, 1);
+	if (req =3D=3D NULL) {
+		ret =3D -ENOMEM;
+		goto error;
+	}
+
+	resp_param.user_data =3D req_param->user_data;
+
+	req->req =3D *req_param;
+	req->rsp =3D resp_param;
+
+	ret =3D prep_rtnl_newlink_req(req, req_param);
+	if (ret < 0)
+		goto error;
+
+	pending_requests =3D g_slist_append(pending_requests, req);
+
+	ret =3D send_rtnl_req(req);
+	if (ret =3D=3D 0)
+		return 0;
+
+	pending_requests =3D g_slist_remove(pending_requests, req);
+error:
+	g_free(req);
+	return ret;
+}
+
+int caif_rtnl_delete_interface(int ifid)
+{
+	struct iplink_req req;
+
+	memset(&req, 0, sizeof(req));
+	prep_rtnl_dellink_req(&req, ifid);
+	return send_rtnl_req(&req);
+}
diff --git a/drivers/stemodem/caif_rtnl.h b/drivers/stemodem/caif_rtnl.h
new file mode 100644
index 0000000..3d171f9
--- /dev/null
+++ b/drivers/stemodem/caif_rtnl.h
@@ -0,0 +1,40 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+struct rtnl_rsp_param {
+	int result;
+	gpointer user_data;
+	char ifname[IF_NAMESIZE];
+	int  ifindex;
+};
+
+struct rtnl_req_param {
+	void (*callback)(struct rtnl_rsp_param *param);
+	gpointer user_data;
+	int type;
+	int conn_id;
+	gboolean loop_enabled;
+};
+
+extern int caif_rtnl_create_interface(struct rtnl_req_param *req);
+extern int caif_rtnl_delete_interface(int ifid);
+
+extern int caif_rtnl_init(void);
+extern void caif_rtnl_exit(void);
-- =

1.7.0.4


--===============6493393618178935720==--

