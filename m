Content-Type: multipart/mixed; boundary="===============0429632264383940480=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Handle broken AT command process
Date: Mon, 19 Aug 2019 21:29:07 +0200
Message-ID: <9c9e17cf-549d-dfef-21c0-1c6a13913986@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0429632264383940480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Does ofono have a way to handle lacking OK/error messages? I seems like =

my modem (Quectel M95) is buggy when it comes to unsolicited indications =

and (as far as I have seen) SIM commands:

  > AT+CRSM=3D178,28614,3,4,8
  < +CRSM: 144,0,"FFFFFFFFFFFFFFFF"
  < OK
  > AT+CRSM=3D178,28614,4,4,8
  < Call Ready
  < +CREG: 5,"0119","04EA"

The "Call Ready" indication causes a lacking "OK" from the preceding =

"AT+CRSM" command. This has happened with other CRSM commands, and can =

also be caused by an unsolicited +CREG indication.

I guess one way handle it, is to to glue op the URC listeners to peek =

into the AT command queue and check if a command is pending for =

OK/errors, and retry it if so.

But that could cause unexpected side effects depending on the retried =

command...

// Martin

--===============0429632264383940480==--

