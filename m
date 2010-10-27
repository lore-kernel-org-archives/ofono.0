Content-Type: multipart/mixed; boundary="===============5811688839635324408=="
MIME-Version: 1.0
From: Zhang Caiwen <caiwen.zhang@windriver.com>
Subject: [PATCH] Add CDMA/EVDO tasks in TODO
Date: Wed, 27 Oct 2010 19:16:35 +0800
Message-ID: <1288178195-16493-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5811688839635324408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 239bab0..efb2bff 100644
--- a/TODO
+++ b/TODO
@@ -543,3 +543,60 @@ Miscellaneous
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
+  automaticlly. Unlike GSM,it don't support manually register to network.S=
o its
+  mainly function is to get CDMA network information. The information incl=
ude:
+  registration status, service domain, CDMA 1x signal strength, HDR signal
+  strength, MCC, MNC, SID, NID etc.
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
+  Complexity: C6
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
+- Add SIM/UIM data access support. Add a card atom, it will support read/u=
pdate/
+  delete/add conatact add SMS in SIM/UIM card.
+
+  Priority: High
+  Complexity: C6
+
-- =

1.7.0.4


--===============5811688839635324408==--

