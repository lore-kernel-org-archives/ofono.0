Content-Type: multipart/mixed; boundary="===============3762629390603159338=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: [RFC] "magic" numbers (145,129)
Date: Sun, 16 Jan 2011 15:48:54 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702EC2452@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <453fcdb2b40bbc8f6628d8912df89588.squirrel@squirrel-webmail.surftown.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3762629390603159338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi George, =


> Hi,
> =

> this is proposal for a patch series which would replace =

> "magic" numbers 145 and 129 with well defined enumeration.
> =

> Currently we have the following (eliminating sms and CAIF =

> related code):
> =

> geo(a)fermat:/home/work/ofono/ofono$ grep -nr 145 drivers src|grep -v
> sms|grep -v CAIF
> drivers/huaweimodem/voicecall.c:123:	if (ph->type =3D=3D 145)
> drivers/stemodem/voicecall.c:195:	if (ph->type =3D=3D 145)
> drivers/atmodem/voicecall.c:374:	if (ph->type =3D=3D 145)
> drivers/calypsomodem/voicecall.c:88:	if (ph->type =3D=3D 145)
> drivers/hfpmodem/voicecall.c:369:	if (ph->type =3D=3D 145)
> drivers/ifxmodem/voicecall.c:313:	if (ph->type =3D=3D 145)
> src/phonebook.c:41:#define TYPE_INTERNATIONAL 145
> src/common.c:74:	{ 145,	"Message class not supported" },
> src/common.c:408:	if (ph->type =3D=3D 145 && =

> (strlen(ph->number) > 0) &&
> src/common.c:425:		ph->type =3D 145;	/* International */
> geo(a)fermat:/home/work/ofono/ofono$
> =

> Even though TYPE_INTERNATIONAL is defined it is used only once:
> =

> geo(a)fermat:/home/work/ofono/ofono$ grep -nr _INTERNATIONAL =

> .|grep -v SMS ./src/phonebook.c:41:#define TYPE_INTERNATIONAL 145
> ./src/phonebook.c:179:	if ((type =3D=3D =

> TYPE_INTERNATIONAL) && (number[0] !=3D
> '+'))
> geo(a)fermat:/home/work/ofono/ofono$
> =

> And for "magic" number 129 we have:
> =

> geo(a)fermat:/home/work/ofono/ofono$ grep -nr 129 drivers src|grep -v
> sms|grep -v CAIF
> drivers/atmodem/call-forwarding.c:92:		=

> list[num].phone_number.type =3D 129;
> drivers/atmodem/atutil.c:115:		int number_type =3D 129;
> drivers/atmodem/ssn.c:72:	ph.type =3D 129;
> drivers/calypsomodem/voicecall.c:298:		type =3D 129;
> src/call-forwarding.c:794:		ph.type =3D 129;
> src/common.c:70:	{ 129,	"Short message type 0 not supported" },
> src/common.c:428:		ph->type =3D 129;	/* Local */
> geo(a)fermat:/home/work/ofono/ofono$
> =

> =

> So if we introduce enum phone_number_type in src/common.h =

> similar to sms_number_type defined in smsutils.h:
> =

> enum phone_number_type {
> 	PHONE_NUMBER_TYPE_LOCAL =3D 0,
> 	PHONE_NUMBER_TYPE_INTER =3D 1
> };
> =

> and use it consistently with phone type then we may avoid =

> magic numbers and need to guess what they mean.

145 and 129, doesnt only represent the type of number (TON), but also
includes the numbering plan indentification (NPI). =

145 - 1 001 0001 (1- EXT, 001 - international number, 0001 -
ISDN/telephony numbering plan )
129 - 1 000 0001 (1- EXT, 000 - unknown, 0001 - ISDN/telephony numbering
plan )

In 129 TON is unknown type, not Local or National, so it should be
_UNKNOWN not _LOCAL

BR,
Rajesh

--===============3762629390603159338==--

