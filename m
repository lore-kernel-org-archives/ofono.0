Content-Type: multipart/mixed; boundary="===============0865806017303269410=="
MIME-Version: 1.0
From: Alexander Smirnov <asmirnov@ilbers.de>
Subject: U-Blox modem reconnect
Date: Fri, 01 Jul 2016 13:22:07 +0300
Message-ID: <5776444F.6070307@ilbers.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0865806017303269410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear all,

could you please help me with the following issue. I use U-Blox =

SARA-U270 modem. I'm able to online it and connect to GPRS using both: =

connman and ofono-tests. The problem occurs when modem loses GSM link.

What I did:

  - Boot board with ofono 1.18
  - activate-context & process-context-settings
  - ifconfig shows ppp0, everything works
  - Disconnect physical GSM antenna, network strength becomes 0 (in =

list-modems)
  - Connect antenna, network strength becomes 40

Problem:

  After these steps, modem doesn't reconnect to GPRS, while =

list-contexts shows correct settings:

[ /ublox_0 ]
     [ /ublox_0/context1 ]
         Username =3D t-mobile
         AuthenticationMethod =3D chap
         Protocol =3D ip
         Name =3D Internet
         Settings =3D { Interface=3Dppp0 Netmask=3D255.255.255.255 =

Method=3Dstatic DomainNameServers=3D10.74.210.210,10.74.210.211, =

Address=3D10.23.6.118 }
         IPv6.Settings =3D { }
         Active =3D 1
         AccessPointName =3D internet.t-mobile
         Password =3D tm
         Type =3D internet

But I don't see ppp0 interface.

An attempt to activate-context doesn't do anything, just empty output =

(with enabled debugging).

Attempt to deactivate-context failed with:

Error deactivating /ublox_0/context1: =

org.freedesktop.DBus.Error.NoReply: Did not receive a reply. Possible =

causes include: the remote application did not send a reply, the message =

bus security policy blocked


The only hard modem reset helps.

Moreover, after antenna disconnect, there is no more cellular service in =

ConnMan. Only daemon restart helps.


How should I handle lose GSM network events to keep ppp0 up? Why ofonod =

hangs with the steps mentioned above?


-- =

With best regards,
Alexander Smirnov

ilbers GmbH
Baierbrunner Str. 28c
D-81379 M=C3=BCnchen
+49 (89) 122 67 24-0
http://ilbers.de/
Commercial register Munich, HRB 214197
General manager: Baurzhan Ismagulov

--===============0865806017303269410==--

