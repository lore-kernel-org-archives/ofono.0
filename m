Content-Type: multipart/mixed; boundary="===============1424182495691641520=="
MIME-Version: 1.0
From: Joey Hewitt <joey@joeyhewitt.com>
Subject: [PATCH] qmimodem: enable message waiting atom
Date: Fri, 08 Sep 2017 18:26:03 -0700
Message-ID: <20170909021949.1FCD060F2C@rivendell.scintill.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1424182495691641520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Conditional on one of UIM (SIM), DMS (legacy SIM), or WMS (SMS).
---

Tested on my Android phone. It correctly reported
VoicemailMailboxNumber, and VoicemailWaiting property when a voicemail
was sent. I got an error "Queuing a EF-MWI write to SIM failed", though
-- I'm not sure if that's a bug somewhere in the stack, or if that's
just how my SIM is.

 plugins/gobi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index a498599..0bc134f 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -490,6 +490,7 @@ static void gobi_post_online(struct ofono_modem *modem)
 	struct gobi_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	struct ofono_message_waiting *mw;
 =

 	DBG("%p", modem);
 =

@@ -499,6 +500,12 @@ static void gobi_post_online(struct ofono_modem *modem)
 	if (data->features & GOBI_VOICE)
 		ofono_ussd_create(modem, 0, "qmimodem", data->device);
 =

+	if (data->features & (GOBI_UIM | GOBI_DMS | GOBI_WMS)) {
+		mw =3D ofono_message_waiting_create(modem);
+		if (mw)
+			ofono_message_waiting_register(mw);
+	}
+
 	if (data->features & GOBI_WDS) {
 		gprs =3D ofono_gprs_create(modem, 0, "qmimodem", data->device);
 		gc =3D ofono_gprs_context_create(modem, 0, "qmimodem",
-- =

2.7.4


--===============1424182495691641520==--

