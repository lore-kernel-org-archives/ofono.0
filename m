Content-Type: multipart/mixed; boundary="===============7042976958953335272=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH] gril: avoid glib runtime warning
Date: Tue, 17 May 2016 09:24:39 +0800
Message-ID: <1463448279-20873-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7042976958953335272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@intel.com>

gril may be destroyed in the request callback (e.g in the callback of
set modem power off request). 'out_queue' and 'command_queue' is NULL.
there will be glib runtime warning if use them.
---
 gril/gril.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gril/gril.c b/gril/gril.c
index 297a772..a1c9661 100644
--- a/gril/gril.c
+++ b/gril/gril.c
@@ -374,6 +374,12 @@ static void handle_response(struct ril_s *p, struct ri=
l_msg *message)
 			if (req->callback)
 				req->callback(message, req->user_data);
 =

+			/* gril may have been destroyed in the request callback */
+			if (p->destroyed) {
+				ril_request_destroy(req);
+				return;
+			}
+
 			len =3D g_queue_get_length(p->out_queue);
 =

 			for (i =3D 0; i < len; i++) {
-- =

2.7.4


--===============7042976958953335272==--

