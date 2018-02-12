Content-Type: multipart/mixed; boundary="===============9067838682285018045=="
MIME-Version: 1.0
From: philippedeswert@gmail.com
Subject: [PATCH 1/5] voicecall: Rename callbacks/functions related to dialing
 the last called number
Date: Mon, 12 Feb 2018 20:37:14 +0200
Message-ID: <20180212183718.17194-2-philippedeswert@gmail.com>
In-Reply-To: <20180212183718.17194-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9067838682285018045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Philippe De Swert <philippedeswert@gmail.com>

Calling from memory index is very similar in functionality to dialing the
last called number. So we rename the functions so we can reuse them, to deal
with memory index calling. Function names now also reflect this is for hfp.
---
 src/voicecall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 4c2f71f8..eae4b904 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1577,7 +1577,7 @@ static DBusMessage *manager_dial(DBusConnection *conn,
 	return __ofono_error_failed(msg);
 }
 =

-static void manager_dial_last_callback(const struct ofono_error *error,
+static void manager_dial_hfp_callback(const struct ofono_error *error,
 								void *data)
 {
 	struct ofono_voicecall *vc =3D data;
@@ -1606,7 +1606,7 @@ error:
 					__ofono_error_failed(vc->pending));
 }
 =

-static int voicecall_dial_last(struct ofono_voicecall *vc,
+static int voicecall_dial_hfp(struct ofono_voicecall *vc,
 					ofono_voicecall_cb_t cb, void *data)
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
@@ -1646,7 +1646,7 @@ static DBusMessage *manager_dial_last(DBusConnection =
*conn,
 =

 	vc->pending =3D dbus_message_ref(msg);
 =

-	err =3D voicecall_dial_last(vc, manager_dial_last_callback, vc);
+	err =3D voicecall_dial_hfp(vc, manager_dial_hfp_callback, vc);
 =

 	if (err >=3D 0)
 		return NULL;
-- =

2.11.0


--===============9067838682285018045==--

