Content-Type: multipart/mixed; boundary="===============2305182763665374727=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH v2] Add CDMA extension tasks
Date: Tue, 24 Aug 2010 18:42:21 +0800
Message-ID: <1282646541-1655-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2305182763665374727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index a97f076..b159c07 100644
--- a/TODO
+++ b/TODO
@@ -614,3 +614,79 @@ Miscellaneous
 =

   Priority: Low
   Complexity: C4
+
+
+CDMA/EVDO
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Extend modem interface with a 'Type' property to indicate the modem type.
+
+  Priority: High
+  Complexity: C1
+
+- Add CDMA call settings support, include:
+  Call forwarding(include busy, no answer, default and unconditional situa=
tion),
+  Calling Number Identification Presentation(CNIP), Calling Number Identif=
ication
+  Restriction(CNIR), Do Not Disturb(DND), Call Delivery(CD), Call Waiting(=
CW),
+  Voice Privacy(VP) etc.
+
+  All these services except VP are achieved through similar way: get relev=
ant feature code
+   -> compose dialing string -> originate a voice call.
+
+  Priority: High
+  Complexity: C2
+
+- Extend radio setting, add CDMA radio access technology support. The CDMA=
 modem preferred
+  technology can be CDMA, HDR or CDMA/HDR hybrid.
+
+  Priority: Medium
+  Complexity: C1
+
+- Add UIM support. UIM support change pin, enter pin, reset pin, set pin l=
ock, get pin lock setting,
+  get pin remain retry time, and get information that stored in UIM, inclu=
de MCC/MNC, ruimid, IMSI,
+  MDN, PRL version etc.
+
+  Priority: High
+  Complexity: C4
+
+- Add CDMA SMS support, include broadcast short message. In CDMA, broadcas=
t short message is
+  a kind of SMS. CDMA SMS manager atom will support SMS sending and receiv=
ing. Many CDMA modems
+  may only support text mode and other modems only support PDU mode. In CD=
MA SMS manage atom will
+  define a data structure that contain every parameters and subparameters =
defined in C.S0015. In
+  relative modem driver plug-in, the relevant fields(text mode) or PDU(may=
 be manufacturer
+  specific) will be parsed and filled into the data structure, then it wil=
l be proceed in CDMA
+  SMS manager atom.
+
+  Special SMSs, SCPT, CATPT and voice mail notification(VMN)(please refer =
to C.S0015 section 4.3.8,
+  4.3.9, 4.3.5)will be processed in ofono, and other messages with a port =
number (include WAP push
+  message) will be processed by external plug-ins. CDMA SMS manager atom o=
ffer an API for register
+  external plug-in.
+
+  Priority: High
+  Complexity: C8
+
+- Add CDMA voice call support. CDMA voice call will support originate/end/=
hold a call,
+  transfer a call, 3WC(three-way calling), conference call and DTMF. For a=
 voice call, can get
+  its status, CLI and ending result(if it is end).
+
+  Priority: High
+  Complexity: C6
+
+- Add CDMA Data connection support. CDMA data connection manager support s=
tart/end a data connect
+  according to the settings from other module(upper layer or ConnMan)and g=
et/set Qos.
+
+  Priority: High
+  Complexity: C4
+
+- Add SIM/UIM data access support. Add a card atom, it will support read/u=
pdate/delete/add conatact
+  add SMS in SIM/UIM card.
+
+  Priority: High
+  Complexity: C6
+
+- Add CTCC modem driver. The CTCC modem driver will totally obey <China Te=
lecom CDMA terminal
+  requirement specification -- 1xEV-DORevA Data Terminal AT command Interf=
ace fascicule V1.1>
+
+  Priority: High
+  Complexity: C10
+
-- =

1.7.0.4


--===============2305182763665374727==--

