Content-Type: multipart/mixed; boundary="===============7798245992380627959=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [n900-v5 0/5] n900 and isigen modem driver
Date: Thu, 16 Sep 2010 17:56:14 +0300
Message-ID: <1284648979-19046-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7798245992380627959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I did more restructuring on the patches.

The new isigen plugin is modeled after atgen.

The "isimodem" modem driver is removed.

The n900 modem driver seems to run on Nokia N900 with meego kernel and
userspace.

All the naughty bits that R=C3=A9mi complained about are now moved into
uspnmodem (and modemconf). =


If the modem has (non-zero) integer property "Address", the isigen or
n900 modem driver will configure the interface with the given address.

If there is no "Address", then the modem drivers assume that configation
is done for them.

--Pekka


--===============7798245992380627959==--

