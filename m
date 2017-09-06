Content-Type: multipart/mixed; boundary="===============0607289230492291604=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: connmand[186]: Online check failed but running dhclient manually
 fixes this issue
Date: Wed, 06 Sep 2017 10:40:18 -0500
Message-ID: <8ed7097c-ddbf-5a41-556d-6f30a6e99bf5@gmail.com>
In-Reply-To: <87k21bg8ko.fsf@helium.monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0607289230492291604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,
>>
>> If this is true, then falling back to DHCP would seem to be required
>> for many Qualcomm based devices.  This seems to be a recently
>> introduced 'bug' as older QMI devices did not need this workaround.
> =

> Do you think we should try to figure out which Qualcomm device is
> misbehaving or should the feature just be reverted?

It would seem that this only affects devices introduced in the last =

several years.  The QMI code is from 2012, and the devices Marcel tested =

this with worked fine.

Perhaps we should have plugins/udevng.c maintain a database of all the =

'dhcp-required' devices and set this property accordingly.  Running DHCP =

takes time, so if it can be avoided, you get online a bit faster...

> =

> The other option is to add some fallback mechanism in ConnMan and print
> a fat warning into the log. But I don't this idea.
> =


Sounds like a least preferred option to me as well.

Regards,
-Denis

--===============0607289230492291604==--

