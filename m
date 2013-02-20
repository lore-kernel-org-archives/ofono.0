Content-Type: multipart/mixed; boundary="===============5673523886004055565=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: Re: [PATCH] doc: Add experimental handsfree-audio API
Date: Wed, 20 Feb 2013 09:55:33 +0100
Message-ID: <CANT-zCXA0E-5MOu-KWu9HL=8e3BrPRavufd3cM3mY_-u3jaKvA@mail.gmail.com>
In-Reply-To: <1361347442-4350-1-git-send-email-mikel.astiz.oss@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5673523886004055565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, Feb 20, 2013 at 9:04 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> =
wrote:
> From: Denis Kenzior <denkenz@gmail.com>
>
> ---
> Either I have a problem with my subscription or this patch was never subm=
itted to the mailing-list.
>
> Not only it helps follow Claudio's patchset, but it's in general worth di=
scussion such API publicly.
>  doc/handsfree-audio-api.txt | 96 +++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 doc/handsfree-audio-api.txt
>
> diff --git a/doc/handsfree-audio-api.txt b/doc/handsfree-audio-api.txt
> new file mode 100644
> index 0000000..78ba9e1
> --- /dev/null
> +++ b/doc/handsfree-audio-api.txt
> @@ -0,0 +1,96 @@
> +Handsfree Audio Manager hierarchy [experimental]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service                org.ofono
> +Interface      org.ofono.HandsfreeAudioManager
> +Object path    /
> +
> +Methods                array{object,dict} GetCards()
> +
> +                       Get an array of card objects and properties
> +                       that represent the currently attached devices.
> +
> +                       This method call should only be used once when an
> +                       application starts up. Further device additions
> +                       and removal shall be monitored via CardAdded and
> +                       CardRemoved signals.
> +
> +               void Register(object path, array{byte})
> +
> +                       Registers a Handsfree Audio agent with a specific
> +                       path (freely selectable by the audio subsystem) a=
nd
> +                       list of supported codecs.  Available codec
> +                       identifiers:
> +
> +                               1       CVSD
> +                               2       mSBC
> +
> +               void Unregister(object path)
> +
> +                       Unregisters a Handsfree Audio agent registered
> +                       through the Register method.
> +
> +Signals                CardAdded(object path, dict properties)
> +
> +                       Signal that is sent when a new card is added.  It
> +                       contains the object path of new card and its
> +                       properties.
> +
> +               CardRemoved(object path)
> +
> +                       Signal that is sent when a card has been removed.
> +                       The object path is no longer accessible after this
> +                       signal and only emitted for reference.
> +
> +
> +Handsfree Audio Card hierarchy [experimental]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +Service                org.ofono
> +Interface      org.ofono.HandsfreeAudioCard
> +Object path    /{device0,device1,...}

I'd propose dropping this interface entirely or at least using the
conventional modem object path, assuming that every HandsfreeAudioCard
would necessarily have an associated modem.

After all, the Audio agent would typically have to match cards with
modems, probably because the associated voicecall status needs to be
known (e.g. if the HS wants to ignore the inband-ringing and instead
use another ring tone).

> +
> +Methods                dict GetProperties()
> +
> +                       Returns properties for the device object. See
> +                       the properties section for available properties.
> +
> +               void Connect()
> +
> +                       Attempts to establish the SCO audio connection.
> +                       The Agent NewConnection() method will be called
> +                       whenever the SCO audio link has been established.=
  If
> +                       the audio connection could not be established, th=
is
> +                       method will return an error.

Isn't Disconnect() missing here? How would the agent release an SCO?

This method (along with Disconnect(), if needed) could be moved to
org.ofono.HandsfreeAudioManager, dropping HandsfreeAudioCard entirely.

Or alternatively, if you think the interface is actually important,
I'd be in favor of registering it in the same modem object path,
avoiding the CardAdded/CardRemoved signals.

> +
> +Signals                PropertyChanged(string name, variant value)
> +
> +                       This signal indicates a changed value of the given
> +                       property.
> +
> +Properties     string RemoteAddress [readonly]
> +
> +                       Bluetooth address of the remote peer.
> +
> +               string LocalAddress [readonly]
> +
> +                       Bluetooth address of the local adapter.
> +
> +
> +Handsfree Audio Agent hierarchy [experimental]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +Service                <freely defined>
> +Interface      org.ofono.HandsfreeAudioAgent
> +Object         <freely defined>
> +
> +Methods                void NewConnection(object card, fd sco, byte code=
c)
> +
> +                       Notifies the handler that a new SCO connection is
> +                       available. Returning an error will cause oFono to
> +                       disconnect the SCO connection.

Same here. How would the agent receive a release-notification? Perhaps
this would be implicit in the socket HUP?

If so, I have some concerns about the potential race conditions. If
SCO was closed and reopen immediately afterwards, the client could
receive the (second) NewConnection before the HUP.

Besides, is this D-Bus API intended to support SCO-over-PCM as well?
If yes, several considerations seems to be missing, specially
regarding the socket fd. In particular, the HUP approach for
disconnections would not be valid anymore.

> +
> +               void Release()
> +
> +                       Notifies the Agent that it is no longer registered
> +                       to oFono.
> --
> 1.8.1
>

Cheers,
Mikel

--===============5673523886004055565==--

