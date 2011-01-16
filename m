Content-Type: multipart/mixed; boundary="===============7272863564378926173=="
MIME-Version: 1.0
From: George Matveev <george@matveev.se>
Subject: [RFC] "magic" numbers (145,129)
Date: Sun, 16 Jan 2011 19:39:17 +0100
Message-ID: <453fcdb2b40bbc8f6628d8912df89588.squirrel@squirrel-webmail.surftown.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7272863564378926173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

this is proposal for a patch series which would replace
"magic" numbers 145 and 129 with well defined enumeration.

Currently we have the following (eliminating sms and CAIF related code):

geo(a)fermat:/home/work/ofono/ofono$ grep -nr 145 drivers src|grep -v
sms|grep -v CAIF
drivers/huaweimodem/voicecall.c:123:	if (ph->type =3D=3D 145)
drivers/stemodem/voicecall.c:195:	if (ph->type =3D=3D 145)
drivers/atmodem/voicecall.c:374:	if (ph->type =3D=3D 145)
drivers/calypsomodem/voicecall.c:88:	if (ph->type =3D=3D 145)
drivers/hfpmodem/voicecall.c:369:	if (ph->type =3D=3D 145)
drivers/ifxmodem/voicecall.c:313:	if (ph->type =3D=3D 145)
src/phonebook.c:41:#define TYPE_INTERNATIONAL 145
src/common.c:74:	{ 145,	"Message class not supported" },
src/common.c:408:	if (ph->type =3D=3D 145 && (strlen(ph->number) > 0) &&
src/common.c:425:		ph->type =3D 145;	/* International */
geo(a)fermat:/home/work/ofono/ofono$

Even though TYPE_INTERNATIONAL is defined it is used only once:

geo(a)fermat:/home/work/ofono/ofono$ grep -nr _INTERNATIONAL .|grep -v SMS
./src/phonebook.c:41:#define TYPE_INTERNATIONAL 145
./src/phonebook.c:179:	if ((type =3D=3D TYPE_INTERNATIONAL) && (number[0] !=
=3D
'+'))
geo(a)fermat:/home/work/ofono/ofono$

And for "magic" number 129 we have:

geo(a)fermat:/home/work/ofono/ofono$ grep -nr 129 drivers src|grep -v
sms|grep -v CAIF
drivers/atmodem/call-forwarding.c:92:		list[num].phone_number.type =3D 129;
drivers/atmodem/atutil.c:115:		int number_type =3D 129;
drivers/atmodem/ssn.c:72:	ph.type =3D 129;
drivers/calypsomodem/voicecall.c:298:		type =3D 129;
src/call-forwarding.c:794:		ph.type =3D 129;
src/common.c:70:	{ 129,	"Short message type 0 not supported" },
src/common.c:428:		ph->type =3D 129;	/* Local */
geo(a)fermat:/home/work/ofono/ofono$


So if we introduce enum phone_number_type in src/common.h
similar to sms_number_type defined in smsutils.h:

enum phone_number_type {
	PHONE_NUMBER_TYPE_LOCAL =3D 0,
	PHONE_NUMBER_TYPE_INTER =3D 1
};

and use it consistently with phone type then we may avoid magic numbers
and need to guess what they mean.

Also if we do so there will be no need to include any new headers in
voicecall.c files in case of
stemodem and hfpmodem drivers. Only voicecall.c for atmodem, calypsomodem,
and ifxmodem drivers will have to include common.h.

If project maintainers agree that such patch (series) might make oFono
code more structured
and easier to understand (no need to comment on each line) I'll submit a
patch series shortly.

Best regards,
George Matveev








--===============7272863564378926173==--

