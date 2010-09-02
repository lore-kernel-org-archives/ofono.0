Content-Type: multipart/mixed; boundary="===============4529908504979994749=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 02/11] Changes done as per the changed driver API
Date: Thu, 02 Sep 2010 11:00:59 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802A0E4F1@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <AANLkTi=xZgRGy3PYVS5OJyXkXA5bLzQ26ZibG+ki54s8@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4529908504979994749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =

Hi Pekka,

> I thought the modem already unpacks the ussd message to 8-bit gsm and
the dcs parameter is rather meaningless in that case. Perhaps the
atmodem ussd should re-pack the string in order to achieve the =

> desired symmetry on the API?

Agree that the modem already unpacks the string received from the
network to the "character set" set by TE(UCS2 or UTF-8 or ...). Atom
driver will do the conversion to UTF-8 based on active character set
supported by modem, so it should have information of the active
character set. At present, we read and set the "character set" in the
phonebook atom driver. USSD atom driver could to do the same or the
reading/setting of character set can be done during the modem
initialisation (eg: atgen.c). I would prefer to have the reading and
setting of character set during the modem initialisation. I hope the
character set is not set by some other component apart from ofono :-)

Regards,
jeevaka



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============4529908504979994749==--

