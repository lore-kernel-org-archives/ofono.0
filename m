Content-Type: multipart/mixed; boundary="===============5272608033675943966=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: Re: Problems with voice call.
Date: Thu, 16 Jul 2009 08:36:59 +0300
Message-ID: <4A5EBC7B.6060203@gmail.com>
In-Reply-To: <200907151151.21627.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5272608033675943966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

With Option iCON 225 the SMS service started to work and I was also able
to send SMS message with the following command:

$ dbus-send --system --print-reply --dest=3Dorg.ofono /modem1
org.ofono.SmsManager.SendMessage array:string:"+358000000000"
string:"ofono test message"


The Nokia E51 returns still the SMS error thing. To AT+CPMS=3D? the E51
returns the following:
+CPMS: (),(),()

OK

There is also following errors printed by the ofonod when modem is
created with E51:

...
ofonod[14999]: at_crsm_info_cb got result: 0
ofonod[14999]: Final response: ERROR
ofonod[14999]: cops_numeric_cb got result: 1
...
ofonod[14999]: at_crsm_info_cb got result: 0
ofonod[14999]: Final response: ERROR
ofonod[14999]: cmgf_query_cb got result: 1
...
ofonod[14999]: at_crsm_info_cb got result: 0
ofonod[14999]: Final response: ERROR
ofonod[14999]: cpms_query_cb got result: 1
ofonod[14999]: Response line: +CPMS: (),(),()
ofonod[14999]: SMS not supported by this modem.  If this is in error
please submit patches to support this hardware



Regards,
Marko

--===============5272608033675943966==--

