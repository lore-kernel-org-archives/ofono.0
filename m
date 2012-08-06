Content-Type: multipart/mixed; boundary="===============0845397705046361191=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v3 2/2] test: Add hangup-call script for GCF testing
Date: Mon, 06 Aug 2012 10:26:40 +0200
Message-ID: <501F7FC0.5050603@linux.intel.com>
In-Reply-To: <1344013087.2083.25.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0845397705046361191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 03/08/2012 18:58, Marcel Holtmann wrote:
> Hi Guillaume,
>
>>   Makefile.am      |    3 ++-
>>   test/hangup-call |   36 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 38 insertions(+), 1 deletions(-)
>>   create mode 100755 test/hangup-call
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index 7e8f12c..8cf6920 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -625,7 +625,8 @@ test_scripts =3D test/backtrace \
>>   		test/swap-calls \
>>   		test/release-and-answer \
>>   		test/hold-and-answer \
>> -		test/hangup-multiparty
>> +		test/hangup-multiparty \
>> +		test/hangup-call
>>   =

>>   if TEST
>>   testdir =3D $(pkglibdir)/test
>> diff --git a/test/hangup-call b/test/hangup-call
>> new file mode 100755
>> index 0000000..bc77acf
>> --- /dev/null
>> +++ b/test/hangup-call
>> @@ -0,0 +1,36 @@
>> +#!/usr/bin/python
>> +
>> +import sys
>> +import dbus
>> +
>> +bus =3D dbus.SystemBus()
>> +
>> +manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
>> +						'org.ofono.Manager')
>> +
>> +modems =3D manager.GetModems()
>> +path =3D modems[0][0]
>> +
>> +manager =3D dbus.Interface(bus.get_object('org.ofono', path),
>> +						'org.ofono.VoiceCallManager')
>> +
>> +calls =3D manager.GetCalls()
>> +if (len(calls) =3D=3D 0):
>> +	print "No calls available"
>> +	sys.exit(1)
>> +
>> +if (len(sys.argv) < 2):
>> +	i =3D 0
>> +	for path, properties in calls:
>> +		multi =3D properties["Multiparty"]
>> +		print "Call Path [ %s ] Multiparty %d" % (path, multi)
>> +		print
>> +		i +=3D 1
>> +
>> +	print "Usage: %s [ Call Path ]" % (sys.argv[0])
>> +	print
>> +	sys.exit(1)
> we have list-calls for this. So why not make this really simple and and
> require the call object path as input.

Ok, I will only check if there is an argument and don't list the call.

Kind regards,
Guillaume

--===============0845397705046361191==--

