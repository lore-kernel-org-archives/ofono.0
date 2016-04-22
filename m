Content-Type: multipart/mixed; boundary="===============4115936953583326422=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 13/24] network: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:07 +0000
Message-ID: <1461330601-21333-14-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-13-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4115936953583326422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/network.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/network.c b/src/network.c
index 8ad11d3..a3d41a7 100644
--- a/src/network.c
+++ b/src/network.c
@@ -746,8 +746,7 @@ static gboolean update_operator_list(struct ofono_netre=
g *netreg, int total,
 		}
 	}
 =

-	g_slist_foreach(compressed, (GFunc)g_free, NULL);
-	g_slist_free(compressed);
+	g_slist_free_full(compressed, g_free);
 =

 	if (n)
 		n =3D g_slist_reverse(n);
-- =

1.9.1

--===============4115936953583326422==--

