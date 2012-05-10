Content-Type: multipart/mixed; boundary="===============6954818554099688610=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono-tests internet context: DNS works,
 ping wget and ssh do not (Connection Refused)
Date: Thu, 10 May 2012 16:39:01 -0500
Message-ID: <4FAC3575.8030207@gmail.com>
In-Reply-To: <4FAC2B51.3080109@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6954818554099688610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Darren,

<snip>

> =

> =

> In my case, AccessPointName is empty.
> =


Then provisioning failed.

>>
>> The settings are then persisted in /var/lib/ofono/<your sim card's imsi>
> =

> # cat /var/lib/ofono/310410469131422/gprs
> =

> [Settings]
> Powered=3Dtrue
> RoamingAllowed=3Dfalse
> =

> [context1]
> Name=3DInternet
> AccessPointName=3D
> Username=3D
> Password=3D
> Type=3Dinternet
> Protocol=3Dip
> =

> =


And this is why the context is not shown in ConnMan's list of available
services.  ConnMan ignores contexts with empty APNs as invalid.

>>
>> If provisioning fails, oFono creates a default, empty context.  It can
>> be recognized by an empty APN.  In theory activating an empty APN should
>> fail.
>>
>> You then need to use create-internet-context to set the settings
>> manually.  For AT&T the WAP-only APN is wap.cingular, and the data APN
>> is isp.cingular I believe.
>>
> =

> =

> OK:
> =

> # ./create-internet-context isp.cingular
> Found context /mbm_1/context1
> Setting APN to isp.cingular
> =

> root(a)fri2:/usr/lib/ofono/test# cat /var/lib/ofono/310410469131422/gprs
> =

> [Settings]
> Powered=3Dtrue
> RoamingAllowed=3Dfalse
> =

> [context1]
> Name=3DInternet
> AccessPointName=3Disp.cingular
> Username=3D
> Password=3D
> Type=3Dinternet
> Protocol=3Dip
> =

> =

> # ./activate-context
> Error activating /mbm_1/context1: org.ofono.Error.Failed: Operation failed

Yep, looks like this pre-paid account is configured with access to the
APN with WAP based services only.

> =

> I don't know why the modem is now mbm_1 instead of mbm_0...
> =


Have you pulled it out and re-inserted?  In general oFono does not have
a facility to persist the hardware ids unless the hardware exports its
serial number to udev.  I'm guessing this hardware does not.

<snip>

>>> This makes it clear to me that I have some research to do. I don't know
>>> what those terms mean, and certainly don't know which APN I am using (or
>>> should be using). I haven't specified one intentionally. Any tips on how
>>> I can determine this?
>>>
>>
>> If you are using an AT&T GoPhone SIM then likely you're limited to
>> WAP-only network, not a real internet connection.  The easy way to tell
>> is to run
>>
>> test/create-internet-context "isp.cingular"
>>
>> And then try to activate the context.
> =

> See above.
> =

> Also, I'm trying to look up the distinction between WAP-only and Full GPR=
S:
> =

> http://en.wikipedia.org/wiki/General_Packet_Radio_Service
> http://en.wikipedia.org/wiki/Wireless_Application_Protocol
> =

> This suggests to me that this SIM can only do WAP and not IP, which
> explains why my wget, ssh, and ping tests fail. I'm confused why I'm
> then able to get a an inet and an inet6 address though, and DNS appears
> to work.
> =


Sorry I confused you.  While WAP does provide a replacement to IP, no
one ended up using it in the end.  Carriers run WAP services over HTTP
but with a weird compressed binary format.  Generally the only thing you
can reach from the "wap.cingular" APN is the WAP gateway IP and/or the
MMSC (for MMS, aka picture messaging) gateway IP.  The contexts are
still some form of IP.

> So, is there a typical way to verify that WAP is at least working?
> =


ping the wap gateway, assuming you can find its IP on Google somewhere.

> Should I update the context Protocol to "wap" instead of "ip" ?

Nope, the Protocol setting is correct.  Carriers can choose to run
different services on different APNs (e.g. for billing or traffic
counting purposes).  Hence you can have an 'internet' APN, an mms-only
APN, a wap-only APN, everything and the kitchen sink APN.  Sometimes you
might even have a VPN-to-your-employer APN, etc.

The operator can set up different billing structures for each APN, e.g.
bill MMS by the number of messages, not bytes.

> =

> Finally, if the Go Phone SIM is WAP-only, what do I need for a "Full
> GPRS" SIM?

I don't know how AT&T structures their pre-paid plans these days.  I
believe you had to buy another package for $20 or so to add internet
capability to pre-paid SIMs.  You can also check out what T-Mobile is
doing for pre-paid data.

Alternatively just borrow an iPhone of someone nearby ;)

Regards,
-Denis

--===============6954818554099688610==--

