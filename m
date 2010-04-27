Content-Type: multipart/mixed; boundary="===============2667037005200951354=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 2/6] stkutil: Move advance of ctlv to decicated
 proactive	commands parser
Date: Tue, 27 Apr 2010 17:42:14 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731CDB6B13@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <201004261039.20895.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2667037005200951354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew and Denis,


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Denis Kenzior
>Sent: Monday, April 26, 2010 11:39 PM
>To: ofono(a)ofono.org
>Subject: Re: [PATCH 2/6] stkutil: Move advance of ctlv to decicated proact=
ive commands
>parser
>
>Hi Andrew,
>
>> Hi Yang,
>>
>> On 26 April 2010 12:29, Yang Gu <yang.gu@intel.com> wrote:
>> > Not all the proactive commands have comprehension tlv other than comma=
nd
>> > details and device identities. So the appropriate code should be moved=
 to
>> > decicated parser if needed.
>>
>> Maybe parse_dataobj() would be a better place?
>
>Agreed, lets not repeat this in every single command parser.

Really good advice:) I will modify the patches.

>
>Regards,
>-Denis
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

Regards,
-Yang

--===============2667037005200951354==--

