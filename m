Content-Type: multipart/mixed; boundary="===============2837319921963816880=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2, 5/7] cdmamodem: Add CDMA SMS driver support
Date: Wed, 05 Jan 2011 11:52:29 -0600
Message-ID: <4D24AFDD.7040505@gmail.com>
In-Reply-To: <4D24B038.2040200@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2837319921963816880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lei,

>>> +
>>> +    data->vendor =3D vendor;
>>> +
>>> +    ofono_cdma_sms_set_data(cdma_sms, data);
>>> +
>>> +    at_sms_initialized(cdma_sms);
>>
>> Currently it is not possible to call the register method from within
>> probe.  So you need to either use g_idle_add or run an AT command before
>> registering the cdma_sms atom.  See how other drivers do this.
>>
> =

> Will fix. Could you pls explain why it is not possible to do this sync
> way but have to force this into async? I have tested and it worked. Or
> this is just a general architecture rule between atom and driver?
> =


This is a general rule.  The core atom implementation reserves the right
to start calling driver functions as soon as the atom is registered.  If
the atom is registered within probe, then atom driver is still NULL.
This results in a crash.

Regards,
-Denis

--===============2837319921963816880==--

