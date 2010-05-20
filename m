Content-Type: multipart/mixed; boundary="===============7388039904950797409=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH v3 1/2] huawei: detect SecondaryDevice which is used for
 events
Date: Thu, 20 May 2010 10:15:51 +0300
Message-ID: <87sk5nnivs.fsf@potku.valot.fi>
In-Reply-To: <201005190840.59307.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7388039904950797409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

> Hi Kalle,

Hi Denis,

> Please keep the commit header to less than 50 lines.

Fixed.

>> +	device =3D ofono_modem_get_string(modem, "SecondaryDevice");
>> +	if (!device)
>> +		return -EINVAL;
>
> Two tabs is enough here.

Sorry, but I see only two tabs here. What am I missing? Ah, now I
understand. I think you are commenting the line earlier in
huawei_enable() which is indented wrong. I'll fix that.

>> +	channel =3D g_at_tty_open(device, NULL);
>> +	if (!channel)
>> +		return -EIO;
>> +
>> +	syntax =3D g_at_syntax_new_gsm_permissive();
>> +	data->event =3D g_at_chat_new(channel, syntax);
>> +	g_at_syntax_unref(syntax);
>> +	g_io_channel_unref(channel);
>> +
>> +	if (!data->event)
>> +		return -EIO;
>> +
>> +	g_at_chat_add_terminator(data->event, "COMMAND NOT SUPPORT", -1,
>> +				 FALSE);
>
> Don't mix spaces and tabs for indentation

Fixed.

>> +
>> +	if (getenv("OFONO_AT_DEBUG"))
>> +		g_at_chat_set_debug(data->event, huawei_event_debug, NULL);
>> +
>> +
>
> Why the extra space?

You mean the newline, right? That's by accident, I removed it now.

> Also, this entire sequence leaks the data->chat in case the 2nd port
> could not be opened. See plugins/mbm.c for an example on how to do
> this better.

Damn, so it does. I changed it now to follow the style from mbm.c.

Thanks a lot for the comments.

-- =

Kalle Valo

--===============7388039904950797409==--

