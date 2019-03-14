Content-Type: multipart/mixed; boundary="===============8586624860714759633=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 5/5] ublox: do not set bridge mode for TOBY L2
Date: Thu, 14 Mar 2019 23:28:43 +0100
Message-ID: <20190314222843.9232-5-jonas@norrbonn.se>
In-Reply-To: <20190314222843.9232-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8586624860714759633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Trying to set the networking mode to "bridge" mode in the plugin is bogus
because the setting does not apply until after the device has been
reset.  Instead, the current setting should be queried.

If a user wants to set the modem networking mode, the setting should be
made outside of ofono.

The gprs-context driver has already been adjusted to query the
networking mode and to set things up accordingly.
---
 plugins/ublox.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 8100dfba..dc001765 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -145,11 +145,6 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
 		return;
 	}
 =

-	if (data->flags & UBLOX_DEVICE_F_HIGH_THROUGHPUT_MODE)
-		/* use bridged mode until routed mode support is added */
-		g_at_chat_send(data->aux, "AT+UBMCONF=3D2", none_prefix,
-						NULL, NULL, NULL);
-
 	ofono_modem_set_powered(modem, TRUE);
 }
 =

-- =

2.19.1


--===============8586624860714759633==--

