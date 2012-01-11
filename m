Content-Type: multipart/mixed; boundary="===============5431401268958941289=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/3] SIMCOM SIM900 module support
Date: Wed, 11 Jan 2012 05:21:15 -0600
Message-ID: <4F0D70AB.60904@gmail.com>
In-Reply-To: <1326293559.6454.234.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5431401268958941289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>> +	/* For obtain correct sms service number */
>> +	g_at_chat_send(data->modem, "AT+CSCS=3D\"GSM\"", NULL, =

>> +			NULL, NULL, NULL);
> =

> you might better introduce a OFONO_VENDOR_SIM900 quirk and use that in
> the SMS atom driver. The phonebook support will also end up overwriting
> this one later on. So I am not even sure this works reliable this way.
> Might be just pure luck with the order of the atom.
> =


Actually this is fine assuming the modem does not support UTF-8
character set.  The builtin assumption for most atoms is that CSCS is
set to something sane before they're initialized.  The phonebook driver
will temporarily switch to UCS2 for the duration of the phonebook read
and restore the previous setting.

Regards,
-Denis

--===============5431401268958941289==--

