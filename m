Content-Type: multipart/mixed; boundary="===============5794909422520766772=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject: [RFC] [PATCH 0/2] HFP AG integration with PulseAudio
Date: Fri, 29 Jan 2010 12:44:24 -0200
Message-ID: <1264776266-7646-1-git-send-email-jprvita@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5794909422520766772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm trying to add support for the Handsfree Gateway role Gustavo just added
to BlueZ and oFono. The BlueZ patches can be found on [1] and [2] and the
oFono part was just merged upstream.

But when it comes to integrate them with Pulse, I'm getting a POLLHUP when
trying to write on the fd. Also, it seems different gateways have different
behaviours regarding when they connect the SCO link. Some phone connect
them just after the RFCOMM link (some Nokia phones), when there is no call
going on yet, and others just when a call is started (Android 1.5).

Also, right now the same property (State) is beeing used to refer when the
RFCOOM link is established (State=3DConnected) and when the SCO link is
established (State=3DPlaying). Shouldn't this be handled by separate props?

And last but not least, is the new Media API intended to handle the audio
part of handsfree gateways too? If so, maybe we should use all this work
as a prototype for latter integration with the new API.

Any help on testing and getting this working together or comments on the
topic would be appreciated.

[1] http://www.spinics.net/lists/linux-bluetooth/msg04250.html
[2] http://www.spinics.net/lists/linux-bluetooth/msg04251.html

--
Jo=C3=A3o Paulo Rechi Vita
http://jprvita.wordpress.com/


--===============5794909422520766772==--

