Content-Type: multipart/mixed; boundary="===============4075340738943289178=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: Add check in dial_request_finish
Date: Mon, 30 Aug 2010 10:35:06 -0500
Message-ID: <4C7BCFAA.40503@gmail.com>
In-Reply-To: <1283149713-19007-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4075340738943289178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

On 08/30/2010 01:28 AM, Zhenhua Zhang wrote:
> To avoid signal 11 if no dial_req exists.
> ---
>  src/voicecall.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> =

> diff --git a/src/voicecall.c b/src/voicecall.c
> index 6ad58ad..1313129 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -220,6 +220,9 @@ static void dial_request_finish(struct ofono_voicecal=
l *vc, gboolean callback)
>  {
>  	struct dial_request *dial_req =3D vc->dial_req;
>  =

> +	if (dial_req =3D=3D NULL)
> +		return;
> +
>  	if (callback && dial_req->cb)
>  		dial_req->cb(dial_req->call ? dial_req->call->call : NULL,
>  				dial_req->user_data);

I fixed it slightly differently.  Let me know if it still crashes.

Regards,
-Denis

--===============4075340738943289178==--

