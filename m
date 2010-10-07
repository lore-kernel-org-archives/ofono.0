Content-Type: multipart/mixed; boundary="===============8062242397822822852=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: CDMA SMS Handling
Date: Wed, 06 Oct 2010 19:10:04 -0500
Message-ID: <4CAD0FDC.7030103@gmail.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702AC9A8D@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8062242397822822852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

> As from the above decoding example we can see there is substantial
> differences between the GSM and CDMA SMS specifications and so the SMS
> atom needs many additions and needs to be heavily modified to support
> also CDMA SMS handling. Currently the oFono sms file unit handles the
> common and the GSM technology aspects of the SMS stack along with the
> smsutils. The SMS atom has the GSM specific members, segmentation and
> queuing logic. The smsutils mainly takes care of encoding/decoding of
> the PDUs, which is GSM specific. As the segmentation and queuing logic
> and the interface is common for both GSM and CDMA, we could reuse this
> common code and add the CDMA handling into it and create a new
> cdmasmsutils unit to support the CDMA SMS specifics, much like the
> smsutils does already for GSM.

This gets my vote, I like to start bottom up.  E.g. build the
infrastructure first, with unit tests, etc and then hook up the
controlling logic.  So starting cdma smsutils seems like a good idea to me.

Do note however that there's more to smsutils than basic parsing.  We
also have sms fragmentation / de-fragmentation logic, sms assembly
serialization, status reports, character encoding / decoding, etc.  We
will have to figure out which parts can be re-used for both CDMA and GSM
as we go along...

Regards,
-Denis

--===============8062242397822822852==--

