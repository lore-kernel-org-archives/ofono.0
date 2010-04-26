Content-Type: multipart/mixed; boundary="===============7775455363549501254=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: use default ACCM when sending LCP codes 1-7
Date: Mon, 26 Apr 2010 11:44:36 -0700
Message-ID: <1272307476-22148-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7775455363549501254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According to the spec, you must transmit all Link Configuration,
Termination, and Code-Reject packets as if no options had been
negotiated.  This requires that when encoding we use the
default ACCM of 0xffffffff when sending these types of packets.
---
 gatchat/gatppp.c |   10 ++++++++++
 gatchat/ppp_cp.c |    8 ++++++++
 gatchat/ppp_cp.h |    2 ++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 1547a75..c7bf089 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -124,6 +124,7 @@ static struct frame_buffer *ppp_encode(GAtPPP *ppp, gui=
nt8 *data, int len)
 	int i =3D 0;
 	guint16 fcs =3D PPPINITFCS16;
 	guint16 proto =3D get_host_short(data);
+	guint8 code;
 	gboolean lcp =3D (proto =3D=3D LCP_PROTOCOL);
 	guint8 *frame;
 	struct frame_buffer *fb =3D
@@ -133,6 +134,15 @@ static struct frame_buffer *ppp_encode(GAtPPP *ppp, gu=
int8 *data, int len)
 		return NULL;
 	frame =3D fb->bytes;
 =

+	/*
+	 * all LCP Link Configuration, Link Termination, and Code-Reject
+	 * packets must be sent with the default sending ACCM
+	 */
+	if (lcp) {
+		code =3D pppcp_get_code(data);
+		lcp =3D code > 0 && code < 8;
+	}
+
 	/* copy in the HDLC framing */
 	frame[pos++] =3D PPP_FLAG_SEQ;
 =

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index 6cd3681..dfb4dbe 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -267,6 +267,14 @@ const guint8 *ppp_option_iter_get_data(struct ppp_opti=
on_iter *iter)
 	return iter->option_data;
 }
 =

+guint8 pppcp_get_code(const guint8 *data)
+{
+	struct ppp_header *ppp_packet =3D (struct ppp_header *) data;
+	struct pppcp_packet *packet =3D (struct pppcp_packet *) ppp_packet->info;
+
+	return packet->code;
+}
+
 static gboolean pppcp_timeout(gpointer user_data)
 {
 	struct pppcp_timer_data *timer_data =3D user_data;
diff --git a/gatchat/ppp_cp.h b/gatchat/ppp_cp.h
index 519a4a0..8930e50 100644
--- a/gatchat/ppp_cp.h
+++ b/gatchat/ppp_cp.h
@@ -110,6 +110,8 @@ void pppcp_set_data(struct pppcp_data *pppcp, gpointer =
data);
 gpointer pppcp_get_data(struct pppcp_data *pppcp);
 GAtPPP *pppcp_get_ppp(struct pppcp_data *pppcp);
 =

+guint8 pppcp_get_code(const guint8 *data);
+
 void pppcp_set_local_options(struct pppcp_data *data,
 				const guint8 *options,
 				guint16 len);
-- =

1.6.6.1


--===============7775455363549501254==--

