Content-Type: multipart/mixed; boundary="===============7148830655446968933=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] atutil: Add logic for cgcontrdp to get address and
 netmask
Date: Tue, 05 Sep 2017 11:11:57 -0500
Message-ID: <4ac9fd14-a4d4-753e-f7b0-b64218d2e394@gmail.com>
In-Reply-To: <1504245182-17949-3-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7148830655446968933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ankit,

On 09/01/2017 12:53 AM, Ankit Navik wrote:
> ---
>   drivers/atmodem/atutil.c | 44 +++++++++++++++++++++++++++++++++++++++++=
+++
>   drivers/atmodem/atutil.h |  3 +++
>   2 files changed, 47 insertions(+)
> =

> diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
> index 1487348..1067f20 100644
> --- a/drivers/atmodem/atutil.c
> +++ b/drivers/atmodem/atutil.c
> @@ -27,6 +27,7 @@
>   #include <gatchat.h>
>   #include <string.h>
>   #include <stdlib.h>
> +#include <errno.h>
>   =

>   #define OFONO_API_SUBJECT_TO_CHANGE
>   #include <ofono/log.h>
> @@ -614,3 +615,46 @@ void at_util_sim_state_query_free(struct at_util_sim=
_state_query *req)
>   =

>   	g_free(req);
>   }
> +
> +/*
> + * CGCONTRDP returns addr + netmask in the same string in the form
> + * of "a.b.c.d.m.m.m.m" for IPv4.
> + * TODO: Add logic for IPv6.
> + */
Put a comment here stating that address/netmask must be able to hold
255.255.255.255 + null =3D 16 characters

> +int at_util_set_address_and_netmask(const char *addrnetmask, char *addre=
ss,
> +					char *netmask)

Lets call this at_util_get_ipv4_address_and_netmask

> +{
> +	char *dup =3D strdup(addrnetmask);

You could avoid a strdup entirely by marking the position of the 4th dot =

and doing some pointer math...

> +	char *s =3D dup;
> +
> +	const char *addr =3D s;
> +	const char *net =3D NULL;
> +
> +	int ret =3D -EINVAL;
> +	int i;
> +
> +	/* Count 7 dots for ipv4, less or more means error. */
> +	for (i =3D 0; i < 8; i++, s++) {

This doesn't actually check that the number of dots > 7 ...

> +		s =3D strchr(s, '.');
> +
> +		if (!s)
> +			break;
> +
> +		if (i =3D=3D 3) {
> +			/* set netmask ptr and break the string */
> +			net =3D s + 1;
> +			s[0] =3D 0;
> +		}
> +	}
> +
> +	if (i =3D=3D 7) {
> +		strncpy(address, addr, strlen(addr));
> +		strncpy(netmask, net, strlen(net));

This would appear not to copy the null terminator.  Not sure this is =

intended?

> +
> +		ret =3D 0;
> +	}
> +
> +	free(dup);
> +
> +	return ret;
> +}
> diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
> index 5cb88b7..cc8fc52 100644
> --- a/drivers/atmodem/atutil.h
> +++ b/drivers/atmodem/atutil.h
> @@ -83,6 +83,9 @@ struct at_util_sim_state_query *at_util_sim_state_query=
_new(GAtChat *chat,
>   						GDestroyNotify destroy);
>   void at_util_sim_state_query_free(struct at_util_sim_state_query *req);
>   =

> +int at_util_set_address_and_netmask(const char *addrnetmask, char *addre=
ss,
> +						char *netmask);
> +
>   struct cb_data {
>   	void *cb;
>   	void *data;
> =


Regards,
-Denis

--===============7148830655446968933==--

