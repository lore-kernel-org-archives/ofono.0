Content-Type: multipart/mixed; boundary="===============8429207058763372936=="
MIME-Version: 1.0
From: Florent Beillonnet <florent.beillonnet@gmail.com>
Subject: [PATCH 1/2] Adding the ofono_sim_initialized_notify function after
 ofono_sim_inserted_notify,
 as suggested by Denis Kenzior in this commit :
 54d56d763e40bc44c99a9b24aa0477bd373ea085
Date: Tue, 22 May 2018 13:08:30 +0000
Message-ID: <1526994511-302-2-git-send-email-florent.beillonnet@ext.actia.fr>
In-Reply-To: <1526994511-302-1-git-send-email-florent.beillonnet@ext.actia.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8429207058763372936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/gemalto.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index ec8174d..29e3b09 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -160,6 +160,7 @@ static void sim_ready_cb(gboolean present, gpointer use=
r_data)
 	DBG("sim present: %d", present);
 =

 	ofono_sim_inserted_notify(sim, present);
+	ofono_sim_initialized_notify(sim);
 }
 =

 static void gemalto_ciev_notify(GAtResult *result, gpointer user_data)
@@ -576,6 +577,7 @@ static void gemalto_pre_sim(struct ofono_modem *modem)
 =

 	if (data->sim && data->have_sim =3D=3D TRUE)
 		ofono_sim_inserted_notify(data->sim, TRUE);
+		ofono_sim_initialized_notify(data->sim);
 }
 =

 static void gemalto_post_sim(struct ofono_modem *modem)
-- =

1.9.1


--===============8429207058763372936==--

