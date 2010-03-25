Content-Type: multipart/mixed; boundary="===============0574075838817885842=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: change debug output to include control protocol prefix
Date: Thu, 25 Mar 2010 10:59:34 -0700
Message-ID: <1269539974-21061-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0574075838817885842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/ppp_cp.c  |   12 ++++++------
 gatchat/ppp_cp.h  |   10 +++++++++-
 gatchat/ppp_lcp.c |   12 ++++++++++--
 gatchat/ppp_net.c |   12 ++++++++++--
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index 75b3bec..137f6b9 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -40,7 +40,7 @@ static const char *pppcp_state_strings[] =3D
 	"REQSENT", "ACKRCVD", "ACKSENT", "OPENED" };
 =

 #define pppcp_trace(p) do { \
-	g_print("%s: current state %d:%s\n", __FUNCTION__, \
+	g_print("%s: %s: current state %d:%s\n", p->prefix, __FUNCTION__, \
 		p->state, pppcp_state_strings[p->state]); \
 } while (0)
 #else
@@ -1483,8 +1483,7 @@ void pppcp_free(struct pppcp_data *data)
 	g_free(data);
 }
 =

-struct pppcp_data *pppcp_new(GAtPPP *ppp, guint16 proto,
-				gpointer priv)
+struct pppcp_data *pppcp_new(struct pppcp_protocol_data *protocol_data)
 {
 	struct pppcp_data *data;
 =

@@ -1502,9 +1501,10 @@ struct pppcp_data *pppcp_new(GAtPPP *ppp, guint16 pr=
oto,
 	data->max_failure =3D MAX_FAILURE;
 	data->event_queue =3D g_queue_new();
 	data->identifier =3D 0;
-	data->ppp =3D ppp;
-	data->proto =3D proto;
-	data->priv =3D priv;
+	data->ppp =3D protocol_data->ppp;
+	data->proto =3D protocol_data->proto;
+	data->priv =3D protocol_data->priv;
+	data->prefix =3D protocol_data->prefix;
 =

 	/* setup func ptrs for processing packet by pppcp code */
 	data->packet_ops[CONFIGURE_REQUEST - 1] =3D
diff --git a/gatchat/ppp_cp.h b/gatchat/ppp_cp.h
index 095a8b5..69676cd 100644
--- a/gatchat/ppp_cp.h
+++ b/gatchat/ppp_cp.h
@@ -106,6 +106,13 @@ struct pppcp_timer_data {
 	guint restart_timer;
 };
 =

+struct pppcp_protocol_data {
+	guint16 proto;
+	const char *prefix;
+	gpointer priv;
+	GAtPPP *ppp;
+};
+
 struct pppcp_data {
 	enum pppcp_state state;
 	struct pppcp_timer_data config_timer_data;
@@ -131,9 +138,10 @@ struct pppcp_data {
 				guint length);
 	gpointer priv;
 	guint16 proto;
+	const char *prefix;
 };
 =

-struct pppcp_data *pppcp_new(GAtPPP *ppp, guint16 proto, gpointer priv);
+struct pppcp_data *pppcp_new(struct pppcp_protocol_data *proto_data);
 void pppcp_free(struct pppcp_data *data);
 void pppcp_add_config_option(struct pppcp_data *data,
 				struct ppp_option *option);
diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 0892b2c..7206b4b 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -153,6 +153,13 @@ static void lcp_option_process(gpointer data, gpointer=
 user)
 	}
 }
 =

+static const char lcp_prefix[] =3D "lcp";
+
+static struct pppcp_protocol_data lcp_protocol_data =3D {
+	.proto =3D LCP_PROTOCOL,
+	.prefix =3D lcp_prefix,
+};
+
 struct ppp_packet_handler lcp_packet_handler =3D {
 	.proto =3D LCP_PROTOCOL,
 	.handler =3D pppcp_process_packet,
@@ -213,13 +220,14 @@ void lcp_free(struct pppcp_data *lcp)
 	pppcp_free(lcp);
 }
 =

-struct pppcp_data * lcp_new(GAtPPP *ppp)
+struct pppcp_data *lcp_new(GAtPPP *ppp)
 {
 	struct pppcp_data *pppcp;
 	struct ppp_option *option;
 	guint16 codes =3D LCP_SUPPORTED_CODES;
 =

-	pppcp =3D pppcp_new(ppp, LCP_PROTOCOL, NULL);
+	lcp_protocol_data.ppp =3D ppp;
+	pppcp =3D pppcp_new(&lcp_protocol_data);
 	if (!pppcp) {
 		g_print("Failed to allocate PPPCP struct\n");
 		return NULL;
diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index a873c00..d8df896 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -249,6 +249,8 @@ static void ipcp_finished(struct pppcp_data *data)
 	g_print("ipcp finished\n");
 }
 =

+static const char ipcp_prefix[] =3D "ipcp";
+
 struct pppcp_action ipcp_action =3D {
 	.this_layer_up =3D	ipcp_up,
 	.this_layer_down =3D 	ipcp_down,
@@ -258,6 +260,11 @@ struct pppcp_action ipcp_action =3D {
 	.option_process =3D 	ipcp_option_process,
 };
 =

+static struct pppcp_protocol_data ipcp_protocol_data =3D {
+	.proto =3D IPCP_PROTO,
+	.prefix =3D ipcp_prefix,
+};
+
 struct ppp_packet_handler ipcp_packet_handler =3D {
 	.proto =3D IPCP_PROTO,
 	.handler =3D pppcp_process_packet,
@@ -326,14 +333,15 @@ static struct pppcp_data * ipcp_new(GAtPPP *ppp)
 	if (!data)
 		return NULL;
 =

-	pppcp =3D pppcp_new(ppp, IPCP_PROTO, data);
+	ipcp_protocol_data.ppp =3D ppp;
+	ipcp_protocol_data.priv =3D data;
+	pppcp =3D pppcp_new(&ipcp_protocol_data);
 	if (!pppcp) {
 		g_printerr("Failed to allocate PPPCP struct\n");
 		g_free(data);
 		return NULL;
 	}
 	pppcp_set_valid_codes(pppcp, IPCP_SUPPORTED_CODES);
-	pppcp->priv =3D data;
 =

 	/* set the actions */
 	pppcp->action =3D &ipcp_action;
-- =

1.6.6.1


--===============0574075838817885842==--

