Content-Type: multipart/mixed; boundary="===============4720998957946951910=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Telit LE910V1 - LTE only modem
Date: Mon, 20 Mar 2017 09:39:14 -0500
Message-ID: <bcefd4c9-3a47-1f6f-b3ac-0e721136fb57@gmail.com>
In-Reply-To: <18b346e6-dee3-a7bd-058b-a4b9586a94d6@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4720998957946951910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On 03/20/2017 08:19 AM, Lukasz Nowak wrote:
> Hi Piotr, Denis,
>
> With the qmimodem patch I was able to bring the LE910-SVG modem on-line.
> But I had to do two things:

So it looks like the LE910 is a Qualcomm chip / firmware, funny.

>
> 1. The gprs driver was never getting attached.
> a) This statement in src/gprs.c, gprs_netreg_update()
> 	if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
> 			ACCESS_TECHNOLOGY_EUTRAN)
> 		/*
> 		 * For LTE we set attached status only on successful
> 		 * context activation.
> 		 */
>                 return;
> means that the gprs->driver_attached is never set to true.
> If I remove this piece of code, the gprs->driver->set_attached() gets cal=
led, and that
> gets everything attached and working.

Strictly speaking this statement is correct.  In LTE there's really no =

concept of 'attached'.  We're attached by the virtue of getting onto the =

LTE network (the default bearer is always available).  So there should =

be no need to explicitly issue a set_attached method.

>
> b) I can see, that another path to it would be:
> qmimodem/gprs.c create_nas_cb() calls qmi_service_register(QMI_NAS_SS_INF=
O_IND, ss_info_notify)
> But then, ss_info_notify() is never called. I think that the modem is qui=
ck enough to register
> to the network before qmi_service_register(QMI_NAS_SS_INFO_IND) is called.
>
> c) Denis, you mentioned that I need to call ofono_gprs_cid_activated()
> Which piece of code should do that? qmimodem/network-registration.c or pl=
ugins/gobi.c?
>

your gprs.c atom driver.

>
> 2. qmimodem/network-registration.c:extract_ss_info() seems to be getting =
a corrupted
> operator name:
> plmn->desc_len =3D 3
> plmn->desc[] =3D { 0x56, 0xfd, 0x15 }
> The first byte seems correct ('V' for Verizon), but the other two are wro=
ng (later on, dbus
> aborts the entire ofono process, saying this is not a valid utf-8 string).
> plmn->mcc and plmn->mnc are correct (311:480 - US:Verizon)
>
> Have you ever seen anything like that?
> If I replace the invalid characters, everything works ok. But I imagine t=
his is not
> the right way to handle this.
>

I have not played with QMI enough to give any guidance.  You might want =

to look at libqmi to see if they handle this differently.

Regards,
-Denis

--===============4720998957946951910==--

