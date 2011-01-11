Content-Type: multipart/mixed; boundary="===============1729308787173053017=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: Discussion on CTM enhancement 
Date: Tue, 11 Jan 2011 21:26:25 +0000
Message-ID: <C50CA21D80D6B74F80FB941E215DF4140D3CCF@008-AM1MPN1-002.mgdnok.nokia.com>
In-Reply-To: <8250E4885F9967469CAC3FB5CBA2CE69934E645C02@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1729308787173053017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 22 Dec 2010, Predon, Frederic wrote:
> 1) First, it might a good proposal to merge the TextTelephony and the
> AudioSettings atoms. Enabling and disabling CTM on a platform require
> to configure the audio settings on the modem side (audio routing
> parameters changes). Today, in my patches, I have nearly the same code

this area is slightly confusing as there are many atoms related
to calls (e.g org.ofono.CallVolume, AudioSettings, CallSettings).

The AudioSettings is AFAIK meant for modems where the audio is =

routed to/from the host (e.g. N900/isimodem or ifxmodem), and to
me it would be a good idea to keep it clean (only features that affect
modems of this type). =


Controlling TTY/CTM applies to all kinds of modems, independently
of how they manage (or don't manage audio), so that to me hints
that the TextTelephony should be a separate atom.

Of course if the CTM implementation needs cooperation with =

the host audio stack (in case host is involved in the audio path), =

then CTM support will impact other atoms as well (AudioSettings in
case of ifxmodem).

> 2) Secondly, I think that 2 properties can be added in the
> TextTelephony atom and/or the AudioSetting atom (or the "merged" atom
> described in 1). The first property is when the device receives an
> incoming CTM call. Even if the type is still a voice call, upper layers

Now continuing the above reasoning, I'd say this should go to =

TextTelephony as modems not implementing AudioSettings can
still implement this, and this property is useful to show in the UI
despite the audio implementation details.

But as the ifxmodem interface is per-call (I guess this maps to the CTM
bearer capability flag in SETUP and its replies), this could
perhaps be a property of org.ofono.VoiceCall as well.

> The second property is for MO calls. Remote user can accept the call as
> a TTY enable device or not. This is supported by the standard. In our

So same for this (either to TextTelephony, or perhaps also a property of =

voicecalls).


--===============1729308787173053017==--

