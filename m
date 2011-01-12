Content-Type: multipart/mixed; boundary="===============3292558167654275799=="
MIME-Version: 1.0
From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
Subject: Update interface with variable port numbers?
Date: Wed, 12 Jan 2011 08:59:29 +0100
Message-ID: <4D2D5F61.5040404@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3292558167654275799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

we could probably use an update in the push_notification_register_agent
in plugins/push-notification.c so that it would be possible to specify =

port numbers instead of them being hardcoded with

#define WAP_PUSH_SRC_PORT 9200
#define WAP_PUSH_DST_PORT 2948

We would like to be able to use the
oma-ilp		7276/tcp    OMA Internal Location Protocol

specified on
http://www.iana.org/assignments/port-numbers

This could also be used for other WAP based services.

Is this something that you would agree would be useful and we could add =

to the TODO list?

Best Regards,
Jessica Nilsson


--===============3292558167654275799==--

