Content-Type: multipart/mixed; boundary="===============3533789553876769306=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH] Fix crash in voicecall atom
Date: Mon, 30 Aug 2010 17:53:54 +0300
Message-ID: <1283180034-1760-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3533789553876769306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hot-unplugging isimodem causes a crash in the voicecall atom.
---
 src/voicecall.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 6ad58ad..52311b9 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -220,6 +220,9 @@ static void dial_request_finish(struct ofono_voicecall =
*vc, gboolean callback)
 {
 	struct dial_request *dial_req =3D vc->dial_req;
 =

+	if (!dial_req)
+	    return;
+
 	if (callback && dial_req->cb)
 		dial_req->cb(dial_req->call ? dial_req->call->call : NULL,
 				dial_req->user_data);
-- =

1.7.0.4


--===============3533789553876769306==--

