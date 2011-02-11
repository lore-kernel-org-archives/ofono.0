Content-Type: multipart/mixed; boundary="===============3162977247415270436=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/1] ifxmodem: fix issue in set rat mode
Date: Fri, 11 Feb 2011 11:20:29 -0800
Message-ID: <1297452029-13911-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1297452029-13911-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3162977247415270436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/radio-settings.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/ifxmodem/radio-settings.c b/drivers/ifxmodem/radio-set=
tings.c
index fd590ae..bd292c5 100644
--- a/drivers/ifxmodem/radio-settings.c
+++ b/drivers/ifxmodem/radio-settings.c
@@ -145,7 +145,10 @@ static void ifx_set_rat_mode(struct ofono_radio_settin=
gs *rs,
 		goto error;
 	}
 =

-	snprintf(buf, sizeof(buf), "AT+XRAT=3D%u,%u", value, preferred);
+	if (value =3D=3D 1)
+		snprintf(buf, sizeof(buf), "AT+XRAT=3D%u,%u", value, preferred);
+	else
+		snprintf(buf, sizeof(buf), "AT+XRAT=3D%u", value);
 =

 	if (g_at_chat_send(rsd->chat, buf, none_prefix,
 					xrat_modify_cb, cbd, g_free) > 0)
-- =

1.7.0.4


--===============3162977247415270436==--

