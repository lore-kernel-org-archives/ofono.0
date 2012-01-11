Content-Type: multipart/mixed; boundary="===============1594719434276286069=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4 1/3] SIMCOM SIM900 module support
Date: Wed, 11 Jan 2012 16:24:18 +0100
Message-ID: <1326295458.6454.238.camel@aeonflux>
In-Reply-To: <4F0D70AB.60904@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1594719434276286069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >> +	/* For obtain correct sms service number */
> >> +	g_at_chat_send(data->modem, "AT+CSCS=3D\"GSM\"", NULL, =

> >> +			NULL, NULL, NULL);
> > =

> > you might better introduce a OFONO_VENDOR_SIM900 quirk and use that in
> > the SMS atom driver. The phonebook support will also end up overwriting
> > this one later on. So I am not even sure this works reliable this way.
> > Might be just pure luck with the order of the atom.
> > =

> =

> Actually this is fine assuming the modem does not support UTF-8
> character set.  The builtin assumption for most atoms is that CSCS is
> set to something sane before they're initialized.  The phonebook driver
> will temporarily switch to UCS2 for the duration of the phonebook read
> and restore the previous setting.

we did a vendor quirk for this for USSD of Qualcomm based modems. Maybe
we should then also move that into the modem plugins.

Regards

Marcel



--===============1594719434276286069==--

