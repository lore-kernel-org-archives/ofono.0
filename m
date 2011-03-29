Content-Type: multipart/mixed; boundary="===============5156297749510745539=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 3/3] atmodem: remove redundant code
Date: Tue, 29 Mar 2011 10:48:30 +0300
Message-ID: <1301384910-28272-4-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1301384910-28272-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5156297749510745539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim-poll.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/atmodem/sim-poll.c b/drivers/atmodem/sim-poll.c
index daef24a..da00ddd 100644
--- a/drivers/atmodem/sim-poll.c
+++ b/drivers/atmodem/sim-poll.c
@@ -239,14 +239,9 @@ static void stk_watch(struct ofono_atom *atom,
 =

 void atmodem_poll_enable(struct ofono_modem *modem, GAtChat *chat)
 {
-	struct ofono_atom *sim_atom;
-	struct ofono_atom *stk_atom;
 	struct sim_poll_data *spd;
 =

-	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
-	stk_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_STK);
-
-	if (sim_atom =3D=3D NULL)
+	if (__ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM) =3D=3D NULL)
 		return;
 =

 	spd =3D g_new0(struct sim_poll_data, 1);
@@ -256,13 +251,7 @@ void atmodem_poll_enable(struct ofono_modem *modem, GA=
tChat *chat)
 =

 	spd->stk_watch =3D __ofono_modem_add_atom_watch(spd->modem,
 			OFONO_ATOM_TYPE_STK, stk_watch, spd, NULL);
-	if (stk_atom && __ofono_atom_get_registered(stk_atom))
-		stk_watch(stk_atom,
-				OFONO_ATOM_WATCH_CONDITION_REGISTERED, spd);
 =

 	spd->sim_watch =3D __ofono_modem_add_atom_watch(spd->modem,
 			OFONO_ATOM_TYPE_SIM, sim_watch, spd, NULL);
-	if (__ofono_atom_get_registered(sim_atom))
-		sim_watch(sim_atom,
-				OFONO_ATOM_WATCH_CONDITION_REGISTERED, spd);
 }
-- =

1.7.1


--===============5156297749510745539==--

