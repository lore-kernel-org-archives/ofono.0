Content-Type: multipart/mixed; boundary="===============0832377690836023945=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [online-impl-v2 PATCH 00/10] implement Online property
Date: Tue, 14 Sep 2010 21:49:19 +0300
Message-ID: <AANLkTinNFDnPKe5dNniR7thus-6TtacO5EoJCBQT=FKo@mail.gmail.com>
In-Reply-To: <1283988973.6640.141.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0832377690836023945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2010/9/9 Marcel Holtmann <marcel@holtmann.org>:
>> Here are 2nd stab at implementing Online property with various modem
>> drivers.
>
> so I pushed most of them, but not all of them.

Ok. Cool.

> STE version needs testing by the STE guys, but I did run into some SIM
> not ready issues with MBM when switching online/offline a few times. So
> that needs to be looked into.

Please have a peek in your AT log and see if there are some spurious
+GCAP: lines? My Dell 5530 branded MBM apparently sends internal
AT+GCAP command. Command and its results gets echoed to the serial
port which obviously confuses the AT parser. Perhaps most MBMs would
benefit from registering dummy "+GCAP:".

> The Huawei has more and more issues with SIM not ready now. This needs
> fixing anyway. I pushed the patch anymore to make these symptoms more
> clear to everybody.

I'll try to remember to fish out my Huawei from the junk box and see
what it has to offer now. ;)

-- =

Pekka.Pessi mail at nokia.com

--===============0832377690836023945==--

