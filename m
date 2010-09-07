Content-Type: multipart/mixed; boundary="===============5591411899459673114=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: How to get the SMS stored in SIM card
Date: Tue, 07 Sep 2010 10:20:17 +0200
Message-ID: <1283847617.6640.21.camel@localhost.localdomain>
In-Reply-To: <F2E9EB7348B8264F86B6AB8151CE2D7928045C89E5@shsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5591411899459673114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lily,

same rules for you than for everybody else. No top posting allowed on
this mailing list. Please follow proper mailing list netiquette here.

>   I have question about "The default SMS driver programs the modem to rep=
ort SMS PDUs directly to the core". I want to know how to deal with the rec=
eived sms by ofono core? Where to save the sms? =


Inside oFono the SMS are delivered via the history abstraction. So you
need a history plugin that decides about the actual storage of the SMS
on your system. This is platform dependent.

Regards

Marcel



--===============5591411899459673114==--

