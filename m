Content-Type: multipart/mixed; boundary="===============4051920565828189329=="
MIME-Version: 1.0
From: Ostermann, Christophe <Christophe.Ostermann@sicpa.com>
Subject: RE: Motorola Modem H24 gprs connection
Date: Tue, 05 Apr 2011 07:57:46 +0200
Message-ID: <65D0035E6914AC478A46CFE3E20C3926017CC405@snch1xch53.sicpa-net.ads>
In-Reply-To: <4D99D8CF.2080904@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4051920565828189329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Denis,

>
>Hi Christophe,
>
>
>>> You might have luck using the legacy ATD*99 variation instead of
>> CGDATA,
>>> but we don't support this inside the current atmodem/gprs-context.c.
>>> Have a look at gatchat/gsmdial.c, it implements this functionality.
>> So
>>> you might be able to quickly test whether PPP/ATD*99 works on the
H24.
>>>
>>
>> ATD*99 works fine on H24. How can I pass an option to gprs driver to
use
>> ATD*99 instead of CGDATA ?  based on vendor as in
drivers/atmodem/sms.c?
>>
>
>Yes, a quirk would be what you want.  However, there's no code inside
>atmodem gprs-context driver to handle quirks yet.  If you do, please
>send us a patch.
>

I have implemented it. I will send you a patch in another email.

>>
>> After setting ConnectionContext property "Active" to true I can see
that
>> IPaddr and DNS server addr are properly returned by APN. A ppp0
>> interface is also available. But ppp0 configuration does not seems to
be
>> correct when I use ifconfig (IP address is not set etc...). Is ofono
>> responsible of doing this or ppp0 interface must be configured by
>> another layer?
>
>oFono only activates the interface and emits the settings.  Some other
>component (e.g. connection manager) does the IP assignment, DHCP if
>needed, etc.  Use ConnMan if you want readily available oFono
>integration, or take a peek at test/process-context-settings.

I have successfully setup/configured a gprs connection by using
ifconfig.
I will have a look to connman.  =


>
>>
>> BR,
>> Christophe
>> PS: is this email ident style ok ?
>
>The quoting is a little mangled still...

Will try to improve.

BR,
Christophe


>
>Regards,
>-Denis
This message was delivered through encrypted mechanism.


The information in this email and any attachments is confidential
and intended solely for the use of the individual(s) to whom it is
addressed or otherwise directed.
Please note that any views or opinions presented in this email are
solely those of the author and do not necessarily represent those
of the Company.
Finally, the recipient should check this email and any attachments
for the presence of viruses.
The Company accepts no liability for any damage caused by any virus
transmitted by this email.

--===============4051920565828189329==--

