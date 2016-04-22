Content-Type: multipart/mixed; boundary="===============6092692585459549025=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 10/24] cdma/sms: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:06 +0000
Message-ID: <1461330601-21333-11-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-10-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6092692585459549025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/cdma-smsutil.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/cdma-smsutil.c b/src/cdma-smsutil.c
index e36f2e3..35b77e0 100644
--- a/src/cdma-smsutil.c
+++ b/src/cdma-smsutil.c
@@ -533,8 +533,7 @@ static gboolean decode_subparams(struct simple_iter *it=
er, guint32 *bitmap,
 		}
 	}
 =

-	g_slist_foreach(entries, (GFunc) g_free, NULL);
-	g_slist_free(entries);
+	g_slist_free_full(entries, g_free);
 =

 	return decode_result;
 }
-- =

1.9.1

--===============6092692585459549025==--

