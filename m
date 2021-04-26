Content-Type: multipart/mixed; boundary="===============8672654921589755011=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 1/2] sim-auth: Remove watch if open_channel fails
Date: Mon, 26 Apr 2021 11:17:33 +0300
Message-ID: <20210426081734.2460416-1-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8672654921589755011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise open_channel won't be called again after a failure.
---
 src/sim-auth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/sim-auth.c b/src/sim-auth.c
index 0e13b533..3c3f35e7 100644
--- a/src/sim-auth.c
+++ b/src/sim-auth.c
@@ -367,6 +367,8 @@ static void get_session_cb(ofono_bool_t active, int ses=
sion_id,
 error:
 	__ofono_dbus_pending_reply(&sa->pending->msg,
 			__ofono_error_failed(sa->pending->msg));
+	__ofono_sim_remove_session_watch(sa->pending->session,
+			sa->pending->watch_id);
 	g_free(sa->pending);
 	sa->pending =3D NULL;
 }
-- =

2.25.1

--===============8672654921589755011==--

