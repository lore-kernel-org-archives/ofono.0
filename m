Content-Type: multipart/mixed; boundary="===============2635335529261723733=="
MIME-Version: 1.0
From: Sergey Lapin <slapinid@gmail.com>
Subject: SIM900 troubles
Date: Fri, 09 Aug 2013 14:48:52 +0400
Message-ID: <1376045332.1576.5.camel@Nokia-N900>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2635335529261723733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, all!

Here we have strange problem with SIM900 modem,
which is controlled by oFono.

A problem seems to look like this:
Modem can't process incoming calls.
Operator reports it is offline.
Soon after call SMS arrives which tell us, that client is online, but calli=
ng again leads to the same results. It is not permanent condition - occasio=
nally it recovers, but after some time gets into this state again.

At the same time GPRS works perfectly,
it is able to reconnect without troubles.
Outgoing calls and SMS work too.
Incoming SMS  do have large delays.

I experimented a bit with modem settings and found the following:

if AT+CSMS=3D0 and AT+CNMI=3D2,1,2,0,0 it operates stable as long as it sta=
ys in GPRS and no SMS arrives during period when GPRS is not active.
If I see +CMT notifications, which arrive for SMS when the modem is not run=
ning GPRS, all breaks 100%. If we see only +CMTI, it might work without pro=
blems for a long time, but sometimes (far more rarely) breaks even in this =
state. The modem =

I think it does something it gets blocked for by operator, or something, I'=
m not GSM expert. Any ideas where I can investigate farther? This "block" o=
ccurs for long enough time and often enough to be major show stopper, when =
you need something more than just gprs modem...
We tried to solve this with Simcom, but had no success with it... :(

--===============2635335529261723733==--

