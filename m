Content-Type: multipart/mixed; boundary="===============2583762575820379196=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH 1/4] test: process-context-settings: use ip instead of
 ifconfig/route
Date: Thu, 18 Jul 2019 21:08:33 +0200
Message-ID: <c79f17be-63f4-9e1b-2cb6-d867f74aed47@geanix.com>
In-Reply-To: <20190718163820.GB21502@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2583762575820379196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 18/07/2019 18.38, Pavel Machek wrote:
> On Thu 2019-07-18 13:49:34, Martin Hundeb=C3=B8ll wrote:
>> ---
>>   test/process-context-settings | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/test/process-context-settings b/test/process-context-settin=
gs
>> index 1d30b30d..a536a771 100755
>> --- a/test/process-context-settings
>> +++ b/test/process-context-settings
>> @@ -41,14 +41,14 @@ for path, properties in modems:
>>   			print("    IP address is %s" % (address))
>>   			print("    Gateway is %s" % (gateway))
>>   =

>> -			cmd =3D "ifconfig " + interface + " " + address
>> -			cmd +=3D " netmask 255.255.255.255"
>> +			cmd =3D "ip address add dev " + interface + " " + address
>> +			cmd +=3D "/32"
>>   			os.system(cmd);
>>   =

>>   			for i in settings["DomainNameServers"]:
>>   				print("    Nameserver is %s" % (i))
>>   =

>> -				cmd =3D "route add -host " + i
>> +				cmd =3D "ip route add  " + i
>>   				cmd +=3D" dev " + interface
>>   				os.system(cmd);
> =

> So.. you move from one tool to another one, fixing it on some systems
> and braking on some.

`ifconfig` and friends have been obsolete for quite some time now. Even =

busybox has been shipping `ip` since 2002...

> But I guess better solution would be to use python module, not execing
> external programs.
> =

> ...which certainly should not be executed using os.system(). Network
> interface called `> /etc/passwd` would be a lot of phun, right? :-).

I'll leave it up to ofono to choose sane names for interfaces :)

// Martin

--===============2583762575820379196==--

