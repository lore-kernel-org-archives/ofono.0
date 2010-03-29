Content-Type: multipart/mixed; boundary="===============5239629076664605871=="
MIME-Version: 1.0
From: ppessi@gmail.com
Subject: [PATCH] Fix: use of g_checksum_get_digest() inout argument
Date: Mon, 29 Mar 2010 16:38:34 +0300
Message-ID: <1269869914-4662-1-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5239629076664605871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 gatchat/ppp_auth.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gatchat/ppp_auth.c b/gatchat/ppp_auth.c
index fe3c501..1e0c82b 100644
--- a/gatchat/ppp_auth.c
+++ b/gatchat/ppp_auth.c
@@ -107,7 +107,7 @@ static void chap_process_challenge(struct auth_data *au=
th, guint8 *packet)
 		response->length =3D htons(response_length);
 		response->data[0] =3D digest_len;
 		g_checksum_get_digest(checksum, &response->data[1],
-					(gsize *) &response->data[0]);
+					&digest_len);
 		/* leave the name empty? */
 	}
 =

-- =

1.6.3.3


--===============5239629076664605871==--

