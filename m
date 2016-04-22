Content-Type: multipart/mixed; boundary="===============8977063403233753872=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 11/24] handsfree: don't rely on undefined behavior when
 casting function pointers
Date: Fri, 22 Apr 2016 13:10:06 +0000
Message-ID: <1461330601-21333-12-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-11-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8977063403233753872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/handsfree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/handsfree.c b/src/handsfree.c
index 31b9d7d..3b518fd 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -687,8 +687,7 @@ static void handsfree_unregister(struct ofono_atom *ato=
m)
 		__ofono_dbus_pending_reply(&hf->pending, reply);
 	}
 =

-	g_slist_foreach(hf->subscriber_numbers, (GFunc) g_free, NULL);
-	g_slist_free(hf->subscriber_numbers);
+	g_slist_free_full(hf->subscriber_numbers, g_free);
 	hf->subscriber_numbers =3D NULL;
 =

 	ofono_modem_remove_interface(modem, OFONO_HANDSFREE_INTERFACE);
-- =

1.9.1

--===============8977063403233753872==--

