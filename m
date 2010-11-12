Content-Type: multipart/mixed; boundary="===============0233989318421856890=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [ANNOUNCE] oFono 0.35
Date: Fri, 12 Nov 2010 12:28:26 -0600
Message-ID: <4CDD874A.7030808@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0233989318421856890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

oFono 0.35 is out.  This release is mostly a development release.  We
also include a bug fix that precluded 2G sims from working correctly due
to FDN/BDN checks.  3G sims were not affected.

The first major change in this release is the included support of WAP
PUSH notifications.  oFono now provides a way for the system to listen
to SMS messages containing WAP PUSH PDUs.  Please see
doc/push-notification-api.txt for more details.

The other major change is the included support for SMS messages
formatted according to the Smart Messaging specification from Nokia.
This allows applications to send and receive vCard and vCalendar objects
over SMS.  Traditionally this is used for e.g. sending business cards
and appointments over SMS.  Please see doc/smart-messaging-api.txt for
more details.

ChangeLog:
- Fix issue with FDN and BDN enabled checks.
- Fix issue with capabilities and Phonet support.
- Fix issue with timeout for ISI network deregistration.
- Add support for Push Notification interface.
- Add support for Smart Messaging interface.
- Remove generic AT command modem plugin.

The signed tarballs for oFono 0.35 can be found on kernel.org [1] [2].

[1] http://www.kernel.org/pub/linux/network/ofono/ofono-0.35.tar.bz2
[2] http://www.kernel.org/pub/linux/network/ofono/ofono-0.35.tar.bz2.sign

Regards,
-Denis

--===============0233989318421856890==--

