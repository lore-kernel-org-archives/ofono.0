Content-Type: multipart/mixed; boundary="===============2881926519895368183=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 2/2] sim-auth: Only close open sessions
Date: Mon, 26 Apr 2021 11:17:34 +0300
Message-ID: <20210426081734.2460416-2-slava.monich@jolla.com>
In-Reply-To: <20210426081734.2460416-1-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2881926519895368183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Session has to be open in order to have a valid session_id
---
 src/sim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/sim.c b/src/sim.c
index 793ff64a..3319ecee 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -3805,7 +3805,8 @@ void __ofono_sim_remove_session_watch(struct ofono_si=
m_aid_session *session,
 {
 	__ofono_watchlist_remove_item(session->watches, id);
 =

-	if (g_slist_length(session->watches->items) =3D=3D 0) {
+	if (g_slist_length(session->watches->items) =3D=3D 0 &&
+			session->state =3D=3D SESSION_STATE_OPEN) {
 		/* last watcher, close session */
 		session->state =3D SESSION_STATE_CLOSING;
 		session->sim->driver->close_channel(session->sim,
-- =

2.25.1

--===============2881926519895368183==--

