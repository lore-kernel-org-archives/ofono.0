Content-Type: multipart/mixed; boundary="===============3219965347851870853=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Why doesn't ofono match all +CGEV notification ? How can I implement
 a GPRS watchdog ?
Date: Tue, 24 Feb 2015 15:26:56 +0100
Message-ID: <54EC8A30.4070207@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3219965347851870853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I'm looking for an issue with GPRS. I have the SIMCOM5216E module with =

ofono 1.12. The problem was see in France with SFR provider. I didn't =

reproduce this with another provider and in another country... But maybe =

it's a question of uptime...

During a good period of time, my device is well connected through the =

GPRS connection. All work perfectly. In recent log, I can see the GPRS =

is reactivated several time along the weeks but the PPP is back online =

soon after.

But, few days ago, I saw the GPRS connection was unusable for 10 days. I =

saw the problem began the 12th February. According to different logs, =

the network connectivity have began to fail since the 2th February. =

Unfortunately, I couldn't get logs from ofono during the period of time =

(it's an embedded device, so the size of the log file is only 64k bytes. =

But it will be a good idea for the future to increment it ...). However, =

the device had others logs. I could see the log from our program that =

deals with ofono (it sends dbus commands and listen for dbus signals) =

and I saw there is a blank period from the 2th to the 12th. It's like =

ofono or the module was dead.

So, I begin to read the code, especially the simcom driver, to see if I =

miss something. And I see something weird.

According to the SIMCOM AT document, the +CGEV notification can be send =

with this list of event:

  REJECT
  NW REACT
  NW DEACT
  ME DEACT
  NW DETACH
  ME DETACH
  NW CLASS
  ME CLASS

But in gprs-context.c, I see we deal only with the "NW DETACH" event. =

Maybe It's the point. Maybe the modem send to ofono an another event and =

therefore ofono begins to be in incorrect state about the GPRS =

connection... Is it possible ?

Otherwise, I'm thinking about implement a GPRS watchdog. Does it exist =

an AT command which could do that ? My idea is to send an AT command =

each XX period of time and check the GPRS connection is really here.

Regards,
Anthony Viallard.

-- =

-----------------------------------------
Viallard Anthony    (+41 024 455 24 82)
[ Embedded System | Software Designer ]
-----------------------------------------
   Syscom Instruments SA
   Rue de l'industrie 21
   1450     Sainte-Croix
-----------------------------------------

--===============3219965347851870853==--

