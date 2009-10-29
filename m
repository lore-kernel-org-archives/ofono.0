Content-Type: multipart/mixed; boundary="===============8279661754440044325=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Re: [PATCH 2/2] This patch enables the pin number and type of pin to
 be sent to daemon to unlock the sim card.
Date: Thu, 29 Oct 2009 15:17:00 +0100
Message-ID: <4AE9A3DC.5060503@gmail.com>
In-Reply-To: <1256824850.5768.43.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8279661754440044325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



Marcel Holtmann wrote:
> Hi Ryan,
> =

>> ---
>>  test/enable-sim |   18 ++++++++++++++++++
>>  1 files changed, 18 insertions(+), 0 deletions(-)
>>  create mode 100755 test/enable-sim
>>
>> diff --git a/test/enable-sim b/test/enable-sim
>> new file mode 100755
>> index 0000000..bbfd34f
>> --- /dev/null
>> +++ b/test/enable-sim
>> @@ -0,0 +1,18 @@
>> +#!/usr/bin/python
>> +
>> +import dbus
>> +import sys
>> +
>> +bus =3D dbus.SystemBus()
>> +
>> +manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
>> +						'org.ofono.Manager')
>> +
>> +properties =3D manager.GetProperties()
>> +
>> +path =3D properties["Modems"][0]
>> +
>> +modem =3D dbus.Interface(bus.get_object('org.ofono', path),
>> +						'org.ofono.SimManager')
>> +
>> +modem.EnterPin(sys.argv[1], sys.argv[2])
> =

> call this script enter-pin and have it check if a PIN is actually
> required.
> =


No prob.

Thanks,
Ryan

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============8279661754440044325==--

