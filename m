Content-Type: multipart/mixed; boundary="===============5092641207108592756=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 6/6] cdmamodem: Add serving system identifier support
Date: Thu, 24 Nov 2011 17:35:30 -0600
Message-ID: <4ECED4C2.8070008@gmail.com>
In-Reply-To: <4ECFC2D2.7040303@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5092641207108592756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>>
>>>
>>> So far, the AT command "Serving system" seems relevant. Now, do you
>>> expect us to communicate also through the qcdm port when using cdma
>>> modem?
>>
>> Have you tested that your theories work?
> Yes, I checked locally with huawei cdma dongles and the speedup SU 7300
> that the command "AT+CSS?" was effectively supported.
> I tested also remotely (through SSH with a machine in China where a
> huawei cdma dongle is plugged) that the SID was correctly returned when
> registered.
>

Fair enough.

> In fact, I applied the same approach as for the atmodem driver.
> We only have one network-registration driver which is taking care of all
> manufacturer specific commands (as for Huawei).
> As the AT command '+CSS' is supported by both Speedup cdma And Huawei
> cdma, I took the initiative indeed to move the specific huawei part into
> a generic driver.

Well not really, the generic driver for GSM uses mostly standard
commands and only supports vendor extensions.  The split is probably 70%
standards, 30% extensions, and even then mostly because just about every
vendor decided to invent one for timezone / network technology / signal
strength indications.

What I see in your proposal is 70% huawei specific and the rest taken up
by CSS which is still of questionable utility.  And if you find that you
do indeed need to use QCDM for finding the SID, then you won't be able
to use the new generic driver anyway, so lets hold off on this for now.

And by the way, there's nothing wrong with using huawei atom drivers /
quirks from non-huawei modem drivers (e.g. speedup).  See ste/mbm
drivers for examples.

Regards,
-Denis

--===============5092641207108592756==--

