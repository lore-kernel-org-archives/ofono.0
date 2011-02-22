Content-Type: multipart/mixed; boundary="===============4619831334403747277=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: [RFC] doc: Add support for CMAS/EU-Alert
Date: Mon, 21 Feb 2011 16:55:18 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC70304D53F@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <1298308697-4144-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4619831334403747277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeeva,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] =

> Sent: 21 February 2011 09:18
> To: ofono(a)ofono.org
> Subject: [RFC] doc: Add support for CMAS/EU-Alert
> =

> ---
>  doc/cell-broadcast-api.txt |   26 +++++++++++++++++---------
>  1 files changed, 17 insertions(+), 9 deletions(-)
> =

> diff --git a/doc/cell-broadcast-api.txt =

> b/doc/cell-broadcast-api.txt index 52618eb..71b2516 100644
> --- a/doc/cell-broadcast-api.txt
> +++ b/doc/cell-broadcast-api.txt
> @@ -36,19 +36,27 @@ Signals		PropertyChanged(string =

> name, variant value)
>  			Please note that base station name =

> broadcasts are
>  			handled by the NetworkRegistration interface.
>  =

> -		EmergencyBroadcast(string text, dict properties)
> +		WarningSystemBroadcast(string text, dict properties)
>  =

> -			This signal is emitted whenever an ETWS =

> cell broadcast
> -			is received.  The string text contains =

> contents of the
> -			broadcast.  The dict is made up of the following
> -			entries:
> -				EmergencyType - string value, =

> possible values
> +			This signal is emitted whenever an ETWS =

> or CMAS or
> +			EU-Alert cell broadcast is received. =

> The string text
> +			contains contents of the broadcast. The =

> dict is made
> +			up of the following entries:
> +				WarningType - string value, =

> possible values
>  						include: "Earthquake",
>  							"Tsunami",
>  							=

> "Earthquake+Tsunami",
> -							"Other"
> -				EmergencyAlert - boolean value =

> hinting whether
> -						an extra =

> emergency indicator
> +							=

> "OtherEmergency",
> +							"Presidential",
> +							"Extreme",
> +							"Severe",
> +							"Advisory",
> +							=

> "ChildAbduction",
> +							"MonthlyTest",
> +							"Exercise"
> +
> +				WarningAlert - boolean value =

> hinting whether
> +						an emergency indicator
>  						should be =

> activated (e.g.
>  						vibrate mode, =

> emergency alert
>  						mode.)

Is this WarningType really required on the App side ? =

Irrespective of the warning type, the emergency broadcast
message handling won't change on the apps side (i.e, its
going to be displayed immediately to the user). This can
be achieved by the old boolean variable EmergencyAlert only ?

BR,
Rajesh

--===============4619831334403747277==--

