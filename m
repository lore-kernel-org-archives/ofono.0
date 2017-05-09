Content-Type: multipart/mixed; boundary="===============2120591034828214256=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH] Fix crash in pri_set_apn when using an LTE SIM
Date: Tue, 09 May 2017 16:52:36 +0200
Message-ID: <1494341557-3118-1-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <880e6dc7-7ab9-2aec-b52a-26c6c45903ec@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2120591034828214256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I use a MC7304 modem.
As Jonas said, ofonod crashes when using an LTE SIM.
I didn't duplicate pri_set_apn code as Denis proposed,
I made it support a NULL msg parameter.


Christophe Ronco (1):
  gprs: pri_set_apn not exclusively a DBus method

 src/gprs.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- =

2.7.4


--===============2120591034828214256==--

