Content-Type: multipart/mixed; boundary="===============7836583778576465134=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC 5/5] doc: Describe TextTelephony property
Date: Tue, 11 Jan 2011 22:00:55 -0800
Message-ID: <1294812055.3873.51.camel@aeonflux>
In-Reply-To: <1294668092-27896-6-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7836583778576465134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

>  doc/voicecall-api.txt |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
> index 4f38e6a..8df8fd2 100644
> --- a/doc/voicecall-api.txt
> +++ b/doc/voicecall-api.txt
> @@ -100,6 +100,13 @@ Properties	string LineIdentification [readonly]
>  			Notifications if a call becomes part or leaves a
>  			multipart call are sent.
>  =

> +		boolean TextTelephony [readonly]
> +
> +			Contains the indication if the voice call is a
> +			text telephony call or not.
> +
> +			Notifications if a call is a text telephony call.
> +
>  		string State [readonly]
>  =

>  			Contains the state of the current call.  The state

I am fine with actually.

Denis, any objections?

regards

Marcel



--===============7836583778576465134==--

