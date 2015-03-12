Content-Type: multipart/mixed; boundary="===============4892562375330900605=="
MIME-Version: 1.0
From: Alexey Mednyy <swexru@gmail.com>
Subject: ofono+connman he910
Date: Thu, 12 Mar 2015 12:40:01 +0300
Message-ID: <55015EF1.9070806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4892562375330900605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Is anybody here successfully using connman+ofono with Telit he910 modem?

Seems like connman using .set_online interface in ofono_modem_driver,
I've added set_online_ to he910 plugin. And everything works fine.
Except after set offline/set online sequence I can't activate gprs
context anymore.
Here is log:
Jan  9 14:32:51 yarus-ng daemon.info ofonod[138]: Modem: >
AT+CGDATA=3D"PPP",1\r
Jan  9 14:32:51 yarus-ng daemon.info ofonod[138]: Modem: <
AT+CGDATA=3D"PPP",1\r\r\nNO CARRIER\r\n
Jan  9 14:32:51 yarus-ng daemon.debug ofonod[138]:
drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 0
Jan  9 14:32:51 yarus-ng daemon.info ofonod[138]: Unable to enter data state
Jan  9 14:32:51 yarus-ng daemon.debug ofonod[138]:
src/gprs.c:pri_activate_callback() 0x149318
Jan  9 14:32:51 yarus-ng daemon.debug ofonod[138]:
src/gprs.c:pri_activate_callback() Activating context failed with error:
Unknown error type
Jan  9 14:32:51 yarus-ng daemon.debug connmand[135]:
plugins/ofono.c:set_property_reply() /he910_0 path /he910_0/context1
org.ofono.ConnectionContext.Active
Jan  9 14:32:51 yarus-ng daemon.err connmand[135]: Failed to change
property: /he910_0/context1 org.ofono.ConnectionContext.Active:
org.ofono.Error.Failed Operation failed

AT+CREG? and AT+CGREG? normal answers
so modem registered in network and gprs context attached AT+CGATT=3D1...

What causes NO CARRIER answer of modem?

If necessary I can provide full log of connman/ofono...

-- =

_________________________________
Best regards, Mednyy Alexey.


--===============4892562375330900605==--

