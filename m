Content-Type: multipart/mixed; boundary="===============0992380992483836847=="
MIME-Version: 1.0
From: arash.javanmard@inro-et.de
Subject: Quectel BG95 Support
Date: Thu, 14 May 2020 14:27:22 +0000
Message-ID: <20200514142722.2843.94186@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0992380992483836847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,
unfortunately there is no support for Quectel BG95 in ofono.  But neverthel=
ess i tried to adapt the existing Quectel implementation for BG95.
So i added:

udevng.c
------- 8< -------------
	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0700"	},
	{ "quectelqmi",	"qcserial",	"2c7c", "0700"	},
	{ "quectel",	"option",	"2c7c", "0700"	},
------- >8 -------------

It helps to recognize the modem, but it seems to be BUG in "setup_quectel" =
fucntion in "udevng.c" file.
Since checking for "modem->serial" in the function produces a segfault. so =
i just commented it out.
But after that the next problems popped up in "quectel.c"-Modul.

------- 8< ----------------------------------------
ofonod[273]: Aux: > AT+CGMM\r
ofonod[273]: Aux: < \r\nBG95-M3\r\n\r\nOK\r\n
ofonod[273]: plugins/quectel.c:cgmm_cb() 0x165dd0 ok 1
ofonod[273]: Failed to query modem model
------- >8 -----------------------------------------

As you can see it failed to query the model modem, even though the modem is=
 answering correct. =

so i digged deeper and found out, that only the number of lines save in res=
ult-argument which is a "GATResult" =

is actually zero! That means somewho the answer of the modem is not parsed =
right!

Any help is welcome!

Best Regards
Arash
--===============0992380992483836847==--

