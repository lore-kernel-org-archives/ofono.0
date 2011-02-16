Content-Type: multipart/mixed; boundary="===============7557181490059038055=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] src: out of bounds problem in smsutil
Date: Wed, 16 Feb 2011 09:25:16 -0600
Message-ID: <4D5BEC5C.3000207@gmail.com>
In-Reply-To: <1297857898-21582-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7557181490059038055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

On 02/16/2011 06:04 AM, Jessica Nilsson wrote:
> ---
> =

> This one was exposed when wgmodem2.5 CBS was run with valgrind.
> =

> Best Regards,
> Jessica Nilsson
> =


Can you post the actual error and the data this happened on?

>  src/smsutil.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/src/smsutil.c b/src/smsutil.c
> index 5524932..b3a1ba1 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -4628,7 +4628,7 @@ char *cbs_topic_ranges_to_string(GSList *ranges)
>  	}
>  =

>  	/* Space for ranges, commas and terminator null */
> -	ret =3D g_new(char, len + nelem);
> +	ret =3D g_new0(char, len + nelem + 1);

I'm having trouble seeing how the old code was wrong.  nelem contains
the number of elements.  Since the last element does not end with a
comma, the use of nelem + 1 in g_new is not necessary.  sprintf takes
care of adding the terminating null, so using g_new0 is also less efficient.

Are you adding channels that are 5 digits long by any chance?

>  =

>  	len =3D 0;
>  =


Regards,
-Denis

--===============7557181490059038055==--

