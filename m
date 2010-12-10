Content-Type: multipart/mixed; boundary="===============1219336794724058809=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 3/7] isigen: Move call forwarding to post sim
Date: Fri, 10 Dec 2010 10:56:45 -0800
Message-ID: <1292007409-15069-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1292007409-15069-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1219336794724058809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/isigen.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/isigen.c b/plugins/isigen.c
index 028f1b2..b7b7ab5 100644
--- a/plugins/isigen.c
+++ b/plugins/isigen.c
@@ -402,6 +402,7 @@ static void isigen_post_sim(struct ofono_modem *modem)
 	DBG("(%p) with %s", modem, isi->ifname);
 =

 	ofono_phonebook_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_call_forwarding_create(isi->modem, 0, "isimodem", isi->idx);
 }
 =

 static void isigen_post_online(struct ofono_modem *modem)
@@ -418,7 +419,6 @@ static void isigen_post_online(struct ofono_modem *mode=
m)
 	ofono_cbs_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_ssn_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_ussd_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_call_forwarding_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_call_settings_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_call_barring_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_call_meter_create(isi->modem, 0, "isimodem", isi->idx);
-- =

1.7.0.4


--===============1219336794724058809==--

