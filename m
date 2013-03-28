Content-Type: multipart/mixed; boundary="===============1652398669466082917=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Re: Randomly SMS sent passes or fails
Date: Thu, 28 Mar 2013 17:29:30 +0100
Message-ID: <51546FEA.7070501@syscom-instruments.com>
In-Reply-To: <515456D1.80800@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1652398669466082917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 28. 03. 13 15:42, Denis Kenzior wrote:
> Hi Anthony,
>
>> I don't know why ofono call the callback with ok=3D0. In the log, I see
>> the command was successful:
>>
>> ---------------
>> Mar 28 13:50:05 mr3000 ofonod[6859]: Data: > AT+CRSM=3D192,28589\r
>> Mar 28 13:50:05 mr3000 ofonod[6859]: Data: < \r\n+CRSM:
>> 144,0,""\r\n\r\nOK\r\n
>> ---------------
>>
>
> The above CRSM response is equivalent to: "File not found".
>

Errr, ok :P

How do you known this ? I looked on AT documentation for my modem, on =

3GPP TS 27.007 V3.13.0, I saw nothing...

I added some logs and each time ofono does AT+CRSM commands, there a =

call to "sim_fs_op_error" function ...

I've got two kind of answers on AT+CRSM commands :


ofonod[12357]: Data: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n

or

ofonod[6859]: Data: < \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n

It means all the CRSM commands fails ???

Regards,
Anthony.

--===============1652398669466082917==--

