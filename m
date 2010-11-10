Content-Type: multipart/mixed; boundary="===============2245046975169832371=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 2/3] modem: add EmergencyMode property
Date: Wed, 10 Nov 2010 08:25:28 -0600
Message-ID: <4CDAAB58.20000@gmail.com>
In-Reply-To: <4CDAA8E0.3040403@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2245046975169832371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

>> So we have to be a bit careful here.  You can't simply call
>> modem_change_state here.  This results in calling the post_online
>> method, which populates the atoms that function when the radio is on.
>> Instead you need to call the set_online driver method directly.
>>
>> Also, you probably do not want to populate the online atoms in an
>> emergency call situation.  Each atom driver / atom will perform
>> initialization procedures when they're newly added.  This can
>> potentially interfere with the voice call setup time, and not desirable.
>>   Not to mention that if we're actually in an emergency situation with
>> the SIM removed or PIN locked, we do not want to populate the atoms in
>> the first place.
>>
>> So the modem 'ONLINE_STATE' has to be slightly de-coupled from whether
>> the radio is 'online'.
>>
>>    =

> Good point, thanks. I am going to call directly the modem driver
> set_online function with my own callback.
> =

> Now the question is whether modem->online should be toggled
> according to the radio state changes? I think yes, and have the
> change signaled on D-Bus (modem "Online" poperty).

That makes sense to me, yes.

> =

> There is another question then, when to notify the modem online
> watchers, supposedly whenever modem->online changes, including
> the changes triggered by the emergency call case.

In the current structure this is just fine.  So let us run with it for
now and see what happens.  In the future we might find something a bit
more complicated is required, but we cross that bridge when we come to it.

> =

>>> +}
>>> +
>>> +void ofono_modem_dec_emergency_mode(struct ofono_modem *modem)
>>> +{
>>> +    DBusConnection *conn =3D ofono_dbus_get_connection();
>>> +    const char *path =3D ofono_modem_get_path(modem);
>>> +    gboolean state =3D FALSE;
>>> +
>>> +    modem->emergency_mode--;
>>> +    if (modem->emergency_mode)
>>> +        return;
>>> +
>>> +    ofono_dbus_signal_property_changed(conn, path,
>>> +                        OFONO_MODEM_INTERFACE,
>>> +                        "EmergencyMode",
>>> +                        DBUS_TYPE_BOOLEAN,
>>> +                        &state);
>>>      =

>> Here you should turn the radio off if it was off before starting the
>> emergency call.
>>
>>    =

> =

> The rationale behind leaving the radio on after emergency calls
> was to have the theoretical possibility the emergency call center
> to call you back (when SIM card is present...). If this is an unrealistic
> scenario, I'll disable the radio after emergency calls in case it was off
> before the call.
> =


That is a fair point, however, just silently leaving us Online might not
be a good idea.

I suggest finding out how exactly this is supposed to work.  E.g. can we
get away with starting an X minute timeout every time we leave emergency
mode and go offline automatically?  This timeout would obviously have to
be canceled if the user sets Online manually.

Regards,
-Denis

--===============2245046975169832371==--

