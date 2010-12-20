Content-Type: multipart/mixed; boundary="===============0165155278042944732=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/9] types: Add CDMA Phone Number
Date: Mon, 20 Dec 2010 14:48:44 -0600
Message-ID: <4D0FC12C.6040303@gmail.com>
In-Reply-To: <1292627481-9109-3-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0165155278042944732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

On 12/17/2010 05:11 PM, Dara Spieker-Doyle wrote:
> ---
>  include/types.h |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> =

> diff --git a/include/types.h b/include/types.h
> index de15437..a394775 100644
> --- a/include/types.h
> +++ b/include/types.h
> @@ -84,6 +84,14 @@ struct ofono_phone_number {
>  	int type;
>  };
>  =


I applied this patch, but amended the commit for some trivial style issues:

> +/* Length of NUM_FIELDS in 3GPP2 C.S0005-E v2.0*/

The closing comment */ should have a space in front

> +#define OFONO_CDMA_MAX_PHONE_NUMBER_LENGTH 256
> +
> +struct ofono_cdma_phone_number {
> +	/*char maps to max size of CHARi (8 bit) in 3GPP2 C.S0005-E v2.0*/

Space after the comment opening and before the comment closing.

> +	char number[OFONO_CDMA_MAX_PHONE_NUMBER_LENGTH];
> +};
> +
>  struct ofono_call {
>  	unsigned int id;
>  	int type;

Regards,
-Denis

--===============0165155278042944732==--

