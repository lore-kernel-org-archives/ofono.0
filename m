Content-Type: multipart/mixed; boundary="===============4075290049034435132=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] MC7430: add read_imsi feature to qmimodem sim driver
Date: Fri, 06 Jan 2017 10:50:24 -0600
Message-ID: <6924828f-c0e0-f079-868f-e4c45f029c2d@gmail.com>
In-Reply-To: <74dbf201-e332-3ab1-3a6f-9faa73547309@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4075290049034435132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

>
> What I would like to do for QMI modem is to always try QMI_DMS_GET_IMSI
> (not only for Sierra modems) and if it fails, try to obtain IMSI via EF
> reads.

So you want the core to try both read_imsi and read_transparent in =

sequence to obtain the IMSI.  This isn't really ideal, as the driver =

should really implement one method or the other.

Do we know whether the Sierra devices actually support raw SIM reads? =

Maybe the QMI commands need to be formatted specifically for Sierra =

devices?  Ideal situation would be to get read_transparent to work for =

obtaining the IMSI.

If the above can't be made to work, then we should probably just add =

another QMI based sim driver for these devices.  E.g. one that supports =

read_imsi via DMS and PIN operations via UIM.

>
> I have done a patch to do that (see diff above). Let me know if you
> think that's a good idea. In this case, I will send two patches:
>  - backup read_imsi by IMSI via EF read

Can you send this patch properly via git send-email.  I might be =

convinced to apply it.

Regards,
-Denis

--===============4075290049034435132==--

