Content-Type: multipart/mixed; boundary="===============7517412704507227061=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v0] modem: Add ModemType
Date: Fri, 04 Nov 2011 13:44:41 +0100
Message-ID: <1320410681-3001-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7517412704507227061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Indicate the kind of modem it is before it is powered up.
---

Hi,

here is the proposal to add this additional flag, so =

that ConnMan only takes control over the real hardware.

cheers,
daniel

 doc/modem-api.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index fa400a2..8a11bd4 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -98,3 +98,14 @@ Properties	boolean Powered [readwrite]
 =

 			TODO: Better to split this into Status and
 			      Capabilites properties?
+
+		string ModemType [readonly]
+
+			Indicates whether the modem is virtual or a real
+			hardware one. This information should only be used
+			to identify which componet (e.g. ConnMan or a phone
+			dialer) should take control over the modem. It does
+			not give any hints on which Interfaces will be
+			supported by this modem.
+
+			Possible values are "hfp", "sap" and "hardware".
-- =

1.7.6.4


--===============7517412704507227061==--

