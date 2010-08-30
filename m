Content-Type: multipart/mixed; boundary="===============8650406236895564361=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-reset-pin-v2 0/3] pass reset password type to driver
Date: Mon, 30 Aug 2010 20:53:41 +0300
Message-ID: <1283190824-9876-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8650406236895564361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

Here is a less controversial version of the SIM API change.

The reset password type is passed down to the driver.

The generic atmodem sim driver caches the pin type from last CPIN?, and if
it is not PUK, returns an error.

A quirk is added for mbm so it will try to trigger the +CPIN: SIM PUK/PUK2
response.

--Pekka


--===============8650406236895564361==--

