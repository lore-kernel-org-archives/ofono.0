Content-Type: multipart/mixed; boundary="===============4117279866904261201=="
MIME-Version: 1.0
From: George Matveev <george@matveev.se>
Subject: Re: [RFC] "magic" numbers (145,129)
Date: Mon, 17 Jan 2011 22:10:12 +0100
Message-ID: <ab2c6e09851c2c5eecd49fe4bd1dfde1.squirrel@squirrel-webmail.surftown.com>
In-Reply-To: <4D346F1D.2010502@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4117279866904261201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Rajesh and Denis, thank you for your comments.

It is really comforting to know that project maintainer knows about
specifications and could provide guidance to other developers.
This is what most contributors have come to expect from them.

What makes me wonder is why don't we use those specs consistently?

Instead of relying on sporadic attempts to define number types ad hock,
in different parts of project (see grep results) and using inconsistent
or simply wrong comments, wouldn't it be more logical to use spec?

Denis, you may be surprised to know that such an attempt had already
been made in the past (though possibly in a wrong place - src/driver.h)
and that patch was accepted by someone called Denis Kenzior :-)

Just have a look into oFono archive here:

http://lists.ofono.org/pipermail/ofono/2009-June/000130.html

Since other developers seem to agree that it'll make project code
more organized and readable I think I'll submit a patch using all
those values defined in 3GPP TS 24.008, section 10.5.4.7
"Called party BCD number", Table 10.5.118.

What I am not entirely sure though is a name of new enumeration,
possibly *called_number_type* would be more appropriate
and also more in line with the spec?

Best regards,
George

> Hi George,
>
> On 01/16/2011 12:39 PM, George Matveev wrote:
>> Hi,
>>
>> this is proposal for a patch series which would replace
>> "magic" numbers 145 and 129 with well defined enumeration.
>>
>> Currently we have the following (eliminating sms and CAIF related code):
>>
>> geo(a)fermat:/home/work/ofono/ofono$ grep -nr 145 drivers src|grep -v
>> sms|grep -v CAIF
>> drivers/huaweimodem/voicecall.c:123:	if (ph->type =3D=3D 145)
>> drivers/stemodem/voicecall.c:195:	if (ph->type =3D=3D 145)
>> drivers/atmodem/voicecall.c:374:	if (ph->type =3D=3D 145)
>> drivers/calypsomodem/voicecall.c:88:	if (ph->type =3D=3D 145)
>> drivers/hfpmodem/voicecall.c:369:	if (ph->type =3D=3D 145)
>> drivers/ifxmodem/voicecall.c:313:	if (ph->type =3D=3D 145)
>> src/phonebook.c:41:#define TYPE_INTERNATIONAL 145
>> src/common.c:74:	{ 145,	"Message class not supported" },
>> src/common.c:408:	if (ph->type =3D=3D 145 && (strlen(ph->number) > 0) &&
>> src/common.c:425:		ph->type =3D 145;	/* International */
>> geo(a)fermat:/home/work/ofono/ofono$
>>
>> Even though TYPE_INTERNATIONAL is defined it is used only once:
>>
>> geo(a)fermat:/home/work/ofono/ofono$ grep -nr _INTERNATIONAL .|grep -v S=
MS
>> ./src/phonebook.c:41:#define TYPE_INTERNATIONAL 145
>> ./src/phonebook.c:179:	if ((type =3D=3D TYPE_INTERNATIONAL) && (number[0=
] !=3D
>> '+'))
>> geo(a)fermat:/home/work/ofono/ofono$
>>
>> And for "magic" number 129 we have:
>>
>> geo(a)fermat:/home/work/ofono/ofono$ grep -nr 129 drivers src|grep -v
>> sms|grep -v CAIF
>> drivers/atmodem/call-forwarding.c:92:		list[num].phone_number.type =3D
>> 129;
>> drivers/atmodem/atutil.c:115:		int number_type =3D 129;
>> drivers/atmodem/ssn.c:72:	ph.type =3D 129;
>> drivers/calypsomodem/voicecall.c:298:		type =3D 129;
>> src/call-forwarding.c:794:		ph.type =3D 129;
>> src/common.c:70:	{ 129,	"Short message type 0 not supported" },
>> src/common.c:428:		ph->type =3D 129;	/* Local */
>> geo(a)fermat:/home/work/ofono/ofono$
>>
>>
>> So if we introduce enum phone_number_type in src/common.h
>> similar to sms_number_type defined in smsutils.h:
>>
>> enum phone_number_type {
>> 	PHONE_NUMBER_TYPE_LOCAL =3D 0,
>> 	PHONE_NUMBER_TYPE_INTER =3D 1
>> };
>>
>> and use it consistently with phone type then we may avoid magic numbers
>> and need to guess what they mean.
>>
>
> As Rajesh mentions in the other reply you at least have to assign proper
> values to the enum.  Assigning 0 and 1 is not going to work.  Also,
> please use proper naming.  PHONE_NUMBER_TYPE_INTER makes no sense to me.
>  If you mean INTERNATIONAL then please spell that out.
>
> Refer to 24.008 Section 10.5.4.7 for more details.
>
>> Also if we do so there will be no need to include any new headers in
>> voicecall.c files in case of
>> stemodem and hfpmodem drivers. Only voicecall.c for atmodem,
>> calypsomodem,
>> and ifxmodem drivers will have to include common.h.
>>
>> If project maintainers agree that such patch (series) might make oFono
>> code more structured
>> and easier to understand (no need to comment on each line) I'll submit a
>> patch series shortly.
>
> Personally I don't really consider these as 'magic numbers'.  They're so
> widely used in 27.007 that if you don't know what type 145/128/129 is,
> you have bigger problems ;)  However, if you really feel this makes
> things better I'm okay with accepting such a patch series.
>
> Regards,
> -Denis
>



--===============4117279866904261201==--

