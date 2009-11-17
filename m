Content-Type: multipart/mixed; boundary="===============3970335837509774710=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Re: Telit 864
Date: Tue, 17 Nov 2009 10:18:10 +0100
Message-ID: <4B026A52.5070404@gmail.com>
In-Reply-To: <212294.47471.qm@web63406.mail.re1.yahoo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3970335837509774710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



Fundu wrote:
> Thanks Ryan !
> =

> so let me ask this then what's involved in getting data modem part workin=
g ?
> =

Uhhh. This is not modem specific.

> I can help a on that. Don't know what would be involved in that.
> =

> My area of comfort.
> 1) C =

> 2) linux drivers
> 3) fair understanding of the telit AT command set.
> =

> not familiar with pppd and wonder how that would play into the picture ?

My suggestion is to read up on pppd and its interaction with modems.

http://en.wikipedia.org/wiki/Point-to-Point_Protocol_daemon

http://tldp.org/HOWTO/PPP-HOWTO/

Ryan
> =

> -fundu =

> =

> =

> ----- Original Message ----
> From: Ryan Raasch <ryan.raasch@gmail.com>
> To: ofono(a)ofono.org
> Sent: Sat, November 14, 2009 8:44:57 AM
> Subject: Re: Telit 864
> =

> Looks like it would work. Compile source, plugin usb cable, run export OF=
ONO_AT_DEBUG=3D1 && ofonod -d -n, run enable-modem script and see if runs.
> =

> The data modem part isn't quite finished yet. Meaning you can't use pppd =
or setup a network device for the rest of the sytem to use (using GPRS, etc=
.). The rest works quite nicely.
> =

> Cheers,
> Ryan
> =

> Fundu wrote:
>> Hi,
>>
>> this is my first post, so please excuse me if it doesn't follow some set=
 rules.
>>
>> Is the TELIT 864 module supported by ofono ? =

>> what i'm looking at is the ability to be able to communicate with the te=
lit module over serial or usb and also use it as a data modem.
>>
>> any insights would be appreciated.
>>
>> thanks !
>>
>> fundu
>>
>>
>>
>>       _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> http://lists.ofono.org/listinfo/ofono
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
> =

> =

> =

>       =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============3970335837509774710==--

