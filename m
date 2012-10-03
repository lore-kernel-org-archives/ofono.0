Content-Type: multipart/mixed; boundary="===============7389408460872889432=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 4/4] gdbus: Fix not freeing list node by using
 g_slist_delete_link
Date: Wed, 03 Oct 2012 14:57:24 +0300
Message-ID: <1349265444-15527-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1349265444-15527-1-git-send-email-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7389408460872889432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

g_slist_remove_link does not free the node which can cause leaks so
replace that with g_slist_delete_link which does free memory properly.
---
 gdbus/watch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index a402ca9..07feb61 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -574,7 +574,7 @@ static DBusHandlerResult message_filter(DBusConnection =
*connection,
 			continue;
 =

 		remove_match(data);
-		listeners =3D g_slist_remove_link(listeners, l);
+		listeners =3D g_slist_delete_link(listeners, l);
 =

 		filter_data_free(data);
 	}
-- =

1.7.11.4


--===============7389408460872889432==--

