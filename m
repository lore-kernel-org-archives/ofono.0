Content-Type: multipart/mixed; boundary="===============0425091540249058830=="
MIME-Version: 1.0
From: Bassem BOUBAKER <bassem.boubaker@actia.fr>
Subject: Problem with ofono communicating on ttyACM
Date: Fri, 03 Nov 2017 17:29:20 +0000
Message-ID: <AM4PR01MB1873B168D0FC89F6020ACD589C5D0@AM4PR01MB1873.eurprd01.prod.exchangelabs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0425091540249058830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm facing an issue with ofono sending/getting back an AT command result co=
rrectly. In fact, when passing to my plugin enable function I sent a first =
AT command.

This issue is this: I open the  ttyACM communication with the correct optio=
ns in ofono but the command response is not correctly returned (maybe not c=
orrectly sent?). Here is a log example of ofono log:

Nov 03 17:13:56 ofonod[492]: App> ATE0\r
Nov 03 17:14:02 ofonod[492]: App< ATE
Nov 03 17:14:02 ofonod[492]: App< 0\r\n

The command should have an OK as a result. My modem state is good as I'm ab=
le to test the return of this command using microcom.=C2=A0

Does anyone have a clue about what could be the issue here?

Regards,
Bassem.








--===============0425091540249058830==--

