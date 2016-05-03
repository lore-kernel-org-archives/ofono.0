Content-Type: multipart/mixed; boundary="===============2927415528991351440=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH 2/2] plugins/ril: enable STK
Date: Tue, 03 May 2016 11:39:00 +0800
Message-ID: <1462246740-5881-2-git-send-email-caiwen.zhang@intel.com>
In-Reply-To: <1462246740-5881-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2927415528991351440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@intel.com>

---
 plugins/ril.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/ril.c b/plugins/ril.c
index b66664a..2298bb6 100644
--- a/plugins/ril.c
+++ b/plugins/ril.c
@@ -229,7 +229,7 @@ void ril_post_sim(struct ofono_modem *modem)
 		ofono_message_waiting_register(mw);
 =

 	ofono_call_forwarding_create(modem, rd->vendor, RILMODEM, rd->ril);
-
+	ofono_stk_create(modem, rd->vendor, RILMODEM, rd->ril);
 	ofono_phonebook_create(modem, rd->vendor, RILMODEM, modem);
 }
 =

-- =

1.9.1


--===============2927415528991351440==--

