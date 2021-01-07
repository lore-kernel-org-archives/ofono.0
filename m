Content-Type: multipart/mixed; boundary="===============7615818957185242255=="
MIME-Version: 1.0
From: s.e.golubtsov@gmail.com
Subject: [PATCH v2] ppp: using RX ACCM = 0 by default
Date: Thu, 07 Jan 2021 23:40:16 +0300
Message-ID: <20210107204017.3382-2-s.e.golubtsov@gmail.com>
In-Reply-To: <20210107204017.3382-1-s.e.golubtsov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7615818957185242255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sergei Golubtsov <s.e.golubtsov@gmail.com>

Some modems such as Quectel EC200T do not honor the default value for
the Async-Control-Character-Map (ACCM) configuration option defined in
RFC 1548 6.2 as 0xffffffff. This patch suggests to use RX ACCM =3D 0 for
Ofono by default as pppd does for instance. This will reduce PPP data
overhead as well.
---
 gatchat/gatppp.c  |  5 +++++
 gatchat/gatppp.h  |  1 +
 gatchat/ppp.h     |  1 +
 gatchat/ppp_lcp.c | 15 ++++++++++++++-
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 141e2746..259e6d5c 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -806,6 +806,11 @@ void g_at_ppp_set_server_info(GAtPPP *ppp, const char =
*remote,
 	ipcp_set_server_info(ppp->ipcp, r, d1, d2);
 }
 =

+void g_at_ppp_set_accm(GAtPPP *ppp, guint32 accm)
+{
+	lcp_set_accm(ppp->lcp, accm);
+}
+
 void g_at_ppp_set_acfc_enabled(GAtPPP *ppp, gboolean enabled)
 {
 	lcp_set_acfc_enabled(ppp->lcp, enabled);
diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index dd203c28..a12e42e3 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -88,6 +88,7 @@ void g_at_ppp_set_recording(GAtPPP *ppp, const char *file=
name);
 void g_at_ppp_set_server_info(GAtPPP *ppp, const char *remote_ip,
 				const char *dns1, const char *dns2);
 =

+void g_at_ppp_set_accm(GAtPPP *ppp, guint32 accm);
 void g_at_ppp_set_acfc_enabled(GAtPPP *ppp, gboolean enabled);
 void g_at_ppp_set_pfc_enabled(GAtPPP *ppp, gboolean enabled);
 =

diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index ac1a7ef2..6c02b053 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -90,6 +90,7 @@ static inline void __put_unaligned_short(void *p, guint16=
 val)
 struct pppcp_data *lcp_new(GAtPPP *ppp, gboolean dormant);
 void lcp_free(struct pppcp_data *lcp);
 void lcp_protocol_reject(struct pppcp_data *lcp, guint8 *packet, gsize len=
);
+void lcp_set_accm(struct pppcp_data *pppcp, guint32 accm);
 void lcp_set_acfc_enabled(struct pppcp_data *pppcp, gboolean enabled);
 void lcp_set_pfc_enabled(struct pppcp_data *pppcp, gboolean enabled);
 =

diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 3fe38217..7c45a27f 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -121,7 +121,9 @@ static void lcp_generate_config_options(struct lcp_data=
 *lcp)
 =

 static void lcp_reset_config_options(struct lcp_data *lcp)
 {
-	/* Using the default ACCM */
+	/* Using RX ACCM =3D 0 instead of the default ACCM */
+	lcp->accm =3D 0;
+	lcp->req_options |=3D REQ_OPTION_ACCM;
 =

 	lcp_generate_config_options(lcp);
 }
@@ -398,6 +400,17 @@ struct pppcp_data *lcp_new(GAtPPP *ppp, gboolean is_se=
rver)
 	return pppcp;
 }
 =

+void lcp_set_accm(struct pppcp_data *pppcp, guint32 accm)
+{
+	struct lcp_data *lcp =3D pppcp_get_data(pppcp);
+
+	lcp->accm =3D accm;
+	lcp->req_options |=3D REQ_OPTION_ACCM;
+
+	lcp_generate_config_options(lcp);
+	pppcp_set_local_options(pppcp, lcp->options, lcp->options_len);
+}
+
 void lcp_set_acfc_enabled(struct pppcp_data *pppcp, gboolean enabled)
 {
 	struct lcp_data *lcp =3D pppcp_get_data(pppcp);
-- =

2.17.1

--===============7615818957185242255==--

