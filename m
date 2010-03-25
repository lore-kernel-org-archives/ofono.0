Content-Type: multipart/mixed; boundary="===============5127612327064735247=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] Add support for NBNS server options
Date: Thu, 25 Mar 2010 10:07:28 -0700
Message-ID: <1269536848-4494-1-git-send-email-marcel@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5127612327064735247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/ppp_net.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index a873c00..131985f 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -48,6 +48,8 @@ struct ipcp_data {
 	guint8 ip_address[4];
 	guint8 primary_dns[4];
 	guint8 secondary_dns[4];
+	guint8 primary_nbns[4];
+	guint8 secondary_nbns[4];
 	struct pppcp_data *pppcp;
 };
 =

@@ -212,7 +214,9 @@ enum ipcp_option_types {
 	IP_COMPRESSION_PROTO	=3D 2,
 	IP_ADDRESS		=3D 3,
 	PRIMARY_DNS_SERVER	=3D 129,
+	PRIMARY_NBNS_SERVER	=3D 130,
 	SECONDARY_DNS_SERVER	=3D 131,
+	SECONDARY_NBNS_SERVER	=3D 132,
 };
 =

 static void ipcp_up(struct pppcp_data *pppcp)
@@ -271,7 +275,9 @@ static guint ipcp_option_scan(struct ppp_option *option=
, gpointer user)
 	switch (option->type) {
 	case IP_ADDRESS:
 	case PRIMARY_DNS_SERVER:
+	case PRIMARY_NBNS_SERVER:
 	case SECONDARY_DNS_SERVER:
+	case SECONDARY_NBNS_SERVER:
 		return OPTION_ACCEPT;
 	default:
 		g_printerr("Unknown ipcp option type %d\n", option->type);
@@ -294,9 +300,15 @@ static void ipcp_option_process(gpointer data, gpointe=
r user)
 	case PRIMARY_DNS_SERVER:
 		memcpy(ipcp->primary_dns, option->data, 4);
 		break;
+	case PRIMARY_NBNS_SERVER:
+		memcpy(ipcp->primary_nbns, option->data, 4);
+		break;
 	case SECONDARY_DNS_SERVER:
 		memcpy(ipcp->secondary_dns, option->data, 4);
 		break;
+	case SECONDARY_NBNS_SERVER:
+		memcpy(ipcp->secondary_nbns, option->data, 4);
+		break;
 	default:
 		g_printerr("Unable to process unknown option %d\n", option->type);
 		break;
-- =

1.6.6.1


--===============5127612327064735247==--

