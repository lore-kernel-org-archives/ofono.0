Content-Type: multipart/mixed; boundary="===============4457126852083622041=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH 2/3] sim: implement function to get password type
Date: Thu, 16 Aug 2012 09:37:19 +0200
Message-ID: <1345102640-8465-2-git-send-email-christopher.vogl@hale.at>
In-Reply-To: <50292E2D.8040403@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4457126852083622041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: August Mayer <august.mayer@hale.at>

---
 src/sim.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 4384eb0..8059d2b 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2243,6 +2243,14 @@ enum ofono_sim_cphs_phase ofono_sim_get_cphs_phase(s=
truct ofono_sim *sim)
 	return sim->cphs_phase;
 }
 =

+enum ofono_sim_password_type ofono_sim_get_password_type(struct ofono_sim =
*sim)
+{
+	if (sim =3D=3D NULL)
+		return OFONO_SIM_PASSWORD_NONE;
+
+	return sim->pin_type;
+}
+
 const unsigned char *ofono_sim_get_cphs_service_table(struct ofono_sim *si=
m)
 {
 	if (sim =3D=3D NULL)
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============4457126852083622041==--

