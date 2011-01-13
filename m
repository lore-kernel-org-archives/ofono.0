Content-Type: multipart/mixed; boundary="===============5356434317496473498=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] message: Code independent of protocol stack
Date: Thu, 13 Jan 2011 16:41:39 -0600
Message-ID: <4D2F7FA3.9050600@gmail.com>
In-Reply-To: <4D2F898D.2000900@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5356434317496473498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Faiyaz,

>> Please keep this as an internal API (e.g.
>> __ofono_message_path_from_uuid) and update ofono.h appropriately.
> =

> Based on a comment in Patch 2/3, message.h and message.c are internal to
> core and to me they look more of a utility/helper functions to sms.c
> file (and in future cdma-sms.c file).  So should I even include
> "message.h" in ofono.h file. I could only rename the function to be
> message_XXX.
> =

> The sms.h still maintains the API "__ofono_sms_message_path_from_uuid"
> which is shared with "smart-messaging.c" and is defined in ofono.h
> =

> =


That would be fine as well.

>>> -        if (message_dbus_register(sms, m) =3D=3D FALSE)
>>> +        if (ofono_message_dbus_register(
>>> +                    __ofono_atom_get_path(sms->atom),
>>> +                                m) =3D=3D FALSE)
>>
>> This looks a bit ugly, can you find a better way to do this?  Perhaps
>> message_create should simply take an atom as well.
> I think we can go with
> 1) Pass "sms->atom", add "struct ofono_atom *atom" in the message struct
> and initialize the reference of the same in message_create. But I am not
> sure if it will be okay to pass a reference to a private data member
> from struct ofono_sms.
> struct message {
>     struct ofono_uuid uuid;
>     enum message_state state;
>     void *data;
>         struct ofono_atom *atom;
> };
> =

> 2) Pass "__ofono_atom_get_path(sms->atom)" and use malloc in
> message_create to initialize "atompath". Just use atompath through the
> code. But a general observation I had was that in ofono we used "static
> char xxx[]" instead of doing malloc. Hence did not go this route in the
> initial patch.
> =

> struct message {
>     struct ofono_uuid uuid;
>     enum message_state state;
>     void *data;
>     char *atompath;
> };
> =

> Please let me know your thoughts on the same.
> =


I don't think there's a huge difference between the two.  Use the atom
member for now and I will have a closer look when you resubmit.

Regards,
-Denis

--===============5356434317496473498==--

