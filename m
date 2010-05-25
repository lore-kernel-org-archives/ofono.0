Content-Type: multipart/mixed; boundary="===============7520778797701728638=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH 4/4] Add description of Online property to modem-api.txt
Date: Wed, 26 May 2010 00:14:41 +0300
Message-ID: <1274822081-930-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1274822081-930-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7520778797701728638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/modem-api.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index 7cccd57..4e0525a 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -32,6 +32,11 @@ Properties	boolean Powered [readwrite]
 			Boolean representing the power state of the modem
 			device.
 =

+		boolean Online [readwrite]
+
+			Boolean representing the rf state of the modem.
+			Online is false in flight mode.
+
 		string Name [readonly, optional]
 =

 			Friendly name of the modem device.
-- =

1.6.3.3


--===============7520778797701728638==--

