Content-Type: multipart/mixed; boundary="===============6680452778724989894=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/7] include/voicecall.h : Add support for dialing number
 at a given memory location
Date: Fri, 08 Dec 2017 08:25:41 -0600
Message-ID: <2c00e58e-d824-ac6d-a5bc-2bbfcf216f29@gmail.com>
In-Reply-To: <20171206153604.15080-4-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6680452778724989894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 12/06/2017 09:36 AM, Philippe De Swert wrote:
> Add a new function to be able to dial numbers from memory/favourites.
> =

> ---
>   include/voicecall.h | 5 +++++
>   1 file changed, 5 insertions(+)
> =

> diff --git a/include/voicecall.h b/include/voicecall.h
> index 79a64bb4..6c4f3f5f 100644
> --- a/include/voicecall.h
> +++ b/include/voicecall.h
> @@ -61,6 +61,11 @@ struct ofono_voicecall_driver {
>   			const struct ofono_phone_number *number,
>   			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
>   			void *data);
> +	/* dials a number at a given memory location */
> +	void (*dial_memory)(struct ofono_voicecall *vc,
> +			long int memory_location,

Why a long int?  Memory indexes are always positive, no?

Do note that size of long will be different between 32 bit and 64 bit =

architectures.

I would think an unsigned int would be sufficient here

> +			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
> +			void *data);
>   	/* Dials the last number again, this handles the hfp profile last numb=
er
>            * dialing with the +BLDN AT command
>            */
> =


Regards,
-Denis

--===============6680452778724989894==--

