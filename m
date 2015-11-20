Content-Type: multipart/mixed; boundary="===============7729093087087934417=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH] voicecall: don't dereference a supplied null value
Date: Fri, 20 Nov 2015 09:36:54 +0100
Message-ID: <1448008614-26007-1-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7729093087087934417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the voicecall atom is unregistered we remove all HFP support as
well but were supplying a zero as value to the emulator status
callbacks which caused the process to crash as we were dereferencing
the supplied value always and not respecting a zero as indicator to
reset.
---
 src/voicecall.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index a4eef0e..31d845e 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2660,16 +2660,25 @@ static void emulator_hfp_unregister(struct ofono_at=
om *atom)
 	struct ofono_voicecall *vc =3D __ofono_atom_get_data(atom);
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 =

+	struct emulator_status data;
+	data.vc =3D vc;
+
+	data.status =3D OFONO_EMULATOR_CALL_INACTIVE;
 	__ofono_modem_foreach_registered_atom(modem,
 						OFONO_ATOM_TYPE_EMULATOR_HFP,
-						emulator_call_status_cb, 0);
+						emulator_call_status_cb, &data);
+
+	data.status =3D OFONO_EMULATOR_CALLSETUP_INACTIVE;
 	__ofono_modem_foreach_registered_atom(modem,
 						OFONO_ATOM_TYPE_EMULATOR_HFP,
 						emulator_callsetup_status_cb,
-						0);
+						&data);
+
+	data.status =3D OFONO_EMULATOR_CALLHELD_NONE;
 	__ofono_modem_foreach_registered_atom(modem,
 						OFONO_ATOM_TYPE_EMULATOR_HFP,
-						emulator_callheld_status_cb, 0);
+						emulator_callheld_status_cb,
+						&data);
 =

 	__ofono_modem_foreach_registered_atom(modem,
 						OFONO_ATOM_TYPE_EMULATOR_HFP,
-- =

2.5.0


--===============7729093087087934417==--

