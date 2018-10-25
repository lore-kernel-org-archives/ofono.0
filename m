Content-Type: multipart/mixed; boundary="===============7021794500115976932=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH] atmodem/atutil.h: cb_data ref/unref possibility
Date: Thu, 25 Oct 2018 08:55:42 +0200
Message-ID: <a3c6c6fc-0af1-f99a-95c3-1d8bb09fed4f@norrbonn.se>
In-Reply-To: <20181025050303.21401-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7021794500115976932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,


On 25/10/2018 07:03, Giacinto Cifelli wrote:
> +static inline struct cb_data *cb_data_ref(struct cb_data *cbd)
> +{
> +	if (cbd =3D=3D NULL)
> +		return NULL;
> +
> +	g_atomic_int_inc(&cbd->ref_count);
> +

Let me just vent my disagreement with using atomic accessors here again:

i)  If I'm a new contributor, unfamiliar with ofono, and I see this then =

I think:  "oh oh, this is a thread-safe library... better be =

careful."... and then I get all confused because nothing else is handled =

in a thread-safe manner.

ii)  The atomic operations introduce an unnecessary memory barrier.

I _presume_ that the code is written this way because it was inherited =

from connman and connman made an early attempt to be thread safe...??? =

I'm not sure that legacy is worth preserving.

Anyway, enough said on the matter.  The implementation is fine aside =

from my reservations.

/Jonas


> +	return cbd;
> +}
> +
> +static inline void cb_data_unref(struct cb_data *cbd)
> +{
> +	gboolean is_zero;
> +
> +	if (cbd =3D=3D NULL)
> +		return;
> +
> +	is_zero =3D g_atomic_int_dec_and_test(&cbd->ref_count);
> +
> +	if (is_zero =3D=3D TRUE)
> +		g_free(cbd);
> +}
> +
>   static inline int at_util_convert_signal_strength(int strength)
>   {
>   	int result;
>=20

--===============7021794500115976932==--

