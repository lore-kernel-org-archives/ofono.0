Content-Type: multipart/mixed; boundary="===============6969825490872041579=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/4] netreg: Add CPHS CSP PLMN mode implementation
Date: Wed, 26 Jan 2011 10:47:16 +0100
Message-ID: <1296035236.1520.93.camel@aeonflux>
In-Reply-To: <1296033569-26774-3-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6969825490872041579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

>  src/network.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++--
>  1 files changed, 72 insertions(+), 3 deletions(-)
> =

> diff --git a/src/network.c b/src/network.c
> index b5450ee..64734d0 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -64,6 +64,7 @@ struct ofono_netreg {
>  	int cellid;
>  	int technology;
>  	int mode;
> +	gboolean forced_auto;

do we wanna keep it named forced_auto and not better keep this in sync
with auto_only as we use in the D-Bus API. Or if manual_disabled.

>  	char *base_station;
>  	struct network_operator_data *current_operator;
>  	GSList *operator_list;
> @@ -93,8 +94,11 @@ struct network_operator_data {
>  	struct ofono_netreg *netreg;
>  };
>  =

> -static const char *registration_mode_to_string(int mode)
> +static const char *registration_mode_to_string(int mode, gboolean forced=
_auto)
>  {
> +	if (forced_auto)
> +		return "auto-only";
> +

I see the benefit of keeping this in this function, but I would not have
done it like this actually. I would have kept it next to the function
needing that string and let it do the auto-only check by itself.

Another possibility might be to convert this into

	get_registration_mode_string(struct ofono_netreg *netreg)

Since I am not mistaken, then the netreg->mode is always set before you
are calling this, right?

Regards

Marcel



--===============6969825490872041579==--

