Content-Type: multipart/mixed; boundary="===============8779862099174248488=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH 2/8] gps: add new interface to feature map
Date: Thu, 16 Dec 2010 17:30:17 -0300
Message-ID: <1292531423-22316-3-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1292531423-22316-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8779862099174248488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 2f9387c..6d7b10e 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -906,6 +906,7 @@ static const struct {
 	{ OFONO_STK_INTERFACE,				"stk"	},
 	{ OFONO_CONNECTION_MANAGER_INTERFACE,		"gprs"	},
 	{ OFONO_TEXT_TELEPHONY_INTERFACE,		"tty"	},
+	{ OFONO_GPS_INTERFACE,				"gps"	},
 	{ },
 };
 =

-- =

1.7.2.3


--===============8779862099174248488==--

