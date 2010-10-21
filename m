Content-Type: multipart/mixed; boundary="===============5522891596160721099=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 5/5] sim: check existence of imsi-code
Date: Thu, 21 Oct 2010 17:58:13 +0300
Message-ID: <1287673093-3022-6-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1287673093-3022-5-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5522891596160721099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For instance: when handling sim_get_properties
in PRE_SIM-state imsi is not received/stored.
---
 src/sim.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index ef2a237..a053759 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -314,7 +314,7 @@ static DBusMessage *sim_get_properties(DBusConnection *=
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



--===============5522891596160721099==--

