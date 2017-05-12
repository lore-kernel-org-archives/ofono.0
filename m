Content-Type: multipart/mixed; boundary="===============2951321564616067314=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 1/2] gemalto: Prepare new interface for hardware monitoring
Date: Fri, 12 May 2017 09:13:56 -0500
Message-ID: <f206c6b1-6f89-988c-893c-652d6bb40e81@gmail.com>
In-Reply-To: <995e23bd92751c1266fc0498c9a39478@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2951321564616067314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

>>
>> So the applications would need to poll these values.  Does the modem
>> enable some sort of unsolicited notifications of these?
>>
>
> No unsolicited notifications for voltage.
> There are notifications for over/under temperature warning,
> but exact value must be polled.

Okay.  In that case a method call is probably the best way to do this. =

I would combine the two method calls into one.  e.g. GetStatistics() =

that would return a dictionary of values.  Something like:

a{sv} GetStatistics()

where s is the key:
	"Voltage" - uint32 (I assume this can't be negative)
	"Temperature" - int32

This keeps your round-trips to a minimum.  It takes ages to go over =

D-Bus, so it should be considerably faster to have oFono query both =

values at once.  Especially if you can combine the query into a single =

AT commmand.

Might want to mention the units as well.  F vs C, etc.

>
> How would you implement the notification? With a property and a signal
> PropertyChanged? Is it ok to keep the methods as I propose, and add
> the notification later?
>

If it is just a plain notification that e.g. a temperature exceeds the =

threshold, then I would model it as a signal.  Something like:
	TemperatureThresholdExceeded()

Is there a way to set the threshold?

Regards,
-Denis

--===============2951321564616067314==--

