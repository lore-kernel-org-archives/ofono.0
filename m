Content-Type: multipart/mixed; boundary="===============8544700261824025498=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [PATCH v5, 2/5] test: Add CDMA MO Call Support
Date: Thu, 13 Jan 2011 10:18:58 -0800
Message-ID: <4D2F4212.5050705@nokia.com>
In-Reply-To: <4D2E8CD8.4080201@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8544700261824025498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On 01/12/2011 09:25 PM, ext Denis Kenzior wrote:
> Hi Dara,
>
> On 01/10/2011 07:45 PM, Dara Spieker-Doyle wrote:
>> ---
>>   Makefile.am           |    5 ++++-
>>   test/cdma-dial-number |   25 +++++++++++++++++++++++++
>>   test/cdma-hangup      |   20 ++++++++++++++++++++
>>   test/cdma-list-call   |   31 +++++++++++++++++++++++++++++++
>>   4 files changed, 80 insertions(+), 1 deletions(-)
>>   create mode 100755 test/cdma-dial-number
>>   create mode 100755 test/cdma-hangup
>>   create mode 100755 test/cdma-list-call
>
> This patch does not apply:
>
> Applying: test: Add CDMA MO Call Support
> error: patch failed: Makefile.am:445
> error: Makefile.am: patch does not apply
> /home/denkenz/ofono-master/.git/rebase-apply/patch:32: new blank line at
> EOF.
> +
> /home/denkenz/ofono-master/.git/rebase-apply/patch:89: new blank line at
> EOF.
> +
> Patch failed at 0001 test: Add CDMA MO Call Support
> When you have resolved this problem run "git am --resolved".
> If you would prefer to skip this patch, instead run "git am --skip".
> To restore the original branch and stop patching run "git am --abort".
>
> Also:
>
> <snip>
>
>>
>> diff --git a/test/cdma-list-call b/test/cdma-list-call
>> new file mode 100755
>> index 0000000..8a2e04e
>> --- /dev/null
>> +++ b/test/cdma-list-call
>> @@ -0,0 +1,31 @@
>> +#!/usr/bin/python
>> +
>> +import dbus
>> +
>> +bus =3D dbus.SystemBus()
>> +
>> +manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
>> +						'org.ofono.Manager')
>> +
>> +modems =3D manager.GetModems()
>> +
>> +for path, properties in modems:
>> +	print "[ %s ]" % (path)
>> +
>> +	if "org.ofono.cdma.VoiceCallManager" not in properties["Interfaces"]:
>> +		continue
>> +
>> +	mgr =3D dbus.Interface(bus.get_object('org.ofono', path),
>> +					'org.ofono.cdma.VoiceCallManager')
>> +
>> +	properties =3D mgr.GetProperties()
>> +
>> +	for key in properties.keys():
>> +		if key in ["Interfaces", "Features"]:
>> +			val =3D ""
>> +			for i in properties[key]:
>> +				val +=3D i + " "
>
> You might want to remove this if statement.  There are no Interfaces or
> Features properties in cdma.VoiceCallManager
>
>> +		else:
>> +			val =3D str(properties[key])
>> +		print "    %s =3D %s" % (key, val)
>> +
>
> Regards,
> -Denis

Thank you, yes I'll fix this up and resubmit. The info re: naming style =

of the atom methods has been passed on to the other guys too to include =

in future/current CDMA patches.

Cheers
Dara



--===============8544700261824025498==--

