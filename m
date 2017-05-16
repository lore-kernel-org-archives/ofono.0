Content-Type: multipart/mixed; boundary="===============6586352044064797989=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] smsutil: sms_decode() allow to pass sms with unknown
 TPDU size
Date: Tue, 16 May 2017 12:49:58 -0500
Message-ID: <42f4d13e-d2c2-bbdd-b268-f9cbbe09c245@gmail.com>
In-Reply-To: <20170516154940.13823-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6586352044064797989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 05/16/2017 10:49 AM, Alexander Couzens wrote:
> Certain modems (QMI based) only return a PDU length, but without
> the length of the TPDU.

It looks like the current QMI_WMS_RESULT_NEW_MSG_NOTIFY assumes that the =

message doesn't have an SMSC preceeding it.  Or is it that we are not =

parsing some other parameters?

> Without passing this information over ofono_sms_deliver_notify() down
> to sms_decode(), sms_decode() will fail, as it try to interpret the
> SC header as PDU header.

How do we know when a PDU contains the SC address and when it doesn't?

> ---
>
> I'm not quite sure this is the best way to implement this.
>
> a) adding a flag to ofono_sms_deliver_notify() would break the api

No, this is not the way to do it

> b) export sms_decode_address_field() which is part of smsutil.h would mean
>    using this function only to get the length of TPDU and throw away the
>    result (address), which is later called a second time.

In-tree drivers can freely utilize core utilities such as smsutil and =

stkutil.  So this isn't really a problem.  Since the QMI API is quite =

dumb, then parsing the SC address field twice is probably the least evil =

way to do this.

> c) add another function to cover this case is also bloated
>
>
>  include/sms.h | 2 ++
>  src/smsutil.c | 8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/include/sms.h b/include/sms.h
> index e9260561..602042d2 100644
> --- a/include/sms.h
> +++ b/include/sms.h
> @@ -60,6 +60,8 @@ struct ofono_sms_driver {
>  				ofono_sms_bearer_set_cb_t, void *data);
>  };
>
> +/* unknown tpdu length, but contains a SC header */
> +#define TPDU_UNKNOWN_WITH_SC -2


Nak.  This couples together the core <-> driver API with the utility =

functions.  They were always independent of each other and should remain =

this way.

>  void ofono_sms_deliver_notify(struct ofono_sms *sms, const unsigned char=
 *pdu,
>  				int len, int tpdu_len);
>  void ofono_sms_status_notify(struct ofono_sms *sms, const unsigned char =
*pdu,
> diff --git a/src/smsutil.c b/src/smsutil.c
> index 24dcfaa7..d4b4a0d4 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -33,6 +33,7 @@
>  #include <unistd.h>
>
>  #include <glib.h>
> +#include <ofono/sms.h>
>
>  #include "util.h"
>  #include "storage.h"
> @@ -1545,7 +1546,12 @@ gboolean sms_decode(const unsigned char *pdu, int =
len, gboolean outgoing,
>
>  	memset(out, 0, sizeof(*out));
>
> -	if (tpdu_len < len) {
> +	if (tpdu_len =3D=3D TPDU_UNKNOWN_WITH_SC) {
> +		/* unknown TPDU length but prefixed with SC */
> +		sms_decode_address_field(pdu, len, &offset, TRUE,
> +				&out->sc_addr);

Why don't you actually check the return value ?

> +		tpdu_len =3D len - offset;
> +	} else if (tpdu_len < len) {
>  		if (!sms_decode_address_field(pdu, len, &offset,
>  						TRUE, &out->sc_addr))
>  			return FALSE;
>

Regards,
-Denis

--===============6586352044064797989==--

