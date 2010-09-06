Content-Type: multipart/mixed; boundary="===============8261951727562994741=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [online-impl-v2 PATCH 00/10] implement Online property
Date: Mon, 06 Sep 2010 21:46:10 +0300
Message-ID: <1283798780-16363-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8261951727562994741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

Here are 2nd stab at implementing Online property with various modem
drivers.

Some more obvious errors (in using g_at_chat_send()) have been
fixed. Huawei has been updated after the comment from Marcel.

I've dropped support for the Nokia usb stick, according to the spec it
does not implement but AT+CFUN=3D0 and AT+CFUN=3D1. (Not that I have tested
what AT+CFUN=3D0 does.)

Again, I have not been able to test with most modems. All of them might
not make sense (if the modem does not support AT+CFUN=3D4, for
instance). There might be some common caveats.  E.g., if the modem does
to wake up with AT+CFUN=3D4, it might work with an initial cfun command
like "AT+CFUN=3D1 ; +CFUN=3D4". At least Calypso requires such an
initialization command.

I'd appreciate if the people with access to various hardware could test
them with the patches here (using test/enable-modem, test/online-modem
and test/offline-modem, or, e.g., the connman with "ofono-refactor-v2"
and "service-leak" patches).

--Pekka


--===============8261951727562994741==--

