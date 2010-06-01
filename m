Content-Type: multipart/mixed; boundary="===============1906888501020690464=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/11] stkutil: Add SMS-PP Data Download envelope builder
Date: Tue, 01 Jun 2010 18:50:19 -0500
Message-ID: <201006011850.19709.denkenz@gmail.com>
In-Reply-To: <1275310044-27469-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1906888501020690464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Note that the sms_tpdu member could be of type struct sms_deliver, but the
> users may more often have access to the raw tpdu so there's no point
> decoding and reencoding it.

Overall patch looks fine, but using a raw pdu is not preferable.  Couple of =

reasons:

- When SMS is delivered, it is delivered in tpdu form, e.g. sc_address + =

deliver pdu.  To obtain the sc_address, we need to decode the deliver tpdu =

anyway.
- Before we know this is an SMS-PP download, we must check the dcs / pid.  =
In =

order to check those, we must again decode the tpdu.
- SMS sc_address can actually be non-numeric.  In that case the SMS-PP =

download should simply be dropped.
- Consistency with Send SMS proactive command.

> +
> +/* Returns TRUE on success */
> +ofono_bool_t stk_pdu_from_envelope(const struct stk_envelope *envelope,
> +					unsigned char *pdu, unsigned int size,
> +					unsigned char **out_pdu,
> +					unsigned int *out_size);
> =


This part just looks ugly.  Can't we hide the details of char buf[512] =

somewhere inside stk_pdu_from_envelope?  Or perhaps make **out_pdu and =

*out_size in/out arguments instead of just out.

Regards,
-Denis

--===============1906888501020690464==--

