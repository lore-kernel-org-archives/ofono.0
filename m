Content-Type: multipart/mixed; boundary="===============5836227980845828726=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] dbus: fix appending on dict for types other than string
Date: Tue, 04 Jan 2011 11:53:17 -0600
Message-ID: <4D235E8D.8030404@gmail.com>
In-Reply-To: <1294162273.5852.100.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5836227980845828726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>>  =

>>  		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
>>  						&(val_array[i + 0]));
>> -		dbus_message_iter_append_basic(&entry, type,
>> -						&(val_array[i + 1]));
>> +		if (type =3D=3D DBUS_TYPE_STRING) {
>> +			dbus_message_iter_append_basic(&entry, type,
>> +							&(val_array[i + 1]));
>> +		} else {
>> +			dbus_message_iter_append_basic(&entry, type,
>> +							val_array[i + 1]);
>> +		}
> =

> this does looks a bit hackish. Can you put it into context please. It
> might be that our call chain is wrong.
> =


We only ever needed (and thus ever added) support for string:string
dicts.  E.g. ones that could be g_strfreev-ed.  No other dicts were
supported by this function.

What Lucas wants is a dict{string,byte}

Regards,
-Denis

--===============5836227980845828726==--

