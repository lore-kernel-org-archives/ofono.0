Content-Type: multipart/mixed; boundary="===============6058958675837242659=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH] sim: fix crash in case of invalid sim password type
Date: Wed, 28 Jun 2017 09:46:43 +0200
Message-ID: <1498636003-24999-2-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <1498636003-24999-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6058958675837242659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Crash seen in sim_pin_query_cb if pin type is OFONO_SIM_PASSWORD_INVALID
---
 src/sim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/sim.c b/src/sim.c
index ac5b6fd..aa4190f 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -145,6 +145,7 @@ static const char *const passwd_name[] =3D {
 	[OFONO_SIM_PASSWORD_PHSP_PUK] =3D "servicepuk",
 	[OFONO_SIM_PASSWORD_PHCORP_PIN] =3D "corp",
 	[OFONO_SIM_PASSWORD_PHCORP_PUK] =3D "corppuk",
+	[OFONO_SIM_PASSWORD_INVALID] =3D "invalid",
 };
 =

 static void sim_own_numbers_update(struct ofono_sim *sim);
-- =

2.7.4


--===============6058958675837242659==--

