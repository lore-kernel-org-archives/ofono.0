Content-Type: multipart/mixed; boundary="===============1166178059535550834=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 1/4] gisi: fix crash bug in g_isi_remove_subscription
Date: Wed, 10 Nov 2010 14:22:28 +0200
Message-ID: <1289391751-2844-2-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1289391751-2844-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1166178059535550834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gisi/client.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/gisi/client.c b/gisi/client.c
index 8ab3dc9..8e41331 100644
--- a/gisi/client.c
+++ b/gisi/client.c
@@ -744,16 +744,19 @@ int g_isi_subscribe(GIsiClient *client, uint8_t type,
  */
 void g_isi_remove_subscription(GIsiClient *client, uint8_t res, uint8_t ty=
pe)
 {
+	void *ret;
 	GIsiIndication *ind;
 	unsigned int id =3D (res << 8) | type;
 =

 	if (!client)
 		return;
 =

-	ind =3D tdelete(&id, &client->inds.subs, g_isi_cmp);
-	if (!ind)
+	ret =3D tfind(&id, &client->inds.subs, g_isi_cmp);
+	if (!ret)
 		return;
 =

+	ind =3D *(GIsiIndication **)ret;
+	tdelete(ind, &client->inds.subs, g_isi_cmp);
 	client->inds.count--;
 	g_free(ind);
 }
-- =

1.7.0.4


--===============1166178059535550834==--

