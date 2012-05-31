Content-Type: multipart/mixed; boundary="===============8165673697073782539=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 1/3] gprs-context: Add new driver entry
Date: Thu, 31 May 2012 17:46:59 -0500
Message-ID: <4FC7F4E3.7090506@gmail.com>
In-Reply-To: <1338458348-335-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8165673697073782539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 05/31/2012 04:59 AM, Guillaume Zajac wrote:
> ---
>   include/gprs-context.h |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/include/gprs-context.h b/include/gprs-context.h
> index 6cae9a2..165792f 100644
> --- a/include/gprs-context.h
> +++ b/include/gprs-context.h
> @@ -71,6 +71,8 @@ struct ofono_gprs_context_driver {
>   	void (*deactivate_primary)(struct ofono_gprs_context *gc,
>   					unsigned int id,
>   					ofono_gprs_context_cb_t cb, void *data);
> +	void (*release_primary)(struct ofono_gprs_context *gc,
> +					unsigned int id);

Please just call it detach_shutdown for now.

>   };
>
>   void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,

Regards,
-Denis

--===============8165673697073782539==--

