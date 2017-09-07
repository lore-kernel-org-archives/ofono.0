Content-Type: multipart/mixed; boundary="===============3763536933361050082=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH][v2 2/2] voicecall: use ofono_call_status_name in DBG messages
Date: Fri, 08 Sep 2017 00:27:33 +0200
Message-ID: <20170907222733.26345-2-lynxis@fe80.eu>
In-Reply-To: <20170907222733.26345-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3763536933361050082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

status names are more readable then integer values.
---
 src/voicecall.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 408c72162ca7..e5b9f505fbd3 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2250,9 +2250,10 @@ void ofono_voicecall_notify(struct ofono_voicecall *=
vc,
 	struct voicecall *v =3D NULL;
 	struct ofono_call *newcall;
 =

-	DBG("Got a voicecall event, status: %d, id: %u, number: %s"
-			" called_number: %s, called_name %s", call->status,
-			call->id, call->phone_number.number,
+	DBG("Got a voicecall event, status: %s (%d), id: %u, number: %s"
+			" called_number: %s, called_name %s",
+			call_status_to_string(call->status),
+			call->status, call->id, call->phone_number.number,
 			call->called_number.number, call->name);
 =

 	l =3D g_slist_find_custom(vc->call_list, GUINT_TO_POINTER(call->id),
-- =

2.14.1


--===============3763536933361050082==--

