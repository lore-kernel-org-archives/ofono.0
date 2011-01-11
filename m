Content-Type: multipart/mixed; boundary="===============0314492616129330080=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH v2 2/9] gps: add new interface to feature map
Date: Tue, 11 Jan 2011 00:23:51 -0300
Message-ID: <1294716238-21218-3-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1294716238-21218-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0314492616129330080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 953d6c3..d579a30 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1077,6 +1077,7 @@ static const struct {
 	{ OFONO_STK_INTERFACE,				"stk"	},
 	{ OFONO_CONNECTION_MANAGER_INTERFACE,		"gprs"	},
 	{ OFONO_TEXT_TELEPHONY_INTERFACE,		"tty"	},
+	{ OFONO_LOCATION_REPORTING_INTERFACE,		"gps"	},
 	{ },
 };
 =

-- =

1.7.2.3


--===============0314492616129330080==--

