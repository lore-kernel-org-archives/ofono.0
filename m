Content-Type: multipart/mixed; boundary="===============8072455818214529591=="
MIME-Version: 1.0
From: Joey Hewitt <joey@joeyhewitt.com>
Subject: [PATCH v2] gobi: enable message waiting atom
Date: Sat, 09 Sep 2017 23:16:03 -0700
Message-ID: <20170910063614.E819A642AA@rivendell.scintill.net>
In-Reply-To: <82c346f5-ac9c-3260-fb42-b751e63ce8dd@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8072455818214529591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

On 09/09/2017 08:18 AM, Denis Kenzior wrote:
> Hi Joey,
> =

> Neither QMI SIM driver supports SIM writes (e.g. write_file_transparent, =

> write_file_linear, write_file_cyclic).  Without those, the =

> message-waiting atom is only half functional...
> =


Ah, I thought I had checked the SIM support was there, but I missed
that! I'm sending another patch to add that for qmimodem.

> And strictly speaking the check should be for
> (data->features & (GOBI_UIM | GOBI_DMS)) && (data->features & GOBI_WMS))
> =

> However, since we got to post_sim/post_online somehow (e.g. presence of =

> one of these services is implied), I'd just simply use
> =

> if (data->features & GOBI_WMS)

My logic was that any of the 3 features alone could provide some level
of message-waiting functionality, but I suppose both SIM and SMS are
needed to really be useful.

Now that I understand more that the legacy SIM will probably never be
able to write SIM files, should the message waiting atom be
"half-functional" if it's legacy, or not enabled at all?

 plugins/gobi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index a498599..3205307 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -481,8 +481,12 @@ static void gobi_post_sim(struct ofono_modem *modem)
 	if (data->features & GOBI_NAS)
 		ofono_radio_settings_create(modem, 0, "qmimodem", data->device);
 =

-	if (data->features & GOBI_WMS)
+	if (data->features & GOBI_WMS) {
 		ofono_sms_create(modem, 0, "qmimodem", data->device);
+		struct ofono_message_waiting *mw =3D ofono_message_waiting_create(modem);
+		if (mw)
+			ofono_message_waiting_register(mw);
+	}
 }
 =

 static void gobi_post_online(struct ofono_modem *modem)
-- =

2.7.4


--===============8072455818214529591==--

