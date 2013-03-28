Content-Type: multipart/mixed; boundary="===============5394079194125440894=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Randomly SMS sent passes or fails
Date: Thu, 28 Mar 2013 13:05:47 -0500
Message-ID: <5154867B.5000506@gmail.com>
In-Reply-To: <51546FEA.7070501@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5394079194125440894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

>
> Errr, ok :P
>
> How do you known this ? I looked on AT documentation for my modem, on
> 3GPP TS 27.007 V3.13.0, I saw nothing...

You really do not want to know.  But if you do, see 3GPP 51.011 or ETSI =

102.221 for details.

>
> I added some logs and each time ofono does AT+CRSM commands, there a
> call to "sim_fs_op_error" function ...
>
> I've got two kind of answers on AT+CRSM commands :
>
>
> ofonod[12357]: Data: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n

I'm guessing you have a 3G sim.  Refer to 'Table 10.14: Status byte =

coding - wrong parameters' in ETSI 102.221.  Literally 106 means '6A', =

130 means '82' -> File Not Found.

>
> or
>
> ofonod[6859]: Data: < \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
>
> It means all the CRSM commands fails ???
>

Actually, this is peculiar, the CRSM command is not failing and the =

result is fine.  Just that it is empty.  Perhaps you need to quirk the =

CRSM behavior in this case.  Does adding your modem to the list in =

at_sim_read_info()

                 /* Maximum possible length */
                 len +=3D sprintf(buf + len, ",0,0,255");
                 break;

make it work properly?

Regards,
-Denis

--===============5394079194125440894==--

