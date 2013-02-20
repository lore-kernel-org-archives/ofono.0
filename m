Content-Type: multipart/mixed; boundary="===============3054145150865163066=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] doc: Add experimental handsfree-audio API
Date: Wed, 20 Feb 2013 09:45:04 -0600
Message-ID: <5124EF80.2060606@gmail.com>
In-Reply-To: <CANT-zCWRxEiYLNV07fsm6xfV8s+kDHE9dsgxrq8SmxOamLWzgQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3054145150865163066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

> However, I still see some value in having a more coupled relation
> between modems and audio-cards, beyond the RemoteAddress/LocalAddress
> pair. This is specially interesting for the HS role, since otherwise
> both modems and audio-cards need to be tracked and matched.
>
> The two roles might actually need to be separated. After all, there
> are some fundamental differences: audio-cards representing a remote
> gateway would be statically associated to a modem. Actually the modem
> *represents* this device, so signals such as CardAdded/CardRemoved
> provide little value.
>

This API is meant specifically for PA or another Audio subsystem.  What =

you want to be tracking and cross-referencing I'm not quite sure of.

> On the other hand, audio-cards representing remote headsets are more
> dynamic: they come and go depending on the number of paired headsets
> (or more likely, the connected ones - it's not clear what "attached"
> means in the doc).

In practice, attached means an established SLC connection.

>
> One possibility would be to register HandsfreeAudioCard in the modem
> object path for the HS role (as I proposed before) and dynamically
> register the necessary objects for the AG role. In the later case, the
> connected headsets could be announced as in Denis' original proposal
> (perhaps renamed to HeadsetAdded/HeadsetRemoved).
>

Perhaps, but why would you be using this API and not one from PA?

> The ability to distinguish HS and AG roles in the client's side is
> desirable (at least PulseAudio heavily depends on this information).
> So even if the proposal above is not accepted, at least the role
> (UUID) would have to be exposed somehow.
>

The type information was left out on purpose from this proposal.  Likely =

it is necessary, but for the initial phase it does not seem relevant.  I =

also have yet to hear concise and clear summary on the utility of =

providing this information.

>>> If so, I have some concerns about the potential race conditions. If
>>> SCO was closed and reopen immediately afterwards, the client could
>>> receive the (second) NewConnection before the HUP.
>>>

You are going over-the-air vs local machine.  I really do not see this =

ever happening.  But even if it does, is this really a hard problem for =

the Agent to deal with?

Regards,
-Denis

--===============3054145150865163066==--

