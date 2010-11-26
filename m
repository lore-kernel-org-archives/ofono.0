Content-Type: multipart/mixed; boundary="===============4042585196924691478=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 5/7] plugins/n900: Move call forwarding to post sim
Date: Thu, 25 Nov 2010 22:23:35 -0800
Message-ID: <1290752617-19024-6-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1290752617-19024-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4042585196924691478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/n900.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/n900.c b/plugins/n900.c
index a9e6b59..3f6aa39 100644
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


--===============4042585196924691478==--

