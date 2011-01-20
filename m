Content-Type: multipart/mixed; boundary="===============7715367014258661534=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 4/6] modem: probe gprs_provision drivers
Date: Thu, 20 Jan 2011 15:11:37 +0200
Message-ID: <1295529099-21082-5-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1295529099-21082-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7715367014258661534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index e966a6e..a302590 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -424,6 +424,7 @@ static void modem_change_state(struct ofono_modem *mode=
m,
 				driver->post_sim(modem);
 			__ofono_history_probe_drivers(modem);
 			__ofono_nettime_probe_drivers(modem);
+			__ofono_gprs_provision_probe_drivers(modem);
 		} else
 			notify_online_watches(modem);
 =

-- =

1.7.1


--===============7715367014258661534==--

