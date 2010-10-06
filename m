Content-Type: multipart/mixed; boundary="===============8663900138165557483=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 3/3] sim: ensure existence of imsi-code when handling
 sim_get_properties
Date: Wed, 06 Oct 2010 17:17:57 +0300
Message-ID: <1286374677-2932-4-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1286374677-2932-3-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8663900138165557483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 930d6bf..5f4f90e 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -311,7 +311,7 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 	ofono_dbus_dict_append(&dict, "FixedDialing", DBUS_TYPE_BOOLEAN,
 				&sim->fixed_dialing);
 =

-	if (sim->mnc_length) {
+	if (sim->mnc_length && sim->imsi) {
 		char mcc[OFONO_MAX_MCC_LENGTH + 1];
 		char mnc[OFONO_MAX_MNC_LENGTH + 1];
 		const char *str;
-- =

1.6.3.3



--===============8663900138165557483==--

