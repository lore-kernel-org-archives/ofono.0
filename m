Content-Type: multipart/mixed; boundary="===============3210832438420964460=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 3/5] voicecall: take into use the new history function
Date: Mon, 22 Nov 2010 18:26:06 +0200
Message-ID: <3b44aa561d01ae8dc733a3a24926caeb5417e0e5.1290442823.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1290442823.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3210832438420964460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index bd64432..b40d284 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -630,6 +630,7 @@ static void voicecall_emit_multiparty(struct voicecall =
*call, gboolean mpty)
 =

 static void voicecall_set_call_status(struct voicecall *call, int status)
 {
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(call->vc->atom);
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path;
 	const char *status_str;
@@ -658,6 +659,8 @@ static void voicecall_set_call_status(struct voicecall =
*call, int status)
 		const char *timestr;
 =

 		call->start_time =3D time(NULL);
+		__ofono_history_call_started(modem, call->call,
+						call->start_time);
 		timestr =3D time_to_str(&call->start_time);
 =

 		ofono_dbus_signal_property_changed(conn, path,
-- =

1.7.0.4


--===============3210832438420964460==--

