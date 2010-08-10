Content-Type: multipart/mixed; boundary="===============3089324908217386994=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 01/10] gatchat: Check notify id in g_at_chat_unregister
Date: Tue, 10 Aug 2010 22:43:40 +0800
Message-ID: <1281451429-17257-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281451429-17257-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3089324908217386994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Return earlier if notify id is zero.
---
 gatchat/gatchat.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index f192a90..a177e10 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -1169,7 +1169,7 @@ gboolean g_at_chat_unregister(GAtChat *chat, guint id)
 	gpointer key, value;
 	GSList *l;
 =

-	if (chat =3D=3D NULL || chat->notify_list =3D=3D NULL)
+	if (chat =3D=3D NULL || chat->notify_list =3D=3D NULL || id =3D=3D 0)
 		return FALSE;
 =

 	g_hash_table_iter_init(&iter, chat->notify_list);
-- =

1.7.0.4


--===============3089324908217386994==--

