Content-Type: multipart/mixed; boundary="===============0423662270710340675=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/4] sim: query remaining pin retries
Date: Tue, 04 Jan 2011 11:13:51 -0600
Message-ID: <4D23554F.2040604@gmail.com>
In-Reply-To: <1294146379-30854-3-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0423662270710340675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 01/04/2011 07:06 AM, Lucas De Marchi wrote:
> Check the remaining pin retries after each operation that might have
> changed it, i.e. locking, unlocking, reseting or changing pin.
> ---
>  src/sim.c |  102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 102 insertions(+), 0 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index 335f611..a57fe84 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -62,6 +62,8 @@ struct ofono_sim {
>  	enum ofono_sim_password_type pin_type;
>  	gboolean locked_pins[OFONO_SIM_PASSWORD_SIM_PUK]; /* Number of PINs */
>  =

> +	GSList *pin_retries;
> +

Are you forgetting to free the pin_retries array when the sim is removed
or the sim atom is destroyed?

The rest seems fine to me.

Regards,
-Denis

--===============0423662270710340675==--

