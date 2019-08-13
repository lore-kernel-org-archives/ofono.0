Content-Type: multipart/mixed; boundary="===============7402238486545657632=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/3] gprs: Ignore activated contexts during init,
 list them later
Date: Tue, 13 Aug 2019 01:43:00 -0500
Message-ID: <bd770ca8-9df2-693d-6418-72e01450114f@gmail.com>
In-Reply-To: <20190812213130.23420-2-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7402238486545657632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 8/12/19 4:31 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> There is an issue if an context gets auto activated early,
> then provisioning might not have run yet for instance,
> so a "new" context is created, which might be duplicated
> by a provisioning context later.
> So ignore the activated contexts until gprs is ready,
> then it calls the driver to list active contexts.
> ---
>   src/gprs.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
> =


<snip>

>   =

> +static void gprs_list_active_contexts_callback(const struct ofono_error =
*error,
> +						void *data)
> +{
> +	(void)data;
> +

Squashed this pointless line and...

> +	DBG("error =3D %d", error->type);
> +}
> +

applied, thanks.

Regards,
-Denis

--===============7402238486545657632==--

