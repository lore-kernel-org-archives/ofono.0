Content-Type: multipart/mixed; boundary="===============3352662242749082891=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 4/7] plugins/n900: Move call forwarding to post sim
Date: Fri, 10 Dec 2010 10:56:46 -0800
Message-ID: <1292007409-15069-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1292007409-15069-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3352662242749082891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/n900.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/n900.c b/plugins/n900.c
index 7619821..9b16f4d 100644
--- a/plugins/n900.c
+++ b/plugins/n900.c
@@ -491,6 +491,7 @@ static void n900_post_sim(struct ofono_modem *modem)
 	DBG("");
 =

 	ofono_phonebook_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_call_forwarding_create(isi->modem, 0, "isimodem", isi->idx);
 }
 =

 static void n900_post_online(struct ofono_modem *modem)
@@ -506,7 +507,6 @@ static void n900_post_online(struct ofono_modem *modem)
 	ofono_cbs_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_ssn_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_ussd_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_call_forwarding_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_call_settings_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_call_barring_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_call_meter_create(isi->modem, 0, "isimodem", isi->idx);
-- =

1.7.0.4


--===============3352662242749082891==--

