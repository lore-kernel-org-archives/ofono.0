Content-Type: multipart/mixed; boundary="===============3808507434631706498=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH] add name field when process chap authentication
Date: Wed, 11 May 2011 17:19:27 +0800
Message-ID: <1305105567-3749-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3808507434631706498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some systems require name field, otherwise chap authentication will fail.

---
 gatchat/ppp_auth.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/gatchat/ppp_auth.c b/gatchat/ppp_auth.c
index b73f320..f2b8c31 100644
--- a/gatchat/ppp_auth.c
+++ b/gatchat/ppp_auth.c
@@ -60,6 +60,7 @@ static void chap_process_challenge(struct ppp_chap *chap,=
 const guint8 *packet)
 	struct chap_header *response;
 	GChecksum *checksum;
 	const char *secret =3D g_at_ppp_get_password(chap->ppp);
+	const char *username =3D g_at_ppp_get_username(chap->ppp);
 	guint16 response_length;
 	struct ppp_header *ppp_packet;
 	gsize digest_len;
@@ -83,6 +84,8 @@ static void chap_process_challenge(struct ppp_chap *chap,=
 const guint8 *packet)
 	 */
 	digest_len =3D g_checksum_type_get_length(chap->method);
 	response_length =3D digest_len + sizeof(*header) + 1;
+	if (username !=3D NULL)
+		response_length +=3D strlen(username);
 	ppp_packet =3D ppp_packet_new(response_length, CHAP_PROTOCOL);
 	if (ppp_packet =3D=3D NULL)
 		goto challenge_out;
@@ -98,6 +101,10 @@ static void chap_process_challenge(struct ppp_chap *cha=
p, const guint8 *packet)
 		/* leave the name empty? */
 	}
 =

+	if (username !=3D NULL)
+		memcpy(response->data + digest_len + 1, username,
+				strlen(username));
+
 	/* transmit the packet */
 	ppp_transmit(chap->ppp, (guint8 *) ppp_packet, response_length);
 	g_free(ppp_packet);
-- =

1.7.5


--===============3808507434631706498==--

