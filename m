Content-Type: multipart/mixed; boundary="===============1902522907701579333=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH 4/5] quectel: Try to update voltage only, when received "vbatt"
Date: Tue, 04 Aug 2020 14:38:48 +0200
Message-ID: <20200804123849.909105-4-poeschel@lemonage.de>
In-Reply-To: <20200804123849.909105-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1902522907701579333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

As there are some more sources of +QIND: activated, do now only update
voltage when we get the
+QIND: "vbatt",-1
but not on things like
+QIND: "act","LTE"
or
+QIND: "csq",20,99
---
 plugins/quectel.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 9aa63c1c..d11aba74 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -447,10 +447,12 @@ static void qind_notify(GAtResult *result, void *user=
_data)
 	if (!g_at_result_iter_next_string(&iter, &type))
 		return;
 =

-	if (!g_at_result_iter_next_number(&iter, &event))
-		return;
+	if (g_strcmp0("vbatt", type)) {
+		if (!g_at_result_iter_next_number(&iter, &event))
+			return;
 =

-	voltage_handle(hw->modem, event);
+		voltage_handle(hw->modem, event);
+	}
 }
 =

 static void power_notify(GAtResult *result, void *user_data)
-- =

2.27.0

--===============1902522907701579333==--

