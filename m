Content-Type: multipart/mixed; boundary="===============8760022795897357944=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 6/8] test-stkutil: Add unit test for Get Inkey response
 encoding.
Date: Tue, 11 May 2010 11:01:43 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731DE13DF8@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1273484066-32276-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8760022795897357944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew, =


>+#define NO_DURATION { .interval =3D 0x00, }
>+#define NO_TEXT { .text =3D NULL, .yesno =3D FALSE, }

There is no need to define these as static variables will be initialized to=
 zero automatically. We must guarentee zero means non-existence. =

If some meaningful initialization happens to be missed, later check would c=
atch them. Hope this can save several lines of code;)


>+
>+static const unsigned char get_inkey_response_111[] =3D {
>+	0x81, 0x03, 0x01, 0x22, 0x00, 0x82, 0x02, 0x82,
>+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x02, 0x04, 0x2b,

Regards,
-Yang

--===============8760022795897357944==--

