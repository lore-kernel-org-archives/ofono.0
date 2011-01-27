Content-Type: multipart/mixed; boundary="===============6720787200154760819=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] voicecallmanager-api: call related SS signals (proposal)
Date: Thu, 27 Jan 2011 14:07:37 +0100
Message-ID: <1296133657.1520.145.camel@aeonflux>
In-Reply-To: <e514ceea10c7e8eb0f8d556e9764ea4e0c9abe04.1296122953.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6720787200154760819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

> Here is a proposal for expanding VoiceCallManager's DBus interface with =

> call related Supplementary Services signals.
> The implementation would be based on the functionality provided by the SSN
> atom (handling the CSSU codes). =

> =

> ---
>  doc/voicecallmanager-api.txt |   54 ++++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 53 insertions(+), 1 deletions(-)
> =

> diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
> index 2bf9ded..5212eac 100644
> --- a/doc/voicecallmanager-api.txt
> +++ b/doc/voicecallmanager-api.txt
> @@ -123,7 +123,59 @@ Methods		dict GetProperties()
>  			'*', '#', 'A', 'B', 'C', 'D'.  The last four are
>  			typically not used in normal circumstances.
>  =

> -Signals		CallAdded(object path, dict properties)
> +Signals		CallForwarded(object path)
> +
> +			Signal sent during call setup when the incoming call is
> +			a forwarded call. The signal contains the object path of
> +			the call in cause.

I don't like this even a single bit. We changed the voice call API
exactly this way to avoid any potential race conditions between calls
and their properties. So please leave this as CallAdded() with the
object path and its properties.

Also having to watch more than three signals for call handling is a bit
overboard. This will cause a lot of extra traffic during setup towards
the D-Bus daemon. Pretty much a bad idea.

Regards

Marcel



--===============6720787200154760819==--

