Content-Type: multipart/mixed; boundary="===============2061393119841452319=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH 1/4] Add: Online property to modem
Date: Thu, 27 May 2010 18:14:03 +0300
Message-ID: <AANLkTik_bD5RSKdfM5_sVGPWCaG9eeFEGSpOj1YbJ0cF@mail.gmail.com>
In-Reply-To: <201005270945.53526.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2061393119841452319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/5/27 Denis Kenzior <denkenz@gmail.com>:
> Hi Pekka,
>
>> 2010/5/27 Denis Kenzior <denkenz@gmail.com>:
>> > Patch has been applied, however I did some refactoring afterward. =C2=
=A0Please
>> > test that I didn't break something.
>>
>> There is now a race condition in online/offline and sim hotswap. With
>> imperfect hw a missing sim gets detected only when modem attempts to
>> register to network and actually tries to read something from sim
>> card. I have no idea if the missing sim can be reported before +cops
>> command response is returned.
>
> Sorry, but how does such a modem even get to the sim ready state? =C2=A0o=
Fono reads
> the IMSI before it even tries to send post_sim, and you certainly can't r=
ead
> the IMSI without a sim card.

If you have a SIM card and then remove it, modem should go to pre_sim
state (and the expectation is that it will go offline, too.)  However,
unless explicitly told otherwise, isimodem goes to limited service
mode.

>> However, at least isimodem needs explicitly told to go offline when
>> sim gets removed.
>>
>
> My thinking is that the modem drivers can take care of this. =C2=A0The co=
re needs
> to be kept simple here and assume an 'ideal' implementation.
>
> I'm still having trouble understanding how we'll support emergency calls =
with
> no SIM with this framework though.

The online/offline cuts in only if you have SIM card (and PIN is
entered/disabled).

-- =

Pekka.Pessi mail at nokia.com

--===============2061393119841452319==--

