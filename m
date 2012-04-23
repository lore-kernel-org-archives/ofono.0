Content-Type: multipart/mixed; boundary="===============1282238109741884184=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC v4 09/10] hfp_ag: Add media transport support
Date: Mon, 23 Apr 2012 14:24:55 -0500
Message-ID: <4F95AC87.3030201@gmail.com>
In-Reply-To: <4F96D2A7.1090903@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1282238109741884184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On 04/24/2012 11:19 AM, Frederic Danis wrote:
> Hello Denis,
> =

> Le 06/04/2012 19:38, Denis Kenzior a =C3=A9crit :
>> Hi Fr=C3=A9d=C3=A9ric,
>>
>>> @@ -82,6 +93,12 @@ static DBusMessage
>>> *hfp_ag_agent_new_connection(DBusConnection *conn,
>>>           return __ofono_error_failed(msg);
>>>
>>>       ofono_emulator_register(em, fd);
>>> +    audio =3D bluetooth_set_audio_management(em, path, features);
>>> +
>>> +    io =3D g_io_channel_unix_new(fd);
>>> +    g_io_add_watch_full(io, G_PRIORITY_HIGH,
>>> +                G_IO_HUP | G_IO_ERR | G_IO_NVAL, client_event,
>>> +                audio, NULL);
>>
>> It might be better to register to atom removal rather than an IO watch.
> =

> As modem can have multiple emulator atoms (in case of connection to
> multiple headsets), I do not think that registering for atom removal
> using __ofono_modem_add_atom_watch() will be OK.

Not sure I'm following, the core will still fire the atom watch for each
and every atom, even if there are multiple of the same type.  So the
worst case you might need a hashtable to map between atoms and your own
data structure.

> =

> I may add an API to emulator to register a disconnection callback:
>     ofono_emulator_set_disconnect_cb(em, cb, cb_data)

And maybe ofono_emulator_set/get_data might be even easier and more
flexible.

Regards,
-Denis

--===============1282238109741884184==--

