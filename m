Content-Type: multipart/mixed; boundary="===============2094201766111056319=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH] telit: pass vendor at sim atom creation
Date: Thu, 16 Aug 2012 11:01:48 +0200
Message-ID: <1345107708-24484-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2094201766111056319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/telit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index 6ae7249..08ce4ad 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -552,7 +552,7 @@ static void telit_pre_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
-	data->sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
+	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_TELIT, "atmodem", data=
->chat);
 	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
 }
 =

-- =

1.7.7.6


--
Scanned by MailScanner.


--===============2094201766111056319==--

