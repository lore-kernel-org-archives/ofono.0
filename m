Content-Type: multipart/mixed; boundary="===============8145443643256955382=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 2/7] doc: RSSI is also an LTE property
Date: Fri, 08 Sep 2017 04:40:35 +0200
Message-ID: <20170908024040.31418-2-jonas@southpole.se>
In-Reply-To: <20170908024040.31418-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8145443643256955382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/networkmonitor-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/networkmonitor-api.txt b/doc/networkmonitor-api.txt
index ddace7e..8d73af0 100644
--- a/doc/networkmonitor-api.txt
+++ b/doc/networkmonitor-api.txt
@@ -77,7 +77,7 @@ byte TimingAdvance [optional, gsm]
 =

 	Contains the Timing Advance.  Valid range of values is 0-219.
 =

-byte Strength [optional, gsm, umts]
+byte Strength [optional, gsm, umts, lte]
 =

 	Contains the signal strength.  Valid values are 0-31.  Refer to <rssi>
 	in 27.007, Section 8.5.
-- =

2.9.3


--===============8145443643256955382==--

