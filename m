Content-Type: multipart/mixed; boundary="===============4791055569793100291=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCHv2 0/2] Robustness fixes for mbm
Date: Mon, 23 Aug 2010 17:18:08 +0300
Message-ID: <1282573090-8351-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4791055569793100291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

Here are some robustness fixes for MBM modem.

In 1/2 I've corrected my older patches which tried to detect the presence of
the SIM card on the particular error response returned to AT+CPIN?. It did
not work as expected.

The patch 2/2 addresses problems initializing the modem too early. The
initial command tends to fail when a MBM modem is inserted via USB and oFono
tries to access the modem while it is still powering up and initializing
itself.

--Pekka


--===============4791055569793100291==--

