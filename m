Content-Type: multipart/mixed; boundary="===============2879596875329884093=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 4/6] src/modem: notify lte driver before going online
Date: Wed, 10 Oct 2018 08:54:53 +0200
Message-ID: <20181010065454.15232-5-gciofono@gmail.com>
In-Reply-To: <20181010065454.15232-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2879596875329884093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/modem.c b/src/modem.c
index 9e254482..74dbe7ad 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -729,6 +729,8 @@ static void sim_state_watch(enum ofono_sim_state new_st=
ate, void *user)
 	case OFONO_SIM_STATE_READY:
 		modem_change_state(modem, MODEM_STATE_OFFLINE);
 =

+		ofono_lte_set_reg_info(modem);
+
 		/* Modem is always online, proceed to online state. */
 		if (modem_is_always_online(modem) =3D=3D TRUE)
 			set_online(modem, TRUE);
-- =

2.17.1


--===============2879596875329884093==--

