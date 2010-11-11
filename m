Content-Type: multipart/mixed; boundary="===============3452548686914058756=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] voicecall: Add EmergencyCall property.
Date: Fri, 12 Nov 2010 00:15:16 +0900
Message-ID: <1289488516.3266.61.camel@aeonflux>
In-Reply-To: <1289488333-1481-1-git-send-email-john.mathew@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3452548686914058756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi John,

>  doc/voicecall-api.txt |    4 ++++
>  src/voicecall.c       |   34 +++++++++++++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 1 deletions(-)
> =

> diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
> index f0ba316..60c692c 100644
> --- a/doc/voicecall-api.txt
> +++ b/doc/voicecall-api.txt
> @@ -125,3 +125,7 @@ Properties	string LineIdentification [readonly]
>  =

>  			Icon identifier to be used instead of or together
>  			with the text information.
> +
> +		boolean EmergencyCall [readonly]
> +
> +			Contains the indication if the voice call is emergency call or not.

do we really wanna call this EmergencyCall instead of just Emergency? In
theory the "call" is already in the interface name.

Regards

Marcel



--===============3452548686914058756==--

