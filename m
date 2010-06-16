Content-Type: multipart/mixed; boundary="===============9147547815351612592=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: SMS status report
Date: Wed, 16 Jun 2010 17:08:21 +0300
Message-ID: <1276697306-1587-1-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9147547815351612592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,
These are the latest modifications for the SMS status report. Pathc
includes:

1. SMS status report assembly in smsutil.
2. Status report result printing in history plugin.
3. API change in history plugin.
4. SMS notify for status report.
5. Saving the pending status report info to imsi file.

The most common use cases were tested in practice. For example
a concatenated message was sent to phone that was turned off and
Ofono was rebooted. Then the phone was turned on and message was
received and  Ofono received the status report and was able to
work with the data which was loaded from the imsi file. Ofono was
run under valgrind supervision and no memory leaks were
detected.

Br,
Pasi Miettinen




--===============9147547815351612592==--

