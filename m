Content-Type: multipart/mixed; boundary="===============8694717070792121109=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 2/2] drivers: use %m instead of strerror()
Date: Fri, 03 Dec 2010 21:35:48 +0200
Message-ID: <1291404948-13335-2-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1291404948-13335-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8694717070792121109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/sim.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
index b79c52a..0b3d2ae 100644
--- a/drivers/isimodem/sim.c
+++ b/drivers/isimodem/sim.c
@@ -428,7 +428,8 @@ static void sim_reachable_cb(GIsiClient *client, gboole=
an alive,
 	struct ofono_sim *sim =3D opaque;
 =

 	if (!alive) {
-		DBG("SIM client: %s", strerror(-g_isi_client_error(client)));
+		errno =3D -g_isi_client_error(client);
+		DBG("SIM client: %m");
 		ofono_sim_remove(sim);
 		return;
 	}
-- =

1.7.1


--===============8694717070792121109==--

