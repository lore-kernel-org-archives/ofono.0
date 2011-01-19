Content-Type: multipart/mixed; boundary="===============4401123680966964558=="
MIME-Version: 1.0
From: Rolf Offermanns <roffermanns@sysgo.com>
Subject: DUN client questions
Date: Wed, 19 Jan 2011 11:00:05 +0100
Message-ID: <4D36B625.6000009@sysgo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4401123680966964558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

I have applied Gustavos patches from 09/11/2010 to the current git
version of ofono and besides a problem with the cid range (min =3D max =3D
2, but my mobile (Nokia N82) only has one context) I was able to get a
connection until the point where the ip and the dns addresses where
written to the log file. So far so good (I guess).

I am not too far into the code right know, so the following questions
maybe stupid. Please bear with me, I appreciate any help.


I am using MeeGo 1.1 with updated ofono, connman and carrick packages
(all from git).

Here is what I did to get the DUN connection up:

1. Connect the mobile using the bluetooth applet in MeeGo
   -> The modem was recognized as DUN capable and shows up in the
      "list-modems" output from ofonos test script as "/dun/xxx_yyy"
2. Then using the ofono test scripts: enable_modem,
create-internet-context, activate-context

Questions:
- How to proceed from here. What is missing to have the context show up
in the meego-network-panel?

- From my understanding a DUN modem looks very much like the USB 3G
modem. The AT commands look similar (if not identical). Why is it
necessary to have another modem type for this? Can't the atmodem driver
be used for DUN, too?

Thanks,
Rolf

--===============4401123680966964558==--

