Content-Type: multipart/mixed; boundary="===============7211687463098677613=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 1/7] call-forwarding: Read/Write cfis/cphs-cff
Date: Tue, 07 Dec 2010 15:59:07 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802C40D5C@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <4CF94048.4000005@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7211687463098677613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
 =

> > +	ofono_bool_t online;
> =

> Why do you need to track this variable?  Can't you simply =

> call ofono_modem_get_online()?
> =


This way calling of ofono_modem_get_online for each get or set request
can be avoided.

Regards,
Jeevaka

--===============7211687463098677613==--

