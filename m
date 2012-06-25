Content-Type: multipart/mixed; boundary="===============6636667217654948757=="
MIME-Version: 1.0
From: Audric Schiltknecht <audric.schiltknecht@toulouse.viveris.com>
Subject: Re: Unable to decode PDU for SMS-STATUS-REPORT
Date: Mon, 25 Jun 2012 18:20:16 +0200
Message-ID: <c672aae055cfb534c0e37639c1bfa323@toulouse.viveris.com>
In-Reply-To: <d075607b731e301c6ab7b10bb99a5774@toulouse.viveris.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6636667217654948757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Jun 2012 18:10:36 +0200, Audric Schiltknecht wrote:
> Hi guys.
>
> I'm having troubles with delivery reports.
>
> When I send a message with the property "UseDeliveryReports" set to =

> "true",
> I can get the delivery report from the GSM modem, but ofono is unable
> to decode it:
>
> ofonod[677]: SMS:    < \r\n+CDS:
> =

> 32\r\n07913386094000F006DB0A810011223344216052714081802160527140228000\r\n
> ofonod[677]: drivers/atmodem/sms.c:at_cds_notify() Got new
> Status-Report PDU via CDS:
> 07913386094000F006DB0A810011223344216052714081802160527140228000, 32
> ofonod[677]: src/sms.c:ofono_sms_status_notify() len 32 tpdu len 32
> ofonod[677]: Unable to decode PDU
>
> The PDU is valid, since I can decode it using some online tool.
>
> It seems that sms_decode does not correctly handle the SMSCC part
> (913386094000F0),
> and tries to decode it as the sender address, which obviously fails.


Digging a little further in the code, I found that the sms_decode() =

function is responsible
of decoding the SMSC part of the PDU. However, this is done if tpdu_len =

< len, which is not the case,
since both of them equal to 32.

If I correctly understand, 'tpdu' is returned by the modem in the +CDS =

notification.
Here, its value is 32, which is correct as shown in the logs.
'len' is calculated in the decode_hex_own_buffer() function called in =

the +CDS notification callback.
Here, its value also is 32, and I do not see how it could not be that.

Any help to point out my mistake(s) will be appreciated ;)

Regards,
Audric Schiltknecht

--===============6636667217654948757==--

