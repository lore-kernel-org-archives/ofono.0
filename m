Content-Type: multipart/mixed; boundary="===============8780550272339853411=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: [PATCH] documentation: fix a typo in the SIM API docs
Date: Fri, 05 Mar 2010 19:37:49 -0500
Message-ID: <20100305193749.324e3744@droptest.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8780550272339853411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


ISMI -> IMSI (for the International Mobile Subscriber Identity).
---
 doc/sim-api.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index 9fe9a92..3565dd4 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -47,7 +47,7 @@ Signals		PropertyChanged(string name, variant value)
 =

 Properties	string SubscriberIdentity [readonly, optional]
 =

-			Contains the ISMI of the SIM, if available
+			Contains the IMSI of the SIM, if available
 =

 		uint8 MobileNetworkCodeLength [readonly, optional]
 =

-- =

1.7.0


--===============8780550272339853411==--

