Content-Type: multipart/mixed; boundary="===============7330621972282252583=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: SetProperty for UseDeliveryReports
Date: Mon, 07 Jun 2010 12:53:25 +0300
Message-ID: <1275904409-19829-1-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7330621972282252583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches implement the setting of UseDeliveryReports variable
via DBus.

Patches include:
1. Setting of SRR according to UseDeliveryReports in
   sms_text_prepare().
2. Add new parameter to sms_text_prepare calls in test-sms.c.
3. SMS core changes.
4. Changes for send-sms script. If the third parameter for the
   script is "1", UseDeliveryReports is set to TRUE and the
   message is sent.




--===============7330621972282252583==--

