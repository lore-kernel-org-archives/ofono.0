Content-Type: multipart/mixed; boundary="===============5488395809692260728=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] sim: Stop imsi/lock query sequence when SIM is removed
Date: Thu, 05 Jan 2017 15:28:56 +0300
Message-ID: <1483619336-26053-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5488395809692260728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

SIM card can be removed while the query is in progress. There's
still a remote possibility that SIM card is removed and inserted
back while the query is pending, that would start the second query
sequence and end up invoking sim_initialize() twice. But at least
these checks reduce the probability of something like that happening.
---
 src/sim.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/sim.c b/src/sim.c
index edd7c76..63c7b3c 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2466,6 +2466,9 @@ static void sim_query_fac_pinlock_cb(const struct ofo=
no_error *error,
 {
 	struct ofono_sim *sim =3D data;
 =

+	if (sim->state =3D=3D OFONO_SIM_STATE_NOT_PRESENT)
+		return;
+
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
 		goto done;
 =

@@ -2480,6 +2483,9 @@ static void sim_query_fac_networklock_cb(const struct=
 ofono_error *error,
 {
 	struct ofono_sim *sim =3D data;
 =

+	if (sim->state =3D=3D OFONO_SIM_STATE_NOT_PRESENT)
+		return;
+
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
 		goto done;
 =

@@ -2496,6 +2502,9 @@ static void sim_query_fac_imsilock_cb(const struct of=
ono_error *error,
 {
 	struct ofono_sim *sim =3D data;
 =

+	if (sim->state =3D=3D OFONO_SIM_STATE_NOT_PRESENT)
+		return;
+
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
 		goto done;
 =

-- =

1.9.1


--===============5488395809692260728==--

