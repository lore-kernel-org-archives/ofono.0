Content-Type: multipart/mixed; boundary="===============4964937876305552987=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] src/lte: added proto and authentication handling
Date: Fri, 12 Oct 2018 12:47:00 -0500
Message-ID: <7bf041d0-299d-51b3-896b-2ca242ff0646@gmail.com>
In-Reply-To: <CAKSBH7Ez4GTSFwgo29Sbmh-BW1W9HqOU=fgQpJGHZta1BM_5kQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4964937876305552987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>> Ugh.  I'm not really liking this at all.  The property name and the new
>> value are already available inside the dbus_message object (e.g.
>> lte->pending).  There's nothing wrong with parsing that message again or
>> simply store pointers to the data inside the dbus-message.
>>
> =

> ah no! this is the famous "it's initialized to NULL when the structure
> is created", do you remember it?

No?

> The pointer to the dbus message would go out of scope once the dbus
> message is answered, which happens before the signal is emitted.
> =


So build the signal prior to answering the method return...  You can =

still send the signal afterwards.

>>> +             if (!*propstr)
>>> +                     /* Clear entry on empty string. */
>>> +                     g_key_file_remove_key(lte->settings,
>>> +                             SETTINGS_GROUP, key, NULL);
>>>                else
>>> -                     g_key_file_set_string(lte->settings, SETTINGS_GRO=
UP,
>>> -                                             DEFAULT_APN_KEY, lte->inf=
o.apn);
>>> +                     g_key_file_set_string(lte->settings,
>>> +                             SETTINGS_GROUP, key, propstr);
>>>
>>>                storage_sync(lte->imsi, SETTINGS_STORE, lte->settings);
>>>        }
>>
>> I can see this applying for APN and maybe Username/Password.  But not
>> the other settings...?
> =

> I don't get this sorry. which part is applicable only to apn/user/pwd?
> the propstr is never null for protocol and auth_method, due to the
> close-set enumeration.

The removal part should probably only apply to APNs and Username / =

Password.  Fair enough that others would never be empty, but you might =

still want to make an explicit check or at least a comment stating this =

for clarity.

Regards,
-Denis

--===============4964937876305552987==--

