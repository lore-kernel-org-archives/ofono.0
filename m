Content-Type: multipart/mixed; boundary="===============8646521066746903573=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH -v3 2/3] phonesim: Add modem reset trigger
Date: Tue, 23 Nov 2010 15:52:26 -0600
Message-ID: <4CEC379A.3070002@gmail.com>
In-Reply-To: <20101123200133.GE22502@vigoh>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8646521066746903573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

>>> +static void crst_notify(GAtResult *result, gpointer user_data)
>>> +{
>>> +	struct ofono_modem *modem =3D user_data;
>>> +
>>> +	ofono_modem_reset(modem);
>>
>> I suggest you simply clean up the phonesim connection (e.g. closing the
>> tcp socket) when you receive this notification, and then call
>> modem_reset at the end.
> =

> So here do you mean unref phonesim data->chat and also call
> ofono_modem_set_powered(modem, FALSE) before call ofono_modem_reset()?
> =


So I really mean performing the same steps as disable.  Calling
ofono_modem_set_powered is pretty much optional.  The core should simply
assume that once ofono_modem_reset has been called, the modem is off and
needs to be re-initialized from the beginning.

Regards,
-Denis

--===============8646521066746903573==--

