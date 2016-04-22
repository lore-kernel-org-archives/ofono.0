Content-Type: multipart/mixed; boundary="===============6322100339116361627=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 05/24] stemodem: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:06 +0000
Message-ID: <1461330601-21333-6-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-5-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6322100339116361627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 drivers/stemodem/voicecall.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 1cbf51a..356ab7c 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -574,8 +574,7 @@ static void ste_voicecall_remove(struct ofono_voicecall=
 *vc)
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

-	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
-	g_slist_free(vd->calls);
+	g_slist_free_full(vd->calls, g_free);
 =

 	ofono_voicecall_set_data(vc, NULL);
 =

-- =

1.9.1

--===============6322100339116361627==--

