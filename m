Content-Type: multipart/mixed; boundary="===============7987167936177525798=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Making voice call with Huawei E272 USB Modem
Date: Thu, 13 Jan 2011 10:08:55 -0600
Message-ID: <4D2F2397.6040906@gmail.com>
In-Reply-To: <1294933381.8421.13.camel@yanni-laptop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7987167936177525798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Neels,

On 01/13/2011 09:43 AM, yanni wrote:
> Hi
> =

> I've managed to send SMSs and perform USSD etc. with ofono and the E272.
> =

> However, I'm unable to make a voice call with ofono.  I can make voice
> call with python&pyserial.
> =

> Any pointers in right direction will be appreciated
> =

> #output from list-modem testscrip
> ./list-modems =

> [ /huawei0 ]
>     Features =3D sms gprs cbs net rat sim =

>     Powered =3D 1
>     Lockdown =3D 0
>     Interfaces =3D org.ofono.SmartMessaging org.ofono.PushNotification
> org.ofono.MessageManager org.ofono.ConnectionManager
> org.ofono.CellBroadcast org.ofono.NetworkRegistration
> org.ofono.SupplementaryServices org.ofono.Phonebook
> org.ofono.RadioSettings org.ofono.SimManager =

>     Online =3D 1
>     Model =3D E272
>     Manufacturer =3D huawei
>     Serial =3D 357865013196535

So all USB dongles support voice calls, however 99% of them do not
support audio.  There are two huawei devices that I know of that do.  Is
your device one of these?  Otherwise oFono does not enable the voicecall
functionality on such devices.

If your device does indeed support audio, then check the huawei modem
driver in plugins/huawei.c.  oFono performs some queries to determine if
your Huawei modem supports voice or not.  This magic might not be
working appropriately for your hardware.

Regards,
-Denis

--===============7987167936177525798==--

