Content-Type: multipart/mixed; boundary="===============3832805521611515859=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] doc: Fix documentation for HFP memory dialling
Date: Wed, 07 Mar 2018 22:20:23 +0100
Message-ID: <F3D6A125-DA28-4C9A-9C8D-12ED20B13A2C@holtmann.org>
In-Reply-To: <20180307211814.30527-2-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3832805521611515859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> Signed-off-by: Philippe De Swert <philippedeswert@gmail.com>

No signed-off-by please.

> ---
> doc/voicecallmanager-api.txt | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
> index 5c4ce11b..96492ced 100644
> --- a/doc/voicecallmanager-api.txt
> +++ b/doc/voicecallmanager-api.txt
> @@ -69,10 +69,10 @@ Methods		dict GetProperties()
> 					 [service].Error.NotImplemented
> 					 [service].Error.Failed
> =

> -		object DialMemory(string memory position, string hide_callerid)
> +		object DialMemory(unsigned int memory position)

And there is no unsigned int in D-Bus.

Regards

Marcel


--===============3832805521611515859==--

