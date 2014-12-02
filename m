Content-Type: multipart/mixed; boundary="===============5319594936237935953=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] add set_online interface to he910 modem
Date: Tue, 02 Dec 2014 11:36:38 -0600
Message-ID: <547DF8A6.7080405@gmail.com>
In-Reply-To: <547C526D.3030901@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5319594936237935953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexey,

On 12/01/2014 05:35 AM, Alexey Mednyy wrote:
> Had to add set_online interface to he910 modem connman now, working
> properly if disable he910 cellular (was not implemented error before).
> ---
>   plugins/he910.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>

Please be aware that HE910s are shipped with no support for online mode. =

  It was a feature added by later firmware.  On earlier firmware, the =

HE910 would turn off the SIM when CFUN=3D4 is sent.  This is obviously not =

what oFono expects.

By now this patch is probably okay to accept as the new firmware is more =

widely available.  However, you might want to double check that your =

firmware is recent enough and is working as expected.

> diff --git a/plugins/he910.c b/plugins/he910.c
> index 69362b8..add2243 100644
> --- a/plugins/he910.c
> +++ b/plugins/he910.c
> @@ -322,6 +322,30 @@ static void he910_pre_sim(struct ofono_modem *modem)
>          ofono_location_reporting_create(modem, 0, "telitmodem", data->ch=
at);
>   }
>
> +
> +static void set_online_cb(gboolean ok, GAtResult *result, gpointer
> user_data)

Please re-read our coding style guidelines in doc/coding-style.txt.  In =

particular, pay attention to indentation rules and how to break up long =

lines (over 80 characters).

Regards,
-Denis

--===============5319594936237935953==--

