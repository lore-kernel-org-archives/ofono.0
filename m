Content-Type: multipart/mixed; boundary="===============1002450492923996132=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [RFC] stemodem: Add RTNL support for creating CAIF interface.
Date: Wed, 18 Aug 2010 15:39:52 +0200
Message-ID: <1282138792-16477-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1002450492923996132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a new module rtnl.[ch] for creating and deleting a
CAIF Network Interface. The rtnl module uses standard RTNL NEWLINK
and DELLINK commands. CAIF Network Interface takes a Connection-ID
in order to be able to associate the AT command for pdp-context
activation with CAIF Channel and CAIF Interface.

gprs-context.c will create interfaces at initially in the probe function
and delete the interfaces at remove. The RTNL requests are handled
asynchronously.
---
 Makefile.am                     |    2 +
 drivers/stemodem/gprs-context.c |   77 ++++++---
 drivers/stemodem/rtnl.c         |  359 +++++++++++++++++++++++++++++++++++=
++++
 drivers/stemodem/rtnl.h         |   42 +++++
 4 files changed, 456 insertions(+), 24 deletions(-)
 create mode 100644 drivers/stemodem/rtnl.c
 create mode 100644 drivers/stemodem/rtnl.h

diff --git a/Makefile.am b/Makefile.am
index 0485a84..52debb7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -203,6 +203,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/stemodem/stemodem.c \
 			drivers/stemodem/voicecall.c \
 			drivers/stemodem/radio-settings.c \
+			drivers/stemodem/rtnl.c \
+			drivers/stemodem/rtnl.h \
 			drivers/stemodem/gprs-context.c \
 			drivers/stemodem/caif_socket.h \
 			drivers/stemodem/if_caif.h
diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index d3a50a9..1c8e203 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -46,6 +46,7 @@
 #include "stemodem.h"
 #include "caif_socket.h"
 #include "if_caif.h"
+#include "rtnl.h"
 =

 #define MAX_CAIF_DEVICES 7
 #define MAX_DNS 2
