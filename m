Content-Type: multipart/mixed; boundary="===============3316673278621246934=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 3/3] sim: getters for mcc and mnc implementation
Date: Wed, 19 Jan 2011 09:21:28 +0200
Message-ID: <1295421688-19291-4-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1295421688-19291-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3316673278621246934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 891116b..86c3f13 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1990,6 +1990,22 @@ const char *ofono_sim_get_imsi(struct ofono_sim *sim)
 	return sim->imsi;
 }
 =

+const char *ofono_sim_get_mcc(struct ofono_sim *sim)
+{
+	if (sim =3D=3D NULL)
+		return NULL;
+
+	return sim->mcc;
+}
+
+const char *ofono_sim_get_mnc(struct ofono_sim *sim)
+{
+	if (sim =3D=3D NULL)
+		return NULL;
+
+	return sim->mnc;
+}
+
 enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim)
 {
 	if (sim =3D=3D NULL)
-- =

1.7.1


--===============3316673278621246934==--

