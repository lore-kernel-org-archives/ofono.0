Content-Type: multipart/mixed; boundary="===============5455365727455844831=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCH] plugins-mbm: Combining mbm_disable and reopen_callback
Date: Wed, 12 Jan 2011 18:42:43 +0100
Message-ID: <AANLkTin8kasNL6OkGO+pN2=ECKDAoERasAp7UYBL-bn4@mail.gmail.com>
In-Reply-To: <AANLkTim3ZMKZWDhLk5iWdObiQTBgJZXbTUKos=ZXB+Ym@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5455365727455844831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tomasz, don't worry the tone on the list is quite rough. If you
like marit or I can review tomorrow, but feel free to send patch as
well if you like. :) Sjur

2011/1/12, Tomasz Gregorek <tomasz.gregorek@gmail.com>:
> Hi Marcel
> I already had my solution in head and misunderstood you. I will correct a=
nd
> retest it.
> Br
> Tomasz
>
> 2011/1/12 Marcel Holtmann <marcel@holtmann.org>
>
>> Hi Tomasz,
>>
>> > Combining mbm_disable and reopen_callback into one and removing 1 seco=
nd
>> > delay between them to avoid call to reopen_callback after modem being
>> > disconnected.
>>
>> have you actually tested this? This will not work since you can not
>> reopen the TTY right away. You need that delay in between.
>>
>> From my previous email, I remember saying that the right fix would be to
>> disarm the timer within disable. Why are we not doing that?
>>
>> Regards
>>
>> Marcel
>>
>>
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> http://lists.ofono.org/listinfo/ofono
>>
>

--===============5455365727455844831==--

