Content-Type: multipart/mixed; boundary="===============7778250257654999307=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] droid 4: add special handling required for voice
 calls and SIM
Date: Tue, 15 Sep 2020 10:19:26 -0500
Message-ID: <8f56af43-5b94-427c-6e3f-4a488e4fa26c@gmail.com>
In-Reply-To: <20200915132300.GA13208@duo.ucw.cz>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7778250257654999307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 9/15/20 8:23 AM, Pavel Machek wrote:
> Droid 4 modem is "special" (aka broken) so it seems to need a bit of
> error handling.
> ---
>   drivers/atmodem/sim.c       | 1 +
>   drivers/atmodem/vendor.h    | 1 +
>   drivers/atmodem/voicecall.c | 4 ++++
>   3 files changed, 6 insertions(+)
> =


<snip>

> @@ -160,6 +160,10 @@ static void clcc_poll_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>   			poll_again =3D TRUE;
>   			goto poll_again;
>   		}

applied with an extra newline here to satisfy doc/coding-style.txt item M1.

> +		if (vd->vendor =3D=3D OFONO_VENDOR_DROID) {
> +			poll_again =3D TRUE;
> +			goto poll_again;
> +		}
>   =

>   		ofono_error("We are polling CLCC and received an error");
>   		ofono_error("All bets are off for call management");
> =


Regards,
-Denis
--===============7778250257654999307==--