@@ -68,7 +69,9 @@ struct conn_info {
 	unsigned int cid;
 	unsigned int device;
 	unsigned int channel_id;
-	char interface[10];
+	unsigned int ifindex;
+	gboolean created;
+	char interface[IF_NAMESIZE];
 };
 =

 struct eppsd_response {
@@ -168,20 +171,53 @@ static struct conn_info *conn_info_create(unsigned in=
t device,
 	return connection;
 }
 =

+static void rtnl_callback(struct rtnl_rsp_param *param)
+{
+	struct conn_info *conn =3D param->user_data;
+
+	strncpy(conn->interface, param->ifname, sizeof(conn->interface));
+	conn->ifindex =3D param->ifindex;
+	conn->created =3D param->result =3D=3D 0;
+}
+
 /*
  * Creates a new IP interface for CAIF.
  */
-static gboolean caif_if_create(const char *interface, unsigned int connid)
+static gboolean caif_if_create(struct conn_info *conn)
 {
-	return FALSE;
+	struct rtnl_req_param req_param;
+
+	req_param.type =3D IFLA_CAIF_IPV4_CONNID;
+	req_param.conn_id =3D conn->channel_id;
+	req_param.user_data =3D conn;
+	req_param.callback =3D rtnl_callback;
+	strcpy(req_param.ifname, "caif%d");
+
+	if (rtnl_create_caif_interface(&req_param) < 0) {
+		DBG("Failed to create IP interface for CAIF");
+		return FALSE;
+	}
+
+	return TRUE;
 }
 =

 /*
  * Removes IP interface for CAIF.
  */
-static gboolean caif_if_remove(const char *interface, unsigned int connid)
+static void caif_if_remove(struct conn_info *conn)
 {
-	return FALSE;
+	if (!conn->created)
+		return;
+
+	if (rtnl_delete_caif_interface(conn->ifindex) < 0) {
+		ofono_error("Failed to delete caif interface %s",
+			conn->interface);
+		return;
+	}
+
+	DBG("removed CAIF interface ch:%d ifname:%s ifindex:%d\n",
+		conn->channel_id, conn->interface, conn->ifindex);
+	return;
 }
 =

 static void ste_eppsd_down_cb(gboolean ok, GAtResult *result,
@@ -210,12 +246,6 @@ static void ste_eppsd_down_cb(gboolean ok, GAtResult *=
result,
 	}
 =

 	conn =3D l->data;
-
-	if (!caif_if_remove(conn->interface, conn->channel_id)) {
-		DBG("Failed to remove caif interface %s.",
-				conn->interface);
-	}
-
 	conn->cid =3D 0;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
@@ -283,20 +313,9 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	dns[1] =3D rsp.dns_server2;
 	dns[2] =3D NULL;
 =

-	sprintf(conn->interface, "caif%u", conn->device);
-
-	if (!caif_if_create(conn->interface, conn->channel_id)) {
-		ofono_error("Failed to create caif interface %s.",
-				conn->interface);
-		CALLBACK_WITH_SUCCESS(cb, NULL, FALSE, rsp.ip_address,
+	CALLBACK_WITH_SUCCESS(cb, conn->interface, FALSE, rsp.ip_address,
 				rsp.subnet_mask, rsp.default_gateway,
 				dns, cbd->data);
-	} else {
-		CALLBACK_WITH_SUCCESS(cb, conn->interface,
-				FALSE, rsp.ip_address, rsp.subnet_mask,
-				rsp.default_gateway, dns, cbd->data);
-	}
-
 	return;
 =

 error:
@@ -343,6 +362,13 @@ static void ste_cgdcont_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	}
 =

 	conn =3D l->data;
+
+	/* TODO: Do we need better error handling on missing caif interface? */
+	if (!conn->created) {
+		DBG("at_cgdcont_cb, CAIF Interface creation has failed");
+		goto error;
+	}
+
 	conn->cid =3D gcd->active_context;
 	snprintf(buf, sizeof(buf), "AT*EPPSD=3D1,%u,%u",
 			conn->channel_id, conn->cid);
@@ -517,6 +543,7 @@ static int ste_gprs_context_probe(struct ofono_gprs_con=
text *gc,
 =

 	for (i =3D 0; i < MAX_CAIF_DEVICES; i++) {
 		ci =3D conn_info_create(i, i+1);
+		caif_if_create(ci);
 		if (ci)
 			g_caif_devices =3D g_slist_append(g_caif_devices, ci);
 	}
@@ -527,7 +554,7 @@ static int ste_gprs_context_probe(struct ofono_gprs_con=
text *gc,
 static void ste_gprs_context_remove(struct ofono_gprs_context *gc)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-
+	g_slist_foreach(g_caif_devices, (GFunc) caif_if_remove, NULL);
 	g_slist_foreach(g_caif_devices, (GFunc) g_free, NULL);
 	g_slist_free(g_caif_devices);
 	g_caif_devices =3D NULL;
@@ -548,10 +575,12 @@ static struct ofono_gprs_context_driver driver =3D {
 =

 void ste_gprs_context_init()
 {
+	rtnl_init();
 	ofono_gprs_context_driver_register(&driver);
 }
 =

 void ste_gprs_context_exit()
 {
+	rtnl_exit();
 	ofono_gprs_context_driver_unregister(&driver);
 }
diff --git a/drivers/stemodem/rtnl.c b/drivers/stemodem/rtnl.c
new file mode 100644
index 0000000..4fb760d
--- /dev/null
+++ b/drivers/stemodem/rtnl.c
@@ -0,0 +1,359 @@
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
+#include <net/if_arp.h>
+#include <linux/rtnetlink.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+
+#include "if_caif.h"
+#include "rtnl.h"
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
+static GIOChannel *channel =3D NULL;
+static guint32 rtnl_seqnr;
+
+static gboolean get_ifname(struct ifinfomsg *msg, int bytes,
+			const char **ifname)
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
+static void store_rtnl_response(struct iplink_req *req, unsigned short typ=
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
+static int send_iplink_req(struct iplink_req *req)
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
+static void rtnl_final_response(struct iplink_req *req)
+{
+
+	if (req->req.callback && req->n.nlmsg_type =3D=3D RTM_NEWLINK )
+		req->req.callback(&req->rsp);
+
+	pending_requests =3D g_slist_remove(pending_requests, req);
+	g_free(req);
+}
+
+static void handle_rtnl_message(void *buf, size_t len)
+{
+	struct ifinfomsg *msg;
+	struct iplink_req *req;
+
+	while (len > 0) {
+		struct nlmsghdr *hdr =3D buf;
+		struct nlmsgerr *err;
+
+		if (!NLMSG_OK(hdr, len))
+			break;
+
+		if (hdr->nlmsg_type =3D=3D NLMSG_ERROR) {
+			req =3D find_request(hdr->nlmsg_seq);
+			if (req =3D=3D NULL)
+				break;
+
+			err =3D NLMSG_DATA(hdr);
+			DBG("RTNL failed: seq:%d error %d (%s)",
+					hdr->nlmsg_seq, err->error,
+					strerror(-err->error));
+			req->rsp.result =3D err->error;
+			rtnl_final_response(req);
+			return;
+		} else if (hdr->nlmsg_type =3D=3D RTM_NEWLINK ||
+				hdr->nlmsg_type =3D=3D RTM_DELLINK) {
+			req =3D g_slist_nth_data(pending_requests, 0);
+			if (req =3D=3D NULL)
+				break;
+
+			msg =3D (struct ifinfomsg *) NLMSG_DATA(hdr);
+			store_rtnl_response(req, msg->ifi_type,
+					msg->ifi_index, msg->ifi_flags,
+					msg->ifi_change, msg,
+					IFA_PAYLOAD(hdr));
+			break;
+		} else
+			return;
+
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
+	req->n.nlmsg_flags =3D NLM_F_REQUEST|NLM_F_CREATE|NLM_F_EXCL|NLM_F_ACK;
+	req->n.nlmsg_type =3D RTM_NEWLINK;
+	req->n.nlmsg_seq =3D ++rtnl_seqnr;
+	req->i.ifi_family =3D AF_UNSPEC;
+
+	linkinfo =3D NLMSG_TAIL(&req->n);
+
+	add_attribute(&req->n, sizeof(*req), IFLA_LINKINFO,
+			NULL, 0);
+	add_attribute(&req->n, sizeof(*req), IFLA_INFO_KIND,
+			type, strlen(type));
+	add_attribute(&req->n, sizeof(*req), IFLA_IFNAME,
+			param->ifname, strlen(param->ifname));
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
+		g_free(req);
+		return -1;
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
+	req->n.nlmsg_flags =3D NLM_F_REQUEST|NLM_F_CREATE|NLM_F_EXCL|NLM_F_ACK;
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
+	handle_rtnl_message(buf, len);
+
+	return TRUE;
+}
+
+int rtnl_init(void)
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
+	g_io_add_watch(channel, G_IO_IN | G_IO_NVAL | G_IO_HUP | G_IO_ERR,
+							netlink_event, NULL);
+
+	return 0;
+}
+
+void rtnl_exit(void)
+{
+	GSList *list;
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
+/* Note ifname is in/out and must be minimum size IF_NAMESIZE */
+int rtnl_create_caif_interface(struct rtnl_req_param *req_param)
+{
+	int ret;
+	struct rtnl_rsp_param resp_param;
+	struct iplink_req *req;
+
+	memset(&resp_param, 0, sizeof(resp_param));
+
+	req =3D g_try_new0(struct iplink_req, 1);
+	if (req =3D=3D NULL)
+		return -ENOMEM;
+
+	resp_param.user_data =3D req_param->user_data;
+
+	req->req =3D *req_param;
+	req->rsp =3D resp_param;
+
+	ret =3D prep_rtnl_newlink_req(req,req_param);
+	if (ret < 0)
+		return ret;
+
+	pending_requests =3D g_slist_append(pending_requests, req);
+
+	return send_iplink_req(req);
+}
+
+int rtnl_delete_caif_interface(int ifid)
+{
+	struct iplink_req req;
+
+	memset(&req, 0, sizeof(req));
+
+	prep_rtnl_dellink_req(&req, ifid);
+
+	return send_iplink_req(&req);
+}
diff --git a/drivers/stemodem/rtnl.h b/drivers/stemodem/rtnl.h
new file mode 100644
index 0000000..41b14ba
--- /dev/null
+++ b/drivers/stemodem/rtnl.h
@@ -0,0 +1,42 @@
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
+	char ifname[IF_NAMESIZE];
+	gboolean loop_enabled;
+};
+
+extern int rtnl_create_caif_interface(struct rtnl_req_param *req);
+extern int rtnl_delete_caif_interface(int ifid);
+
+extern int rtnl_init();
+extern void rtnl_exit();
-- =

1.7.0.4


--===============1002450492923996132==--

