Content-Type: multipart/mixed; boundary="===============7347782790978729606=="
MIME-Version: 1.0
From: Holger Freyther <holger@freyther.de>
Subject: ofono plugin and state transmissions
Date: Sat, 12 Mar 2016 13:57:22 +0000
Message-ID: <loom.20160312T144416-707@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7347782790978729606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,                                                                        =
     =

                                                                           =
     =

at sysmocom we are building a BTS (OsmoBTS, OpenBSC) test setup and        =
     =

use ofono to build our testcases. We are using Sierra Wireless (former     =
     =

Wavecom) modules and have some stability issues.                           =
     =

                                                                           =
     =

I have two issues that I don't understand and they are related to the plugi=
n    =

model and after looking at others I don't find the answer.                 =
     =

                                                                           =
     =

In the beginning we used the +WIND indication and created objects. E.g.    =
     =

we created the netreg after it starts to search for networks.. but if the  =
     =

+WIND indication fro the SIM ready came either during the registration     =
     =

or before.. we would see crashes. We now mostly ignore +WIND and guess     =
     =

about it. Not all plugins create all objects and they are created at differ=
ent  =

points. So what is the best way to do it?                                  =
     =

                                                                           =
     =

One other problem is that post_sim doesn't seem to be called. After looking=
     =

at the src/modem.c file I see that it is only called for certain states. E.=
g.   =

it looks like it is only called if the modem is still in the offline state =
and  =

appears to be never called for us. Is there a way to debug it? E.g. when sh=
ould =

the modem be powered up? when the SIM has been read? When the AT command   =
     =

interpreter is ready?                                                      =
     =

                                                                           =
     =

                                                                           =
     =

kind regards                                                               =
     =

  holger                                                                   =
     =



--===============7347782790978729606==--

