Content-Type: multipart/mixed; boundary="===============7812575798281483874=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: implement ppp_packet_new()
Date: Mon, 10 May 2010 15:09:12 -0700
Message-ID: <1273529352-8707-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7812575798281483874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Centralize allocation of PPP packets.
---
 gatchat/gatppp.c   |    8 ++++++++
 gatchat/ppp.h      |    1 +
 gatchat/ppp_auth.c |    2 +-
 gatchat/ppp_cp.c   |    2 +-
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 82d1eca..8b6739a 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -84,6 +84,14 @@ void ppp_debug(GAtPPP *ppp, const char *str)
 	ppp->debugf(str, ppp->debug_data);
 }
 =

+struct ppp_header *ppp_packet_new(gsize infolen)
+{
+	struct ppp_header *ppp_packet;
+
+	ppp_packet =3D g_try_malloc0(infolen + sizeof(*ppp_packet));
+	return ppp_packet;
+}
+
 /*
  * Silently discard packets which are received when they shouldn't be
  */
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 7f6c950..f7b6c4b 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -114,3 +114,4 @@ void ppp_lcp_finished_notify(GAtPPP *ppp);
 void ppp_set_recv_accm(GAtPPP *ppp, guint32 accm);
 void ppp_set_xmit_accm(GAtPPP *ppp, guint32 accm);
 void ppp_set_mtu(GAtPPP *ppp, const guint8 *data);
+struct ppp_header *ppp_packet_new(gsize infolen);
diff --git a/gatchat/ppp_auth.c b/gatchat/ppp_auth.c
index eae5d17..5f03fa4 100644
--- a/gatchat/ppp_auth.c
+++ b/gatchat/ppp_auth.c
@@ -83,7 +83,7 @@ static void chap_process_challenge(struct ppp_chap *chap,=
 const guint8 *packet)
 	 */
 	digest_len =3D g_checksum_type_get_length(chap->method);
 	response_length =3D digest_len + sizeof(*header) + 1;
-	ppp_packet =3D g_try_malloc0(response_length + sizeof(struct ppp_header));
+	ppp_packet =3D ppp_packet_new(response_length);
 	if (!ppp_packet)
 		goto challenge_out;
 =

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index e152f6e..5a538b4 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -204,7 +204,7 @@ static struct pppcp_packet *pppcp_packet_new(struct ppp=
cp_data *data,
 	struct ppp_header *ppp_packet;
 	guint16 packet_length =3D bufferlen + sizeof(*packet);
 =

-	ppp_packet =3D g_try_malloc0(packet_length + sizeof(*ppp_packet));
+	ppp_packet =3D ppp_packet_new(packet_length);
 	if (!ppp_packet)
 		return NULL;
 =

-- =

1.6.6.1


--===============7812575798281483874==--

