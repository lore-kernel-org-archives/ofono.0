Content-Type: multipart/mixed; boundary="===============6534094286451255797=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: RE: sms segment fault with 160 char
Date: Fri, 31 Jul 2009 10:36:35 +0800
Message-ID: <B94C62E7C2870743865418621F040C1302055CCFF5@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <200907301028.09597.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6534094286451255797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
Great! More than one recipients and more segment work fine after I reinstal=
l the python package =

Thanks

>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Denis Kenzior
>Sent: 2009=E5=B9=B47=E6=9C=8830=E6=97=A5 23:28
>To: ofono(a)ofono.org
>Subject: Re: sms segment fault with 160 char
>
>Hi,
>
>> Please see the log of phonesim:
>>  AT+CMGS=3D18 :
>>
>> 0011000B815128010272F40000A70461F1980C :
>> +CMGS: 0
>> OK
>
>Destination: 158210202..
>Content: abcd
>
>> AT+CMGS=3D18 :
>>
>> 0011000B813118567873F20000A704B2D88C06 :
>> +CMGS: 0
>> OK
>> The content is different, and it should be abcd
>
>Destination: 138165873..
>Content: 2134
>
>So I don't understand, you're physically sending two different SMSs here.
>
>>
>> In real network:
>> Because I use phone as modem so maybe something wrong in at response.
>> Whatever it was wrong behavior:
>> The number1 target device received two message:
>>  1, content: abcd
>>  2, content: number1
>
>Again, you're sending two SMSes according to the log.  First with 2
>recipients, and second with a single one.  This means three SMSes are sent,
>and presumably one of the recipients will get 2 of them.  All three get se=
nt
>eventually.  What is the problem?
>
>Regards,
>-Denis
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============6534094286451255797==--

