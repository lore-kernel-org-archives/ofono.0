Content-Type: multipart/mixed; boundary="===============4212595744277904303=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH v3 6/7] stemodem: Use RTNL for creating CAIF interface
Date: Mon, 16 Aug 2010 22:35:48 +0200
Message-ID: <1281990950-21705-6-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1281990950-21705-5-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4212595744277904303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

CAIF in Linux kernel 2.6.35 must use RTNL for configuring
CAIF interfaces.
---
 drivers/stemodem/gprs-context.c |   51 +++++--
 drivers/stemodem/rtnl.c         |  318 +++++++++++++++++++++++++++++++++++=
++++
 drivers/stemodem/rtnl.h         |   24 +++
 3 files changed, 380 insertions(+), 13 deletions(-)
 create mode 100644 drivers/stemodem/rtnl.c
 create mode 100644 drivers/stemodem/rtnl.h

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index ace9d6e..591df33 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -43,8 +43,9 @@
 =

 #include "gatchat.h"
 #include "gatresult.h"
+
+#include "rtnl.h"
 #include "stemodem.h"
-#include "caif_socket.h"
 #include "if_caif.h"
 =

 #define MAX_CAIF_DEVICES 7
@@ -68,7 +69,8 @@ struct conn_info {
 	unsigned int cid;
 	unsigned int device;
 	unsigned int channel_id;
-	char interface[10];
+	char ifname[16];
+	int ifindex;
 };
 =

 struct eppsd_response {
@@ -171,17 +173,40 @@ static struct conn_info *conn_info_create(unsigned in=
t device,
 /*
  * Creates a new IP interface for CAIF.
  */
-static gboolean caif_if_create(const char *interface, unsigned int connid)
+static gboolean caif_if_create(struct conn_info *conn)
 {
-	return FALSE;
+
+	strcpy(conn->ifname, "caif%d");
+	if (rtnl_create_caif_interface(IFLA_CAIF_IPV4_CONNID,
+					conn->channel_id,
+					conn->ifname,
+					&conn->ifindex) < 0) {
+		DBG("Failed to create IP interface for CAIF");
+		return FALSE;
+	}
+
+	DBG("created CAIF interface ch:%d ifname:%s ifindex:%d\n",
+		conn->channel_id, conn->ifname, conn->ifindex);
+
+	return TRUE;
 }
 =

 /*
  * Removes IP interface for CAIF.
  */
-static gboolean caif_if_remove(const char *interface, unsigned int connid)
+static gboolean caif_if_remove(struct conn_info *conn)
 {
-	return FALSE;
+
+	if (rtnl_delete_caif_interface(conn->ifindex) < 0) {
+		ofono_error("Failed to delete caif interface %s",
+			conn->ifname);
+		return FALSE;
+	}
+
+	DBG("removed CAIF interface ch:%d ifname:%s ifindex:%d\n",
+		conn->channel_id, conn->ifname, conn->ifindex);
+
+	return TRUE;
 }
 =

 static void ste_eppsd_down_cb(gboolean ok, GAtResult *result,
@@ -211,9 +236,9 @@ static void ste_eppsd_down_cb(gboolean ok, GAtResult *r=
esult,
 =

 	conn =3D l->data;
 =

-	if (!caif_if_remove(conn->interface, conn->channel_id)) {
+	if (!caif_if_remove(conn)) {
 		DBG("Failed to remove caif interface %s.",
-				conn->interface);
+				conn->ifname);
 	}
 =

 	conn->cid =3D 0;
@@ -283,16 +308,16 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	dns[1] =3D rsp.dns_server2;
 	dns[2] =3D NULL;
 =

-	sprintf(conn->interface, "caif%u", conn->device);
+	sprintf(conn->ifname, "caif%u", conn->device);
 =

-	if (!caif_if_create(conn->interface, conn->channel_id)) {
+	if (!caif_if_create(conn)) {
 		ofono_error("Failed to create caif interface %s.",
-				conn->interface);
+				conn->ifname);
 		CALLBACK_WITH_SUCCESS(cb, NULL, FALSE, rsp.ip_address,
 				rsp.subnet_mask, rsp.default_gateway,
 				dns, cbd->data);
 	} else {
-		CALLBACK_WITH_SUCCESS(cb, conn->interface,
+		CALLBACK_WITH_SUCCESS(cb, conn->ifname,
 				FALSE, rsp.ip_address, rsp.subnet_mask,
 				rsp.default_gateway, dns, cbd->data);
 	}
@@ -544,7 +569,7 @@ static void ste_gprs_context_remove(struct ofono_gprs_c=
ontext *gc)
 static struct ofono_gprs_context_driver driver =3D {
 	.name			=3D "stemodem",
 	.probe			=3D ste_gprs_context_probe,
-	.remove			=3D ste_gprs_context_remove,
+	.remove		=3D ste_gprs_context_remove,
 	.activate_primary	=3D ste_gprs_activate_primary,
 	.deactivate_primary	=3D ste_gprs_deactivate_primary,
 };
diff --git a/drivers/stemodem/rtnl.c b/drivers/stemodem/rtnl.c
new file mode 100644
index 0000000..7990810
--- /dev/null
+++ b/drivers/stemodem/rtnl.c
@@ -0,0 +1,318 @@
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
+	int ifindex;
+	char ifname[16];
+	int result;
+};
+
+static guint32 ipconfig_seqnr =3D 1;
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
+static void handle_rtnl_response(struct iplink_req *req, unsigned short ty=
pe,
+					int index, unsigned flags,
+					unsigned change, struct ifinfomsg *msg,
+					int bytes)
+{
+	const char *ifname =3D NULL;
+
+	get_ifname(msg, bytes, &ifname);
+	req->ifindex =3D index;
+	strncpy(req->ifname, ifname,
+			sizeof(req->ifname));
+	req->ifname[sizeof(req->ifname)-1] =3D '\0';
+}
+
+static int send_iplink_req(int sk, struct iplink_req *req)
+{
+	struct sockaddr_nl addr;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.nl_family =3D AF_NETLINK;
+
+	return sendto(sk, req, req->n.nlmsg_len, 0,
+			(struct sockaddr *) &addr, sizeof(addr));
+}
+
+static int parse_rtnl_message(void *buf, size_t len, struct iplink_req *re=
q)
+{
+	struct ifinfomsg *msg;
+
+	while (len > 0) {
+		struct nlmsghdr *hdr =3D buf;
+		struct nlmsgerr *err;
+
+		if (!NLMSG_OK(hdr, len))
+			break;
+
+		if (hdr->nlmsg_type =3D=3D NLMSG_ERROR) {
+			err =3D NLMSG_DATA(hdr);
+			DBG("RTNL failed: seq:%d error %d (%s)",
+					hdr->nlmsg_seq, err->error,
+					strerror(-err->error));
+			req->result =3D err->error;
+			return err->error;
+		}
+
+		else if (hdr->nlmsg_type =3D=3D RTM_NEWLINK ||
+			hdr->nlmsg_type =3D=3D RTM_DELLINK) {
+			msg =3D (struct ifinfomsg *) NLMSG_DATA(hdr);
+			handle_rtnl_response(req, msg->ifi_type,
+					msg->ifi_index, msg->ifi_flags,
+					msg->ifi_change, msg,
+					IFA_PAYLOAD(hdr));
+			break;
+		} else
+			return -1;
+
+		len -=3D hdr->nlmsg_len;
+		buf +=3D hdr->nlmsg_len;
+	}
+	return 1;
+}
+
+static int netlink_get_response(int sk, struct iplink_req *req)
+{
+	unsigned char buf[4096];
+	int ret;
+
+	memset(buf, 0, sizeof(buf));
+
+	do {
+		ret =3D read(sk, buf, sizeof(buf));
+		if (ret < 0)
+			break;
+		ret =3D parse_rtnl_message(buf, sizeof(buf), req);
+	} while (ret > 0);
+
+	return ret;
+}
+
+static int add_attribute(struct nlmsghdr *n, int maxlen, int type,
+			const void *data, int datalen)
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
+static int create_caif_interface(int sk, struct iplink_req *req,
+					int connection_type, char *ifname,
+					int nsapi, int loop_enabled)
+{
+	char type[] =3D "caif";
+	struct rtattr *linkinfo;
+	struct rtattr *data;
+
+	req->n.nlmsg_len =3D NLMSG_LENGTH(sizeof(struct ifinfomsg));
+	req->n.nlmsg_flags =3D NLM_F_REQUEST|NLM_F_CREATE|NLM_F_EXCL|NLM_F_ACK;
+	req->n.nlmsg_type =3D RTM_NEWLINK;
+	req->n.nlmsg_seq =3D ipconfig_seqnr++;
+	req->i.ifi_family =3D AF_UNSPEC;
+
+	linkinfo =3D NLMSG_TAIL(&req->n);
+
+	add_attribute(&req->n, sizeof(*req), IFLA_LINKINFO,
+			NULL, 0);
+
+	add_attribute(&req->n, sizeof(*req), IFLA_INFO_KIND,
+			type, strlen(type));
+
+	add_attribute(&req->n, sizeof(*req), IFLA_IFNAME,
+			ifname, strlen(ifname));
+
+	data =3D NLMSG_TAIL(&req->n);
+	add_attribute(&req->n, sizeof(*req), IFLA_INFO_DATA,
+			NULL, 0);
+
+	if (connection_type =3D=3D IFLA_CAIF_IPV4_CONNID)
+		add_attribute(&req->n, sizeof(*req),
+				IFLA_CAIF_IPV4_CONNID, &nsapi, sizeof(nsapi));
+	else if (connection_type =3D=3D IFLA_CAIF_IPV6_CONNID)
+		add_attribute(&req->n, sizeof(*req),
+				IFLA_CAIF_IPV6_CONNID, &nsapi, sizeof(nsapi));
+	else {
+		DBG("unsupported linktype\n");
+		g_free(req);
+		return -1;
+	}
+
+	if (loop_enabled) {
+		int loop;
+		add_attribute(&req->n, sizeof(*req),
+				IFLA_CAIF_LOOPBACK, &loop, sizeof(loop));
+	}
+
+	data->rta_len =3D (void *)NLMSG_TAIL(&req->n) - (void *)data;
+
+	linkinfo->rta_len =3D (void *)NLMSG_TAIL(&req->n) - (void *)linkinfo;
+
+	return send_iplink_req(sk, req);
+}
+
+static int destroy_caif_interface(int sk, struct iplink_req *req, int ifin=
dex)
+{
+
+	req->n.nlmsg_len =3D NLMSG_LENGTH(sizeof(struct ifinfomsg));
+	req->n.nlmsg_flags =3D NLM_F_REQUEST|NLM_F_CREATE|NLM_F_EXCL|NLM_F_ACK;
+	req->n.nlmsg_type =3D RTM_DELLINK;
+	req->n.nlmsg_seq =3D ipconfig_seqnr++;
+	req->i.ifi_family =3D AF_UNSPEC;
+	req->i.ifi_index =3D ifindex;
+
+	return send_iplink_req(sk, req);
+}
+
+static int rtnl_init(void)
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
+
+	if (ret < 0) {
+		close(sk);
+		return ret;
+	}
+
+	return sk;
+}
+
+/* Note ifname is in/out and must be minimum size 16 */
+int rtnl_create_caif_interface(int type, int conn_id, char ifname[16],
+					int *ifindex)
+{
+	int sk, ret;
+	int loop =3D 0;
+	struct iplink_req req;
+
+	memset(&req, 0, sizeof(req));
+	*ifindex =3D -1;
+
+	sk =3D rtnl_init();
+	ret =3D sk;
+	if (sk < 0)
+		goto out;
+
+	ret =3D create_caif_interface(sk, &req, type, ifname, conn_id, loop);
+	if (ret < 0)
+		goto out;
+
+	ret =3D netlink_get_response(sk, &req);
+	if (ret < 0)
+		goto out;
+
+	strncpy(ifname, req.ifname, sizeof(req.ifname));
+	ifname[sizeof(req.ifname)-1] =3D '\0';
+	*ifindex =3D req.ifindex;
+	ret =3D req.result;
+
+out:
+	close(sk);
+	return ret;
+}
+
+int rtnl_delete_caif_interface(int ifid)
+{
+	struct iplink_req req;
+	int sk, ret;
+
+	memset(&req, 0, sizeof(req));
+
+	sk =3D rtnl_init();
+	ret =3D sk;
+	if (sk < 0)
+		goto out;
+
+	ret =3D destroy_caif_interface(sk, &req, ifid);
+	if (ret < 0)
+		goto out;
+
+	ret =3D netlink_get_response(sk, &req);
+	if (ret < 0)
+		goto out;
+
+	ret =3D req.result;
+
+out:
+	close(sk);
+	return ret;
+}
diff --git a/drivers/stemodem/rtnl.h b/drivers/stemodem/rtnl.h
new file mode 100644
index 0000000..8f6a84f
--- /dev/null
+++ b/drivers/stemodem/rtnl.h
@@ -0,0 +1,24 @@
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
+extern int rtnl_create_caif_interface(int type, int conn_id, char ifname[1=
6],
+					int *ifindex);
+extern int rtnl_delete_caif_interface(int ifid);
-- =

1.6.3.3


--===============4212595744277904303==--

