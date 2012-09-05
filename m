Content-Type: multipart/mixed; boundary="===============2164682815901855982=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/4] ussd: Recover idle state after a transaction error
Date: Wed, 05 Sep 2012 14:53:01 -0500
Message-ID: <5047AD9D.3020702@gmail.com>
In-Reply-To: <1346864182-24464-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2164682815901855982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 09/05/2012 11:56 AM, Philippe Nunes wrote:
> The "USSD terminated by network" notification is handled to recover
> the idle state in case of USSD transaction error.
> ---
>   src/ussd.c |   12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/src/ussd.c b/src/ussd.c
> index 74888b2..a35f172 100644
> --- a/src/ussd.c
> +++ b/src/ussd.c
> @@ -414,6 +414,18 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int =
status, int dcs,
>   		return;
>   	}
>
> +	if (status =3D=3D OFONO_USSD_STATUS_TERMINATED&&
> +			(ussd->state =3D=3D USSD_STATE_IDLE ||

Why do you need this guard?

> +			ussd->state =3D=3D USSD_STATE_USER_ACTION)) {

Or this one for that matter.  In theory the terminated notification can =

come at any time.

> +		ussd_change_state(ussd, USSD_STATE_IDLE);
> +
> +		if (ussd->pending =3D=3D NULL)
> +			return;
> +
> +		reply =3D __ofono_error_failed(ussd->pending);
> +		goto out;
> +	}
> +
>   	if (status =3D=3D OFONO_USSD_STATUS_NOT_SUPPORTED) {
>   		ussd_change_state(ussd, USSD_STATE_IDLE);
>

Can't we treat it exactly like 'NOT_SUPPORTED' or 'TIMED_OUT' but with a =

different error?

Regards,
-Denis

--===============2164682815901855982==--

