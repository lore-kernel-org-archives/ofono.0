Content-Type: multipart/mixed; boundary="===============4105900364912339625=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] xmm7modem: CPIN handling after sending puk
Date: Fri, 20 Dec 2019 12:50:11 -0600
Message-ID: <5d515685-0f76-d946-9210-e8f64482db11@gmail.com>
In-Reply-To: <1576760226-30941-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4105900364912339625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 12/19/19 6:57 AM, Antara Borwankar wrote:
> On XMM modems SIM is busy after PUK is entered. CME ERROR: 14
> is received for AT+CPIN? query. Therefore polling for CPIN: READY
> state.
> ---
>   drivers/atmodem/sim.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index e750a13..3ed5aa0 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -1354,13 +1354,14 @@ static void at_pin_send_cb(gboolean ok, GAtResult=
 *result,
>   	case OFONO_VENDOR_HUAWEI:
>   	case OFONO_VENDOR_SIMCOM:
>   	case OFONO_VENDOR_SIERRA:
> +	case OFONO_VENDOR_XMM:
>   		/*
>   		 * On ZTE modems, after pin is entered, SIM state is checked
>   		 * by polling CPIN as their modem doesn't provide unsolicited
>   		 * notification of SIM readiness.
>   		 *
> -		 * On SIMCOM modems, SIM is busy after pin is entered (we
> -		 * got a "+CME ERROR: 14" for the "AT+CPIN?" request) and
> +		 * On SIMCOM and XMM modems, SIM is busy after pin is entered
> +		 * (we got a "+CME ERROR: 14" for the "AT+CPIN?" request) and
>   		 * ofono don't catch the "+CPIN: READY" message sent by the
>   		 * modem when SIM is ready. So, use extra CPIN to check the
>   		 * state.
> =


Shouldn't this be already taken care of by setting wait_initialized =

inside src/sim.c sim_enter_pin_cb()?  This particular logic is a work =

around for modems that do not have a separate notification that can be =

used to send ofono_sim_initialized_notify.

Regards,
-Denis
--===============4105900364912339625==--

