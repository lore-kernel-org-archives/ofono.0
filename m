Content-Type: multipart/mixed; boundary="===============6939012366669460785=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH] avoid glib runtime warning
Date: Mon, 16 May 2016 14:53:36 +0800
Message-ID: <1463381616-12304-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6939012366669460785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@intel.com>

When set modem power off, in the callback of the request gril is cleaned
up, 'out_queue' and 'command_queue' is NULL. If don't check before use
them, there will be glib runtime warning.
---
 gril/gril.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/gril/gril.c b/gril/gril.c
index 297a772..34cadbb 100644
--- a/gril/gril.c
+++ b/gril/gril.c
@@ -374,7 +374,10 @@ static void handle_response(struct ril_s *p, struct ri=
l_msg *message)
 			if (req->callback)
 				req->callback(message, req->user_data);
 =

-			len =3D g_queue_get_length(p->out_queue);
+			if (p->out_queue)
+				len =3D g_queue_get_length(p->out_queue);
+			else
+				len =3D 0;
 =

 			for (i =3D 0; i < len; i++) {
 				id =3D GPOINTER_TO_INT(g_queue_peek_nth(
@@ -387,8 +390,10 @@ static void handle_response(struct ril_s *p, struct ri=
l_msg *message)
 =

 			ril_request_destroy(req);
 =

-			if (g_queue_peek_head(p->command_queue))
-				ril_wakeup_writer(p);
+			if (p->command_queue) {
+				if (g_queue_peek_head(p->command_queue))
+					ril_wakeup_writer(p);
+			}
 =

 			break;
 		}
-- =

2.7.4


--===============6939012366669460785==--

