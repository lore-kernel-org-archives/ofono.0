Content-Type: multipart/mixed; boundary="===============6082343778021286724=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] include: Add driver api for user confirmation
Date: Wed, 06 Jul 2011 01:28:35 -0500
Message-ID: <4E140093.3080607@gmail.com>
In-Reply-To: <1309946773-7747-2-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6082343778021286724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 07/06/2011 05:06 AM, Jeevaka Badrappan wrote:
> ---
>  include/stk.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> =

> diff --git a/include/stk.h b/include/stk.h
> index c276c84..9a63917 100644
> --- a/include/stk.h
> +++ b/include/stk.h
> @@ -47,6 +47,7 @@ struct ofono_stk_driver {
>  	void (*terminal_response)(struct ofono_stk *stk,
>  					int length, const unsigned char *resp,
>  					ofono_stk_generic_cb_t cb, void *data);
> +	void (*user_confirmation)(struct ofono_stk *stk, gboolean confirm);

Please don't use glib types in public API.  Use ofono_bool_t here instead.

>  };
>  =

>  int ofono_stk_driver_register(const struct ofono_stk_driver *d);

Regards,
-Denis

--===============6082343778021286724==--

