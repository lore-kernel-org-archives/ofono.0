Content-Type: multipart/mixed; boundary="===============0628142954831776146=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 3/5] voicecall: use ofono_call_status_name in DBG messages
Date: Tue, 25 Jul 2017 15:26:22 +0200
Message-ID: <20170725132624.32293-3-lynxis@fe80.eu>
In-Reply-To: <20170725132624.32293-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0628142954831776146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index c99f11fa..e3ae80cf 100644
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
+			ofono_call_status_to_string(call->status),
+			call->status, call->id, call->phone_number.number,
 			call->called_number.number, call->name);
 =

 	l =3D g_slist_find_custom(vc->call_list, GUINT_TO_POINTER(call->id),
-- =

2.13.3


--===============0628142954831776146==--

