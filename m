Content-Type: multipart/mixed; boundary="===============1160464953895246579=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC patches 05/13] util.h: Add BUILD_BUG_ON() and friends for
 compile-time assert checking
Date: Fri, 28 May 2010 16:17:44 +0200
Message-ID: <1275056264.4706.77.camel@aeonflux.t-mobile.de>
In-Reply-To: <0aea8fdf557ffb7c1c8e2079cdcf86d1d1ad98c2.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1160464953895246579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> =

> These have been stolen from the Linux kernel source; come pretty handy
> to make build-time consistency checks and thus avoid run-time
> surprises.
> ---
>  src/util.h |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
> =

> diff --git a/src/util.h b/src/util.h
> index 2835b76..cf34b67 100644
> --- a/src/util.h
> +++ b/src/util.h
> @@ -77,3 +77,32 @@ unsigned char *pack_7bit(const unsigned char *in, long=
 len, int byte_offset,
>  				long *items_written, unsigned char terminator);
>  =

>  char *sim_string_to_utf8(const unsigned char *buffer, int length);
> +
> +/*
> + * Build time consistency checks
> + *
> + * Stolen from the Linux kernel 2.6.35-rc; as most taken from the
> + * Linux kernel, this is licensed GPL v2 or newer.
> + */
> +
> +/* Force a compilation error if condition is true */
> +#define BUILD_BUG_ON(condition) ((void)BUILD_BUG_ON_ZERO(condition))
> +
> +/* Force a compilation error if condition is constant and true */
> +#define MAYBE_BUILD_BUG_ON(cond) ((void)sizeof(char[1 - 2 * !!(cond)]))
> +
> +/* Force a compilation error if a constant expression is not a power of =
2 */
> +#define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
> +	BUILD_BUG_ON((n) =3D=3D 0 || (((n) & ((n) - 1)) !=3D 0))
> +
> +/* Force a compilation error if condition is true, but also produce a
> +   result (of value 0 and type size_t), so the expression can be used
> +   e.g. in a structure initializer (or where-ever else comma expressions
> +   aren't permitted). */
> +#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
> +#define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))
> +
> +/*
> + * End of code stolen from the Linux kernel 2.6.35-rc. From now, code
> + * is GPL v2 only.
> + */

sounds like a nice addition, but src/util.h is the wrong file. I prefer
we make this compatible so that it can be applied to ConnMan and BlueZ
as well.

I think something like include/bug.h is better.

Regards

Marcel



--===============1160464953895246579==--

