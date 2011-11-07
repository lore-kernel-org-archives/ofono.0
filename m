Content-Type: multipart/mixed; boundary="===============5500990323204922446=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 1/6] gatchat: Add IPv6 Control Protocol
Date: Mon, 07 Nov 2011 12:26:33 -0600
Message-ID: <4EB822D9.7050507@gmail.com>
In-Reply-To: <1320756418-30890-2-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5500990323204922446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 11/08/2011 06:46 AM, Oleg Zhurakivskyy wrote:
> ---
>  Makefile.am          |    2 +-
>  gatchat/ppp.h        |    8 +
>  gatchat/ppp_ipv6cp.c |  377 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 386 insertions(+), 1 deletions(-)
>  create mode 100644 gatchat/ppp_ipv6cp.c

Patch has been applied, however you made one small error here:


<snip>

> +		switch (type) {
> +		case IPV6CP_INTERFACE_ID:
> +			memcpy(&ipv6cp->peer_addr, data,
> +					sizeof(ipv6cp->peer_addr));
> +			if (ipv6cp->peer_addr !=3D 0)
> +				break;
> +			/*
> +			 * Fall through, reject zero Interface ID
> +			 */
> +			break;

The break statement seems to be in error and I fixed it in a follow on
commit.  Let me know if I was wrong.

> +		default:
> +			if (options =3D=3D NULL) {
> +				guint16 max_len =3D ntohs(packet->length) - 4;
> +				options =3D g_new0(guint8, max_len);
> +			}
> +
> +			OPTION_COPY(options, len, options !=3D NULL,
> +					type, data,
> +					ppp_option_iter_get_length(&iter));
> +			break;
> +		}
> +	}
> +

Regards,
-Denis

--===============5500990323204922446==--

