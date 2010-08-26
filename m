Content-Type: multipart/mixed; boundary="===============0807011403699154573=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: [PATCH v2] Add CDMA extension tasks
Date: Thu, 26 Aug 2010 03:39:42 +0200
Message-ID: <D87B22B1FE8C0F479CA9BEAD6C25AAE8056A6C4A@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <AANLkTimtk2J5vxeXhzM01jYLjhSi+6oznBkqoX5bqodW@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0807011403699154573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Jeevaka Prabu Badrappan
Sent: Wednesday, August 25, 2010 5:46 PM
To: ofono(a)ofono.org,

Subject: Re: [PATCH v2] Add CDMA extension tasks

Hi Caiwen,

---
=C2=A0TODO | =C2=A0 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++
=C2=A01 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index a97f076..b159c07 100644
--- a/TODO
+++ b/TODO
@@ -614,3 +614,79 @@ Miscellaneous

=C2=A0 Priority: Low
=C2=A0 Complexity: C4
+
+
+CDMA/EVDO
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Extend modem interface with a 'Type' property to indicate the modem type.
+
+ =C2=A0Priority: High
+ =C2=A0Complexity: C1
+
+- Add UIM support. UIM support change pin, enter pin, reset pin, set pin l=
ock, get pin lock setting,
+ =C2=A0get pin remain retry time, and get information that stored in UIM, =
include MCC/MNC, ruimid, IMSI,
+ =C2=A0MDN, PRL version etc.
+
+ =C2=A0Priority: High
+ =C2=A0Complexity: C4
+
+- Add CDMA SMS support, include broadcast short message. In CDMA, broadcas=
t short message is
+ =C2=A0a kind of SMS. CDMA SMS manager atom will support SMS sending and r=
eceiving. Many CDMA modems
+ =C2=A0may only support text mode and other modems only support PDU mode. =
In CDMA SMS manage atom will
+ =C2=A0define a data structure that contain every parameters and subparame=
ters defined in C.S0015. In
+ =C2=A0relative modem driver plug-in, the relevant fields(text mode) or PD=
U(may be manufacturer
+ =C2=A0specific) will be parsed and filled into the data structure, then i=
t will be proceed in CDMA
+ =C2=A0SMS manager atom.
+
+ =C2=A0Special SMSs, SCPT, CATPT and voice mail notification(VMN)(please r=
efer to C.S0015 section 4.3.8,
+ =C2=A04.3.9, 4.3.5)will be processed in ofono, and other messages with a =
port number (include WAP push
+ =C2=A0message) will be processed by external plug-ins. CDMA SMS manager a=
tom offer an API for register
+ =C2=A0external plug-in.
+
+ =C2=A0Priority: High
+ =C2=A0Complexity: C8
+
+- Add CDMA voice call support. CDMA voice call will support originate/end/=
hold a call,
+ =C2=A0transfer a call, 3WC(three-way calling), conference call and DTMF. =
For a voice call, can get
+ =C2=A0its status, CLI and ending result(if it is end).
+
+ =C2=A0Priority: High
+ =C2=A0Complexity: C6
+
+- Add CDMA Data connection support. CDMA data connection manager support s=
tart/end a data connect
+ =C2=A0according to the settings from other module(upper layer or ConnMan)=
and get/set Qos.
+
+ =C2=A0Priority: High
+ =C2=A0Complexity: C4
+
+- Add SIM/UIM data access support. Add a card atom, it will support read/u=
pdate/delete/add conatact
+ =C2=A0add SMS in SIM/UIM card.
+
+ =C2=A0Priority: High
+ =C2=A0Complexity: C6
+
+- Add CTCC modem driver. The CTCC modem driver will totally obey <China Te=
lecom CDMA terminal
+ =C2=A0requirement specification -- 1xEV-DORevA Data Terminal AT command I=
nterface fascicule V1.1>
+
+ =C2=A0Priority: High
+ =C2=A0Complexity: C10
+
--
1.7.0.4
=C2=A0
It looks like you are providing new dbus interface for UIM(SimManager), Dat=
aConnection(DataConnectionManager), etc...
If so, what is the need for providing a new interface, why can't we extend =
the existing SimManager, DataConnectionManager etc... to support CDMA useca=
ses.
If we provide new interfaces, there could be changes needed in upper layers=
 for eg: ConnMan.

Could you clarify?

Thanks and Regards,
jeevaka


--===============0807011403699154573==--

