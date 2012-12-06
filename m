Content-Type: multipart/mixed; boundary="===============2977672151759006867=="
MIME-Version: 1.0
From: Ming Li Wu <mingli@southpole.se>
Subject: Telit HE910: CMER command problem
Date: Thu, 06 Dec 2012 16:23:42 +0100
Message-ID: <50C0B87E.2090702@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2977672151759006867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I am using Telit HE910 modem,

After sending AT+CMER=3D3,0,0,2 I always got "sim card is busy".

The followoing is the part of log:
ofonod[446]: Aux: > AT+CMER=3D3,0,0,2\r
ofonod[446]: Aux: < \r\n+CME ERROR: 14\r\n
ofonod[446]: +CMER not supported by this modem.  If this is an error =

please submit patches to support this hardware

My question is :
How important is this command.?
I mean what the worst consequence will be if I just ignore this error =

message,

Thanks!


Mingli

--===============2977672151759006867==--

