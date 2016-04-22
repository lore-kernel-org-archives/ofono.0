Content-Type: multipart/mixed; boundary="===============7850341922022136731=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 03/24] ifxmodem: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:06 +0000
Message-ID: <1461330601-21333-4-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-3-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7850341922022136731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 drivers/ifxmodem/voicecall.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index 7c27642..45b5ca4 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -1009,8 +1009,7 @@ static void ifx_voicecall_remove(struct ofono_voiceca=
ll *vc)
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

-	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
-	g_slist_free(vd->calls);
+	g_slist_free_full(vd->calls, g_free);
 =

 	g_strfreev(vd->en_list);
 =

-- =

1.9.1

--===============7850341922022136731==--

