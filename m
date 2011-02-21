Content-Type: multipart/mixed; boundary="===============2733982642702286245=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: gatchat looses UR code if received while waiting a response
Date: Mon, 21 Feb 2011 11:38:34 +0200
Message-ID: <1298281114.18611.53.camel@lkunnasl-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2733982642702286245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I've seen an issue in Unsolicited Result code handling in gatchat. If
ofono has sent an AT command and is waiting for a response, but modem
has sent an UR code just before the AT command reached the modem,
gatchat does not handle that UR code correctly (it drops it). =


27.007 does not restrict UR-sending in the time between AT command and
sending final response.

Even modem would not send an UR while an active AT command, this may
happen as a command may be on its way to ofono (e.g. in kernel).

Real example of this happening:
ofonod[1388]: Default: > AT+CGMM\r                  =

ofonod[1388]: Default: < \r
\n*STKI:"D027810301258082028182850A5361756E616C616874698F09013E507265706169=
641801241F020103"\r\n =

ofonod[1388]: Default: < \r\nST-Ericsson Mobile Broadband\r\n\r\nOK\r
\n  =


In this case the call back of *STKI was never called.

This is not a modem issue as it has been verified the modem has sent
*STKI before AT+CGMM was received.

One way to solve this is to change the sequence in gatchat.c/have_line()
a bit and check first if this is UR code and then proceeding to response
handling. Would this be acceptable solution for this issue or would it
cause some drawbacks? If it is okay I can submit a patch

BR,
-Lasse


--===============2733982642702286245==--

