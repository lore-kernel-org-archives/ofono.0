Content-Type: multipart/mixed; boundary="===============6437640101426437163=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH v6 03/16] dundee: Add test scripts
Date: Tue, 24 Apr 2012 14:33:11 +0200
Message-ID: <4F969D87.6070700@monom.org>
In-Reply-To: <2CF57A644018A745B8FE029C7223E16E0FD1CDB4@SHSMSX102.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6437640101426437163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Wu,

On 23.04.2012 12:13, Zheng, Wu wrote:
> Hi Daniel,
>
> I try to test your patches.

Thanks for giving them a try.

>> -----Original Message-----
>> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Be=
half
>> Of Daniel Wagner
>> Sent: Tuesday, April 03, 2012 12:20 AM
>> To: ofono(a)ofono.org
>> Cc: Daniel Wagner
>> Subject: [PATCH v6 03/16] dundee: Add test scripts
>>
>> From: Daniel Wagner<daniel.wagner@bmw-carit.de>
>>
>> ---
>>   test/dundee-connect    |   20 +++++++++
>>   test/dundee-disconnect |   20 +++++++++
>>   test/monitor-dundee    |  109
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 149 insertions(+)
>>   create mode 100755 test/dundee-connect
>>   create mode 100755 test/dundee-disconnect  create mode 100755
>> test/monitor-dundee
>>
>> diff --git a/test/dundee-connect b/test/dundee-connect new file mode 100=
755
>> index 0000000..6cbc629
>> --- /dev/null
>> +++ b/test/dundee-connect
>> @@ -0,0 +1,20 @@
>> +#!/usr/bin/python
>> +
>> +import dbus
>> +import sys
>> +
>> +bus =3D dbus.SystemBus()
>> +
>> +if len(sys.argv) =3D=3D 2:
>> +	path =3D sys.argv[1]
>> +else:
>> +	manager =3D dbus.Interface(bus.get_object('org.ofono.dundee', '/'),
>> +			'org.ofono.dundee.Manager')
>> +	devices =3D manager.GetDevices()
>> +	path =3D devices[0][0]
>> +
>> +print "Connect device %s..." % path
>> +device =3D dbus.Interface(bus.get_object('org.ofono.dundee', path),
>> +						'org.ofono.dundee.Device')
>> +
>> +device.Connect()
>
> The dbus method connect() does not exist on org.ofono.dundee.Device, it c=
annot be found in device.c and doc/dundee-api.txt.
> Why?
>
> Best regards
>
>> diff --git a/test/dundee-disconnect b/test/dundee-disconnect new file mo=
de
>> 100755 index 0000000..e67d8cd
>> --- /dev/null
>> +++ b/test/dundee-disconnect
>> @@ -0,0 +1,20 @@
>> +#!/usr/bin/python
>> +
>> +import dbus
>> +import sys
>> +
>> +bus =3D dbus.SystemBus()
>> +
>> +if len(sys.argv) =3D=3D 2:
>> +	path =3D sys.argv[1]
>> +else:
>> +	manager =3D dbus.Interface(bus.get_object('org.ofono.dundee', '/'),
>> +			'org.ofono.dundee.Manager')
>> +	devices =3D manager.GetDevices()
>> +	path =3D devices[0][0]
>> +
>> +print "Disonnect device %s..." % path
>> +device =3D dbus.Interface(bus.get_object('org.ofono.dundee', path),
>> +						'org.ofono.dundee.Device')
>> +
>> +device.Disconnect()

Change this line to

device.SetProperty("Active", True)

That should do the trick.

> The dbus method Disconnect() does not exist on org.ofono.dundee.Device, i=
t cannot be found in device.c and doc/dundee-api.txt.
> Why?

The documentation and the script are not in sync with the =

implementation. I'll fix that.

Documentation change:

Methods
	SetProperty()

Test script change:

	device.SetProperty("Active", True)

cheers,
daniel

--===============6437640101426437163==--

