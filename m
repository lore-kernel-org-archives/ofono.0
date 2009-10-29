Content-Type: multipart/mixed; boundary="===============2924431200602934156=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Re: [PATCH 2/2] Altered the atgeneric modem to include the added
 modem.conf options.
Date: Thu, 29 Oct 2009 17:29:34 +0100
Message-ID: <632f5f310910290929m6604d070o502e7076298f2697@mail.gmail.com>
In-Reply-To: <200910291125.06961.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2924431200602934156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/10/29 Denis Kenzior <denkenz@gmail.com>:
> Hi Ryan,
>
>> The modem.conf options for the driver portion of the patch.
>
> Patch has been applied with some refactoring afterward. =C2=A0I know you =
ran
> checkpatch.pl, but please make sure you follow the coding standard even f=
or
> parts which checkpatch.pl does not catch. =C2=A0In particular:
>
>> +static const char *tty_opts[] =3D
>> + =C2=A0{
>> + =C2=A0 =C2=A0 =C2=A0 "Baud",
>> + =C2=A0 =C2=A0 =C2=A0 "Read",
>> + =C2=A0 =C2=A0 =C2=A0 "Local",
>> + =C2=A0 =C2=A0 =C2=A0 "StopBits",
>> + =C2=A0 =C2=A0 =C2=A0 "DataBits",
>> + =C2=A0 =C2=A0 =C2=A0 "Parity",
>> + =C2=A0 =C2=A0 =C2=A0 "XonXoff",
>> + =C2=A0 =C2=A0 =C2=A0 "Rtscts",
>> + =C2=A0 =C2=A0 =C2=A0 NULL,
>> + =C2=A0};
>
> - There are spaces for indentation, ONLY tabs should be used.
> - The opening brace should be on the tty_opts line.
>
Thanks. I will make sure next time.

Greetings,
Ryan

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============2924431200602934156==--

