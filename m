Content-Type: multipart/mixed; boundary="===============3453792950096691568=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 2/4] Handle the conversion failure when parsing item
Date: Wed, 17 Mar 2010 11:33:41 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731C76B5B7@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <201003161529.49624.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3453792950096691568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Denis Kenzior
>Sent: Wednesday, March 17, 2010 4:30 AM
>To: ofono(a)ofono.org
>Subject: Re: [PATCH 2/4] Handle the conversion failure when parsing item
>
>Hi Yang,
>
>> -	item->text =3D sim_string_to_utf8(data+1, len-1);
>> +	utf8 =3D sim_string_to_utf8(data+1, len-1);
>
>I applied the patch and fixed up the arithmetic operator style issue.  Ple=
ase
>make sure you follow this convention from now on.

Thank you, and I will pay attention to this in future. =


I'm always wondering what's the complete coding style we should follow. Can=
 we have some document to describe them? I have collected some of them:
1. Check the patch using checkpatch.pl (checkpatch.pl --no-tree patch_name)=
. In theory, you need to clean up all the warnings and errors except one "E=
RROR: Missing Signed-off-by: line(s)". However, sometimes, the warning of e=
xceeding maximum characters for a line (80 characters) can be ignored.
2. There should be a blank line before if statement, unless it is nested an=
d not preceded by an expression or variable declaration.
3. There should be space before and after operator.
4. It's better not to have a complicated statement for if. You may judge it=
s contrary condition and return | break | continue ASAP.
5. Better to use abbreviation, rather than full name, to name a variable, f=
unction, struct, etc.
Any others?

>
>Regards,
>-Denis
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono


Regards,
-Yang

--===============3453792950096691568==--

