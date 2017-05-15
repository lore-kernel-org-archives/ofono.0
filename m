Content-Type: multipart/mixed; boundary="===============1929279883394947462=="
MIME-Version: 1.0
From: Vincent CESSON <vincent.cesson@smile.fr>
Subject: Re: [RFC 1/2] gemalto: Prepare new interface for hardware monitoring
Date: Mon, 15 May 2017 17:53:07 +0200
Message-ID: <578699111450176e4882a6d5e3473417@smile.fr>
In-Reply-To: <f206c6b1-6f89-988c-893c-652d6bb40e81@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1929279883394947462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


Le 2017-05-12 16:13, Denis Kenzior a =C3=A9crit=C2=A0:
> Hi Vincent,
> =

>>> =

>>> So the applications would need to poll these values.  Does the modem
>>> enable some sort of unsolicited notifications of these?
>>> =

>> =

>> No unsolicited notifications for voltage.
>> There are notifications for over/under temperature warning,
>> but exact value must be polled.
> =

> Okay.  In that case a method call is probably the best way to do
> this. I would combine the two method calls into one.  e.g.
> GetStatistics() that would return a dictionary of values.  Something
> like:
> =

> a{sv} GetStatistics()
> =

> where s is the key:
> "Voltage" - uint32 (I assume this can't be negative)
> "Temperature" - int32
> =

> This keeps your round-trips to a minimum.  It takes ages to go over
> D-Bus, so it should be considerably faster to have oFono query both
> values at once.  Especially if you can combine the query into a single
> AT commmand.
> =

> Might want to mention the units as well.  F vs C, etc.
> =


Ok to squash the methods. Why GetStatistics? I suggest simply =

GetProperties instead.
How would you mention the units? In the key name? "Temperature (C)" and =

"Voltage (mV)"?
Or in a new entry?
It's details but I prefer to have your opinion.

>> =

>> How would you implement the notification? With a property and a =

>> signal
>> PropertyChanged? Is it ok to keep the methods as I propose, and add
>> the notification later?
>> =

> =

> If it is just a plain notification that e.g. a temperature exceeds
> the threshold, then I would model it as a signal.  Something like:
> TemperatureThresholdExceeded()
> =

> Is there a way to set the threshold?

There is no way to set the thresholds. In fact there are 5 levels:

Below lowest temperature limit (causes switch-off after 5 s time).
Below low temperature alert limit.
Normal operating temperature.
Above upper temperature alert limit.
Above uppermost temperature limit (causes switch-off after 5 s time).

> =

> Regards,
> -Denis

Regards,
-Vincent

--===============1929279883394947462==--

