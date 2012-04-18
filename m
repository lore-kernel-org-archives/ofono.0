Content-Type: multipart/mixed; boundary="===============3219524250359114893=="
MIME-Version: 1.0
From: Mike Brudevold <puffy.taco@gmail.com>
Subject: [PATCH] voicecall: send CallRemoved for calls when voicecall atom is
 unregistered
Date: Wed, 18 Apr 2012 17:02:26 -0500
Message-ID: <1334786546-4890-1-git-send-email-puffy.taco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3219524250359114893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Michael Brudevold <michael.brudevold@logicpd.com>

The CallRemoved signal was not being sent for existing calls when the voice=
call
atom was unregistered. An example of this is the lack of a CallRemoved sign=
al
when an HFP AG is disconnected due to SLC timeout while a call is active.
---
 src/voicecall.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 104b600..263f1ee 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2699,8 +2699,11 @@ static void voicecall_unregister(struct ofono_atom *=
atom)
 	if (vc->dial_req)
 		dial_request_finish(vc);
 =

-	for (l =3D vc->call_list; l; l =3D l->next)
+	for (l =3D vc->call_list; l; l =3D l->next) {
+		voicecalls_emit_call_removed(vc, l->data);
+
 		voicecall_dbus_unregister(vc, l->data);
+	}
 =

 	g_slist_free(vc->call_list);
 	vc->call_list =3D NULL;
-- =

1.7.5.4


--===============3219524250359114893==--

