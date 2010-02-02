Content-Type: multipart/mixed; boundary="===============6210934749750111195=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [RFC] [PATCH 0/2] HFP AG integration with PulseAudio
Date: Tue, 02 Feb 2010 09:03:57 -0800
Message-ID: <2d5a2c101002020903p19f78ddbxef5aaf6bb6096433@mail.gmail.com>
In-Reply-To: <1264776266-7646-1-git-send-email-jprvita@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6210934749750111195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

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

Yep, Media API is supposed to handle this, that why I asked them to be
though in an integrated manner maybe being registered in the same
interface (although hfp is not really media only), anyway basically we
should have pa acting as a2dp source/sink and/or hfp gateway/headset
endpoint handling the audio. So in essence ofono is acting as a
controller/target in a very similar way as avrcp does for a2dp,
although for avrcp we don't really need an agent as we use uinput.

> Any help on testing and getting this working together or comments on the
> topic would be appreciated.

There is already some code in my git tree:
http://gitorious.org/~vudentz/bluez/vudentzs-clone/commits/for-upstream

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=C3=A7=C3=A3o

--===============6210934749750111195==--

