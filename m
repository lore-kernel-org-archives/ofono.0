Content-Type: multipart/mixed; boundary="===============5953578439471941686=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 6/6] emulator: add ppp_suspend implementation and registration.
Date: Tue, 15 Mar 2011 10:19:03 +0100
Message-ID: <1300180743-27624-7-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5953578439471941686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 20a575f..5179ea9 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -99,6 +99,15 @@ static void ppp_disconnect(GAtPPPDisconnectReason reason=
, gpointer user_data)
        g_at_server_resume(em->server);
 }
 =

+static void ppp_suspend(gpointer user_data)
+{
+       struct ofono_emulator *em =3D user_data;
+
+       DBG("");
+
+       g_at_server_resume(em->server);
+}
+
 static gboolean setup_ppp(gpointer user_data)
 {
        struct ofono_emulator *em =3D user_data;
@@ -126,6 +135,7 @@ static gboolean setup_ppp(gpointer user_data)
 =

        g_at_ppp_set_connect_function(em->ppp, ppp_connect, em);
        g_at_ppp_set_disconnect_function(em->ppp, ppp_disconnect, em);
+       g_at_ppp_set_suspend_function(em->ppp, ppp_suspend, em);
 =

        return FALSE;
 }
-- =

1.7.1


--===============5953578439471941686==--

