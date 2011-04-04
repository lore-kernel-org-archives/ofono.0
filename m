Content-Type: multipart/mixed; boundary="===============3514376829940048051=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Motorola Modem H24 gprs connection
Date: Mon, 04 Apr 2011 09:42:23 -0500
Message-ID: <4D99D8CF.2080904@gmail.com>
In-Reply-To: <65D0035E6914AC478A46CFE3E20C3926017CC401@snch1xch53.sicpa-net.ads>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3514376829940048051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,


>> You might have luck using the legacy ATD*99 variation instead of
> CGDATA,
>> but we don't support this inside the current atmodem/gprs-context.c.
>> Have a look at gatchat/gsmdial.c, it implements this functionality.
> So
>> you might be able to quickly test whether PPP/ATD*99 works on the H24.
>>
> =

> ATD*99 works fine on H24. How can I pass an option to gprs driver to use
> ATD*99 instead of CGDATA ?  based on vendor as in drivers/atmodem/sms.c?
> =


Yes, a quirk would be what you want.  However, there's no code inside
atmodem gprs-context driver to handle quirks yet.  If you do, please
send us a patch.

> =

> After setting ConnectionContext property "Active" to true I can see that
> IPaddr and DNS server addr are properly returned by APN. A ppp0
> interface is also available. But ppp0 configuration does not seems to be
> correct when I use ifconfig (IP address is not set etc...). Is ofono
> responsible of doing this or ppp0 interface must be configured by
> another layer?    =


oFono only activates the interface and emits the settings.  Some other
component (e.g. connection manager) does the IP assignment, DHCP if
needed, etc.  Use ConnMan if you want readily available oFono
integration, or take a peek at test/process-context-settings.

> =

> BR,
> Christophe
> PS: is this email ident style ok ?

The quoting is a little mangled still...

Regards,
-Denis

--===============3514376829940048051==--

