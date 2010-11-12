Content-Type: multipart/mixed; boundary="===============1940683611871005330=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH v5b 3/3] stemodem: Use RTNL to create interfaces
Date: Fri, 12 Nov 2010 16:02:40 +0100
Message-ID: <1289574160-22899-4-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1289574160-22899-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1940683611871005330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

Use rtnl_caif_* functions to create network interfaces.
The conn_info struct is also re-structured in order to
hold the relevant information for network interfaces.
---
 drivers/stemodem/gprs-context.c |   76 ++++++++++++++++++++++++++++++++++-=
----
 1 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 62643ee..8b5cfdc 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -47,6 +47,7 @@
 #include "stemodem.h"
 #include "caif_socket.h"
 #include "if_caif.h"
+#include "caif_rtnl.h"
 =

 #define MAX_CAIF_DEVICES 4
 #define MAX_DNS 2
@@ -66,10 +67,18 @@ struct gprs_context_data {
 };
 =

 struct conn_info {
+	/*
+	 * cid is allocated in oFono Core and is identifying
+	 * the Account. cid =3D 0 indicates that it is currently unused.
+	 */
 	unsigned int cid;
-	unsigned int device;
+	/* Id used by CAIF and EPPSD to identify the CAIF channel*/
 	unsigned int channel_id;
-	char interface[10];
+	/* Linux Interface Id */
+	unsigned int ifindex;
+	/* Linux Interface name */
+	char interface[IF_NAMESIZE];
+	gboolean created;
 };
 =

 struct eppsd_response {
@@ -77,7 +86,6 @@ struct eppsd_response {
 	char ip_address[IP_ADDR_LEN];
 	char subnet_mask[IP_ADDR_LEN];
 	char mtu[IP_ADDR_LEN];
-	char default_gateway[IP_ADDR_LEN];
 	char dns_server1[IP_ADDR_LEN];
 	char dns_server2[IP_ADDR_LEN];
 	char p_cscf_server[IP_ADDR_LEN];
@@ -97,8 +105,6 @@ static void start_element_handler(GMarkupParseContext *c=
ontext,
 		rsp->current =3D rsp->subnet_mask;
 	else if (!strcmp(element_name, "mtu"))
 		rsp->current =3D rsp->mtu;
-	else if (!strcmp(element_name, "default_gateway"))
-		rsp->current =3D rsp->default_gateway;
 	else if (!strcmp(element_name, "dns_server") &&
 					rsp->dns_server1[0] =3D=3D '\0')
 		rsp->current =3D rsp->dns_server1;
@@ -124,7 +130,7 @@ static void text_handler(GMarkupParseContext *context,
 =

 	if (rsp->current) {
 		strncpy(rsp->current, text, IP_ADDR_LEN);
-		rsp->current[IP_ADDR_LEN] =3D 0;
+		rsp->current[IP_ADDR_LEN] =3D '\0';
 	}
 }
 =

@@ -167,12 +173,38 @@ static struct conn_info *conn_info_create(unsigned in=
t channel_id)
 	return connection;
 }
 =

+static void rtnl_callback(int ifindex, char *ifname, void *user_data)
+{
+	struct conn_info *conn =3D user_data;
+
+	if (ifindex < 0) {
+		conn->created =3D FALSE;
+		ofono_error("Failed to create caif interface %s",
+			conn->interface);
+		return;
+	}
+
+	strncpy(conn->interface, ifname, sizeof(conn->interface));
+	conn->ifindex =3D ifindex;
+	conn->created =3D TRUE;
+}
+
 /*
  * Creates a new IP interface for CAIF.
  */
 static gboolean caif_if_create(struct conn_info *conn)
 {
-	return FALSE;
+	int err;
+
+	err =3D caif_rtnl_create_interface(IFLA_CAIF_IPV4_CONNID,
+						conn->channel_id, FALSE,
+						rtnl_callback, conn);
+	if (err < 0) {
+		DBG("Failed to create IP interface for CAIF");
+		return FALSE;
+	}
+
+	return TRUE;
 }
 =

 /*
@@ -180,6 +212,18 @@ static gboolean caif_if_create(struct conn_info *conn)
  */
 static void caif_if_remove(struct conn_info *conn)
 {
+	if (!conn->created)
+		return;
+
+	if (caif_rtnl_delete_interface(conn->ifindex) < 0) {
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
@@ -283,7 +327,7 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	dns[2] =3D NULL;
 =

 	CALLBACK_WITH_SUCCESS(cb, conn->interface, TRUE, rsp.ip_address,
-				rsp.subnet_mask, rsp.default_gateway,
+				rsp.subnet_mask, NULL,
 				dns, cbd->data);
 	return;
 =

@@ -380,6 +424,11 @@ static void ste_gprs_activate_primary(struct ofono_gpr=
s_context *gc,
 	}
 =

 	conn =3D l->data;
+	if (!conn->created) {
+		DBG("CAIF interface not created (rtnl error?)");
+		goto error;
+	}
+
 	conn->cid =3D ctx->cid;
 =

 	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
@@ -460,6 +509,7 @@ static void ste_cgact_read_cb(gboolean ok, GAtResult *r=
esult,
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	gint cid, state;
 	GAtResultIter iter;
+	GSList *l;
 =

 	if (!ok)
 		return;
@@ -483,6 +533,13 @@ static void ste_cgact_read_cb(gboolean ok, GAtResult *=
result,
 		ofono_gprs_context_deactivated(gc, gcd->active_context);
 		gcd->active_context =3D 0;
 =

+		l =3D g_slist_find_custom(g_caif_devices, GUINT_TO_POINTER(cid),
+				conn_compare_by_cid);
+		if (l) {
+			struct conn_info *conn =3D l->data;
+			conn->cid =3D 0;
+		}
+
 		break;
 	}
 }
@@ -540,7 +597,6 @@ static int ste_gprs_context_probe(struct ofono_gprs_con=
text *gc,
 static void ste_gprs_context_remove(struct ofono_gprs_context *gc)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-
 	g_slist_foreach(g_caif_devices, (GFunc) caif_if_remove, NULL);
 	g_slist_foreach(g_caif_devices, (GFunc) g_free, NULL);
 	g_slist_free(g_caif_devices);
@@ -562,10 +618,12 @@ static struct ofono_gprs_context_driver driver =3D {
 =

 void ste_gprs_context_init()
 {
+	caif_rtnl_init();
 	ofono_gprs_context_driver_register(&driver);
 }
 =

 void ste_gprs_context_exit()
 {
+	caif_rtnl_exit();
 	ofono_gprs_context_driver_unregister(&driver);
 }
-- =

1.6.3.3


--===============1940683611871005330==--

