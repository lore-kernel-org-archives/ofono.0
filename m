Content-Type: multipart/mixed; boundary="===============0156550136599676361=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] TODO: Set number of significant digits in settings
Date: Mon, 17 Sep 2012 12:04:42 -0500
Message-ID: <5057582A.5010408@gmail.com>
In-Reply-To: <1347464010-30242-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0156550136599676361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

On 09/12/2012 10:33 AM, Ronald Tessier wrote:
> This patch concerns mmsd.
> The number of significant digits is country dependant, mmsd cannot know t=
he
> local numbering plan and so needs this information from the upper layer.
>
> ---
>   TODO |   13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/TODO b/TODO
> index 6e54f6f..3635a2f 100644
> --- a/TODO
> +++ b/TODO
> @@ -63,6 +63,19 @@ MMS Delivery Report
>     Owner: S=C3=A9bastien Bianti<sebastien.bianti@linux.intel.com>
>
>
> +MMS Settings
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- Add an entry in MMS settings file to set number of significant digits
> +  (i.e.: last digits of the phone number).
> +  Use this value to match international and local phone number when deal=
ing with
> +  conversation or delivery report.
> +

Actually I'd rather not do that, we should pick a sane default instead. =

  For example, oFono uses the last 6 digits, or as many digits as are =

available.

Do we have any other information we can use, like some sort of identifier ?

Regards,
-Denis

--===============0156550136599676361==--

