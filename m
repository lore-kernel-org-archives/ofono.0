Content-Type: multipart/mixed; boundary="===============8178570358486263810=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [RFC v4 09/10] hfp_ag: Add media transport support
Date: Tue, 24 Apr 2012 18:19:51 +0200
Message-ID: <4F96D2A7.1090903@linux.intel.com>
In-Reply-To: <4F7F29FA.5060106@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8178570358486263810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

Le 06/04/2012 19:38, Denis Kenzior a =C3=A9crit :
> Hi Fr=C3=A9d=C3=A9ric,
>
>> @@ -82,6 +93,12 @@ static DBusMessage *hfp_ag_agent_new_connection(DBusC=
onnection *conn,
>>   		return __ofono_error_failed(msg);
>>
>>   	ofono_emulator_register(em, fd);
>> +	audio =3D bluetooth_set_audio_management(em, path, features);
>> +
>> +	io =3D g_io_channel_unix_new(fd);
>> +	g_io_add_watch_full(io, G_PRIORITY_HIGH,
>> +				G_IO_HUP | G_IO_ERR | G_IO_NVAL, client_event,
>> +				audio, NULL);
>
> It might be better to register to atom removal rather than an IO watch.

As modem can have multiple emulator atoms (in case of connection to =

multiple headsets), I do not think that registering for atom removal =

using __ofono_modem_add_atom_watch() will be OK.

I may add an API to emulator to register a disconnection callback:
     ofono_emulator_set_disconnect_cb(em, cb, cb_data)

This keep separation between oFono core and HFP AG plug-in.

Regards

Fred

-- =

Frederic Danis                            Open Source Technology Center
frederic.danis(a)intel.com                              Intel Corporation


--===============8178570358486263810==--

