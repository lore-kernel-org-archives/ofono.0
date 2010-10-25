Content-Type: multipart/mixed; boundary="===============4920655705833332128=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] radio settings: add FastDormancy property
Date: Mon, 25 Oct 2010 10:19:56 -0500
Message-ID: <4CC5A01C.9020104@gmail.com>
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782A7D885430@NOK-EUMSG-03.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4920655705833332128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 10/25/2010 10:05 AM, Mika.Liljeberg(a)nokia.com wrote:
> Hi Marcel,
> =

>>> @@ -103,14 +103,60 @@ static DBusMessage =

>> *radio_get_properties_reply(DBusMessage *msg,
>>>  					=

>> OFONO_PROPERTIES_ARRAY_SIGNATURE,
>>>  					&dict);
>>>  =

>>> -	ofono_dbus_dict_append(&dict, "TechnologyPreference",
>>> +	if ((int)rs->mode !=3D -1) {
>>> +		const char *mode =3D =

>> radio_access_mode_to_string(rs->mode);
>>> +		ofono_dbus_dict_append(&dict, "TechnologyPreference",
>>>  					DBUS_TYPE_STRING, &mode);
>>
>> what is up with this (int) rs->mode cast here. That looks highly wrong
>> to me. The mode is an enum so please don't hack around it like this.
>>
>> If mode can be invalid or not present then we need to extend this enum
>> with an initial value of OFONO_RADIO_ACCESS_MODE_UNKNOWN, but not hack
>> some cast magic into it.
> =

> Yes, it's fishy. Denis introduced the enum in commit 81bc8884b414e6c2d511=
789d2e183cdad55182f0 but left mode initialized as -1. I'm not sure what's u=
p with that but I did not want to start fixing it. I suppose the initialize=
r could be added to the enum, as you say, or the whole patch could be rever=
ted. Not my call, though.

I must have missed the -1 initialization.  In general the preference is
as follows:

- If the property is queried at the network, then set to a value that
means "unknown".  Otherwise set to a default sane value.
- Only set to the new value if the query succeeds
- If the query fails (a bizarre case if querying the modem), don't reset
the sane value and don't set cached.  The next GetProperties will try to
re-query the setting.
- Don't show the attribute if the query_ method is not provided by the
driver.

Regards,
-Denis

--===============4920655705833332128==--

