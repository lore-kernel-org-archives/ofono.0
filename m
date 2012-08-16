Content-Type: multipart/mixed; boundary="===============8058449660836774723=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] sim: support PIN retry counters for telit modems
Date: Thu, 16 Aug 2012 01:09:44 -0500
Message-ID: <502C8EA8.7090506@gmail.com>
In-Reply-To: <1345102640-8465-3-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8058449660836774723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher/August,

On 08/16/2012 02:37 AM, Christopher Vogl wrote:
> From: August Mayer<august.mayer@hale.at>
>
> ---
>   drivers/atmodem/sim.c |   61 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 files changed, 61 insertions(+), 0 deletions(-)
>

Patch has been applied, however it had 3 trailing whitespace violations. =

  I had to edit it manually for it to apply.

Please configure your editor appropriately and add:
[apply]
         whitespace =3D error

to your .git/config.  It always doesn't hurt to test-apply your patches =

before submission.

Also:

<snip>

> +	enum ofono_sim_password_type pin_type =3D ofono_sim_get_password_type(s=
im);

We still prefer C90 syntax for variable declarations, so I had to fix =

this in a follow-on commit.

> +	if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE) {
> +		DBG("Note: No password required, returning maximum retries:");
> +		AT_PCT_SET_RETRIES(retries, OFONO_SIM_PASSWORD_SIM_PIN, 3);
> +		AT_PCT_SET_RETRIES(retries, OFONO_SIM_PASSWORD_SIM_PIN2, 3);
> +		AT_PCT_SET_RETRIES(retries, OFONO_SIM_PASSWORD_SIM_PUK, 10);
> +		AT_PCT_SET_RETRIES(retries, OFONO_SIM_PASSWORD_SIM_PUK2, 10);
> +		goto callback;
> +	}
> +

Regards,
-Denis

--===============8058449660836774723==--

