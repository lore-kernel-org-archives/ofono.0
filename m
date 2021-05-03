Content-Type: multipart/mixed; boundary="===============6312050575834301067=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim-auth: Parse auth response according to TS 31.102
Date: Mon, 03 May 2021 16:20:44 -0500
Message-ID: <7a2e4d9e-1b41-1498-be00-ebecec64044b@gmail.com>
In-Reply-To: <20210503140435.3559338-1-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6312050575834301067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 5/3/21 9:04 AM, Slava Monich wrote:
> ---

So what is this trying to fix?  I mean I can understand 1 line patch fixes =
that =

come without a description.  These tend to be self-evident.  300+ line diff =

needs a least some explanation.

>   src/sim-auth.c      |  34 ++++++-----
>   src/simutil.c       | 146 +++++++++++++++++++++++++++++++++-----------
>   src/simutil.h       |  13 ++--
>   unit/test-simutil.c | 125 ++++++++++++++++++++++++++++---------
>   4 files changed, 234 insertions(+), 84 deletions(-)

This really should be broken down into at least 2 commits. See HACKING, =

'Submitting Patches' section, item 3.

> =

> diff --git a/src/sim-auth.c b/src/sim-auth.c
> index 3c3f35e7..6dab52ee 100644
> --- a/src/sim-auth.c
> +++ b/src/sim-auth.c
> @@ -207,14 +207,10 @@ static void handle_umts(struct ofono_sim_auth *sa, =
const uint8_t *resp,
>   	DBusMessage *reply =3D NULL;
>   	DBusMessageIter iter;
>   	DBusMessageIter dict;
> -	const uint8_t *res =3D NULL;
> -	const uint8_t *ck =3D NULL;
> -	const uint8_t *ik =3D NULL;
> -	const uint8_t *auts =3D NULL;
> -	const uint8_t *kc =3D NULL;
> +	struct data_block res, ck, ik, auts, sres, kc;
>   =

>   	if (!sim_parse_umts_authenticate(resp, len, &res, &ck, &ik,
> -			&auts, &kc))
> +			&auts, &sres, &kc))
>   		goto umts_end;
>   =

>   	reply =3D dbus_message_new_method_return(sa->pending->msg);
> @@ -224,15 +220,23 @@ static void handle_umts(struct ofono_sim_auth *sa, =
const uint8_t *resp,
>   	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
>   			"{say}", &dict);
>   =

> -	if (auts) {
> -		append_dict_byte_array(&dict, "AUTS", auts, 14);
> -	} else {
> -		append_dict_byte_array(&dict, "RES", res, 8);
> -		append_dict_byte_array(&dict, "CK", ck, 16);
> -		append_dict_byte_array(&dict, "IK", ik, 16);
> -		if (kc)
> -			append_dict_byte_array(&dict, "Kc", kc, 8);
> -	}
> +	if (auts.data)
> +		append_dict_byte_array(&dict, "AUTS", auts.data, auts.len);
> +
> +	if (sres.data)
> +		append_dict_byte_array(&dict, "SRES", sres.data, sres.len);

You're modifying the behavior of the D-Bus API without actually updating th=
e =

relevant docs.

Also, this part looks suspect.  SRES is only done in GSM context, so should=
n't =

this be taken care sim_parse_gsm_authenticate()?

> +
> +	if (res.data)
> +		append_dict_byte_array(&dict, "RES", res.data, res.len);
> +
> +	if (ck.data)
> +		append_dict_byte_array(&dict, "CK", ck.data, ck.len);
> +
> +	if (ik.data)
> +		append_dict_byte_array(&dict, "IK", ik.data, ik.len);
> +
> +	if (kc.data)
> +		append_dict_byte_array(&dict, "Kc", kc.data, kc.len);
>   =

>   	dbus_message_iter_close_container(&iter, &dict);
>   =

> diff --git a/src/simutil.c b/src/simutil.c
> index 5d2aa6a2..30b76f05 100644
> --- a/src/simutil.c
> +++ b/src/simutil.c
> @@ -1672,63 +1672,135 @@ int sim_build_gsm_authenticate(unsigned char *bu=
ffer, int len,
>   	return build_authenticate(buffer, rand, NULL);
>   }
>   =

> -gboolean sim_parse_umts_authenticate(const unsigned char *buffer,
> -		int len, const unsigned char **res, const unsigned char **ck,
> -		const unsigned char **ik, const unsigned char **auts,
> -		const unsigned char **kc)
> +gboolean sim_parse_umts_authenticate(const unsigned char *buffer, int le=
n,
> +		struct data_block *res, struct data_block *ck,
> +		struct data_block *ik, struct data_block *auts,
> +		struct data_block *sres, struct data_block *kc)

At least by my reading of 33.102, lengths of ck, ik, kc and sres are set in =

stone, are they not?

Also, RFC 4187 also sets in stone the definition of AUTS (and RES, AUTN, et=
c). =

So you probably have to explain how and when AUTS length could be not in li=
ne =

with that RFC?  The authentication API is mostly meant to be used by =

implementations of this RFC, so we would need to take appropriate steps tha=
t =

nothing is broken by this change.

>   {
> -	if (len < 16 || !buffer)
> +	const unsigned char *ptr =3D buffer;
> +	const unsigned char *end =3D ptr + len;
> +	unsigned int l;
> +
> +	if (!buffer || len < 2)
>   		return FALSE;
>   =

> -	switch (buffer[0]) {
> +	memset(res, 0, sizeof(*res));
> +	memset(ck, 0, sizeof(*ck));
> +	memset(ik, 0, sizeof(*ik));
> +	memset(kc, 0, sizeof(*kc));
> +	memset(auts, 0, sizeof(*auts));
> +	memset(sres, 0, sizeof(*sres));

Generally we don't like side-effecting arguments on error.  If you're going =

through the trouble of introducing a new structure, might as well just have=
 it =

represent the result of the parse operation and cut down on arguments.  May=
be =

something like:

struct sim_auth_umts_result {
	uint8_t success;
	union {
		struct {
			const unsigned char *auts;
			uint8_t auts_len;
		}
		struct {
			const unsigned char *res;
			uint8_t res_len;
			const unsigned char *ck;
			const unsigned char *ik;
			const unsigned char *ic;
		}
	};
}

Regards,
-Denis
--===============6312050575834301067==--

