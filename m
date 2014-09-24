Content-Type: multipart/mixed; boundary="===============7826536631210687001=="
MIME-Version: 1.0
From: Stephan Schmolke <stephan.schmolke@googlemail.com>
Subject: Problem with oFono on pandaboard
Date: Wed, 24 Sep 2014 12:58:25 +0200
Message-ID: <5422A3D1.9000807@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7826536631210687001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear oFono-Team,

I have issues using oFono on my PandaBoard running ubuntu. I had to =

compile ofono from source, because I needed the bluez4 plugin =

(configure-option --enable-bluez4) and got it running on my x86 machine =

running ubuntu 13. My Programm is working fine on it.
After Setting it up the same way on the pandaboard and checking D-Bus =

debug Messages related to oFono I figured that directly after the =

ModemAdded Signal, and getting the Modems properties the ModemRemoved =

Signal ist send. I think that might be the reason, why my Programm does =

not work. After that Signal, invoking methods on the modem Interface =

will not work anymore and time out. What could be the reason that the =

modem is almost instantly removed again?

I also have another question: For my iPhone 5s there are not all =

Interfaces available. Is this because the iPhone/modem for it does not =

support them oder are there some Options for configuration, so they are =

available.

Can you help me or give me contact to somebody who might?
Aside from the first problem I am really fond of the oFono Service.

Best Regards,
Stephan Schmolke

--===============7826536631210687001==--

