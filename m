Content-Type: multipart/mixed; boundary="===============6781010995297883291=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] gprs: Add new external APIs to create,
 activate and remove a PDP context
Date: Wed, 04 May 2011 22:42:29 -0500
Message-ID: <4DC21CA5.5070000@gmail.com>
In-Reply-To: <1304530002-13336-3-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6781010995297883291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 05/04/2011 12:26 PM, Philippe Nunes wrote:
> ---
>  include/gprs.h |   16 ++++
>  src/gprs.c     |  234 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 246 insertions(+), 4 deletions(-)
> =

> diff --git a/include/gprs.h b/include/gprs.h
> index 157a6f9..0bb37f7 100644
> --- a/include/gprs.h
> +++ b/include/gprs.h
> @@ -36,6 +36,10 @@ typedef void (*ofono_gprs_status_cb_t)(const struct of=
ono_error *error,
>  =

>  typedef void (*ofono_gprs_cb_t)(const struct ofono_error *error, void *d=
ata);
>  =

> +typedef void (*ofono_gprs_add_pdp_context_cb_t)(int error, char *interfa=
ce,
> +						char *ipv4, char *ipv6,
> +						void *data);
> +
>  struct ofono_gprs_driver {
>  	const char *name;
>  	int (*probe)(struct ofono_gprs *gprs, unsigned int vendor,
> @@ -77,7 +81,19 @@ void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
>  				unsigned int min, unsigned int max);
>  void ofono_gprs_add_context(struct ofono_gprs *gprs,
>  				struct ofono_gprs_context *gc);
> +unsigned int ofono_gprs_add_pdp_context(struct ofono_gprs *gprs,
> +					const char *type,
> +					const char *protocol,
> +					const char *apn,
> +					const char *username,
> +					const char *password,
> +					const char *host);
> +
> +int ofono_gprs_remove_pdp_context(struct ofono_gprs *gprs, unsigned int =
id);
>  =

> +int ofono_gprs_activate_pdp_context(struct ofono_gprs *gprs, unsigned in=
t id,
> +					ofono_gprs_add_pdp_context_cb_t cb,
> +					void *data);

Why do you want to expose STK activated contexts over D-Bus and try to
deal with the consequences of this decision?  Having oFono handle them
completely internally would simplify the design quite a bit, no?

Regards,
-Denis

>  #ifdef __cplusplus
>  }
>  #endif

--===============6781010995297883291==--

