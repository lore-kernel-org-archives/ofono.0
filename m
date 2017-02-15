Content-Type: multipart/mixed; boundary="===============8834733372235606112=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/1] Use ATD*99 to enter data state when needed
Date: Wed, 15 Feb 2017 17:38:36 +0100
Message-ID: <20170215163837.28766-1-c.ronco@kerlink.fr>
In-Reply-To: <f34c67a0-8c15-8bbc-4ec4-bfb08e1202b5@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8834733372235606112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here is my patch proposal.
I have a warning using checkpatch.pl:
WARNING: static const char * array should probably be static const char * c=
onst
#21: FILE: drivers/atmodem/gprs-context.c:50:
+static const char *cgdata_prefix[] =3D { "+CGDATA:", NULL };

I have copied what is in src/gprs.c. Let me know if it should be fixed.

Christophe Ronco (1):
  atmodem: use ATD99 to enter data state when needed

 drivers/atmodem/gprs-context.c | 45 ++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 44 insertions(+), 1 deletion(-)

-- =

2.11.0


--===============8834733372235606112==--

