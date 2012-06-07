Content-Type: multipart/mixed; boundary="===============9222748891562918889=="
MIME-Version: 1.0
From: Audric Schiltknecht <audric.schiltknecht@toulouse.viveris.com>
Subject: Implement signal strength polling in plugin/driver
Date: Thu, 07 Jun 2012 17:20:07 +0200
Message-ID: <d9e9c17c27aa80d12803dbaa87b8b971@toulouse.viveris.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9222748891562918889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi guys,

It seems my first post was lost, so here is a new try.

I am currently developing an ofono-based GSM control interface, using a =

Sagem
Hilo modem (I wrote the appropriate plugin) with the atmodem driver.

I am having trouble with signal strength reporting. The terminal does =

not report
signal strength by event. Hence, it is not possible to get the value =

from Ofono,
since Ofono expects it to be updated on a +CIEV event. I implemented a
new DBus method in the NetworkRegistration interface to force AT+CSQ =

command and
update the property value, but this is clearly not a valid solution.

I found by looking in include/netreg.h that it should be up to the =

plugin to
implement CSQ polling, however I can't find how it is supposed to be =

done.
Indeed, the plugin has no access to the netreg atom nor structure, so =

how is it
supposed to update one of these properties ?

Thank you for your help.

Regards,
Audric Schiltknecht

--===============9222748891562918889==--

