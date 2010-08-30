Content-Type: multipart/mixed; boundary="===============2026417639479481945=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] voicecall: Add check in dial_request_finish
Date: Mon, 30 Aug 2010 14:28:33 +0800
Message-ID: <1283149713-19007-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2026417639479481945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To avoid signal 11 if no dial_req exists.
---
 src/voicecall.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 6ad58ad..1313129 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -220,6 +220,9 @@ static void dial_request_finish(struct ofono_voicecall =
*vc, gboolean callback)
 {
 	struct dial_request *dial_req =3D vc->dial_req;
 =

+	if (dial_req =3D=3D NULL)
+		return;
+
 	if (callback && dial_req->cb)
 		dial_req->cb(dial_req->call ? dial_req->call->call : NULL,
 				dial_req->user_data);
-- =

1.7.0.4


--===============2026417639479481945==--

