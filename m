Content-Type: multipart/mixed; boundary="===============5822470511615999601=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 7/8] voicecall: add +CHUP support for HFP emulator
Date: Mon, 11 Apr 2011 11:50:16 -0500
Message-ID: <4DA33148.7040903@gmail.com>
In-Reply-To: <4DA3300A.1000208@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5822470511615999601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

>>> +    switch (ofono_emulator_request_get_type(req)) {
>>> +    case OFONO_EMULATOR_REQUEST_TYPE_COMMAND_ONLY:
>>> +        if (vc->driver->release_specific =3D=3D NULL&&
>>> +                vc->driver->hangup_active =3D=3D NULL)
>>> +            goto fail;
>>> +
>>> +        if (vc->driver->hangup_active) {
>>> +            vc->driver->hangup_active(vc, emulator_generic_cb, em);
>>> +            goto done;
>>> +        }
>>> +
>>> +        /* if there is already a CHUP pending we return an error */
>>> +        if (vc->hfp_release_list)
>>> +            goto fail;
>>
>> Why are you checking this here?  Shouldn't you check this before
>> potentially sending a hangup_active?
> As far as I understand AT+CHUP, it releases all active calls (active +
> incoming + dialing + alerting), so we do not need a call list and are
> not able to know that we already perform one.
> =

> Is it correct ?

Yes you're right.  I jumped ahead slightly.  Since I'd like to re-use
release_queue, it would be safer to check for the release list prior to
issuing any driver commands (just in case the release_list was set by
something else.)

Regards,
-Denis

--===============5822470511615999601==--

