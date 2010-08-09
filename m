Content-Type: multipart/mixed; boundary="===============3993091973618140618=="
MIME-Version: 1.0
From: Leaf John <leafjohn@gmail.com>
Subject: Re: [PATCH] add default property setter for modemconf
Date: Mon, 09 Aug 2010 16:30:13 +0800
Message-ID: <AANLkTimGZLPZfUcecYk0ZJPiXJi3jG5-LfZO_UYfh3gc@mail.gmail.com>
In-Reply-To: <1281342257.12579.189.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3993091973618140618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On common linux distros, suse, ubuntu, fedora.., ofono do auto-detect well,
However, on my meego netbook, ofono won't auto detect any devices.
That is the reason why i do this.

For N900, we could use as an atgen modem
for Huawei, we can use it with current modemconf system.
so this patch becomes as the only way for me to use huawei stick on the net=
book.


On Mon, Aug 9, 2010 at 4:24 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Leaf,
>
>> I was trying to run ofono for a huawei usb modem on my meego netbook,
>> but the udev on netbook seems not work for ofono, so that I've to
>> mannualy write settings in modem.conf.
>>
>> Huawei driver needs two device, pcui & modem, and I can't specify them
>> by either Interface & Device in modem.conf.
>>
>> Then I wrote this patch, It will load all Key=3DValue pairs in
>> modem.conf file( Except Driver=3Dxxx pair ), and store them to modem
>> properties.
>>
>> Then I add Pcui=3D & Modem=3D entry in modem.conf file, it works, I can
>> use ofono to send & recieve message by huawei stick now.
>
> my question is why you wanna do this at all? oFono should auto-detect
> any Huawei modem via udev. So this is not needed.
>
> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>



-- =

Best Reagres,
Leaf Johnson<leafjohn@gmail.com>

--===============3993091973618140618==--

