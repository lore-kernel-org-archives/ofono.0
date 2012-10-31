Content-Type: multipart/mixed; boundary="===============3035232961021006745=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] Set MNC length to 2 if EFad doesn't specify it
Date: Wed, 31 Oct 2012 15:09:24 -0500
Message-ID: <50918574.8060600@gmail.com>
In-Reply-To: <1347525847-2991-1-git-send-email-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3035232961021006745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 09/13/2012 03:44 AM, Jonas Bonn wrote:
> Byte 4 of the EFAD structure, which specifies the MNC length, is optional.
> If this byte is not present, then there is no way to determine the length
> of the MNC.  As the, by far, most common length is 2, we might as well
> default to this value.

Depends on the continent.  On some it is not common at all.

>
> This patch changes the ofono_error to a warning as it's not really an
> error that we're encountering, but the user should nonetheless be given
> a heads-up that something might not work as expected.

What spec are you reading? 31.102 says it is mandatory ;)

>
> Signed-off-by: Jonas Bonn<jonas@southpole.se>

We do not use Signed-off-by here.

> ---
>   src/sim.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/src/sim.c b/src/sim.c
> index 4384eb0..f6109c6 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -1760,7 +1760,9 @@ static void sim_ad_read_cb(int ok, int length, int =
record,
>   		return;
>
>   	if (length<  4) {
> -		ofono_error("EFad should contain at least four bytes");
> +		ofono_warn("EFad does not specify (optional) MNC length"
> +			   ", defaulting to 2");
> +		sim->mnc_length =3D 2;

And I'd rather not do this.  If mnc_length is unable to be determined, =

then oFono does not guess, but simply does not provide this information. =

  This hack might work for really old 2G devices which did not =

understand length 3 MNCs and always assumed length 2, but that is not =

really oFono's target.

>   		return;
>   	}
>

Regards,
-Denis

--===============3035232961021006745==--

