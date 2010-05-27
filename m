Content-Type: multipart/mixed; boundary="===============6463174120897809720=="
MIME-Version: 1.0
From: Miettinen Pasi <pasi.miettinen@ixonos.com>
Subject: SMS delivery report
Date: Thu, 27 May 2010 13:06:56 +0300
Message-ID: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A36@jklmail01.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6463174120897809720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

My name is Pasi Miettinen. I have been working with SMS delivery report item
based on the TODO list. The work covers requesting of SMS report in the =

DBus interface via SendMessage method by adding third parameter. If =

parameter is TRUE status report is asked. Incoming status report is reported
also via DBus by sending signla called IncomingStatusreport. Status reports
of the concatenated messages are also supported. Internal oFono SMS
history is updated according status report results. This patch utilizes old=
 style
msg_id (not hash). Concatenated messages have one internal msg_id that
relates to multiple TP-MR. If one MR-number is resulted to "delivery-failed=
",
the whole concatenated message is considered as failed and history is
updated using internal msg_id.

An initial set of patches follow for review.

Best regards,
Pasi Miettinen=20

--===============6463174120897809720==--

