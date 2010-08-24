Content-Type: multipart/mixed; boundary="===============2106381611924038971=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [online PATCH 0/9] implement Online properties
Date: Tue, 24 Aug 2010 14:31:55 +0300
Message-ID: <1282649524-31353-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2106381611924038971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

Here are online implementation for a few more modem drivers. All of them
might not make sense (if the modem does not support AT+CFUN=3D4, for
instance).

I have not tested these patches with more exotic hardware. There might be
some common caveats.  E.g., if the modem does to wake up with AT+CFUN=3D4, =
it
might work with an initial cfun command like "AT+CFUN=3D1 ; +CFUN=3D4". At =
least
Calypso requires such an initialization command.

--Pekka


--===============2106381611924038971==--

