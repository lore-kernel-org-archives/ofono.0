Content-Type: multipart/mixed; boundary="===============3177747207128267732=="
MIME-Version: 1.0
From: Benis, Robertino <robertino.benis@intel.com>
Subject: RE: [PATCH v5] ifx: Adding modem selftest for Infineon modem
Date: Wed, 26 Jan 2011 16:06:37 -0800
Message-ID: <CB28AA307186A940B1253A743EA1F20ABCED9EA0@orsmsx507.amr.corp.intel.com>
In-Reply-To: <1295891257.1520.6.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3177747207128267732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>> Infineon modem selftest, during ifx_enable().
>> Two steps trigger, with timeout. In case one
>> fails, modem will not power up.

<snip>

>> +     flags =3D g_io_channel_get_flags(data->device) | G_IO_FLAG_NONBLOC=
K;
>> +     g_io_channel_set_flags(data->device, flags, NULL);
>> +
>> +     g_io_channel_set_encoding(data->device, NULL, NULL);
>> +     g_io_channel_set_buffered(data->device, FALSE);

> have you actually tested this patch. Your re-base of the patch is wrong
> again. It will not work like this.

You are right. I am sorry about this. There are times when state of my plat=
form hardware does not match patch submissions schedule... =


Updated and validated patch is coming out in the next e-mail.

Thank you,
-- r.
--===============3177747207128267732==--

