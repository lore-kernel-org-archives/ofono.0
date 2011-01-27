Content-Type: multipart/mixed; boundary="===============0108580029255313738=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Ofono has too tight limits for SIM lock code lengths
Date: Thu, 27 Jan 2011 14:09:27 +0100
Message-ID: <1296133767.1520.147.camel@aeonflux>
In-Reply-To: <1296132771-17621-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0108580029255313738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

> ---
>  include/sim.h      |    1 +
>  src/call-barring.c |   14 ++++++++------
>  src/call-meter.c   |    4 ++--
>  src/common.c       |   29 ++++++++++++++++++++++++-----
>  src/common.h       |   11 +++--------
>  src/ofono.h        |    3 +++
>  src/sim.c          |   13 +++++++------
>  7 files changed, 48 insertions(+), 27 deletions(-)
> =

> diff --git a/include/sim.h b/include/sim.h
> index 5e3ba5b..ee63d74 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -54,6 +54,7 @@ enum ofono_sim_password_type {
>  	OFONO_SIM_PASSWORD_PHNETSUB_PUK,
>  	OFONO_SIM_PASSWORD_PHSP_PUK,
>  	OFONO_SIM_PASSWORD_PHCORP_PUK,
> +	OFONO_PASSWORD_PIN_TYPE_NET,
>  	OFONO_SIM_PASSWORD_INVALID,
>  };

so every single enum has kept some sort of proper namespacing. And I
would really prefer to not break this for ofono_sim_password_type.

Regards

Marcel



--===============0108580029255313738==--

