Content-Type: multipart/mixed; boundary="===============0885545025822267662=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem/lte: proto and authentication handling
Date: Wed, 24 Oct 2018 21:50:19 -0500
Message-ID: <a946f636-f5f9-2de3-8967-c8d21fb57e94@gmail.com>
In-Reply-To: <CAKSBH7EKBZ68oBnarbfmmBGssfAoTguYPtpFPpnk84XcNm-R-w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0885545025822267662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>>> +     const struct ofono_lte_default_attach_info *info;
>>
>> And honestly, I'd just put this into lte_driver_data as well.
>>
>> Nope you can't do this. This is the third time I nak-ed this part
> =

> I can't do what? I don't see what you are referring to.
> =


There are two comments here.  First is that this 'pending' info stuff =

doesn't belong here.

Second is that you cannot hold a reference to an object owned by the =

core.  The driver cannot assume that it will be valid for the duration =

of the asynchronous operation.  E.g. the core might have created a =

temporary object on the stack to pass to the driver and it will go =

*poof* as soon as the driver function returns.

There is very strict separation between driver managed memory / =

structures and ones owned by the core.

Regards,
-Denis

--===============0885545025822267662==--

