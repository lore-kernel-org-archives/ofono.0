Content-Type: multipart/mixed; boundary="===============5474962376055809903=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [RFC PATCH 3/4] sim: add ofono_sim_get_mnc_length
Date: Mon, 10 Jan 2011 15:11:11 +0200
Message-ID: <1294665072-13630-4-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1294665072-13630-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5474962376055809903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    1 +
 src/sim.c     |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 7860e24..9b21f2e 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -173,6 +173,7 @@ void ofono_sim_set_data(struct ofono_sim *sim, void *da=
ta);
 void *ofono_sim_get_data(struct ofono_sim *sim);
 =

 const char *ofono_sim_get_imsi(struct ofono_sim *sim);
+unsigned int ofono_sim_get_mnc_length(struct ofono_sim *sim);
 enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim);
 =

 enum ofono_sim_cphs_phase ofono_sim_get_cphs_phase(struct ofono_sim *sim);
diff --git a/src/sim.c b/src/sim.c
index 335f611..e9b1688 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1913,6 +1913,14 @@ const char *ofono_sim_get_imsi(struct ofono_sim *sim)
 	return sim->imsi;
 }
 =

+unsigned int ofono_sim_get_mnc_length(struct ofono_sim *sim)
+{
+	if (sim =3D=3D NULL)
+		return 0;
+
+	return sim->mnc_length;
+}
+
 enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim)
 {
 	if (sim =3D=3D NULL)
-- =

1.7.1


--===============5474962376055809903==--

