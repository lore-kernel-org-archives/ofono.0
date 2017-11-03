Content-Type: multipart/mixed; boundary="===============1816670664329477225=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/8] include/voicecall.h : Add support for dialing number
 at a given memory location
Date: Fri, 03 Nov 2017 13:41:31 -0500
Message-ID: <af1904f5-6ded-9931-2b5a-6ed1650e3e05@gmail.com>
In-Reply-To: <20171031083939.4393-6-philippe.deswert@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1816670664329477225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 10/31/2017 03:39 AM, Philippe De Swert wrote:
> ---
>   include/voicecall.h | 5 +++++
>   1 file changed, 5 insertions(+)
> =

> diff --git a/include/voicecall.h b/include/voicecall.h
> index 6871a6b5..b3d5bc06 100644
> --- a/include/voicecall.h
> +++ b/include/voicecall.h
> @@ -61,6 +61,11 @@ struct ofono_voicecall_driver {
>   			const struct ofono_phone_number *number,
>   			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
>   			void *data);
> +	/* dials a number at a given memory location */
> +	void (*dial_memory)(struct ofono_voicecall *vc,
> +			long int memory_location,

Why a long int?  Is a simple int not sufficient?

> +			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
> +			void *data);
>   	/* Dials the last number again, this handles the hfp profile last numb=
er
>            * dialing with the +BLDN AT command
>            */
> =


Regards,
-Denis

--===============1816670664329477225==--

