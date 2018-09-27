Content-Type: multipart/mixed; boundary="===============7819495668419573563=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] drivers: default gprs authentication
Date: Thu, 27 Sep 2018 11:32:17 -0500
Message-ID: <0a3894cd-3233-fc8b-7c0d-70442e228c96@gmail.com>
In-Reply-To: <20180925132035.19417-4-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7819495668419573563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 09/25/2018 08:20 AM, Giacinto Cifelli wrote:
> Default value for gprs authentication method:
> for most of the atoms, there is already a default, that is either
> no authentication or error.
> In case of error (only PAP and CHAP supported), this is unchanged, like
> for atmodem PPP. This legacy code will run as-is today, defaulting later
> to no authentication if username or password are empty.
> In case of default to no authentication, the new value
> OFONO_GPRS_AUTH_METHOD_NONE is added to make this explicit.

I'm lost now.  Your patch results in atmodem driver failing the context =

activation if auth_method=3DNone is used.  How is this good?

> =

> It turns out that only the atmodem (PPP) and the mbimmodem need to have
> default value in the switch/case for selecting the method.
> For the atmodem, it is in the ublox vendor logic, and the fix removes
> the method prefix in the APN name. According to ublox specification,
> it is the right way to do it.
> =

> For the mbim modem, NONE is supported, it just needs to be added to the
> switch/case.
> =

> There are 3 more drivers containing a gprs-context atom, which have a
> default behavior as follow:
> error for:  telitmodem, ubloxmodem,
> no authentication for: qmimodem
> ---
>   drivers/atmodem/gprs-context.c   | 4 ++++
>   drivers/mbimmodem/gprs-context.c | 2 ++
>   2 files changed, 6 insertions(+)
> =

> diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-contex=
t.c
> index 79ac4c8e..b10777a5 100644
> --- a/drivers/atmodem/gprs-context.c
> +++ b/drivers/atmodem/gprs-context.c
> @@ -304,6 +304,10 @@ static void at_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
>   				snprintf(buf + len, sizeof(buf) - len - 3,
>   						",\"PAP:%s\"", ctx->apn);
>   				break;
> +			default:
> +				snprintf(buf + len, sizeof(buf) - len - 3,
> +						",\"%s\"", ctx->apn);
> +				break;

Actually please avoid 'default' statements for well defined =

enumerations.  The compiler will warn us if a given enumeration is not =

handled.

>   			}
>   			break;
>   		default:
> diff --git a/drivers/mbimmodem/gprs-context.c b/drivers/mbimmodem/gprs-co=
ntext.c
> index 79793c92..ce33b927 100644
> --- a/drivers/mbimmodem/gprs-context.c
> +++ b/drivers/mbimmodem/gprs-context.c
> @@ -75,6 +75,8 @@ static uint32_t auth_method_to_auth_protocol(enum ofono=
_gprs_auth_method method)
>   		return 2; /* MBIMAuthProtocolChap */
>   	case OFONO_GPRS_AUTH_METHOD_PAP:
>   		return 1; /* MBIMAuthProtocolPap */
> +	default:
> +		return 0;

As above.

>   	}
>   =

>   	return 0;
> =


Regards,
-Denis

--===============7819495668419573563==--

