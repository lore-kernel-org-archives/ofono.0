Content-Type: multipart/mixed; boundary="===============5895076960460086073=="
MIME-Version: 1.0
From: Tikander Petteri <petteri.tikander@ixonos.com>
Subject: TODO: Network updating the emergency number list
Date: Fri, 17 Dec 2010 11:10:39 +0200
Message-ID: <1292577039.29886.56.camel@r82e1wc.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5895076960460086073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I have investigated a little bit dynamic updating of emergency numbers
by network. So I suggest, I'll register new notification-handler for
'+CEN'-report in voicecall-driver. And naturally give those new
emergency-numbers for voicecall-atom to be analyzed.

First version of network-ECC handling will enable +CEN-reporting
statically in driver-probing. Then it listens '+CEN'-reports and after
receiving new numbers compares those numbers with already stored numbers
(SIM/default ECC's) and sends property-changed signal for same old good
EmergencyNumbers-property, if new emergency numbers have been received
from the network.

According to TS.27007 network emergency numbers are not necessarily
received from the same operator as currently registered, so this should
probably also be considered in the future.

My test-modem doesn't actually support '+CEN'-reports, but I can update
a little bit Phonesim for simulating of testing the unsolicited network
emergency-numbers.

Br, Petteri

-- See us at Mobile World Congress, 14-17 February 2011, in Barcelona, Spai=
n. Visit the Ixonos booth Hall 1, # 1E19.


--===============5895076960460086073==--

