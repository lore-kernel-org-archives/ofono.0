Content-Type: multipart/mixed; boundary="===============0227033167940465229=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [RFC] TODO: Move signal strength property to separate Agent API.
Date: Thu, 20 Jan 2011 11:24:14 +0100
Message-ID: <1295519054-2162-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0227033167940465229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
I think we should consider changing the way we handle
signal strength in oFono.

In the past I have seen very frequent signal strength
reports from the modem under certain network conditions.
I think we can improve the power consumption by changing
the design here. I know other Radio Interfaces are subscribing
to changes in power modes and turns off the signal strength
reporting when screen is turned off. =


An Agent API for for Signal Strength would allow oFono to
subscribe to modem signal strength updates only when an Agent is
registered, and applications should register on the Agent API only
when the signal-strength information is really needed. =


Regards,
Sjur

 TODO |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index a36e9ed..50561a8 100644
--- a/TODO
+++ b/TODO
@@ -434,6 +434,14 @@ Miscellaneous
   Complexity: C1
   Owner: Aki Niemi <aki.niemi@nokia.com>
 =

+- Move the Property "Strength" in NetworkRegistration into an Agent
+  API in order to avoid frequent wakeup due to signal strength updates
+  from the modem. With an Agent API the application can register for updat=
es
+  if the strength bars are visible, and unregister when applicable (before
+  going into low-power mode).
+  Priority: Medium
+  Complexity: C1
+
 CDMA Voicecall
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.0.4


--===============0227033167940465229==--

