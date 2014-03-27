Content-Type: multipart/mixed; boundary="===============5715553094687570830=="
MIME-Version: 1.0
From: Eric BOUXIROT <eric.bouxirot@azimut-monitoring.com>
Subject: Re: problem sim status
Date: Thu, 27 Mar 2014 21:21:28 +0100
Message-ID: <lh218l$pqc$1@ger.gmane.org>
In-Reply-To: <53348499.30802@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5715553094687570830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior a pens=C3=A9 tr=C3=A8s fort :
> Hi Eric,
>
> On 03/27/2014 01:55 PM, Eric BOUXIROT wrote:
>> hi,
>> =

>> i make an embedded platform with a 3G modem from Sierra Wireless (SL808x
>> series).
>> i have a problem with ofono (v1.14) that ask sim status too fast after
>> modem added resulting in CME Error 14 (SIM busy).
>> =

>> is there a way to delay the sim status query (+CPIN) ??
>> =

>
> Try adding OFONO_VENDOR_SIERRA to the list of vendors that require CPIN?
> retry logic.  See drivers/atmodem/sim.c:1256
>
> Regards,
> -Denis

ok, i will add this, but if i understand well, this is for +CPIN =

request AFTER sending a PIN. (but i mean my modem need this too.)

my problem is when modem is added throught dbus/ofono, ofono send somes =

init commands and finaly i mean sim-manager send an +CPIN request to =

know if SIM is locked or not... THIS request fail with CME error 14 =

because of too fast query.

i will try to put a log in few minutes..


--===============5715553094687570830==--

