Content-Type: multipart/mixed; boundary="===============3223251295494413055=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v3 3/3] test: Add hangup-call script for GCF testing
Date: Fri, 03 Aug 2012 10:47:59 +0200
Message-ID: <501B903F.4070302@linux.intel.com>
In-Reply-To: <1343935276.2083.6.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3223251295494413055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 02/08/2012 21:21, Marcel Holtmann wrote:
> Hi Guillaume,
>
>>   Makefile.am      |    3 ++-
>>   test/hangup-call |   39 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 41 insertions(+), 1 deletions(-)
>>   create mode 100755 test/hangup-call
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index a689483..534245e 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -624,7 +624,8 @@ test_scripts =3D test/backtrace \
>>   		test/swap-calls \
>>   		test/release-and-answer \
>>   		test/hold-and-answer \
>> -		test/hangup-call-state
>> +		test/hangup-call-state \
>> +		test/hangup-call
>>   =

>>   if TEST
>>   testdir =3D $(pkglibdir)/test
>> diff --git a/test/hangup-call b/test/hangup-call
>> new file mode 100755
>> index 0000000..926efc4
>> --- /dev/null
>> +++ b/test/hangup-call
>> @@ -0,0 +1,39 @@
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
>> +		print "Call ID [ %d ] Multiparty %d" % (i, multi)
>> +		print
>> +		i +=3D 1
>> +
>> +	print "Usage: %s [ Call ID ]" % (sys.argv[0])
>> +	print
>> +	sys.exit(1)
>> +
>> +path =3D calls[int(sys.argv[1])][0]
>> +
>> +call =3D dbus.Interface(bus.get_object('org.ofono', path),
>> +						'org.ofono.VoiceCall')
>> +
>> +call.Hangup()
> why are we not just asking to provide the object path as argument and
> then list-calls can be used to determine which call to hang up. That way
> also the hangup-call-state hack is not needed.
>
> Using the object path also makes this less racy since we identify the
> call by object path and not a random number that might no longer be
> valid.

We can use voicecall path indeed, however this script will not be enough =

to clear all the remote parties of a multiparty call at once.
For instance, I have a 3GPP test case that ask me to do this:
     - create a multiparty call with 3 parties
     - create a new single call
     - clear multiparty call in held

I could either use the hangup-call-state script (with held argument) =

either create a new script using HangupMultiparty() method from =

voicecallmanager API (like there is a hangup-all script).
One of those scripts would avoid to call thrice hangup-call for a =

multiparty call with 3 party for instance.

Kind regards,
Guillaume

--===============3223251295494413055==--

