Content-Type: multipart/mixed; boundary="===============8050583836907280382=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] simfs: Prevent a crash in sim_fs_notify_file_watches
Date: Fri, 12 May 2017 18:40:16 +0300
Message-ID: <1494603616-19298-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8050583836907280382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If no file watchers have ever been added, context->file_watches
is NULL and sim_fs_notify_file_watches() should take that into
account.
---
 src/simfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/simfs.c b/src/simfs.c
index 595dbad..37a232a 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -226,6 +226,9 @@ void sim_fs_notify_file_watches(struct sim_fs *fs, int =
id)
 		struct ofono_sim_context *context =3D l->data;
 		GSList *k;
 =

+		if (context->file_watches =3D=3D NULL)
+			continue;
+
 		for (k =3D context->file_watches->items; k; k =3D k->next) {
 			struct file_watch *w =3D k->data;
 			ofono_sim_file_changed_cb_t notify =3D w->item.notify;
-- =

1.9.1


--===============8050583836907280382==--

