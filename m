Content-Type: multipart/mixed; boundary="===============3904038267848821383=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/6] emulator: add RING for HFP AG
Date: Tue, 19 Apr 2011 13:57:50 -0500
Message-ID: <4DADDB2E.8060709@gmail.com>
In-Reply-To: <1302710734-6103-2-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3904038267848821383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 04/13/2011 11:05 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>  src/emulator.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++---=
-----
>  1 files changed, 76 insertions(+), 13 deletions(-)
> =


Patch has been applied, thanks.  One thing you need to watch out for though:

> +	/*
> +	 * Ring timer should be started when callsetup indicator is set to
> +	 *   Incoming
> +	 * If there is no active call, a first RING should be sent just after
> +	 *   the +CIEV
> +	 * It should be stopped for all other values of callsetup
> +	 */
> +	if (g_str_equal(name, OFONO_EMULATOR_IND_CALLSETUP) =3D=3D FALSE)
>  		return;
> +
> +	if (value =3D=3D OFONO_EMULATOR_CALLSETUP_INCOMING) {
> +		if (call_ind->value =3D=3D OFONO_EMULATOR_CALL_INACTIVE)
> +			send_callsetup_notification(em);
> +
> +		em->callsetup_source =3D g_timeout_add_seconds(RING_TIMEOUT,
> +					send_callsetup_notification, em);
> +	} else if (value !=3D OFONO_EMULATOR_CALLSETUP_INCOMING &&
> +						em->callsetup_source) {
> +		g_source_remove(em->callsetup_source);
> +		em->callsetup_source =3D 0;

It is quite possible for the following situation to occur:

Initial State:
Active Call A + Waiting Call B

User dials another number C

Which results in:
Held call A, Waiting call B and Dialing call C.  This case is not
covered by the original spec, so you might need to be extra pedantic on
when you remove the callsetup_source.

>  	}
>  }

Regards,
-Denis

--===============3904038267848821383==--

