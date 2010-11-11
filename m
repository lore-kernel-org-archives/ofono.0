Content-Type: multipart/mixed; boundary="===============4104171967673548147=="
MIME-Version: 1.0
From: John.Mathew@elektrobit.com
Subject: RE: [PATCH] voicecall: Add EmergencyCall property.
Date: Thu, 11 Nov 2010 17:18:31 +0200
Message-ID: <FE1DB9979BF5A743BEB836613423CAD80124E5F9@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1289488516.3266.61.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4104171967673548147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Will change the property name to Emergency and resend the patch.

Regards,
John =


-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behalf
Of Marcel Holtmann
Sent: 11 November 2010 17:15
To: ofono(a)ofono.org
Subject: Re: [PATCH] voicecall: Add EmergencyCall property.

Hi John,

>  doc/voicecall-api.txt |    4 ++++
>  src/voicecall.c       |   34 +++++++++++++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 1 deletions(-)
> =

> diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt index =

> f0ba316..60c692c 100644
> --- a/doc/voicecall-api.txt
> +++ b/doc/voicecall-api.txt
> @@ -125,3 +125,7 @@ Properties	string LineIdentification
[readonly]
>  =

>  			Icon identifier to be used instead of or
together
>  			with the text information.
> +
> +		boolean EmergencyCall [readonly]
> +
> +			Contains the indication if the voice call is
emergency call or not.

do we really wanna call this EmergencyCall instead of just Emergency? In
theory the "call" is already in the interface name.

Regards

Marcel


_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono

--===============4104171967673548147==--

