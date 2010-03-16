Content-Type: multipart/mixed; boundary="===============6839583081009981198=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH] Add support of Huawei EM770 modem
Date: Tue, 16 Mar 2010 15:05:29 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731C76AFCA@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1268721909.2700.15.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6839583081009981198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Marcel Holtmann
>Sent: Tuesday, March 16, 2010 2:45 PM
>To: ofono(a)ofono.org
>Subject: Re: [PATCH] Add support of Huawei EM770 modem
>
>Hi Yang,
>
>> Comparing with general Huawei modem, EM770 is a full feature modem that
>> supports voicecall, phonebook, call forwarding, call barring, etc.
>> ---
>>  Makefile.am            |    3 +
>>  plugins/huawei-em770.c |  226
>++++++++++++++++++++++++++++++++++++++++++++++++
>>  plugins/ofono.rules    |    1 +
>>  plugins/udev.c         |   27 ++++++
>>  4 files changed, 257 insertions(+), 0 deletions(-)
>>  create mode 100644 plugins/huawei-em770.c
>
>for simplicity just let call it em770.c and everything where you have
>huawei_em770 just use em770. We do similar things for G1 etc.

I added the prefix "huawei" on purpose so that other users may not confuse =
about what kind of modem it belongs. Anyway, I will remove it soon. =


>
>Regards
>
>Marcel
>
>
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============6839583081009981198==--

