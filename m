Content-Type: multipart/mixed; boundary="===============7269395116386418428=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH] avoid stk atom is removed when sim pin is blocked
Date: Thu, 12 Sep 2013 01:51:01 +0800
Message-ID: <1378921861-6238-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7269395116386418428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@intel.com>

When sim pin is blocked after input wrong pin code three times,
modem will change to pre-sim status, at this time, STK function
should be available. stk atoms shouldn't be removed.
---
 src/modem.c |    7 ++++++-
 src/stk.c   |    4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/modem.c b/src/modem.c
index 01b0e35..7124d53 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -196,7 +196,12 @@ struct ofono_atom *__ofono_modem_add_atom(struct ofono=
_modem *modem,
 	atom =3D g_new0(struct ofono_atom, 1);
 =

 	atom->type =3D type;
-	atom->modem_state =3D modem->modem_state;
+	/* to avoid STK is removed when modem change to
+		MODEM_STATE_PRE_SIM status */
+	if (type =3D=3D OFONO_ATOM_TYPE_STK)
+		atom->modem_state =3D MODEM_STATE_PRE_SIM;
+	else
+		atom->modem_state =3D modem->modem_state;
 	atom->destruct =3D destruct;
 	atom->data =3D data;
 	atom->modem =3D modem;
diff --git a/src/stk.c b/src/stk.c
index 01c95b5..a00a425 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -3196,6 +3196,10 @@ struct ofono_stk *ofono_stk_create(struct ofono_mode=
m *modem,
 	if (driver =3D=3D NULL)
 		return NULL;
 =

+	/* STK may already exist, in the case that restore from pin blocked */
+	if (__ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_STK) !=3D NULL)
+		return NULL;
+
 	stk =3D g_try_new0(struct ofono_stk, 1);
 =

 	if (stk =3D=3D NULL)
-- =

1.7.9.5


--===============7269395116386418428==--

