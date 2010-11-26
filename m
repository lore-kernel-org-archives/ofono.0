Content-Type: multipart/mixed; boundary="===============2320084275180883251=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] call-volume: Remove atom registered check
Date: Fri, 26 Nov 2010 13:43:05 -0600
Message-ID: <4CF00DC9.2060405@gmail.com>
In-Reply-To: <1290783487-5579-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2320084275180883251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 11/26/2010 08:58 AM, Jeevaka Badrappan wrote:
> ---
>  src/call-volume.c |    9 ---------
>  1 files changed, 0 insertions(+), 9 deletions(-)
> =

> diff --git a/src/call-volume.c b/src/call-volume.c
> index dd1be92..c448d32 100644
> --- a/src/call-volume.c
> +++ b/src/call-volume.c
> @@ -62,9 +62,6 @@ void ofono_call_volume_set_speaker_volume(struct ofono_=
call_volume *cv,
>  =

>  	cv->speaker_volume =3D percent;
>  =

> -	if (__ofono_atom_get_registered(cv->atom) =3D=3D FALSE)
> -		return;
> -

The idea here is that the atom driver can set the volume before it is
fully registered / initialized, hence the reason for this check.

The chance of this happening is small, but I think it is safe to leave
it the way it was.  Thoughts?

Regards,
-Denis

--===============2320084275180883251==--

