Content-Type: multipart/mixed; boundary="===============9122421352408821992=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Use GET RESPONSE sim command to retrieve EF length.
Date: Thu, 18 Jun 2009 02:10:38 -0500
Message-ID: <200906180210.39532.denkenz@gmail.com>
In-Reply-To: <1245296668-15210-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9122421352408821992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wednesday 17 June 2009 22:44:28 Andrzej Zaborowski wrote:
> Also accept 0x9f as a success status word 1 for READ BINARY (GSM specific=
).
>
> Note that GET RESPONSE doesn't seem to work on on the TI Calypso modems
> in OpenMoko phones.  They return the 0x9f status which ETSI says is what
> the SIM shall return if GET RESPONSE is not issued immediately after
> the command generating the response, which would be the case if the
> modem sends some command between SELECT and the GET RESPONSE.  These
> modems don't support AT+CSIM either in case we wanted to manually send
> the SELECT and the GET RESPONSE.

Patch has been applied.  Note that GET RESPONSE or the CSIM equivalent is t=
he =

only sane way to do this as we also need to support cyclical and record bas=
ed =

files.  Is there any other way to find out the total file size and the reco=
rd =

size on the Neo besides GET RESPONSE?

For Record-Based files you can use CRSM=3D178,<file>,0,0,0 to find the reco=
rd size, =

but not the total length of the file (e.g. how many records there are)

If we can obtain this information, then we simply have to maintain a differ=
ent =

implementation when ti_calypso is used.

And I can confirm that GET RESPONSE simply doesn't work on the Freerunner:

AT+CRSM=3D176,28423,0,0,0
STR=3D`AT+CRSM=3D176,28423,0,0,0'
RSTR=3D`+CRSM: 103,9'

Ok, EFimsi exists with length 9

AT+CRSM=3D192,28423
STR=3D`AT+CRSM=3D192,28423'
RSTR=3D`+CRSM: 111,0'

Unknown technical problem.

Regards,
-Denis

--===============9122421352408821992==--

