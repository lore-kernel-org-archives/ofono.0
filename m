Content-Type: multipart/mixed; boundary="===============0922008841422617667=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 07/20] SMS: implement SHA256-based message IDs [incomplete]
Date: Tue, 27 Jul 2010 12:03:02 -0500
Message-ID: <4C4F1146.8050409@gmail.com>
In-Reply-To: <47f01a9253e6f181da9435a7d52a600220665aee.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0922008841422617667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> -unsigned int __ofono_sms_txq_submit(struct ofono_sms *sms, GSList *list,
> -					unsigned int flags,
> +struct tx_queue_entry * __ofono_sms_txq_submit(struct ofono_sms *sms, GS=
List *list,
> +					unsigned int flags, unsigned ref,
>  					ofono_sms_txq_submit_cb_t cb,
>  					void *data, ofono_destroy_func destroy);

I disagree with this, you're modifying an ofono internal API function to
return a structure which is opaque and cannot be manipulated.  I'd
rather see you returning a struct sms_uuid...

> +	/*
> +	 * Instead of using the telephone number/address we got from
> +	 * D-Bus, we do the reverse formatting, so we get something
> +	 * that has been normalized--this is used later and we do it
> +	 * here to simplify error handling.
> +	 */
> +	sms_address_from_string(&receiver, to);
> +	if (sms_address_to_hex_string(&receiver, receiver_str)
> +	    =3D=3D FALSE)
> +		return __ofono_error_failed(msg);

Please avoid mixing tabs and spaces for indentation.  And in this case
it is more readale to break up the function than the equals line.  E.g.

if (sms_address_to_hex_string(&receiver,
				receiver_str =3D=3D FALSE)
	return __ofono_error_failed(msg);

Regards,
-Denis

--===============0922008841422617667==--

