Content-Type: multipart/mixed; boundary="===============7107709779871353787=="
MIME-Version: 1.0
From: Zhang Caiwen <caiwen.zhang@windriver.com>
Subject: [PATCH v2] Add CDMA/EVDO tasks in TODO
Date: Thu, 28 Oct 2010 09:12:38 +0800
Message-ID: <1288228358-17225-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7107709779871353787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 239bab0..e368070 100644
--- a/TODO
+++ b/TODO
@@ -543,3 +543,55 @@ Miscellaneous
 =

   Priority: Low
   Complexity: C4
+
+
+CDMA/EVDO
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Extend modem interface with a 'Mode' property to indicate the modem type.
+
+  Priority: High
+  Complexity: C1
+
+- Extend radio setting,add CDMA radio access technology support. The CDMA =
modem
+  preferred technology can be CDMA, HDR or CDMA/HDR hybrid.
+
+  Priority: Medium
+  Complexity: C1
+  Owner: Zhang Caiwen <caiwen.zhang@windriver.com>
+
+- Add CDMA Network registration support. CDMA device will register to netw=
ork
+  automaticlly. Unlike GSM,generally,it don't support manually register to
+  network.So its mainly function is to get CDMA network information. The
+  information include: registration status, service domain, CDMA 1x signal
+  strength, HDR signal strength, MCC, MNC, SID, NID etc.
+
+  Priority: Medium
+  Complexity: C1
+  Owner: Zhang Caiwen <caiwen.zhang@windriver.com>
+
+- Add UIM support. UIM support change pin, enter pin, reset pin, set pin l=
ock,
+  get pin lock setting, get pin remain retry time, and get information that
+  stored in UIM, include MCC/MNC, ruimid, IMSI,MDN, PRL version etc.
+
+  Priority: High
+  Complexity: C4
+  Owner: Zhang Caiwen <caiwen.zhang@windriver.com>
+
+- Add CDMA voice call support. CDMA voice call will support originate/end/=
hold
+  a call,transfer a call, 3WC(three-way calling), conference call and DTMF=
. For
+  a voice call, can get its status, CLI and ending result(if it is end).
+
+  Priority: High
+  Complexity: C8
+  Owner: Zhang Zhengguang <zhengguang.Zhang@windriver.com>
+
+- Add CDMA Data connection support. CDMA data connection manager support
+  start/end a data connect according to the settings from other module(upp=
er
+  layer or ConnMan).
+
+  Priority: High
+  Complexity: C4
+  Owner: Zhang Caiwen <caiwen.zhang@windriver.com>
+
+
-- =

1.7.0.4


--===============7107709779871353787==--

