Content-Type: multipart/mixed; boundary="===============4448470600046710517=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject: Re: [RFC] [PATCH 0/2] HFP AG integration with PulseAudio
Date: Mon, 01 Feb 2010 15:09:36 -0200
Message-ID: <aa32413d1002010909h1ba06e13n1511d56903406945@mail.gmail.com>
In-Reply-To: <1264776266-7646-1-git-send-email-jprvita@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4448470600046710517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/1/29 Jo=C3=A3o Paulo Rechi Vita <jprvita@gmail.com>:
> Hi all,
>
> I'm trying to add support for the Handsfree Gateway role Gustavo just add=
ed
> to BlueZ and oFono. The BlueZ patches can be found on [1] and [2] and the
> oFono part was just merged upstream.
>
> But when it comes to integrate them with Pulse, I'm getting a POLLHUP when
> trying to write on the fd. Also, it seems different gateways have differe=
nt
> behaviours regarding when they connect the SCO link. Some phone connect
> them just after the RFCOMM link (some Nokia phones), when there is no call
> going on yet, and others just when a call is started (Android 1.5).
>
> Also, right now the same property (State) is beeing used to refer when the
> RFCOOM link is established (State=3DConnected) and when the SCO link is
> established (State=3DPlaying). Shouldn't this be handled by separate prop=
s?
>
> And last but not least, is the new Media API intended to handle the audio
> part of handsfree gateways too? If so, maybe we should use all this work
> as a prototype for latter integration with the new API.
>
> Any help on testing and getting this working together or comments on the
> topic would be appreciated.
>
> [1] http://www.spinics.net/lists/linux-bluetooth/msg04250.html
> [2] http://www.spinics.net/lists/linux-bluetooth/msg04251.html
>
> --
> Jo=C3=A3o Paulo Rechi Vita
> http://jprvita.wordpress.com/
>
>

Just updating, this patch actually worked when testing with a
different adapter (Fujitsu-Siemens CSR-based). The adapter causing
problems was a Broadcom 2.1, the internal adapter of a Dell Mini10.
Also, suspending the source / sink actually doesn't interfere.

I did a small video of the whole stuff: http://www.vimeo.com/9078799

There are still some problems when testing against Nokia N900 and
2660. After the "enable-modem" step, the RFCOMM link is connected and
the SCO just after that, leading module-bluetooth-discover to load
module-bluetooth-device. Sometimes after that the polling on the
stream fd get a POLLHUP and the module-bluetooth-device unloads
itself. Other times the POLLHUP doesn't happen and the remaining steps
go without any problem.

Ideas on how to improve this scenario will be very helpful.

-- =

Jo=C3=A3o Paulo Rechi Vita
http://jprvita.wordpress.com/

--===============4448470600046710517==--

