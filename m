Content-Type: multipart/mixed; boundary="===============5409271778635018162=="
MIME-Version: 1.0
From: Nandini Rebello <nandini.rebello@intel.com>
Subject: [PATCH] modem: add support to clear cached pins.
Date: Thu, 03 Jan 2019 16:35:38 +0530
Message-ID: <1546513538-13289-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5409271778635018162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding support to clear cached pins when modem is disabled.
---
 src/modem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/modem.c b/src/modem.c
index bc46275..590d85b 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1243,6 +1243,8 @@ void ofono_modem_set_powered(struct ofono_modem *mode=
m, ofono_bool_t powered)
 		set_online(modem, FALSE);
 =

 		modem_change_state(modem, MODEM_STATE_POWER_OFF);
+
+		ofono_sim_clear_cached_pins();
 	}
 =

 out:
-- =

2.7.4


--===============5409271778635018162==--

