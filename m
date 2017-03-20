Content-Type: multipart/mixed; boundary="===============1481204709609229560=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: Re: Telit LE910V1 - LTE only modem
Date: Mon, 20 Mar 2017 13:19:25 +0000
Message-ID: <18b346e6-dee3-a7bd-058b-a4b9586a94d6@gmail.com>
In-Reply-To: <20170316093204.25275-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1481204709609229560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Piotr, Denis,

With the qmimodem patch I was able to bring the LE910-SVG modem on-line.
But I had to do two things:

1. The gprs driver was never getting attached.
a) This statement in src/gprs.c, gprs_netreg_update()
	if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
			ACCESS_TECHNOLOGY_EUTRAN)
		/*
		 * For LTE we set attached status only on successful
		 * context activation.
		 */
                return;
means that the gprs->driver_attached is never set to true.
If I remove this piece of code, the gprs->driver->set_attached() gets calle=
d, and that
gets everything attached and working.

b) I can see, that another path to it would be:
qmimodem/gprs.c create_nas_cb() calls qmi_service_register(QMI_NAS_SS_INFO_=
IND, ss_info_notify)
But then, ss_info_notify() is never called. I think that the modem is quick=
 enough to register
to the network before qmi_service_register(QMI_NAS_SS_INFO_IND) is called.

c) Denis, you mentioned that I need to call ofono_gprs_cid_activated()
Which piece of code should do that? qmimodem/network-registration.c or plug=
ins/gobi.c?


2. qmimodem/network-registration.c:extract_ss_info() seems to be getting a =
corrupted =

operator name:
plmn->desc_len =3D 3
plmn->desc[] =3D { 0x56, 0xfd, 0x15 }
The first byte seems correct ('V' for Verizon), but the other two are wrong=
 (later on, dbus
aborts the entire ofono process, saying this is not a valid utf-8 string).
plmn->mcc and plmn->mnc are correct (311:480 - US:Verizon)

Have you ever seen anything like that?
If I replace the invalid characters, everything works ok. But I imagine thi=
s is not
the right way to handle this.


Thanks for all your help with this.

Lukasz



On 16/03/17 09:32, Piotr Haber wrote:
> Hi Lukasz,
> =

> I have never useg LE910-SVG but I have used LE910-EUG which is also V1 LE=
910 modem.
> It uses QMI interface and is End-of-life product according to Telit.
> Below is a patch I used to add support for it, maybe it will help you.
> =

> Modem is not recognized automatically, you need to point ofono  to use co=
rrect driver
> by setting ENV{OFONO_DRIVER}=3D"le910" in udev.
> =

> =

>=20

--===============1481204709609229560==--

